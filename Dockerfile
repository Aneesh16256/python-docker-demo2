# Build stage
FROM python:3.9-slim as builder

WORKDIR /app
COPY app/requirements.txt .

RUN pip install --user -r requirements.txt

# Runtime stage
FROM python:3.9-slim

WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY app/ .

# Fix: Specify compatible versions
RUN pip install --user werkzeug==2.3.7 flask==2.3.2

ENV PATH=/root/.local/bin:$PATH
ENV FLASK_APP=main.py

EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]