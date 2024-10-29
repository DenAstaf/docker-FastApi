# информация о том, как запустить контейнер
# docker build -t testdocker . – собирает образ
# docker run -d -p 8000:8000 testdocker – запускает контейнер
# http://localhost:8000/ping/ - ссылка, для просмотра результата

# Указываем базовый Python
FROM python:3.11.9

# Устанавливает переменные окружения для оптимизации поведения Python
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

#Устанавливает рабочую директорию внутри контейнера
WORKDIR /app

# Устанавливает Poetry.
RUN pip install poetry

# Отключает создание виртуальных окружений, т.е Poetry устанавливает зависимости в глобальное окружение контейнера, а не в отдельное виртуальное окружение
RUN poetry config virtualenvs.create false

# Копирует файлы pyproject.toml и poetry.lock для установки зависимостей (./ - текущая рабочая директория)
COPY poetry.lock pyproject.toml ./

# Устанавливает зависимости, используя Poetry
RUN poetry install --no-root

# Копирует остальной исходный код приложения
COPY . .

#Открывает порт 8000 для доступа к приложению
EXPOSE 8000

# Запускает команду для старта сервера FastApi
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]