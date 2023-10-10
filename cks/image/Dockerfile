FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y golang-go
COPY app.go .

RUN CGO_ENABLED=0 go build app.go

CMD ["./app"]
