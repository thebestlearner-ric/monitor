.PHONY: build up

NAME = website-check

build:
	docker buildx build -t $(NAME):latest .

run:
	docker run -d --name $(NAME) $(NAME)

up:
	docker-compose up -d

down: 
	docker-compose down