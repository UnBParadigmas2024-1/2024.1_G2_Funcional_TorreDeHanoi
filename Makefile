.PHONY: init
init:
	docker-compose up --build -d
	docker exec -it ubuntu zsh
install:
	chmod +x ./install.sh
	./install.sh