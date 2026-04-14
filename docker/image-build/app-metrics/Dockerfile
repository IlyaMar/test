FROM python:3.10-slim

RUN useradd worker -u 10001 --create-home --user-group  # <--- Create a user


# Копируем код приложения в контейнер
COPY metrics.txt /app/

# Устанавливаем рабочий каталог
WORKDIR /app

USER worker

# Запускаем веб-сервер при запуске контейнера
CMD ["python3", "-m", "http.server"]
