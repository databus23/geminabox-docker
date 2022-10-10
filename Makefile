IMAGE ?= databus23/geminbox
VERSION ?= 0.1.1
build:
	docker build -t $(IMAGE):$(VERSION) .

push: build
	docker push $(IMAGE):$(VERSION)
