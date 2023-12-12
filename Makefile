DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml


all: 
	@if [ ! -d /home/enoviell/data/mariadb_data ]; then \
        mkdir -p /home/enoviell/data/mariadb_data; \
	fi
	@if [ ! -d /home/enoviell/data/wordpress_data ]; then \
        mkdir -p /home/enoviell/data/wordpress_data; \
    fi
	@$(RUN_WITH_COLOR) $(DOCKER_COMPOSE) up -d --build

# Aggiungi questa regola per impostare l'associazione tra enoviell.42.fr e l'IP di localhost
set-hosts:
	@echo "Aggiornamento del file /etc/hosts"
	@echo "127.0.0.1 enoviell.42.fr" | sudo tee -a /etc/hosts

stop:
	$(DOCKER_COMPOSE) down
clean:
	@if [ -n "$$(docker ps -q)" ]; then docker stop $$(docker ps -q); fi
	@if [ -n "$$(docker ps -aq)" ]; then docker rm $$(docker ps -aq); fi
	@if [ -n "$$(docker images -q)" ]; then docker rmi -f $$(docker images -q); fi
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	@docker network ls --format "{{.Name}} {{.Driver}}" | \
		grep -vE '(bridge|host|none)' | \
		awk '{ print $$1 }' | \
		xargs -r docker network rm
	@sudo rm -rf /home/enoviell/data/*

prune: clean
	docker system prune -a