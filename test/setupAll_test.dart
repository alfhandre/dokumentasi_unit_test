import 'package:test/test.dart';

void main() {
  var data = "";

// bisa digunakan ketika connect ke db, jadi hanya dieksekusi 1 kali
  setUpAll(() {
    print("setupAll Test Start");
  });

  setUp(() {
    data = "nama";
    print(data);
  });

  tearDown(() {
    print(data);
  });

  group("Test String", () {
    // // bisa juga teardown didalam sini jadi hanya dalam group saja
    // tearDown(() {
    //   print(data);
    // });

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
