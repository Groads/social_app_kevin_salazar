/*

Auth Repository-Outlines the possible auth operations for this app.

*/


import 'package:social_app_kevin_salazar/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo{
  Future<AppUser?> loginWithEmailPassword(String email,String password);
  Future<AppUser?> registerWithEmailPassword(String name,String email,String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}