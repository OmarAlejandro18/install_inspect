import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Aqui se vera lo que esta guardado'),),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.pushNamed(context, 'formInstalacion'),
        child: const Icon(Icons.add),
        ),
    );
  }
}