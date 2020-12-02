.PHONY: build

MODSEC_VERSION = 3.0.4
CONNECTOR_VERSION = 1.0.1
CRS_VERSION = 3.2.0

build:
	docker build \
		--build-arg MODSEC_VERSION=$(MODSEC_VERSION) \
		--build-arg CRS_VERSION=$(CRS_VERSION) \
		--build-arg CONNECTOR_VERSION=$(CONNECTOR_VERSION) \
		-t nginx-modsec-crs \
		.