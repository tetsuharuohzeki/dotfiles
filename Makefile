all: help

help:
	@echo "Specify the task"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@exit 1

clean: ## Clean up symlinks
	go run setup.go -clean

run: ## Create symlinks
	go run setup.go

dry_run: ## dry-run mode
	go run setup.go -dry-run

clean_without_go: ## Clean up symlinks without go
	./install --only clean

run_without_go: ## Create symlinks without go
	./install
