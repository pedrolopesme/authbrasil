# Define o comando Hugo a ser usado
HUGO = hugo

# Define o diretório de saída do Hugo
OUTPUT_DIR = public

# Target default
.DEFAULT_GOAL:=help
			
help: ## Exibe o texto de ajuda 
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: build
build: ## Limpa o diretório de saída
	$(HUGO) --destination=$(OUTPUT_DIR)

.PHONY: server
server: ## Inicia o servidor local do Hugo para desenvolvimento
	$(HUGO) server --watch --destination=$(OUTPUT_DIR)

.PHONY: clean
clean: ## Limpa o diretório de saída
	rm -rf $(OUTPUT_DIR)

.PHONY: dev
dev: clean ## Executa o servidor local com suporte ao live-reloading
	$(HUGO) server --watch --destination=$(OUTPUT_DIR) --buildDrafts --buildFuture

.PHONY: update
update: ## Atualiza o Hugo para a versão mais recente
	go get -u github.com/gohugoio/hugo
