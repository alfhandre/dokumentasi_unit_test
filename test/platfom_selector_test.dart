@TestOn("windows")

import 'package:test/test.dart';

int sum(int a, int b) => a + b;

void main() {
  group("test sum()", () {
    test("positive", () {
      expect(sum(1, 2), equals(3));
    });

    test("negative", () {
      expect(sum(10, -5), equals(5));
      TestOn("windows");
    });
  });
}


// import 'dart:io';
// import 'package:test/test.dart';

// void main() {
//   if (!Platform.isWindows) {
//     print("Skipping tests because not running on Windows");
//     return;
//   }

//   group("test khusus Windows", () {
//     test("contoh test", () {
//       expect(1 + 2, equals(3));
//     });
//   });
// }
