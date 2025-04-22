import 'package:belajar_dart_unit_test/book.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<BookRepository>()])
import "mock_object_test.mocks.dart";

void main() {
  var bookRepository = MockBookRepository();
  var bookService = BookService(bookRepository);
  test("find book by id not found", () {
    expect(() {
      bookService.find("1");
    }, throwsException);

    verify(bookRepository.findById("1")).called(1);
  });

  test("find book by id success", () {
    // manipulasi datava
    when(bookRepository.findById("1"))
        .thenReturn(Book("1", "Belajar Dart", 100000));

    var book = bookService.find("1");
    expect(book, Book("1", "Belajar Dart", 100000));

    verify(bookRepository.findById("1")).called(1);
  });
}
