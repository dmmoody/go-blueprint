# go-blueprint

A modular, minimal Go project scaffold for fast, repeatable service creation — with clean layering, PostgreSQL, Docker, and optional module drop-ins.

> This is not an application. It's a **blueprint** for creating new Go services with consistent structure, tooling, and startup behavior.

---

## 🏁 Quick Start

```bash
git clone https://github.com/dmmoody/go-blueprint.git my-service
cd my-service
./scripts/init-project.sh
```

This script will:

* Rename the Go module to `github.com/dmmoody/my-service`
* Update `.envrc` and `Makefile` with the correct `APP_NAME` and `GO_VERSION`
* Reinitialize git history
* Delete itself

---

## 🗂️ Structure

```
cmd/app/                 → Entrypoint binary (wired to server)
internal/server/         → Base orchestration logic (always present)
internal/db/             → Postgres connection layer (pgx)
templates/{api,cli,...}  → Optional modules to enable per project
scripts/enable-*.sh      → Copy & wire templates into internal/
```

---

## 🧩 Enabling Optional Modules

### Enable API (Chi)

```bash
./scripts/enable-api.sh
```

### Enable CLI

```bash
./scripts/enable-cli.sh
```

### Enable Pub/Sub

```bash
./scripts/enable-pubsub.sh
```

All scripts:

* Copy templates into `internal/`
* Wire in code (if possible)
* Delete themselves
* Support `--dry-run` mode

---

## 🦪 Running the App

### Local

```bash
direnv allow
make build
make run
```

### Dockerized

```bash
make docker-build
make docker-run
make docker-down
```

---

## 🐘 Database (Local Dev)

```bash
make db/start   # Starts Postgres via docker-compose
make db/stop    # Stops the container
```

Configure DB connection via `.envrc`. Example provided in `.envrc.example`.

---

## ✅ Assumptions

* You use `direnv` for ENV management (no `.env`)
* You develop with Docker + Homebrew + Go 1.22+
* You prefer CLI bootstrapping over Make-based setup
* You want full control over what gets wired in

---

## 📌 What This Is **Not**

* A framework
* A runtime library
* A full starter application

This is a fast-launch **blueprint** for real-world Go projects.

---

## 🧠 Conventions

* All long-lived apps use `internal/server`
* CLI apps are short-lived and run directly from `main.go`
* Go version and binary name are pinned in `.envrc` and `Makefile`
* All enable scripts self-delete to keep project clean

---

## 📦 Next Steps

* [ ] Add linting via `golangci-lint`
* [ ] Add test scaffolds to `internal/api` and `internal/server`
* [ ] Add CI template (GitHub Actions or self-hosted)
* [ ] Add background job templates (optional)

---

## License

MIT License

Copyright (c) 2025 Duane Moody

Permission is hereby granted, free of charge, to any person obtaining a copy...
