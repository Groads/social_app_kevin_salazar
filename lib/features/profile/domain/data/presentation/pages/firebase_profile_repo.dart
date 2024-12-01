import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/entities/profile_user.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/repos/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo{

  final FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
  @override
  
  Future<ProfileUser?> fetchUserProfile(String uid) async{
    try {
      //get user document from firestore
      final userDoc= 
      await firebaseFirestore.collection('users').doc(uid).get();

      if (userDoc.exists){
        final userData = userDoc.data();

        if (userData!=null){

          return ProfileUser(
          uid: uid,
          email: userData['email'], 
          name: userData['name'], 
          bio: userData['bio'] ?? '', 
          profileImageUrl: userData['profileImageUrl'].toString(),
          );
        }
      }

      return null;
    } catch(e){
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateProfile) async {
    try {
       //convert update profile to jason to store in firestore
       await firebaseFirestore
       .collection('users')
       .doc(updateProfile.uid)
       .update({
        'bio': updateProfile.bio,
        'profileImageUrl': updateProfile.profileImageUrl
       });
    }
    catch (e){
      throw Exception(e);
    }
  }
}