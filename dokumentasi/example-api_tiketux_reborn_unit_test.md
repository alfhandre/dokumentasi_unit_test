# Contoh implementasi:
### Berikut merupakan salah satu contoh implementasi dari repo `api-tiketux-reborn` 
---
Terdapat class yang bernama `Reservasi`, dan di dalamnya terdapat function `KotaPopuler()` yang digunakan untuk mendapatkan data kota-kota populer. Function ini merupakan asynchronous function yang akan mengembalikan response berupa objek bertipe `Future<kotpop.KotaPopulerModel>`.

```dart
class Reservasi {

  Future<kotpop.KotaPopulerModel> KotaPopuler(
      {bool? bearer = false, String? bearerToken}) async {
    String phoneType = await FunctionDataConst().getPhoneType();
    String phoneOS = await FunctionDataConst().getOS();
    String versionApps = await FunctionDataConst().getVersion();

    try {
      String auth = function.getBasicAuth();
      final uri = Uri.parse("${url}tiketux/kota-populer");
      final response = await client.get(
        uri,
        headers: {
          "authorization": bearer == false ? "$auth" : "Bearer $bearerToken",
          "x-versi-app": "v.$versionApps",
          "x-hp-tipe": phoneType,
          "x-hp-os": phoneOS
        },
      );

      return kotpop.kotaPopulerModelFromJson(response.body);
    } catch (e) {
      return kotpop.KotaPopulerModel(
          status: "FAILED $e", results: kotpop.Results(listKota: []));
    }
  }
}

```

berikut merupakan isi dari model KotaPopularModel

```dart
// To parse this JSON data, do
//
//     final kotaPopulerModel = kotaPopulerModelFromJson(jsonString);

import 'dart:convert';

KotaPopulerModel kotaPopulerModelFromJson(String str) =>
    KotaPopulerModel.fromJson(json.decode(str));

String kotaPopulerModelToJson(KotaPopulerModel data) =>
    json.encode(data.toJson());

class KotaPopulerModel {
  KotaPopulerModel({
    this.status,
    this.results,
  });

  String? status;
  Results? results;

  factory KotaPopulerModel.fromJson(Map<String, dynamic> json) =>
      KotaPopulerModel(
        status: json["status"] == null ? null : json["status"],
        results:
            json["results"] == null ? null : Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "results": results == null ? null : results!.toJson(),
      };
}

class Results {
  Results({
    this.listKotaDepan,
    this.listKota,
  });

  List<ListKota>? listKotaDepan;
  List<ListKota>? listKota;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        listKotaDepan: json["list_kota_depan"] == null
            ? null
            : List<ListKota>.from(
                json["list_kota_depan"].map((x) => ListKota.fromJson(x))),
        listKota: json["list_kota"] == null
            ? null
            : List<ListKota>.from(
                json["list_kota"].map((x) => ListKota.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list_kota_depan": listKotaDepan == null
            ? null
            : List<dynamic>.from(listKotaDepan!.map((x) => x.toJson())),
        "list_kota": listKota == null
            ? null
            : List<dynamic>.from(listKota!.map((x) => x.toJson())),
      };
}

class ListKota {
  ListKota({
    this.id,
    this.nama,
    this.image,
  });

  int? id;
  String? nama;
  String? image;

  factory ListKota.fromJson(Map<String, dynamic> json) => ListKota(
        id: json["id"] == null ? null : json["id"],
        nama: json["nama"] == null ? null : json["nama"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama": nama == null ? null : nama,
        "image": image == null ? null : image,
      };
}

```

Berikut unit test nya
1. Buat mock dari class Reservasi nya dengan menggunakan annotation `@GenerateMocks`

```dart
// File: reservasi_service_test.dart
import 'package:mockito/annotations.dart';

@GenerateMocks([ReservasiService])
void main() {}
```

2. Lalu jalankan perintah berikut untuk generate file mock:
```bash
dart run build_runner build
```

Akan dihasilkan file seperti:
```
reservasi_service_test.mocks.dart
```

3. Setup
- inisialisasi mock object MockReservasi yang merupakan hasil generate dengan mockito.
- Disiapkan pada blok setUp() agar dibuat ulang sebelum setiap test.

```dart
void main() {
  late MockReservasi mockReservasiService;

  setUp(() {
    mockReservasiService = MockReservasi();
  });
}
```

4. Group: `getKotaPopular()`

4a. Success - Bearer False & Valid Token
- Menguji skenario sukses saat menggunakan autentikasi Basic Auth (bearer: false).
- Data dummy disiapkan (dataSuccess) dan di-stub melalui when(...).thenAnswer(...).
- expect() memverifikasi bahwa response mengandung status OK.
- verify() memastikan method dipanggil tepat satu kali dengan parameter yang sesuai.

```dart
    test("getKotaPopular() success -> bearer false & valid token ", () async {
      final dataSuccess = KotaPopulerModel(
          status: "OK",
          results: Results(
              listKota: [ListKota(id: 1)], listKotaDepan: [ListKota(id: 1)]));

      when(mockReservasiService.KotaPopuler(
              bearer: false, bearerToken: "valid_token"))
          .thenAnswer((_) async => dataSuccess);
      final res = await mockReservasiService.KotaPopuler(
          bearer: false, bearerToken: "valid_token");

      expect(res.status, "OK");
      verify(mockReservasiService.KotaPopuler(
              bearer: false, bearerToken: "valid_token"))
          .called(1);
    });
```

4b. Fail - Invalid Bearer Token
- Menguji skenario gagal saat token yang digunakan salah (bearerToken: "invalid_token").
- Fungsi dipastikan mengembalikan object model dengan field status dan results bernilai null.
- Diverifikasi bahwa function tetap dipanggil satu kali.
```dart
test("getKotaPopular() fail -> invalid bearerToken", () async {
      final dataFail = KotaPopulerModel(status: null, results: null);

      when(mockReservasiService.KotaPopuler(
              bearer: false, bearerToken: "invalid_token"))
          .thenAnswer((_) async => dataFail);

      final res = await mockReservasiService.KotaPopuler(
          bearer: false, bearerToken: "invalid_token");

      expect(res.status, null);
      expect(res.results, null);

      verify(mockReservasiService.KotaPopuler(
              bearer: false, bearerToken: "invalid_token"))
          .called(1);
    });
```

5. Test Deserialisasi: `fromJson`

5a. Full Data
- Menguji parsing JSON lengkap menjadi objek KotaPopulerModel.
- Diuji apakah nilai properti sudah terisi sesuai data JSON.

```dart
  test('fromJson with full data', () {
    final json = {
      "status": "OK",
      "results": {
        "list_kota_depan": [
          {"id": 1, "nama": "Jakarta", "image": "img/jkt.png"}
        ],
        "list_kota": [
          {"id": 2, "nama": "Bandung", "image": "img/bdg.png"}
        ]
      }
    };

    final model = KotaPopulerModel.fromJson(json);
    expect(model.status, "OK");
    expect(model.results!.listKota!.length, 1);
    expect(model.results!.listKotaDepan!.first.nama, "Jakarta");
  });
```

5b. Null Fields
- Menguji skenario di mana field status dan results bernilai null.
- Diharapkan tidak terjadi error dan hasil tetap valid secara struktur model.

```dart
  test('fromJson with null fields', () {
    final json = {"status": null, "results": null};
    final model = KotaPopulerModel.fromJson(json);
    expect(model.status, null);
    expect(model.results, null);
  });
```

6. Test Serialisasi: `toJson`

6a. Full Data
- Menguji konversi object KotaPopulerModel menjadi bentuk JSON.
- Dicek apakah hasil JSON memiliki field sesuai data yang diberikan.

```dart
  test('toJson with full data', () {
    final model = KotaPopulerModel(
      status: "OK",
      results: Results(
        listKota: [ListKota(id: 1, nama: "A", image: "img/a.png")],
        listKotaDepan: [ListKota(id: 2, nama: "B", image: "img/b.png")],
      ),
    );

    final json = model.toJson();
    expect(json["status"], "OK");
    expect(json["results"]["list_kota"].first["id"], 1);
  });
```

6b. Null Fields
- Menguji apakah hasil serialisasi tetap valid walau ada field null
```dart
  test('toJson with null fields', () {
    final model = KotaPopulerModel(status: null, results: null);
    final json = model.toJson();
    expect(json["status"], null);
    expect(json["results"], null);
  });
```


7. Test Serialisasi & Deserialisasi Kombinasi
- Menguji integritas proses konversi dua arah: fromJson → object & toJson → string JSON kembali
- Pastikan tidak ada kehilangan data selama proses

```dart
  test(
      'kotaPopulerModelFromJson & kotaPopulerModelToJson should convert properly',
      () {
    const jsonString = '''
  {
    "status": "OK",
    "results": {
      "list_kota_depan": [{"id": 1, "nama": "Jakarta", "image": "img/jkt.png"}],
      "list_kota": [{"id": 2, "nama": "Bandung", "image": "img/bdg.png"}]
    }
  }
  ''';

    final model = kotaPopulerModelFromJson(jsonString);
    expect(model.status, "OK");
    expect(model.results?.listKota?.first.nama, "Bandung");

    final encodedJson = kotaPopulerModelToJson(model);
    expect(encodedJson, isA<String>());
    expect(encodedJson.contains('"status":"OK"'), isTrue);
  });
```