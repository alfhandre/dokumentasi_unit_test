// untuk menandakan, jadi bisa per fitur (ex: menjalankan unit test yg tag nya fitur a)
@Tags(["tag_test"])
import 'package:test/test.dart';

void main() {
  test("test fitur a", () {
    print("fitur a success");
  }, tags: "fiturA");

  test("test fitur b", () {
    print("fitur b success");
  }, tags: "fiturB");
}
