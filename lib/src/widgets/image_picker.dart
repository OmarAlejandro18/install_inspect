// ignore_for_file: unrelated_type_equality_checks
import 'package:image_picker/image_picker.dart';
//import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// cargarFoto() async {
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(source: ImageSource.camera);
//   if (pickedFile != null) {
//     //datosFoto(pickedFile);
//     final fileBytes = File(pickedFile.path).readAsBytesSync();
//     //datosFoto(fileBytes);
//     final imageString = base64Encode(fileBytes);
//     return imageString;
//   } else {
//     return 'null';
//   }
// }

// cargarFotoTermografica() async {
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(source: ImageSource.camera);
//   if (pickedFile != null) {
//     final fileBytes = File(pickedFile.path).readAsBytesSync();
//     final imageString = base64Encode(fileBytes);
//     return imageString;
//   } else {
//     return 'null';
//   }
// }

Future<XFile?> cargarFotoFirestore() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.camera);
  return image;
}

Future<XFile?> cargarFotoTermograficaFirestore() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    return image;
  } else {
    return null;
  }
}

Future<String> subirFotoFireStorage(File imageFile) async {
  if (imageFile != null) {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'inspecciones/foto/${'inspeccionFN' + DateTime.now().toString().substring(0, 10) + '_' + DateTime.now().millisecondsSinceEpoch.toString()}.png');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  } else {}
  return 'null';
}

Future<String> subirfotoTermograficaFireStorage(File imageFile) async {
  if (imageFile != null) {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'inspecciones/fotosTermograficas/${'inspeccionFT' + DateTime.now().toString().substring(0, 10) + '_' + DateTime.now().millisecondsSinceEpoch.toString()}.png');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  } else {
    return 'null';
  }
}
