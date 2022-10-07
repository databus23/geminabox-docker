require "geminabox"

Geminabox.allow_replace = !!ENV["GEMINABOX_ALLOW_REPLACE"]
Geminabox.data = ENV.fetch("GEMINABOX_PATH", "/app/data")

if ENV["GEMINABOX_USERNAME"] && ENV["GEMINABOX_PASSWORD"]
  Geminabox::Server.helpers do
    def protected!
      unless authorized?
        response["WWW-Authenticate"] = %(Basic realm="Geminabox")
        halt 401, "You have no access to this resource.\n"
      end
    end

    def authorized?
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ENV["GEMINABOX_USERNAME"], ENV["GEMINABOX_PASSWORD"]]
    end
  end

  Geminabox::Server.before "/upload" do
    protected!
  end

  Geminabox::Server.before do
    protected! if request.delete? || request.post? || ENV["GEMINABOX_PRIVATE"].to_s == "true"
  end
end

app = Rack::Builder.app do
  map ENV.fetch("GEMINABOX_PREFIX", "/") do
    run Geminabox::Server
  end
end

run app
