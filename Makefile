all: up 
	@grep -qxF "127.0.0.1 apaterno.42.fr" /etc/hosts || echo "127.0.0.1 apaterno.42.fr" | sudo tee -a /etc/hosts	
	

up:
	docker compose -f ./srcs/docker-compose.yml up -d --build
down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	@images=$$(docker image ls -q);\
	if [ -n "$$images" ]; then \
		docker rmi $$images;\
	fi

fclean: clean
	
	@if [ -d "/home/apaterno/data/db" ]; then \
	sudo rm -rf /home/apaterno/data/db/*; \
	fi

	@if [ -d "/home/apaterno/data/wordpress" ]; then \
	sudo rm -rf /home/apaterno/data/wordpress/*;\
	fi

	docker compose -f./srcs/docker-compose.yml down -v
	docker volume prune -f
re: fclean all

