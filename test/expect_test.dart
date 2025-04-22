import 'package:test/test.dart';

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
