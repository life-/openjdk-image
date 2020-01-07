#
# Makefile
# elmer, 2019-12-31 18:43
#

-include .springbootrc.mk
export TAG=${VERSION}-$(shell git log -1 --pretty=format:%h )

.DEFAULT_GOAL := all
.PHONY: all docker tag push jdk jre jre-supervisord

all: docker tag

docker: jdk jre jre-supervisord

jdk:
	docker build -f docker/openjdk/8-jdk/Dockerfile -t $(HUB)/$(NAME)-onbuild:$(TAG) .

jre:
	docker build -f docker/openjdk/8-jre/Dockerfile -t $(HUB)/$(NAME):$(TAG) .

jre-supervisord:
	docker build -f docker/openjdk/8-jre-supervisord/Dockerfile -t $(HUB)/$(NAME)-supervisord:$(TAG) .

tag:
	docker tag $(HUB)/$(NAME)-onbuild:$(TAG) $(HUB)/$(NAME)-onbuild:latest
	docker tag $(HUB)/$(NAME):$(TAG) $(HUB)/$(NAME):latest
	docker tag $(HUB)/$(NAME)-supervisord:$(TAG) $(HUB)/$(NAME)-supervisord:latest

push:
	docker push $(HUB)/$(NAME)-onbuild:latest
	docker push $(HUB)/$(NAME):latest
	docker push $(HUB)/$(NAME)-supervisord:latest

