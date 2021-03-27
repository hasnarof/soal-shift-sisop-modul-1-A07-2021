#!/bin/bash
bash ./soal3a.sh 

file=$(date +%d-%m-%Y)
mkdir "$file"

mv ./Koleksi_* "./$file/"
mv ./Foto.log "./$file/"
echo "Alhamdulillah"
