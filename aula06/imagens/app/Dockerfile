FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y golang-go
COPY app.go .

RUN CGO_ENABLED=0 go build app.go

FROM alpine:3.13.12
RUN chmod a-w /etc
RUN addgroup -S docker && adduser -S curso -G docker -h /home/curso
RUN rm -rf /bin/*
COPY --from=0 /app /home/curso
USER curso
CMD ["/home/curso/app"]
