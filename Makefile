NAME = inception
COMPOSE = docker-compose
SRC_DIR = srcs
ENV_FILE = $(SRC_DIR)/.env
DATA_DIR = /home/$(USER)/data

all: setup $(NAME)

$(NAME):
	@echo "Starting Docker containers..."
	@$(COMPOSE) -f $(SRC_DIR)/docker-compose.yml --env-file $(ENV_FILE) up --build -d

setup:
	@echo "Creating volume folders if they don't exist..."
	@mkdir -p $(DATA_DIR)/db
	@mkdir -p $(DATA_DIR)/wordpress

down:
	@echo "Stopping and removing containers..."
	@$(COMPOSE) -f $(SRC_DIR)/docker-compose.yml down --volumes

fclean: down
	@echo "Removing Docker images..."
	@docker image prune -af
# 	@echo "Removing Docker named volumes..."
# 	@docker volume rm srcs_mariadb_data srcs_wordpress_data || true
#TODO do I need this?

re: fclean all

.PHONY: all setup $(NAME) down re fclean