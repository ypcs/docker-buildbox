all:

build:
	mkdir -p sources artifacts
	docker build --build-arg APT_PROXY="http://172.17.0.1:3142/" -t buildbox:latest .
	docker run -e PACKAGE=nginx -e APT_PROXY="http://172.17.0.1:3142/" -v $(shell pwd)/sources:/sources:ro -v $(shell pwd)/artifacts:/artifacts:rw buildbox:latest
