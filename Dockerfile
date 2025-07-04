# syntax=docker/dockerfile:1.4

ARG GO_VERSION
ARG APP_NAME

FROM golang:${GO_VERSION}-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . ./
RUN go build -o /app/bin/${APP_NAME} ./cmd/app

# ---- final stage ----
FROM alpine
ARG APP_NAME

WORKDIR /app
COPY --from=builder /app/bin/${APP_NAME} /app/${APP_NAME}

ENTRYPOINT ["/app/${APP_NAME}"]