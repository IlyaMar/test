FROM python:3.10-slim

RUN useradd worker -u 10001 --create-home --user-group  # <--- Create a user

RUN apt update && apt install curl iputils-ping iproute2 lsof net-tools -y

# Устанавливаем необходимые зависимости
RUN pip install --upgrade pip
RUN pip install flask

# Копируем код приложения в контейнер
COPY app.py /app/

# Устанавливаем рабочий каталог
WORKDIR /app

USER worker

# Запускаем веб-сервер при запуске контейнера
CMD ["python", "app.py"]
