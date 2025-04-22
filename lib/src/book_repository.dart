import 'package:belajar_dart_unit_test/src/book.dart';

class BookRepository {
  void save(Book book) {
    print("save $book");
    throw UnsupportedError("save not supported");
  }

  void delete(Book book) {
    print("delete $book");
    throw UnsupportedError("delete not supported");
  }

  void update(Book book) {
    print("update $book");
    throw UnsupportedError("update not supported");
  }

  Book? findById(String id) {
    print("findById $id");
    throw UnsupportedError("find book by id not supported");
  }
}
