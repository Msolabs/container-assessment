# ---------- Builder Stage ----------
FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY much-to-do/Server/MuchToDo/go.mod .
COPY much-to-do/Server/MuchToDo/go.sum .

RUN go mod download

COPY much-to-do/Server/MuchToDo/ .

RUN CGO_ENABLED=0 GOOS=linux go build \
    -o much-to-do \
    ./cmd/api/main.go

# ---------- Runtime Stage ----------
FROM alpine:3.22

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app/much-to-do .

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
CMD wget --spider http://localhost:8080/health || exit 1

ENTRYPOINT ["./much-to-do"]