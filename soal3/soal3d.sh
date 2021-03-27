#!/bin/bash

namafiles=$(date +"%d%m%Y")

zip -P "$namafiles" -r -m Koleksi.zip ./Kucing_* ./Kelinci_*
