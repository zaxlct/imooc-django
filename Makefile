# Use development settings for running django dev server.
export DJANGO_SETTINGS_MODULE=imooc.settingsdev

# Initializes virtual environment with basic requirements.
prod:
	pip install -r requirements.txt

# Installs development requirements.
dev:
	pip install -r requirements.txt
	pip install -r requirements-dev.txt


# Runs development server.
# This step depends on `make dev`, however dependency is excluded to speed up dev server startup.
run:
	python manage.py runserver

# Creates migrations and migrates database.
# This step depends on `make dev`, however dependency is excluded to speed up dev server startup.
migrate:
	python manage.py makemigrations
	python manage.py migrate
