import 'package:flutter/material.dart';
import 'package:social_app_kevin_salazar/features/home/presentation/pages/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return Scaffold(
      appBar: AppBar(
      title: const Text("Home"),
      ),

      // DRAWER
      drawer:const MyDrawer(),
    );
  }
}