FROM golang:1.12.6-alpine3.9 as builder
RUN apk update && apk add git && git clone https://github.com/minio/s3-benchmark.git && cd s3-benchmark && CGO_ENABLED=0 go build

FROM alpine:3.9
ENTRYPOINT ["./s3-benchmark"]
COPY --from=builder /go/s3-benchmark/s3-benchmark .
