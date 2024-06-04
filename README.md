## Development
1. Clone repository ini
2. Buka terminal dan arahkan ke folder repository ini
3. Jalankan perintah `flutter pub get`
4. Cek rest api di file `utils/config.dart` pastikan sudah benar
5. jalankan perintah `flutter run` untuk menjalankan aplikasi

## Package
- flutter_bloc: ^8.1.5
- dio: ^5.4.3+1
- equatable: ^2.0.5
- lottie: ^3.1.2
- flutter_svg: ^2.0.10+1

## Build APK
1. Buka terminal pada folder repository/project ini
2. Jalankan perintah `flutter build apk` untuk versi debug
3. Jalankan perintah `flutter build apk --release` untuk versi release
4. file apk akan ada di folder `build/app/outputs/flutter-apk/`

## Stuktur Project
- assets: folder untuk menyimpan asset seperti gambar, animasi dll
- lib/bloc: folder untuk menyimpan class, event, dan state bloc
- lib/model: folder untuk menyimpan class model
- lib/pages: folder untuk menyimpan halaman aplikasi
- lib/repository: folder untuk menyimpan class repository
- lib/utils: folder untuk menyimpan berbagai class helper

## Menambah Animasi lottie
1. Buka [lottiefiles.com](https://lottiefiles.com/)
2. Pilih animasi yang diinginkan
3. Download file json
4. Pindahkan file json ke folder `assets/lottie`
5. update file `pubspec.yaml` dan tambahkan path file json pada bagian `assets`
```yaml
assets:
    - assets/lottie/file_animasi.json
```
6. Load animasi dengan package `lottie`
```dart
Lottie.asset('assets/lottie/file_animasi.json')
```

## Menambah attribute/parameter pada class model
1. Buka file `lib/model/` sesuai dengan class model yang ingin diubah
2. Tambahkan attribute/parameter yang diinginkan
```dart
class ExampleModel {
  final String name;
  final int age;

  // Tambahkan parameter baru
final String address;

  ExampleModel({
    required this.name, 
    required this.age,
    // Tambahkan parameter baru
    required this.address,
    });
}
```
3. tambahkan juga pada fungsi `fromJson` dan `toJson`
```dart
factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(
      name: json['name'],
      age: json['age'],
      // Tambahkan parameter baru
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      // Tambahkan parameter baru
      'address': address,
    };
  }
```
## Alur Proses Request API
- emit event bloc -> memanggil fungsi di repository -> melakukan request api -> mengembalikan response -> emit state bloc


## Menambah event baru pada bloc
1. Buka file event pada `lib/bloc/` contoh `karyawan_event.dart`
2. Tambahkan event baru
```dart
final class DeleteKaryawan extends KaryawanEvent {
  final int nik;

  DeleteKaryawan(this.nik);
}
```
3. Tambahkan kondisi pada pada file `karyawan_bloc.dart`
```dart
 KaryawanBloc() : super(KaryawanListLoading()) {
    on<KaryawanEvent>((event, emit) {
        // kode lainnya
        if (event is DeleteKaryawan) {
            //memanggil fungsi delete dan memberikan nilai event.id
        }
    });
  }
```

## Memanggil Event Bloc
```dart
KaryawanBloc karyawanBloc = KaryawanBloc();

// Memanggil event bloc
karyawanBloc.add(DeleteKaryawan(1));
```