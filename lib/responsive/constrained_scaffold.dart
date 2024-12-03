/*

CONSTRAINED SCAFFOLD

this is  a normal scaffold but the width is constrained so that it behaves
consistently on larger screen (particualr for web browsers)

*/

import 'package:flutter/material.dart';

class ConstrainedScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;

  const ConstrainedScaffold({super.key,required this.body,this.appBar,
  this.drawer,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: Center(
        child: ConstrainedBox(constraints: const BoxConstraints(
          maxWidth: 430 // apply your global constraint here
        ),
        child: body,
        ),
      ),
    );
  }
}