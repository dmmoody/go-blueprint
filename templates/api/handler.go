package api

import (
	"log"
	"net/http"
)

func HelloHandler(w http.ResponseWriter, r *http.Request) {
	_, err := w.Write([]byte("Hello from handler"))
	if err != nil {
		log.Printf("failed to write response: %v", err)
	}
}
