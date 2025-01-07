FROM python:3.10-slim

RUN useradd worker -u 10001 --create-home --user-group  # <--- Create a user

RUN apt update && apt install curl iputils-ping iproute2 lsof net-tools -y
RUN apt install ncat -y

# Устанавливаем необходимые зависимости
RUN pip install --upgrade pip
RUN pip install grpcio-tools

#python -m grpc_tools.protoc -I../../protos --python_out=. --pyi_out=. --grpc_python_out=. ../../protos/route_guide.proto
# RUN python -m grpc_tools.protoc -Igrpc/example/custom/path=../../protos --python_out=. --grpc_python_out=. route_guide.proto


# Копируем код приложения в контейнер
COPY *.py /app/

# Устанавливаем рабочий каталог
WORKDIR /app

USER worker

# Запускаем веб-сервер при запуске контейнера
CMD ["python", "app.py"]
