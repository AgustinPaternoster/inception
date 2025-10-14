all: up 
	@grep -qxF "127.0.0.1 tblaase.42.fr" /etc/hosts || echo "127.0.0.1 tblaase.42.fr" | sudo tee -a /etc/hosts	
	

up:
	docker compose -f ./srcs/docker-compose.yml up -d --build
down:
	docker compose -f ./srcs/docker-compose.ylm down

clean: down
	docker rmi $(docker image ls -q)

fclean:
	@sudo rm -rf /home/apaterno/data/db/*
	@sudo rm -rf /home/apaterno/data/db/*
	@docker compose down -v
 
re: fclean all

