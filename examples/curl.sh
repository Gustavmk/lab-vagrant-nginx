# Web request to Load Balancer
curl -s -v -X GET http://test.com

# Web request to Load Balancer - Metrics
curl -s -v -X GET http://192.168.56.31:8080/status

# Load Testing 
ab -c 10 -n 100000 http://test.com:80/

# LB - Metrics - NGINX Exporter
http://192.168.56.31:9113/metrics

