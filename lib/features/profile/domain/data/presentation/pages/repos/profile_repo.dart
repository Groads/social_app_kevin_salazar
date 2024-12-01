/*

Profile Repository

*/


import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser updateProfile);
}