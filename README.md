<<<<<<< HEAD
# KaderCek — UI Foundation v0.1.0

KaderCek adalah rancangan aplikasi Android offline-first untuk membantu kader Posyandu mencatat pengukuran pertumbuhan balita.

## Progres versi ini

- [x] Langsung masuk ke Beranda tanpa login.
- [x] Kerangka UI dengan tema hijau dan putih.
- [x] Bottom navigation: Beranda, Data Balita, Pengukuran, Laporan.
- [x] Tampilan status offline sebagai penanda UI.
- [x] Halaman awal untuk tiap menu.
- [x] Tombol navigasi dari Beranda ke menu terkait.
- [ ] Penyimpanan SQLite.
- [ ] Registrasi dan pencarian balita dengan data persisten.
- [ ] Kalkulasi WHO LMS yang divalidasi.
- [ ] Grafik riwayat dari pengukuran nyata.
- [ ] Ekspor PDF/Excel.
- [ ] Backend dan sinkronisasi.

> Catatan: status offline di versi ini masih berupa tampilan UI, bukan deteksi koneksi aktual. Belum ada penyimpanan SQLite. Data ringkasan bernilai nol dan bukan data balita nyata.

## Cara menjalankan

Arsip ini berisi file sumber aplikasi, tetapi bukan seluruh folder platform Android hasil Flutter CLI. Buat kerangka Flutter terlebih dahulu, lalu salin file dari arsip ini ke proyek tersebut.

1. Pastikan Flutter SDK dan Android Studio/Android SDK sudah tersedia.
2. Jalankan:

   ```bash
   flutter doctor
   flutter create kadercek
   ```

3. Ekstrak ZIP ini.
4. Salin `pubspec.yaml`, `analysis_options.yaml`, folder `lib/`, folder `test/`, `.gitignore`, dan `README.md` ke folder `kadercek/`, lalu pilih **replace/overwrite** bila diminta.
5. Buka terminal pada folder proyek `kadercek`, kemudian jalankan:

   ```bash
   flutter pub get
   flutter analyze
   flutter test
   flutter run
   ```

Jika ada peringatan atau error, periksa versi Flutter dan kirimkan output terminal agar bisa diperbaiki bersama.

## Struktur

```text
lib/
  main.dart
  app.dart
  theme/
    app_theme.dart
  models/
    app_tab.dart
  screens/
    home_screen.dart
    children_screen.dart
    measurements_screen.dart
    reports_screen.dart
  widgets/
    app_bottom_navigation.dart
    status_badge.dart
```

## Rencana iterasi

1. UI Foundation dan navigasi.
2. Model data dan SQLite.
3. Form registrasi serta input pengukuran.
4. Mesin antropometri dan pengujian referensi.
5. Riwayat, grafik, dan laporan.
6. Sinkronisasi (setelah backend dan keamanan diputuskan).

## Penting

KaderCek bukan alat diagnosis medis. Kategori status gizi hanya boleh ditampilkan setelah algoritma, tabel referensi, cakupan usia, dan aturan klasifikasi diverifikasi terhadap sumber resmi yang disepakati tim.
=======
# kelompok-15---pemantauan-pertumbuhan-balita-dan-deteksi-dini-risiko-stunting-di-posyandu
tugas project mata kuliah capstone project
>>>>>>> origin/main
