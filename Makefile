deploy:
	docker compose down -v && docker compose up -d --build

start:
	docker compose start

stop:
	docker compose stop