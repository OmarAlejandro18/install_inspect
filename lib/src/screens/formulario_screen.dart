// import 'package:flutter/material.dart';
// import 'package:install_inspect/src/models/instalacion_model.dart';
// import 'package:install_inspect/src/services/firebase_services.dart';
// import 'package:install_inspect/src/widgets/widgets.dart';

// // ignore: must_be_immutable
// class FormularioInstalacionScreen extends StatelessWidget {
//   FormularioInstalacionScreen({super.key});
//   final _formKey = GlobalKey<FormState>();
//   final nombreInstalacion = TextEditingController();
//   final ubicacion = TextEditingController();
//   final tipoComponente = TextEditingController();
//   final equipoCritico = TextEditingController();
//   final inspeccionTecnica = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Center(child: Text('Instalacion'))),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               const Text(
//                 'Ingresa los datos de la instalación',
//                 style: TextStyle(fontSize: 18),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               InputDato(
//                   controlador: nombreInstalacion,
//                   hinText: 'Nombre de la Instalación'),
//               const SizedBox(
//                 height: 15,
//               ),
//               InputDato(
//                 controlador: ubicacion,
//                 hinText: 'Ubicación',
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               InputDato(
//                 controlador: tipoComponente,
//                 hinText: 'Tipo de Equipo Componente',
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               AlertaInstalacion(
//                 valorCampo: equipoCritico,
//                 hinText: 'Equipo Critico',
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               AlertaInstalacion(
//                 valorCampo: inspeccionTecnica,
//                 hinText: 'inspección Tecnica del riesgo',
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               ElevatedButton(
//                 onPressed: () => {
//                   if (_formKey.currentState!.validate())
//                     {
//                       salidaEstandar(nombreInstalacion, ubicacion,
//                           tipoComponente, equipoCritico, inspeccionTecnica),
//                       // InsertarInstalacion().agregarInstalacion(Instalacion(
//                       //     nombreInstalacion: nombreInstalacion.text,
//                       //     ubicacion: ubicacion.text,
//                       //     tipoComponente: tipoComponente.text,
//                       //     equipoCritico: equipoCritico.text,
//                       //     inspeccionTecnica: inspeccionTecnica.text,
//                       //     completed: false,
//                       //     timestamp:
//                       //         DateTime.now().millisecondsSinceEpoch ~/ 1000)),
//                       agregarInstalacion(Instalacion(
//                           nombreInstalacion: nombreInstalacion.text,
//                           ubicacion: ubicacion.text,
//                           tipoComponente: tipoComponente.text,
//                           equipoCritico: equipoCritico.text,
//                           inspeccionTecnica: inspeccionTecnica.text,
//                           completed: false,
//                           timestamp:
//                               DateTime.now().millisecondsSinceEpoch ~/ 1000)),
//                       nombreInstalacion.text = '',
//                       ubicacion.text = '',
//                       tipoComponente.text = '',
//                       equipoCritico.text = '',
//                       inspeccionTecnica.text = '',
//                       Navigator.pushNamed(context, 'formInspeccion')
//                     }
//                 },
//                 child: const Text('Guardar'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class InputDato extends StatelessWidget {
//   final TextEditingController controlador;
//   final String hinText;

//   const InputDato(
//       {super.key, required this.controlador, required this.hinText});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: Container(
//         alignment: Alignment.centerLeft,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(
//               offset: Offset(4, -4),
//               blurRadius: 6,
//               color: Colors.black26,
//             ),
//           ],
//         ),
//         height: 60,
//         child: TextFormField(
//           controller: controlador,
//           style: const TextStyle(
//             color: Colors.black87,
//           ),
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Por favor ingrese $hinText';
//             }
//             return null;
//           },
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.only(top: 14),
//             prefixIcon: const Icon(
//               Icons.email,
//               color: Colors.white,
//             ),
//             hintText: hinText,
//             hintStyle: const TextStyle(color: Colors.black38),
//           ),
//         ),
//       ),
//     );
//   }
// }

// salidaEstandar(
//     TextEditingController nombreInstalacion,
//     TextEditingController ubicacion,
//     TextEditingController tipoComponente,
//     TextEditingController equipoCritico,
//     TextEditingController inspeccionTecnica) {
//   print('nombre es ${nombreInstalacion.text}');
//   print('ubicacion es ${ubicacion.text}');
//   print("tipoComponente es ${tipoComponente.text}");
//   print("equipoCritico es ${equipoCritico.text}");
//   print('inspeccionTecnica ${inspeccionTecnica.text}');
// }
