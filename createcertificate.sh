#!/bin/bash 

if [[ -r certificates ]]; then 
    cd certificates
else 
    mkdir certificates & cd certificates
fi 

# Generate private key
openssl genrsa 2048 > ca-test-private-key.pem

# Generate Certificate with key above 
#openssl req -new -x509 -nodes -days 3650 -key ca-test-private-key.pem -out ca-test-public.crt -subj "/C=UK/ST=Greater London/L=London/O=MyTestName Ltd/CN=myCompanyTestWeb-site1.com"
# Or

openssl req -new -x509 -nodes -sha1 -days 3650 -extensions v3_ca -key ca-test-private-key.pem -out ca-test-public.crt -subj "/C=UK/ST=Greater London/L=London/O=MyTestName Ltd/CN=myCompanyTestWeb-site1.com"

# Check CN in the certificate 
openssl x509 -text -in ca-test-public.crt|grep CN

# Optional step to convert to p12 key  and import to acm
#openssl pkcs12 -inkey ca-test-private-key.pem -in ca-test-public.crt -export -out ca-test-public.p12

# Optionally import to acm via command line. 
# aws acm import-certificate — certificate file://ca-test-public.crt — private-key file://ca-test-private-key.pem — region us-east-1

