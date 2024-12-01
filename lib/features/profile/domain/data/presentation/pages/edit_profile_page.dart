

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_kevin_salazar/features/auth/presentation/components/my_text_field.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/cubits/profile_cubit.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/cubits/profile_states.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/entities/profile_user.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final bioTextController = TextEditingController();

  //update profile button pressed
  void updateProfile ()async {

// profile cubit
final profileCubit = context.read<ProfileCubit>();

    if (bioTextController.text.isNotEmpty){
       profileCubit.updateProfile(uid: widget.user.uid, 
       newBio: bioTextController.text
       );
    }
  }
  //BUILD UI

  @override
  Widget build(BuildContext context) {

    //SCAFFOLD
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
          
       // profile loading..
       if (state is ProfileLoading){
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              CircularProgressIndicator(),
              Text("Uploading..."),
            ],),
          )
        );
       }

       //profile error
       else {
        // edit form
       return buildEditPage();
       }

       

      },
      listener: (context, state) {
        if (state is ProfileLoaded){
          Navigator.pop(context);
        }

      },
    );
  }

  Widget buildEditPage({double uploadProgress = 0.0}){
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"),
      foregroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        //save button
        IconButton(
          onPressed:updateProfile, 
          icon: const Icon(Icons.upload),
          ),
      ],
      ),
      body: Column(
        children: [
         // profile picture

         //bio
         const Text("Bio"),

         const SizedBox(height: 25),

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 25.0),
           child: MyTextField(controller: bioTextController, 
           hintText: widget.user.bio, 
           obscureText:false ),
         ),
      ],),
    );
  }
}