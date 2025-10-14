all: up 
	@grep -qxF "127.0.0.1 apaterno.42.fr" /etc/hosts || echo "127.0.0.1 apaterno.42.fr" | sudo tee -a /etc/hosts	
	

up:
	docker compose -f ./srcs/docker-compose.yml up -d --build
down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	@images=$$(docker image ls -q)
	if [ -n "$$images" ]; then \
		docker rmi $$images;\
	else
		echo "no image to delete"	
	fi

fclean: clean
	@sudo rm -rf /home/apaterno/data/db/*
	@sudo rm -rf /home/apaterno/data/db/*
	@docker compose down -v
 
re: fclean all

