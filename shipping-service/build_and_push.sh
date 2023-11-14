#!/bin/bash

# 1. Perintah untuk membuat Docker image dari Dockerfile.
# Baris ini menggunakan perintah docker build untuk membuat Docker image 
# dari Dockerfile yang terdapat di direktori saat ini (.). 
# Image ini kemudian diberi tag dicoding-shipping-service:latest.
docker build -t dicoding-shipping-service:latest .

# ubah tag dan nama, sesuai penamaan github package
docker tag dicoding-shipping-service:latest ghcr.io/mueiya/dicoding-shipping-service:latest 
# karena (Personal Access Token) bersifat rahasia, 
# pastikan untuk menjalankan code dibawah untuk menyimpan PAT dalam ENV
# export PAT_GITHUB=personal_access_token
# 2. Login to github
echo $PAT_GITHUB | docker login ghcr.io --username mueiya --password-stdin

# 3. Mengunggah image ke GitHub Packages (GitHub Container Registry)
docker push ghcr.io/mueiya/dicoding-shipping-service:latest

# menggikuti saran ke 2 dengan menggunakan Github packages.