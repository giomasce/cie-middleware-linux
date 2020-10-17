#!/bin/bash

set -e

# g++ -UWIN32 -U_WIN64 -I/usr/include/PCSC -O3 -Wall -c -fmessage-length=0 -fPIC -pthread -MMD -MP -MF"Crypto/MD5.d" -MT"Crypto/MD5.o" -o "Crypto/MD5.o" "../Crypto/MD5.cpp"

for object in `cat objs` ; do
    source=`echo $object | sed -e 's|\(.*\)\.o|\1|'`.cpp
    #echo object $object
    #echo source $source
    (set -x ; g++ -c -g -O3 -fPIC -I/usr/include/PCSC -o $object $source)
done

(set -x ; g++ -shared -o libcie-pkcs11.so `cat objs`  -lcryptopp -lcrypto -lpcsclite)
