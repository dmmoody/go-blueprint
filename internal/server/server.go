package server

import (
	"context"
	"log"
	"os"
	"os/signal"
	"syscall"
)

func Start() {
	_, cancel := context.WithCancel(context.Background())
	defer cancel()

	log.Println("🚀 Base server started (no modules wired in)")

	waitForShutdown(cancel)

	log.Println("🛑 Server shutdown complete")
}

func waitForShutdown(cancel context.CancelFunc) {
	sig := make(chan os.Signal, 1)
	signal.Notify(sig, syscall.SIGINT, syscall.SIGTERM)
	<-sig
	log.Println("💥 Shutdown signal received")
	cancel()
}
