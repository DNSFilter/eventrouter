FROM golang:1.20.5 AS builder
WORKDIR  /go/src/github.com/openshift/eventrouter
USER 0
COPY Makefile *.go go.mod go.sum ./
COPY sinks ./sinks

RUN make build

FROM alpine:3.18
USER 1000
COPY --from=builder /go/src/github.com/openshift/eventrouter/eventrouter /bin/eventrouter
CMD ["/bin/eventrouter", "-v", "3", "-logtostderr"]
LABEL version=release-5.8
