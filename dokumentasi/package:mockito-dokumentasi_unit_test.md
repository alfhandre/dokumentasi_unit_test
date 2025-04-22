
# Dokumentasi Penggunaan Mockito dalam Unit Test (Dart)

## Overview
Dokumen ini menjelaskan bagaimana menggunakan [Mockito](https://pub.dev/packages/mockito) dalam unit test untuk melakukan mocking terhadap dependency atau service, seperti pada `ReservasiService`. Mockito memungkinkan Anda untuk mengontrol perilaku dari objek yang dimock, serta memverifikasi bahwa metode dipanggil dengan parameter yang benar.

---

## Instalasi

Tambahkan dependensi berikut pada file `pubspec.yaml`:

```yaml
dev_dependencies:
  mockito: ^5.4.2
  build_runner: ^2.4.7
  test: ^1.24.0
```

---

## Langkah-langkah Menggunakan Mockito

### 1. **Buat Abstract Class / Interface**
Pastikan service yang ingin dimock merupakan abstract class atau memiliki method yang bisa dioverride.

Contoh:
```dart
abstract class ReservasiService {
  Future<SearchTujuanModelV2> searchTujuanV2({
    required String asal_id,
    required String asal_tipe,
    required bool bearer,
    required String bearerToken,
    required String textdata,
  });
}
```

---

### 2. **Generate Mock**
Buat file test seperti berikut dan tandai class yang ingin dimock menggunakan annotation `@GenerateMocks`.

```dart
// File: reservasi_service_test.dart
import 'package:mockito/annotations.dart';

@GenerateMocks([ReservasiService])
void main() {}
```

Lalu jalankan perintah berikut untuk generate file mock:
```bash
dart run build_runner build
```

Akan dihasilkan file seperti:
```
reservasi_service_test.mocks.dart
```

---

### 3. **Gunakan Mock dalam Test**
Impor file mock dan gunakan class mock-nya (`MockReservasiService`) dalam test:

```dart
import 'package:test/test.dart';
import './reservasi_service_test.mocks.dart';

void main() {
  late MockReservasiService mockService;

  setUp(() {
    mockService = MockReservasiService();
  });

  test('should return result from mocked service', () async {
    // Buat variabel yg isinya ekspetasi data response 
    final expected = SearchTujuanModelV2(status: "OK", results: Results(listTujuan: []));
    
    // Atur jawaban ketika method tertentu dipanggil
    when(mockService.searchTujuanV2(
      asal_id: "1",
      asal_tipe: "kota",
      bearer: false,
      bearerToken: "valid_token",
      textdata: "",
    )).thenAnswer((_) async => expected);

    // Panggil method dan validasi hasil
    final result = await mockService.searchTujuanV2(
      asal_id: "1",
      asal_tipe: "kota",
      bearer: false,
      bearerToken: "valid_token",
      textdata: "",
    );

    expect(result.status, "OK");
  });
}
```

---

## Fungsi Mockito yang Umum Digunakan

| Fungsi | Keterangan |
|--------|------------|
| `when(...).thenReturn(...)` | Mengatur nilai return untuk fungsi synchronous |
| `when(...).thenAnswer((_) async => ...)` | Mengatur nilai return untuk fungsi async |
| `verify(mock.method(...))` | Memverifikasi bahwa method dipanggil |
| `verifyNever(mock.method(...))` | Memastikan bahwa method **tidak pernah** dipanggil |
| `reset(mock)` | Reset semua interaksi pada mock |
| `any` | Matcher wildcard untuk parameter |
| `captureAny` | Menangkap argumen yang diberikan |
| `throw Exception()` | Simulasi exception saat method dipanggil |

---

## Tips

- Gunakan `late` untuk mendeklarasikan mock agar bisa diinisialisasi ulang pada setiap test.
- Gunakan `setUp()` untuk inisialisasi agar DRY (Don't Repeat Yourself).
- Buat `mock_*.dart` terpisah jika ingin digunakan oleh banyak file test.

---

## Kesimpulan
Mockito adalah alat powerful untuk unit testing di Dart, memungkinkan kita untuk mengisolasi unit yang diuji dan mengatur hasil return dari dependency dengan mudah. Dengan kombinasi `when`, `thenAnswer`, dan `verify`, kita dapat membuat test yang sangat fleksibel dan akurat.
