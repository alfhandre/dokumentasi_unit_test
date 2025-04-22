import 'package:belajar_dart_unit_test/learn/services/api_services.dart';
import 'package:belajar_dart_unit_test/learn/viewmodels/post_view_model.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'post_view_model_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('PostViewModel Tests', () {
    late PostViewModel viewModel;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      final apiService = ApiService(client: mockClient);
      viewModel = PostViewModel(apiService: apiService);
    });

    test('getPosts returns list of posts when HTTP 200', () async {
      final mockResponse = jsonEncode([
        {'id': 1, 'title': 'Post 1'},
        {'id': 2, 'title': 'Post 2'},
      ]);

      when(mockClient
              .get(Uri.parse('https://jsonplaceholder.typicode.com/posts')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final posts = await viewModel.getPosts();

      expect(posts.length, 2);
      expect(posts[0].title, 'Post 1');
    });

    test('getPosts throws Exception on HTTP error', () async {
      when(mockClient
              .get(Uri.parse('https://jsonplaceholder.typicode.com/posts')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(viewModel.getPosts(), throwsException);
    });
  });
}
