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