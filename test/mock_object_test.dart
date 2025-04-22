import 'package:belajar_dart_unit_test/book.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<BookRepository>()])
import "mock_object_test.mocks.dart";

void main() {
  var bookRepository = MockBookRepository();
  var bookService = BookService(bookRepository);
  test("Save book must success", () {
    bookService.save("1", "Belajar unit test", 100000);
    // melakukan verifikasi bahwa mock object itu dipanggil
    verify(bookRepository.save(Book("1", "Belajar unit test", 100000)))
        // jangan lupa juga untuk menambah called untuk nge memastikan fungsi di panggil 1x aja
        .called(1);
  });
}
