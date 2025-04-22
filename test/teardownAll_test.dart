import 'package:test/test.dart';

void main() {
  var data = "";

  setUp(() {
    data = "nama";
    print(data);
  });

  tearDown(() {
    print(data);
  });

  tearDownAll(() {
    print("end unit test");
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
