ORG=jsanda
PROJECT=reaper-k8s
REG=docker.io

# Set this to true if building Reaper from a branch other than master that
# is not a tag.
DEV_BUILD?=false

REAPER_REPO?=${HOME}/dev/cassandra-reaper
REAPER_BRANCH?=2.0.2
REAPER_REV=$(shell ./scripts/get-reaper-rev.sh)

ifeq ($(REAPER_BRANCH),master)
	REAPER_VERSION := $(REAPER_REV)
else ifeq ($(DEV_BUILD),true)
	REAPER_VERSION := $(REAPER_REV)
else
	REAPER_VERSION := $(REAPER_BRANCH)
endif

IMAGE_REV=$(shell git rev-parse --short=12 HEAD)
IMAGE=$(REG)/$(ORG)/$(PROJECT):$(REAPER_VERSION)-$(IMAGE_REV)

.PHONY: image
image:
	echo $(IMAGE)

.PHONY: build-reaper
build-reaper:
	cd ${REAPER_REPO}; \
	git checkout ${REAPER_BRANCH}; \
	mvn clean package -DskipTests

.PHONY: build-image
build-image: build-reaper
	rm -f docker/lib/*.jar
	cp ${REAPER_REPO}/src/server/target/cassandra-reaper-*.jar docker/lib; \
	rm docker/lib/cassandra-reaper-*-sources.jar; \
	mv docker/lib/cassandra-reaper-*.jar docker/lib/cassandra-reaper.jar; \
	cd docker; \
	docker build -t ${IMAGE} .

.PHONY: push-image
push-image:
	docker push ${IMAGE}
