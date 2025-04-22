# 📦 build_runner untuk Unit Testing di Flutter

`build_runner` adalah package penting di Flutter yang digunakan untuk menjalankan code generation. Dalam konteks unit testing, khususnya dengan `mockito`, `build_runner` sangat berguna untuk menghasilkan class mock secara otomatis.

---

## ✨ Fungsi Utama

Dalam unit test, `build_runner` digunakan untuk:

- Menghasilkan **file mock** berdasarkan anotasi `@GenerateMocks`.
- Mempermudah pengujian dengan menggunakan **class mock otomatis**.
- Menghindari pembuatan mock secara manual, sehingga lebih efisien dan minim kesalahan.

---

## 🛠️ Cara Menggunakan

### 1. Tambahkan ke `pubspec.yaml`

```yaml
dev_dependencies:
  mockito: ^5.4.0
  build_runner: ^2.2.1
  test: any
```

### 2. Tambahkan Anotasi di File Test

```dart
import 'package:mockito/annotations.dart';

@GenerateMocks([Reservasi])
void main() {
  // test logic here
}
```

> Anotasi ini akan memberi tahu `build_runner` untuk membuat class `MockReservasi`.

### 3. Jalankan build_runner

```bash
flutter pub run build_runner build
```

Atau jika kamu ingin overwrite file yang konflik:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Import File Mock

```dart
import 'reservasi_service_test.mocks.dart';
```

---

## 🧪 Contoh Singkat

```dart
@GenerateMocks([Reservasi])
void main() {
  late MockReservasi mockReservasi;

  setUp(() {
    mockReservasi = MockReservasi();
  });

  test('sample test', () async {
    when(mockReservasi.getData()).thenReturn("mocked data");
    expect(await mockReservasi.getData(), "mocked data");
  });
}
```

---

## 📁 File yang Dihasilkan

File seperti berikut akan dihasilkan otomatis:

```
reservasi_service_test.mocks.dart
```

> File ini berisi class `MockReservasi` dan class mock lainnya yang kamu anotasi.

---

## 🔁 Tips

- Selalu jalankan ulang `build_runner` setelah kamu mengubah daftar class di `@GenerateMocks`.

---

## 📚 Referensi

- [Mockito](https://pub.dev/packages/mockito)
- [build_runner](https://pub.dev/packages/build_runner)
