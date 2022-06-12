export CONTAINER_NAME := fs-go-postgres

.PHONY: entity

docker:
	@docker run --rm -d \
		-p 15432:5432 \
		-e TZ=UTC \
		-e LANG=ja_JP.UTF-8 \
		-e POSTGRES_HOST_AUTH_METHOD=trust \
		-e POSTGRES_DB=postgres \
		-e POSTGRES_USER=postgres \
		-e POSTGRES_PASSWORD=postgres \
		-e POSTGRES_INITDB_ARGS=--encoding=UTF-8 \
		--name $(CONTAINER_NAME) \
		postgres:14.2-alpine
psql:
	@docker exec -it $(CONTAINER_NAME) psql -U postgres
stop:
	@docker stop $(CONTAINER_NAME)
container:
	@docker-compose up -d
install:
	@go install github.com/rubenv/sql-migrate/sql-migrate@latest && \
	go install github.com/volatiletech/sqlboiler/v4@latest && \
	go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-psql@latest
migrate:
	@sql-migrate up
entity:
	@rm -rf entity && \
	sqlboiler psql -c sqlboiler.yml --no-tests && \
	go mod tidy
