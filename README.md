# soal-shift-sisop-modul-1-A07-2021

Soal Shift Modul 1

Kelompok A07

Sistem Operasi 2021

## 1. 

## 2. Laporan Toko ShiSop
Source code [soal2](https://pip.pypa.io/en/stable/) 

a. Mencari ID transaksi terakhir yang memiliki profit percentage terbesar 

Profit percentage merupakan hasil pembagian dari kolom Price dengan kolom hasil pengurangan kolom Sales dan Profit.

Dataset yang digunakan berupa file .tsv, oleh karena itu untuk pengolahan datanya dapat diselesaikan dengan menggunakan program AWK dengan field separator karakter tab ('\t').

Untuk mencari row dengan profit percentage terbesar dan transaksi yang terakhir dilakukan proses:
1. ````-v max=0```` berfungsi untuk membuar variabel maru max yang digunakan sebagai variabel pembantu untuk mengecek setiap row untuk mendapatkan nilai maksimum.

2. ````NR>1```` digunakan agar proses program melewati/mengabaikan isi baris pertama yaitu nama kolom

3. Dilakukan pemfilteran kondisi untuk mendapatkan nilai maksimum profit percentage, jika nilai profit percentage di row tersebut lebih besar atau sama dengan nilai max saat ini, maka akan disimpan nilai row_id nya pada variabel ````id```` dan nilai variabel ````max```` akan diupdate dengan profit percentage row tersebut.

4. Setelah proses selesai, maka akan keluar output berupa id transaksi serta berapa profit percentage maksimumnya.


```bash
awk -F"\t" -v max=0 'NR>1{    
    if($21/($18-$21)*100>=max){
        id=$1; max=$21/($18-$21)*100
        }
    }
END{
    printf "Transaksi terakhir dengan profit percentage terbesar
            yaitu %d dengan persentase %.2f%.\n\n", id, max
    }' Laporan-TokoShiSop.tsv
```
