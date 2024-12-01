import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_kevin_salazar/features/auth/data/firebase_auth_repo.dart';
import 'package:social_app_kevin_salazar/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_app_kevin_salazar/features/auth/presentation/cubits/auth_states.dart';
import 'package:social_app_kevin_salazar/features/auth/presentation/pages/auth_page.dart';
import 'package:social_app_kevin_salazar/features/home/presentation/pages/home_page.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/cubits/profile_cubit.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/firebase_profile_repo.dart';
import 'package:social_app_kevin_salazar/features/storage/data/firebase_storage_repo.dart';
import 'package:social_app_kevin_salazar/themes/light_mode.dart';


/*
APP - Root level
 -----------------------------------------
Repositories: for the database
- firebase

Bloc Providers: for state managment
- auth
- profile
- post
- search
- theme


Check Auth State
- unauthenticated -> auth page(login/register)
-authrnticated -> home page
*/
class MyApp extends StatelessWidget {
  // auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  // profile repo
  final firebaseProfileRepo = FirebaseProfileRepo();

//storage repo
final firebaseStorageRepo = FirebaseStorageRepo();


  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Provider cubits to app
    return MultiBlocProvider(
      providers: [
          // auth cubit
          BlocProvider<AuthCubit>(
            create: (context)=> AuthCubit(authRepo: firebaseAuthRepo)..checkAuth()
          ),
          // profile cubit
          BlocProvider<ProfileCubit>(
            create: (context)=> ProfileCubit(
              profileRepo: firebaseProfileRepo,
              storageRepo: firebaseStorageRepo,
              ),
            ),
      ], 
    child:MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit,AuthState>(
          builder: (context, authState) {
                print(authState);
                //unauthenticated -> auth page(login/register)
                if (authState is Unauthenticated){
                  return const AuthPage();
                }
                //authrnticated -> home page
                if (authState is Authenticated){
                  return const HomePage();
                }

                // loading..
                else {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator(),
                    )
                  );
                }
          } , 
          // listen for errors
          listener: (context,state) {
            if (state is AuthError){
              ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
            }
          }
          ),
        ),
      );
  }
}