@OnPlatform({"windows": Skip("this working in windows")})
import 'package:test/test.dart';

int sum(int a, int b) => a + b;

void main() {
  group("test sum()", () {
    test(
      "positive",
      () {
        expect(sum(1, 2), equals(3));
      },
    );

    test("negative", () {
      expect(sum(10, -5), equals(5));
    },
        // bisa juga gini
        onPlatform: {"mac-os": Skip("this working in mac")});
  });
}
