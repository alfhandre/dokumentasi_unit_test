
# 📦 Dokumentasi Unit Test dengan `package:test` di Dart

## 📝 Pendahuluan
`package:test` adalah paket resmi dari Dart untuk menulis dan menjalankan unit test, widget test, serta integration test. Dokumentasi ini membahas fungsi utama, struktur dasar, dan best practice dalam penggunaan `test` untuk menjaga kualitas dan reliabilitas kode.

---

## 📦 Instalasi
Pada unit test yg sudah saya buat itu menggunakan versi ^1.21.6. Cara install dengan tambahkan ke dalam `dev_dependencies` di `pubspec.yaml`:

```yaml
dev_dependencies:
  test: ^1.21.6
```

Lalu jalankan:
```bash
flutter pub get
```

---

## ✅ Fungsi Utama
Berikut adalah fungsi-fungsi global yang paling sering digunakan dalam `package:test`:

### 1. `test()`
Mendefinisikan satu unit test.
```dart
test('deskripsi test', () {
  // logika test
  expect(2 + 3, equals(5));
});
```

### 2. `group()`
Mengelompokkan beberapa test agar lebih terstruktur.
```dart
int sum(int a, int b) => a + b;

void main() {
  group("test sum()", () {
    test("positive", () {
      expect(sum(1, 2), equals(3));
    });

    test("negative", () {
      expect(sum(10, -5), equals(5));
    });
  });
}

```

### 3. `expect()`
Mengecek apakah nilai aktual sesuai dengan yang diharapkan.
```dart
expect(nilaiAktual, matcher);
```
Contoh matcher:
- `equals(5)`
- `isNull`, `isNotNull`
- `contains('item')`
- `isA<Type>()`

```dart
String nameString(String nama) => "Hallo $nama";
int sum(int a, int b) => a + b;

void main() {
  test("matcher nameString()", () {
    var res = nameString("andre");

    expect(res, endsWith("andre"));
  });

  test("test sum() matcher", () {
    var res = sum(1, 2);

    expect(res, 3);
    expect(res, equals(3));
    expect(res, greaterThan(2));
    expect(res, lessThan(5));
  });
}

```


### 4. `setUp()` & `tearDown()`
Digunakan untuk inisialisasi atau pembersihan sebelum/ setelah test dijalankan.
```dart
late MyService service;

setUp(() {
  service = MyService();
});

tearDown(() {
  service.dispose();
});
```
contoh setUp()

```dart
void main() {
  var data = "";
  setUp(() {
    data = "nama";
  });

  group("Test String", () {
    test("String Andre", () {
      data = "Andre";
      final res = "$data Lutfi";
      expect(res, "Andre Lutfi");
    });
    test("String Gita", () {
      data = "Gita";
      final res = "$data Daeli";
      expect(res, "Gita Daeli");
    });
  });
}
```
contoh tearDrop()

```dart
void main() {
  var data = "";

  tearDown(() {
    print(data);
  });

  group("Test String", () {
    test("String Andre", () {
      data = "Andre";
      final res = "$data Lutfi";
      expect(res, "Andre Lutfi");
    });
    test("String Gita", () {
      data = "Gita";
      final res = "$data Daeli";
      expect(res, "Gita Daeli");
    });
  });
}

```

### 5. `throwsException`, `throwsA`
Digunakan untuk menguji apakah suatu fungsi melempar exception.
```dart
expect(() => fungsiError(), throwsException);
expect(() => fungsiError(), throwsA(isA<FormatException>()));
```

---

## 🧪 Menjalankan Tes
Gunakan perintah berikut untuk menjalankan seluruh test:
```bash
flutter test
```
Untuk menjalankan file tertentu:
```bash
flutter test test/nama_file_test.dart
```

---

## ⚙️ Konfigurasi Lanjutan

### Timeout & Skip
```dart
test('tes lama', () async {
  await Future.delayed(Duration(seconds: 5));
}, timeout: Timeout(Duration(seconds: 2)), skip: true);
```

### Tagging Test
Menambahkan tag untuk menyaring test tertentu.
```dart
test('tes lambat', () {}, tags: ['slow']);
```

Jalankan dengan filter tag:
```bash
flutter test --tags=slow
```

---

## 📊 Code Coverage
Untuk mengumpulkan informasi cakupan kode:
```bash
flutter test --coverage
```
Outputnya ada di direktori `coverage/`.

---

## 🌐 Platform Spesifik

### Membatasi Platform
```dart
@TestOn('vm') // hanya jalan di Dart VM
```

### File Konfigurasi Global
`dart_test.yaml`:
```yaml
concurrency: 4
tags:
  slow:
    timeout: 10x
```

---

## 🐞 Debugging
- Gunakan `print()` untuk logging
- `printOnFailure()` untuk log saat test gagal
- Debug via VS Code / IntelliJ dengan breakpoint

---

## 📚 Referensi Lanjut
- [https://pub.dev/packages/test](https://pub.dev/packages/test)
- [Dart Testing Docs](https://dart.dev/guides/testing)

---

## 🧼 Best Practice
- Gunakan `group()` untuk struktur test rapi
- Mock dependency agar test tidak tergantung pada API / service eksternal
- Gunakan `setUp()` dan `tearDown()` untuk inisialisasi bersih

---
