#
# Makefile
# elmer, 2019-12-31 18:43
#

-include .springbootrc.mk
export TAG=${VERSION}-$(shell git log -1 --pretty=format:%h )

.DEFAULT_GOAL := all

all: docker tag

docker:
	docker build -f docker/openjdk/8-jdk/Dockerfile -t $(HUB)/$(NAME)-onbuild:$(TAG) .
	docker build -f docker/openjdk/8-jre/Dockerfile -t $(HUB)/$(NAME):$(TAG) .

tag:
	docker tag $(HUB)/$(NAME)-onbuild:$(TAG) $(HUB)/$(NAME)-onbuild:latest
	docker tag $(HUB)/$(NAME):$(TAG) $(HUB)/$(NAME):latest

push:
	docker push $(HUB)/$(NAME)-onbuild:$(TAG) $(HUB)/$(NAME)-onbuild:latest
	docker push $(HUB)/$(NAME):$(TAG) $(HUB)/$(NAME):latest

