import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

cargarFoto() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final fileBytes = File(pickedFile.path).readAsBytesSync();
    final imageString = base64Encode(fileBytes);
    return imageString;
  }else{
    return 'null';
  }
}

cargarFotoTermografica() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final fileBytes = File(pickedFile.path).readAsBytesSync();
    final imageString = base64Encode(fileBytes);
    return imageString;
  }else{
    return 'null';
  }
}
