FROM golang:1.22.0 AS builder

WORKDIR /app
ENV GOPROXY=https://goproxy.cn,direct

# 复制 go.mod 和 go.sum 并下载依赖
COPY go.mod go.sum ./
RUN go mod download

# 复制所有代码并构建项目
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/step2k3s

# 使用 alpine 作为基础镜像，尽可能减少体积
FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /app

# 从构建阶段复制生成的二进制文件
COPY --from=builder /app/step2k3s /app/

EXPOSE 8080

ENTRYPOINT ["./step2k3s"]