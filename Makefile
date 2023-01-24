build_image := riazarbi/work:20230124
build_source := riazarbi/maker:20230124
debug_image := riazarbi/work_debug:20230124
debug_source := riazarbi/maker_binder:20230124

build_run := docker run --rm --mount type=bind,source="$(shell pwd)/",target=/root $(build_image)
debug_run := docker run --rm -p 8888:8888 --mount type=bind,source="$(shell pwd)/",target=/home/maker $(debug_image)

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build docker container with required dependencies and data
	docker build -t $(build_image) --no-cache --build-arg FROMIMG=$(build_source) .

.PHONY: build-debug
build-debug: ## Build docker container with required dependencies
	docker build -t $(debug_image) --no-cache --build-arg FROMIMG=$(debug_source) .

.PHONY: get-data
get-data: ## Copy in work and payments csv from icloud
	cp -r /data/icloud/task_logging ./

.PHONY: test
test: build build-debug ## Run tests
	$(docker_run) R -e 'print("Image Runs")'

.PHONY: clean
clean: ## Remove build files
	rm -rf .cache .config .ipython .jupyter .local .Rhistory .Rproj.user R


.PHONY: debug
debug: build-debug ## Launch an interactive environment
	$(debug_run) jupyter notebook --NotebookApp.default_url=/lab/ --no-browser --ip=0.0.0.0 --port=8888
