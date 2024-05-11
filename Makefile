TAIL=100

define set-default-container
	ifndef c
	c = django
	else ifeq (${c},all)
	override c=
	endif
endef


set-container:
	$(eval $(call set-default-container))
build:
	docker compose -f docker-compose.dev.yml build
up:
	docker compose -f docker-compose.dev.yml up -d $(c)
up-with-celery:
	docker compose -f docker-compose.dev.yml --profile celery up -d
up-with-ws:
	docker compose -f docker-compose.dev.yml --profile ws up -d
down:
	docker compose -f docker-compose.dev.yml --profile ws --profile celery down
logs: set-container
	docker compose -f docker-compose.dev.yml logs --tail=$(TAIL) -f $(c)
restart: set-container
	docker compose -f docker-compose.dev.yml restart $(c)
exec: set-container
	docker compose -f docker-compose.dev.yml exec $(c) /bin/bash
remove: set-container
	docker compose -f docker-compose.dev.yml rm -fs $(c)

compile-reqs: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) bash -c 'pip install pip-tools && pip-compile pyproject.toml'
install-reqs: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) bash -c 'pip install --no-cache-dir -r requirements.txt'
edit-secrets: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) /bin/bash -c 'apt update && \
																	   apt install vim -y && \
																	   EDITOR=vim ./manage.py edit_secrets'
show-secrets: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) /bin/bash -c './manage.py show_secrets'

migrate: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) bash -c './manage.py migrate'
migrations: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) bash -c './manage.py makemigrations'
run-command: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) bash -c './manage.py $(command)'

pre-commit: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) bash -c 'pre-commit run --all-files'
test: set-container
	docker compose -f docker-compose.dev.yml run --rm $(c) bash -c 'pytest -x'
pre-push: set-container pre-commit test
