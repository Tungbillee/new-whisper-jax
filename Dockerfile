FROM python:3.9
WORKDIR /app
EXPOSE 7860
COPY . .
# COPY requirements.txt requirements.txt
# RUN apt-get update \
#     && rm -rf /var/lib/apt/lists/*
# RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -e .["endpoint"]
COPY . .
CMD ["python", "app.py"]