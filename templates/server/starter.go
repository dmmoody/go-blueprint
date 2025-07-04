package server

import (
	"context"
	"log"
	"os"
	"os/signal"
	"syscall"
)

// This is a pluggable server starter for use with internal modules
// Copy this file into internal/server and wire in the modules you need
func Start() {
	_, cancel := context.WithCancel(context.Background())
	defer cancel()

	log.Println("🚀 Starting server...")

	// Wire in optional modules here:
	// go api.Start()
	// go pubsub.StartConsumer(ctx)
	// go background.Run(ctx)

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
