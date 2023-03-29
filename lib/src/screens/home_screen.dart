import 'package:flutter/material.dart';
import 'package:install_inspect/src/services/firebase_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getInstalacion(),
          builder: ((context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return Text(snapshot.data?[i]['nombre']);
                });
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'formInstalacion'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
