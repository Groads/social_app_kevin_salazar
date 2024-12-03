/*

Profile stats

This will be displayed on all profile pages

---------------------------------------------------------------------

Number of:

posts
-followers
-following

*/

import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {

  final int postCount;
  final int followerCount;
  final int followingCount;
  final void Function()? onTap;

  const ProfileStats({
  super.key, 
  required this.postCount,
  required this.followerCount,
  required this.followingCount,
  required this.onTap,
  });

// BUILD UI
  @override
  Widget build(BuildContext context) {

    // text style for count
    var textStyleForCount = TextStyle(
      fontSize: 20,color:Theme.of(context).colorScheme.inversePrimary);

    //text style for text
    var textStyleForText = TextStyle(
      color:Theme.of(context).colorScheme.inversePrimary);
    
    
    return  GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        //posts
       SizedBox(
        width: 100,
         child: Column(children: [
          Text(postCount.toString(), style: textStyleForCount,),
          Text("Posts", style: textStyleForText),
         ],),
       ),
      
        //follower
        
        SizedBox(
          width: 100,
          child: Column(children: [
          Text(followerCount.toString(),style: textStyleForCount,),
          Text("Followers", style: textStyleForText,),
               ],),
        ), 
      
        //following
        SizedBox(
          width: 100,
          child: Column(children: [
          Text(followingCount.toString(),style: textStyleForCount,),
          Text("Following", style: textStyleForText,),
               ],),
        ),
      ],),
    );
  }
}