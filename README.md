# soal-shift-sisop-modul-1-A07-2021

Soal Shift Modul 1

Kelompok A07

Sistem Operasi 2021

## 1. 
1a
https://regexone.com/

1b
https://stackoverflow.com/questions/13242469/how-to-use-sed-grep-to-extract-text-between-two-words
grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | wc -l


1c
https://stackoverflow.com/questions/16317961/how-to-process-each-output-line-in-a-loop
https://linuxize.com/post/how-to-compare-strings-in-bash/
https://stackoverflow.com/questions/1898553/return-a-regex-match-in-a-bash-script-instead-of-replacing-it

1d
https://stackoverflow.com/questions/8948975/how-do-you-do-custom-formatting-with-the-uniq-c-option
https://unix.stackexchange.com/questions/170043/sort-and-count-number-of-occurrence-of-lines


1e
https://stackoverflow.com/questions/8217049/bash-associative-array-sorting-by-value

## 2. Laporan Toko ShiSop
> Source Code 
 > **[soal2_generate_laporan_ihir_shisop.sh](https://github.com/hasnarof/soal-shift-sisop-modul-1-A07-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh)**

> Hasil Laporan 
 > **[hasil.txt](https://github.com/hasnarof/soal-shift-sisop-modul-1-A07-2021/blob/main/soal2/hasil.txt)**
 
Dataset yang digunakan berupa file .tsv, oleh karena itu untuk pengolahan data pada soal nomor 2 dapat diselesaikan dengan menggunakan program AWK dengan field separator karakter tab ('\t').

a. Mencari ID transaksi terakhir yang memiliki profit percentage terbesar 

Profit percentage merupakan hasil pembagian dari kolom Price dengan kolom hasil pengurangan kolom Sales dan Profit.

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
````
b. Mencari nama kustomer yang berada di Alburquerque pada tahun 2017

Untuk menyelesaikan problem ini, digunakan metode pipe di AWK  

1. Script pertama AWK digunakan untuk memfilter baris pada dataset yang memiliki nilai kolom City sama dengan Albuquerque dengan menggunakan conditional statement ````if($10 ~ /Albuquerque/)````. Jika memenuhi kondisi tersebut maka akan memunculkan output $7,$3 yaitu Customer dan Tanggal Transaksi. Setelah itu output akan di-print kemudian drop nama Customer yang duplikat dengan pipe dan command ```` | uniq ````.

2. Setelah itu akan di-pipe lagi dengan command baru yang bertujuan untuk mencari hasil ouput awk sebelumnya yang tanggal transaksinya tahun 2017.

3. Untuk memfilter tahun, maka kita perlu mengekstrak tahun dari kolom tanggal atau kolom $3 dari hasil output AWK yang pertama, tanggal transaksi berformat dd-mm-yy atau field separator berupa "-". Oleh karena itu, output di-split dan disimpan pada array `tgl`. Baru dilakukan conditional statement ````if(tgl[3] ~ /17/)````, jika memenuhi kondisi tersebut maka print $1 dan $2 yang merupakan nama Customer yang di Albuquerque pada tahun 2017.

```bash
echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain :"
awk -F'\t' 'NR>1{ 
    if($10 ~ /Albuquerque/) print $7,$3
    }' Laporan-TokoShiSop.tsv | uniq |
    awk '{split($0,tgl,"-"); if(tgl[3] ~ /17/) print $1,$2}'

printf "\n"
```

c. Tipe segmen customer yang penjualannya paling sedikit dan total transaksinya.

Hampir sama seperti soal sebelumnya, untuk menyelesaikan soal ini menggunakan pipe AWK

1. ````segmen[$8]++```` digunakan untuk menghitung banyak transaksi dengan kolom segmen customer sebagai key.
2. Kemudian looping ```for (s in segmen)``` untuk mengiterasi array segmen di setiap key (```s```), kemudian print key (```s```) serta value-nya (```segmen[s]```).
3. ```sort -g -k 2``` untuk mengurutkan output berdasarkan kolom kedua (banyak transaksi) secara ascending.
4. `head -n 1` untuk menampilkan head-nya saja atau urutan yang paling kecil.
5. Kemudian print sesuai format, dengan split hasil output sebelumnya dengan field separator spasi ' ' menjadi array ```segmen```, ```segmen[1]``` dan ```segmen[2]``` adalah nama segmen yang memiliki transaksi paling sedikit, serta ```segmen[3]``` adalah total transaksinya.

```bash
awk -F'\t' 'NR>1{
    segmen[$8]++
    }
END{ 
    for (s in segmen) print s, segmen[s]
    }' Laporan-TokoShiSop.tsv | sort -g -k 2 | head -n 1 | 
    awk '{split($0,segmen," "); 
    printf "Tipe segmen customer yang penjualannya paling 
            sedikit adalah %s %s dengan %d transaksi.\n\n", 
            segmen[1],segmen[2],segmen[3]}'
```


d. Mencari region yang memiliki profit yang paling sedikit

Konsep soalnya hampir mirip dengan 2.c, bedanya di sini perlu menjumlahkan suatu kolom yaitu kolom profit untuk setiap region.

1. ````region[$13]+=$21```` digunakan untuk mendapatkan total profit dengan kolom region sebagai key.
2. Kemudian looping ```for (r in region)``` untuk mengiterasi array region di setiap key (```r```), kemudian print key (```r```) serta value-nya (```region[r]```).
3. ```sort -g -k 2``` untuk mengurutkan output berdasarkan kolom kedua (jumlah atau total profit) secara ascending.
4. ``` head -n 1``` untuk menampilkan head-nya saja atau urutan yang paling kecil.
5. Kemudian print sesuai format, dengan split hasil output sebelumnya dengan field separator spasi ' ' menjadi array ```region```, ```region[1]``` adalah nama region yang memiliki jumlah profit paling sedikit, serta ```region[2]``` adalah total profitnya.

```bash
awk -F'\t' 'NR>1{
    region[$13]+=$21
    }
END{
    for (r in region) print r,region[r]
    }' Laporan-TokoShiSop.tsv | sort -g -k 2 | head -n 1 |
    awk '{split($0,region," "); 
         printf "Wilayah bagian (region) yang memiliki 
         total keuntungan (profit) yang paling sedikit adalah %s 
         dengan total keuntungan %.2f.\n", region[1],region[2]}'
```

Untuk meng-generate output dalam format file hasil.txt maka semua script tadi digabung dan ditambahkan ```> hasil.txt``` di akhir script.

## 3. Soal No 3
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :
a.  Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...)
b. Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").
c. Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").
d. Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan memindahkan seluruh folder ke zip yang diberi nama “Koleksi.zip” dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).
e. Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya ter-zip saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya ter-unzip dan tidak ada file zip sama sekali.


