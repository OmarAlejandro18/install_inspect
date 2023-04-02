import 'package:flutter/material.dart';

class InspeccionInfo extends StatelessWidget {
  const InspeccionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    int? id =
        int.tryParse(ModalRoute.of(context)!.settings.arguments.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Información inspección ${id! + 1}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('el id es $id'),
          ],
        ),
      ),
    );
  }
}
