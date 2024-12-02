import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_kevin_salazar/features/post/domain/entities/post.dart';
import 'package:social_app_kevin_salazar/features/post/domain/repos/post_repo.dart';
import 'package:social_app_kevin_salazar/features/post/presentation/cubits/post_states.dart';
import 'package:social_app_kevin_salazar/features/storage/domain/storage_repo.dart';

class PostCubit extends Cubit<PostStates>{
  final PostRepo postRepo;
  final StorageRepo storageRepo;


  PostCubit({
  required this.postRepo,
  required this.storageRepo}): 
  super(PostsInitial());

  // create a new post

  Future<void> createPost(Post post, {String? imagePath, Uint8List? imageBytes}) async{
    String? imageUrl;
    
    try{
      // handle image upload for mobile platforms (using file path)
    if (imagePath != null){
      emit(PostsUploading());
      imageUrl = await storageRepo.uploadPostImageMobile(imagePath, post.id);

    }

    // handle image upload for web platforms (using file bytes)
     else if (imageBytes != null){
      emit(PostsUploading());
      imageUrl = await storageRepo.uploadPostImageWeb(imageBytes, post.id);
     }

     //give image url to post 
     final newPost = post.copyWith(imageUrl: imageUrl);


     //create post in thr backend
     postRepo.createPost(newPost);

     //re-fetch all posts
     fetchAllPosts();
    }
    catch (e){
      emit(PostsError("Failed to create post: $e"));
    }
  }

  //fetch all posts
  Future<void> fetchAllPosts() async {
    try{
      emit(PostLoading());
      final posts = await postRepo.fecthAllPosts();    
      emit(PostsLoaded(posts));
      }
    catch (e){
      emit(PostsError("Failed to fetch posts: $e"));
    }
  }


  // delete a post
  Future<void> deletePost(String postId)async{
    try{
      await postRepo.deletePost(postId);
    }

    catch (e) {}
  }
}