package main

import (
	"github.com/gin-gonic/gin"
	"os"
)

func main() {
	r := gin.Default()
	host, _ := os.Hostname()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "Hello, world!",
			"host":    host,
			"version": "3.0.0",
		})
	})
	r.Run()
}
