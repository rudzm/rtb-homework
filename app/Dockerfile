# Używamy oficjalnego obrazu Python jako bazy
FROM python:3.9-slim

# Ustawiamy zmienną środowiskową, aby domyślnie uruchamiać aplikację Flask na porcie 5000
ENV APP_HOME /app
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development

# Instalujemy wymagane pakiety
COPY requirements.txt .
RUN pip install -r requirements.txt

# Kopiujemy pliki aplikacji do kontenera
COPY app.py /app/

# Ustawiamy katalog roboczy
WORKDIR /app

# Otwieramy port dla aplikacji
EXPOSE 5000

# Uruchamiamy aplikację Flask
CMD ["flask", "run"]