.PHONY: docker

docker:
	docker login -u jdkato -p ${DOCKER_PASS}
	docker buildx build \
	--build-arg ltag=${LAST_TAG} \
	--platform=linux/amd64,linux/arm64 \
	--file Dockerfile \
	--tag jdkato/choco-cross:${LAST_TAG} \
	--tag jdkato/choco-cross:latest \
	--push \
	.