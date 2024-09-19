FROM golang:1.22 AS builder

WORKDIR /app
ENV GOPROXY=https://goproxy.cn,direct

COPY go.mod go.sum ./
RUN go mod download

# 复制所有代码并构建项目
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/step2k3s

FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /app

# 从构建阶段复制生成的二进制文件
COPY --from=builder /app/step2k3s /app/

EXPOSE 8080

ENTRYPOINT ["./step2k3s"]