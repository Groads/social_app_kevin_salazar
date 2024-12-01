import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app_kevin_salazar/features/post/domain/entities/post.dart';
import 'package:social_app_kevin_salazar/features/post/domain/repos/post_repo.dart';

class FirebasePostRepo implements PostRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //store the posts in a collection called 'posts'
  final CollectionReference postsCollection = 
  FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> createPost(Post post) async {
    try {
       
       await postsCollection.doc(post.id).set(post.toJson());
      
    }

    catch(e) {
      throw Exception("Error creating post: $e");
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await postsCollection.doc(postId).delete();
  }

  @override
  Future<List<Post>> fecthAllPosts() async {
    try{
      // get all posts with most posts at he top
      final postsSnapshot = 
      await postsCollection.orderBy('timestamp', descending: true).get();

      // convert each firestore document from json -> list of posts
      final List<Post> allPosts = postsSnapshot.docs
      .map((doc)=> Post.fromJson(doc.data() as Map<String, dynamic>))
      .toList();

      return allPosts;
    }

    catch(e){
      throw Exception("Eror fetching posts: $e");
    }
  }

  @override
  Future<List<Post>> fetchPostsByUserId(String userId) async {
    try{
      // fetch posts snapshit with this uid
      final postsSnapshot = 
      await postsCollection.where('userId',isEqualTo: userId).get();

      // convert firestore documents form json -> list of posts
      final userPosts = postsSnapshot.docs
      .map((doc) => Post.fromJson(doc.data()as Map<String, dynamic>))
      .toList();


      return userPosts;
    }

    catch(e){
      throw Exception("Error fetching posts by user : $e");
    }
  }
}