package api

import (
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
)

func Start() {
	r := chi.NewRouter()

	// Basic health route
	r.Get("/health", func(w http.ResponseWriter, r *http.Request) {
		_, err := w.Write([]byte("OK"))
		if err != nil {
			log.Printf("failed to write response: %v", err)
		}
	})

	log.Println("🌐 API server listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", r))
}
