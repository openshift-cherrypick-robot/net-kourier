FROM registry.ci.openshift.org/openshift/release:golang-1.15 AS builder
WORKDIR /app/
COPY . .
RUN go build -mod vendor -o /tmp/kourier ./cmd/kourier

FROM openshift/origin-base
COPY --from=builder /tmp/kourier /ko-app/kourier
ENTRYPOINT ["/ko-app/kourier"]
