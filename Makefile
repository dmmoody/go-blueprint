BINARY_NAME := go-blueprint
BIN_DIR := bin
GO_VERSION := 1.22.3
DOCKER_IMAGE := $(BINARY_NAME):dev
DOCKER_CONTAINER := $(BINARY_NAME)-container

build:
	@echo "🔧 Building binary..."
	@mkdir -p $(BIN_DIR)
	go build -o $(BIN_DIR)/$(BINARY_NAME) ./cmd/app

run:
	@echo "🚀 Running binary..."
	@$(BIN_DIR)/$(BINARY_NAME)

docker-build:
	@echo "🐳 Building Docker image..."
	docker build -t $(DOCKER_IMAGE) \
		--build-arg GO_VERSION=$(GO_VERSION) \
		--build-arg APP_NAME=$(BINARY_NAME) .

docker-run:
	@echo "🏃‍♂️ Running Docker container..."
	docker run --rm -d \
		--name $(DOCKER_CONTAINER) \
		--env-file .envrc \
		--network host \
		$(DOCKER_IMAGE)

docker-down:
	@echo "🧹 Stopping and removing container..."
	docker rm -f $(DOCKER_CONTAINER) || true