
import 'package:flutter_test/flutter_test.dart';
import 'package:lgx_app/post.dart';

void main() {
  test('Post converts to and from JSON', () {
    final json = {
      'userId': 1,
      'id': 101,
      'title': 'Learn Flutter',
      'body': 'Practice JSON serialization',
    };

    
    final post = Post.fromJson(json);

    expect(post.title, 'Learn Flutter');
    expect(post.id, 101);


    final convertedJson = post.toJson();

    expect(convertedJson, json);
  });
}
