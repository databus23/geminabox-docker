threads 0, 16
port ENV.fetch("GEMINABOX_PORT", 9292)
environment "production"
persistent_timeout Integer(ENV.fetch('PERSISTENT_TIMEOUT', 61))
