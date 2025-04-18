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

ENV PATH=/root/.local/bin:$PATH
ENV FLASK_APP=main.py

EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]