all:
        @printf "start containers\n"
        @bash srcs/requirements/wordpress/tools/make_dir.sh
        @docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
        @printf "build images\n"
        @bash srcs/requirements/wordpress/tools/make_dir.sh
        @docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
        @printf "stop containers\n"
        @docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
        @printf "rebuild containers\n"
        @docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
        @printf "remove containers & data\n"
        @docker system prune -a
        @sudo rm -rf ~/data/wordpress/*
        @sudo rm -rf ~/data/mariadb/*

fclean:
        @printf "total clean-up\n"
        @docker stop $$(docker ps -qa)
        @docker system prune --all --force --volumes
        @docker network prune --force
        @docker volume prune --force
        @sudo rm -rf ~/data/wordpress/*
        @sudo rm -rf ~/data/mariadb/*

.PHONY  : all build down re clean fclean