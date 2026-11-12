# syntax=docker/dockerfile:1.7

FROM golang:1.27.3-trixie AS build

WORKDIR /src

# Keep dependency metadata in its own layer so a retained local BuildKit builder
# can reuse downloads when only application source changes.
COPY src/go.mod ./
RUN go mod download

COPY src/main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build \
    -trimpath \
    -ldflags="-s -w" \
    -o /server .

# The app uses only the Go standard library, so a distroless runtime is unnecessary.
FROM scratch AS runtime

WORKDIR /app
COPY --from=build --chown=65532:65532 /server /server

# The app listens on port 80, so its Kubernetes security context must grant NET_BIND_SERVICE.
EXPOSE 80

# Use a non-root user to run our application for security reasons. Scratch images do not have a user database, so we use the numeric UID/GID of the non-root user.
USER 65532:65532

ENTRYPOINT ["/server"]
