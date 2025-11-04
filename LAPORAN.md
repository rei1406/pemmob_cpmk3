# Laporan Tugas Mata Kuliah – Aplikasi MusicWave

- Tanggal: 2025-11-04
- Proyek: `tugas_cpmk3`
- Platform: Flutter (Web)

## Identitas Laporan
- Nama: [Isi Nama]
- NPM/NIM: [Isi NPM/NIM]
- Program Studi: [Isi Prodi]
- Mata Kuliah: [Isi Mata Kuliah]
- Dosen Pengampu: [Isi Nama Dosen]
- Kelas/Semester: [Isi Kelas/Semester]
- Tahun Akademik: [Isi Tahun]
- Tanggal Pengumpulan: [Isi Tanggal]
- Institusi: [Nama Perguruan Tinggi]

## Struktur Folder
Struktur proyek dan penerapan GetX mengikuti pola modular dengan pemisahan `bindings`, `controllers`, dan `views` pada setiap modul.

Struktur ringkas yang relevan (dengan penanda indentasi):

```text
lib/
--- app/
------ modules/
-------- home/
---------- bindings/
---------- controllers/
---------- views/
-------- playlist/
---------- bindings/
---------- controllers/
---------- views/
-------- now_playing/
---------- bindings/
---------- controllers/
---------- views/
-------- search/
---------- bindings/
---------- controllers/
---------- views/
-------- splash/
---------- bindings/
---------- controllers/
---------- views/
------ routes/
-------- app_routes.dart
--- main.dart

web/
--- index.html
--- manifest.json
```

Penerapan GetX:
- Navigasi menggunakan `Get.toNamed(...)` dengan konstanta di `routes/app_routes.dart` (contoh: `Routes.playlist`, `Routes.search`, `Routes.nowPlaying`).
- Pola modul GetX:
  - `bindings/` untuk dependency injection `Controller` (mis. `Get.put`/`Get.lazyPut`) saat route diinisialisasi.
  - `controllers/` berisi logika dan state. Contoh: `NowPlayingController` menyimpan playlist, indeks aktif, dan `coverUrl` (Rx) serta menyediakan `next()`/`previous()`.
  - `views/` berisi widget UI, memakai `Obx` untuk pembaruan UI reaktif dari state controller.
- Konfigurasi aplikasi mengikuti pola GetX (umumnya dengan `GetMaterialApp`) dan mengacu pada konfigurasi route di `lib/app/routes`.

---

## Abstrak
Aplikasi MusicWave telah ditingkatkan agar lebih fungsional dan modern secara tampilan. Fitur navigasi next/previous pada layar Now Playing kini berfungsi, foto track ditampilkan bervariasi dan konsisten di list serta detail, serta seluruh halaman utama (Splash, Home, Playlist, Now Playing, Search) telah diperbarui tampilannya agar lebih bersih dan modern. Verifikasi dilakukan via preview web pada `http://localhost:8080` tanpa error di browser.

## Pendahuluan
### Latar Belakang
Perangkat lunak MusicWave dikembangkan sebagai studi kasus pemrograman mobile/web menggunakan Flutter dan pola arsitektur GetX. Laporan ini menyajikan perancangan, implementasi, serta evaluasi fitur inti dan peningkatan UI.
### Tujuan
- Membuat navigasi lagu di layar Now Playing berjalan mulus tanpa audio playback.
- Menampilkan foto track yang bervariasi (random) pada list dan detail.
- Memodernisasi tampilan seluruh halaman utama agar lebih clean dan konsisten.

### Batasan Masalah
- Modul: `home`, `playlist`, `now_playing`, `search`, `splash`.
- Hanya perubahan UI/UX dan logika kontrol playlist (tanpa audio playback).

## Metodologi dan Implementasi

### 1) Navigasi Now Playing (Next/Previous)
- Mengirim `playlist` penuh dan `index` terpilih dari `PlaylistView` ke `NowPlayingController`.
- Controller menyimpan playlist, indeks aktif, dan `coverUrl` untuk gambar.
- `NowPlayingView` menghubungkan tombol Next/Previous ke fungsi controller dengan logika wrap-around.

### 2) Variasi Foto Track
- Menambahkan `imageUrl` untuk setiap lagu dengan sumber `picsum.photos` agar gambar bervariasi.
- Menampilkan gambar sebagai leading di daftar lagu (Playlist) dan sebagai cover di Now Playing.
- Menyediakan fallback icon jika gambar gagal dimuat.

### 3) Peningkatan UI per Halaman
- Konsistensi `AppBar` (`centerTitle: true`, `elevation: 0`).
- `SafeArea` di seluruh halaman untuk tata letak yang aman.
- Menggunakan `Card` dengan `RoundedRectangleBorder` dan `elevation` ringan.
- Tipografi lebih tebal dan ukuran judul disesuaikan.
- Spasi antar elemen diperbaiki agar tampilan lebih lega.

### Rincian Teknis Per File

- `lib/app/modules/playlist/views/playlist_view.dart`
  - Menambah field `imageUrl` pada setiap item `songs`.
  - Header playlist dibungkus `Card` dan tombol "Mulai Putar" dibulatkan (`borderRadius: 32`).
  - Setiap item lagu dibungkus `Card` dan menampilkan `Image.network` sebagai cover.
  - Memperbaiki kesalahan sintaks yang muncul saat kompilasi.

- `lib/app/modules/now_playing/controllers/now_playing_controller.dart`
  - Menambah observable `coverUrl` dan memuat dari argumen track.
  - Menyediakan `next()` dan `previous()` dengan wrap-around.

- `lib/app/modules/now_playing/views/now_playing_view.dart`
  - Cover image ditampilkan reaktif via `Obx`.
  - UI dimodernisasi: `Card` untuk cover, tipografi judul/artis, slider dengan warna aktif/non-aktif, serta tombol kontrol diperbesar.

- `lib/app/modules/home/views/home_view.dart`
  - `AppBar` dirapikan, body memakai `SafeArea`.
  - Album/artist menggunakan `Card` dan `ClipRRect/ClipOval` dengan rasio grid yang lebih baik.
  - Playlist di Library menampilkan cover bervariasi.
  - Menghapus duplikasi `gridDelegate` yang menyebabkan error kompilasi.

- `lib/app/modules/search/views/search_view.dart`
  - `TextField` diperbarui dengan rounded besar (32), hint style, dan prefix icon.
  - Grid kategori genre dibungkus `Card` dengan spasi dan rasio yang diperbaiki.
  - Menghapus duplikasi argumen dan memperbaiki penutupan widget yang menimbulkan error kompilasi.

- `lib/app/modules/splash/views/splash_view.dart`
  - Menambahkan `SafeArea`, memperbesar icon, mempertebal judul, memberi warna teks, dan `CircularProgressIndicator` untuk animasi loading.

## Hasil dan Pembahasan

Pengujian dilakukan pada device android Redmi Note 10 5g dengan Android versi 13 dan berjalan lancar.

### Uji Fungsional (Ringkas)
- Navigasi Now Playing: tombol Next/Previous berfungsi dengan wrap-around.
- Variasi foto track: cover dan daftar menampilkan gambar yang konsisten per track.
- Pencarian: field input dan grid kategori tampil konsisten, tanpa error kompilasi.
- UI umum: `AppBar`, `SafeArea`, `Card`, tipografi, dan spasi konsisten di seluruh halaman.

> Sisipkan screenshot di bagian-bagian berikut. Gambar dapat disimpan di folder `screenshots/`.

- SplashView
  - ![Screenshot SplashView](screenshots/splash_view.png)
  - <!-- TODO: Sisipkan screenshot SplashView -->

- HomeView
  - ![Screenshot HomeView](screenshots/home_view.png)
  - <!-- TODO: Sisipkan screenshot HomeView -->

- PlaylistView
  - ![Screenshot PlaylistView](screenshots/playlist_view.png)
  - <!-- TODO: Sisipkan screenshot PlaylistView -->

- NowPlayingView
  - ![Screenshot NowPlayingView](screenshots/now_playing_view.png)
  - <!-- TODO: Sisipkan screenshot NowPlayingView -->

- SearchView
  - ![Screenshot SearchView](screenshots/search_view.png)
  - <!-- TODO: Sisipkan screenshot SearchView -->

## Kesimpulan
- Penerapan GetX dan perbaikan UI berhasil meningkatkan konsistensi, keterbacaan, dan kemudahan navigasi pada aplikasi MusicWave.
- Fitur navigasi Now Playing berfungsi stabil, dan variasi gambar track menghadirkan pengalaman visual yang lebih menarik.
- Aplikasi dapat dijalankan pada Flutter Web dan diverifikasi melalui preview tanpa error di browser.
