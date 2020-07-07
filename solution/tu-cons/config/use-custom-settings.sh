export NS=io.confluent.monitoring.clients.interceptor
yum install -y libmnl
rpm -i --nodeps http://vault.centos.org/8.1.1911/BaseOS/x86_64/os/Packages/iproute-tc-4.18.0-15.el8.x86_64.rpm
tc qdisc add dev eth0 root netem delay 10ms
kafka-console-consumer \
    --group group-with-custom-settings \
    --bootstrap-server kafka-1:9092 \
    --from-beginning \
    --topic tuning-topic \
    --consumer-property "interceptor.classes=${NS}.MonitoringConsumerInterceptor" \
    --consumer-property "client.id=custom-settings-consumer" \
    --consumer-property "fetch.max.wait.ms=200" \
    --consumer-property "fetch.min.bytes=16777216"
