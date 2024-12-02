import 'package:social_app_kevin_salazar/features/post/domain/entities/post.dart';

abstract class PostRepo {
  Future<List<Post>> fecthAllPosts();
  Future<void> createPost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> fetchPostsByUserId(String userId);
}