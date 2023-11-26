# Use an official protobuf base image
FROM golang:1.16 as builder

# Set the working directory
WORKDIR /app

# Install protobuf compiler
RUN apt-get update && apt-get install -y protobuf-compiler

# Install protoc-gen-go
RUN go get -u github.com/golang/protobuf/protoc-gen-go

# The proto files are mounted directly, so no need to copy them
# Generate the protobuf files into the mounted volume
CMD ["sh", "-c", "protoc --go_out=plugins=grpc:/app/generated_pb --proto_path=/app/proto /app/proto/*.proto"]
