IMAGE ?= databus23/geminbox
VERSION ?= 0.1.0
build:
	docker build -t $(IMAGE):$(VERSION) .

push: build
	docker push $(IMAGE):$(VERSION)
