import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_kevin_salazar/features/auth/domain/entities/app_user.dart';
import 'package:social_app_kevin_salazar/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/components/bio_box.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/cubits/profile_cubit.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/cubits/profile_states.dart';
import 'package:social_app_kevin_salazar/features/profile/domain/data/presentation/pages/edit_profile_page.dart';


class ProfilePage extends StatefulWidget {

  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //cubits
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit =  context.read<ProfileCubit>();
  
  // current user
  late AppUser? currentUser = authCubit.currentUser;

  // on startup,
  @override
  void initState() {
    super.initState();


    // load user profile data
    profileCubit.fetchUserProfile(widget.uid);
  }


  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder:(context,state){
      //loaded
      if(state is ProfileLoaded){

        //get loaded users
        final user = state.profileUser;


        //SCAFFOLD
        return Scaffold(

      //  APP BAR
      appBar: AppBar(
        title: Text(user.name),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          //edit profile button
          IconButton(
            onPressed: ()=> Navigator.push(
              context,MaterialPageRoute(
                builder: (context)=> EditProfilePage(user: user),
                )), 
          icon: const Icon(Icons.settings),
          )
        ],
      ),


      // BODY
      body: Column(
        children: [
          //email
          Text(user.email, style: 
          TextStyle(color: Theme.of(context).colorScheme.primary ),
            ),
      
         const SizedBox(height: 25),
      
          //profile pic
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 120,
            width: 120,
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Icon(Icons.person, 
              size: 72,
              color: Theme.of(context).colorScheme.primary,),
            ),
          ),
      
          const SizedBox(height: 25),
          //bio box
          Padding(
            padding: const EdgeInsets.only(left:25.0),
            child: Row(
              children: [
                Text("Bio", 
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
            
          const SizedBox(height: 10),
 

          BioBox(text: user.bio),


          // posts
          Padding(
            padding: const EdgeInsets.only(left:25.0, top: 25),
            child: Row(
              children: [
                Text("Posts", 
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
       ],
      ),
      
    );
      }
      //loading..
       else if (state is ProfileLoading){
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
       } else {
        return const Center(child: Text("No profile found.."),
        );
       }
      }, 
      );
  }
}