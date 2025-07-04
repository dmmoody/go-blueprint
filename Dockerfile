ARG APP_NAME=go-blueprint
ARG GO_VERSION=1.24.4

FROM golang:${GO_VERSION}-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . ./
RUN mkdir -p /app/bin && \
    go build -o /app/bin/${APP_NAME} ./cmd/app

# ---- final stage ----
FROM alpine
WORKDIR /app

COPY --from=builder /app/bin/go-blueprint /app/go-blueprint

ENTRYPOINT ["/app/go-blueprint"]