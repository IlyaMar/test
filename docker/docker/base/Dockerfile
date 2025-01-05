FROM python:3.10-slim

RUN useradd worker -u 10001 --create-home --user-group  # <--- Create a user

RUN apt update && apt install curl iputils-ping iproute2 lsof net-tools ncat -y

# Устанавливаем необходимые зависимости
RUN pip install --upgrade pip

CMD ["sleep", "3600"]
