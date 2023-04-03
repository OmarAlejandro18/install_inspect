import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firebase_services.dart';

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: getDataInspeccionFirestore(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error al obtener el dato de Firestore');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Cargando dato de Firestore...');
//         }

//         return Text(snapshot.data['tu_campo'][tu_indice]);
//       },
//     );
//   }
// }