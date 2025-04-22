@Retry(5)
import 'package:test/test.dart';

void main() {
  test(
    "test faield",
    () {
      expect(1, 2);
    },
    // // bisa juga gini
    // retry: 3,
  );
}
