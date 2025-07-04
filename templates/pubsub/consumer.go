package pubsub

import (
	"context"
	"log"
	"time"
)

func StartConsumer(ctx context.Context) {
	log.Println("📬 Starting pubsub consumer...")

	go func() {
		for {
			select {
			case <-ctx.Done():
				log.Println("🛑 Pubsub consumer shutting down")
				return
			default:
				time.Sleep(2 * time.Second)
				log.Println("📨 Processed mock message")
			}
		}
	}()
}
