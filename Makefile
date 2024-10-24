###

.DEFAULT_GOAL := help

.PHONY: help
help: Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

##
build: image ## Same as image

image: ## Build docker image
	@echo "Building docker image..."
	@docker buildx bake -f compose.yml -f compose.override.yml

up: ## Start services
	@echo "Starting services..."
	@docker compose -f compose.yml -f compose.override.yml up -d

down: ## Stop services
	@echo "Stopping services..."
	@docker compose -f compose.yml -f compose.override.yml down

ps: ## Show status of services
	@echo "Status of services..."
	@docker compose -f compose.yml -f compose.override.yml ps

logs: ## Tail logs
	@echo "Tailing..."
	@docker compose -f compose.yml -f compose.override.yml logs -f

.PHONY: build image up down ps logs
###