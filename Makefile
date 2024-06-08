LAST_TAG=$(shell git describe --abbrev=0 --tags)
CURR_SHA=$(shell git rev-parse --verify HEAD)

.PHONY: docker

docker:
	docker login -u jdkato -p ${DOCKER_PASS}
	docker build -f Dockerfile -t jdkato/choco-cross:${LAST_TAG} .
	docker tag jdkato/choco-cross:${LAST_TAG} jdkato/choco-cross:latest
	docker push jdkato/choco-cross:${LAST_TAG}
	docker push jdkato/choco-cross:latest