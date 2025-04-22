@Skip("This unit test still broken")
import 'package:test/test.dart';

int sum(int a, int b) => a + b;

void main() {
  group("test sum()", () {
    test(
      "positive",
      () {
        expect(sum(1, 2), equals(3));
      },
      // // bisa dikasi skip disini misal functionnya masih salah
      // skip: "this function still broken",
    );

    test("negative", () {
      expect(sum(10, -5), equals(5));
    });
  });
}
