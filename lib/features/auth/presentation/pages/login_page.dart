/*
LOGIN PAGE

On this page, an existing user can login with their:

-email
-pw

----------------------------------------------------------
 Once the user successfully logs in,will be redirected to home page.

 if user doesnt have an account yet,they can go to register page from here to
 create one.

*/

import 'package:flutter/material.dart';
import 'package:social_app_kevin_salazar/features/auth/presentation/components/my_button.dart';
import 'package:social_app_kevin_salazar/features/auth/presentation/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State <LoginPage> createState() =>  _LoginPageState();
}

class _LoginPageState extends State <LoginPage> {

// text controllers
final emailController = TextEditingController();
final pwController = TextEditingController();

// BUILD UI
  @override
  Widget build(BuildContext context) {

    //SCAFFOLD
    return Scaffold(

      // BODY
      body:SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[ 
            
            //logo
            Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            
              ),
              const SizedBox(height:50),
              //welcome back msg
              Text("Welcome back, you've been missed!",
              style : TextStyle(color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
               ),
              ),
              const SizedBox(height: 25),
              //email textfield
              MyTextField(
              controller: emailController, 
              hintText: "Email",
              obscureText: false,
               ),

              const SizedBox(height: 10),
            
              //pw textfield
              MyTextField(
              controller: pwController, 
              hintText: "Password",
              obscureText: true,
               ),
              const SizedBox(height: 25),
              // login button
              MyButton(onTap: (){}, 
              text: "Login",
              ),
              const SizedBox(height: 50),
              //not a member? register now
              Text("Not a member? Register Now", 
              style: 
              TextStyle(color: Theme.of(context).colorScheme.primary )
              ),
             ],
            ),
          ),
        ),
      ),
    );
  }
}