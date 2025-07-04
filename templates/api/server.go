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
		w.Write([]byte("OK"))
	})

	log.Println("🌐 API server listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", r))
}
