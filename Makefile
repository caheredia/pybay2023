up: ## Docker compose up
	docker compose up -d --build; docker compose exec pybay_image poetry install
down: ## Docker compose down
	docker compose down --remove-orphans
shell: ## Shell into container
	docker compose exec pybay_image bash
prod: ## Build production image
	docker build --file Dockerfile --target production -t pybay2023_prod_image .
test: ## Run tests
	docker compose exec pybay_image python -m unittest discover tests


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
