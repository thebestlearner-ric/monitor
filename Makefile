.PHONY: build run

NAME = website-check

build:
	docker build -t $(NAME) .

run:
	docker run -d --name $(NAME) $(NAME)
