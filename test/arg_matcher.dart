import 'package:belajar_dart_unit_test/book.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<BookRepository>()])
import "mock_object_test.mocks.dart";

void main() {
  var bookRepository = MockBookRepository();
  var bookService = BookService(bookRepository);

  test("find book by id andre123", () {
    // manipulasi data
    when(bookRepository.findById(argThat(startsWith("and"))))
        .thenReturn(Book("andre123", "Belajar Dart", 100000));

    var book = bookService.find("andre123");
    expect(book, equals(Book("andre123", "Belajar Dart", 100000)));

    verify(bookRepository.findById(any)).called(1);
  });
}
