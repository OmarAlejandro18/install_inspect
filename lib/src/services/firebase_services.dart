import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getInstalacion() async {
  List instalacion = [];
  CollectionReference collectionReferenceInstalacion =
      db.collection('instalacion');
  QuerySnapshot queryInstalacion = await collectionReferenceInstalacion.get();
  queryInstalacion.docs.forEach((documento) {
    instalacion.add(documento.data());
  });
  await Future.delayed(const Duration(seconds: 2));
  return instalacion;
}

Future<void> agregarInstalacion(String nombre, String inspector,
    String instrumento, String lugar, String ubicacion) async {
  await db.collection('instalacion').add({
    'nombre': nombre,
    'inspector': inspector,
    'instrumento': instrumento,
    'lugar': lugar,
    'ubicacion': ubicacion
  });
}

Future<void> agregarInspeccion(
    String equipoComponente,
    String fechaInicioInspeccion,
    String horaInicioInspeccion,
    String fechafinalizacionInspeccion,
    String horafinalizacionInspeccion,
    String temperatura,
    String corrienteAireKMH,
    String fuga,
    String concentracion,
    String reparado,
    String fechaReparacion,
    String horaReparacion,
    String concentracionFuga,
    String faltaComponentes,
    String fechaCompraNuevoComponente,
    String fechaReparacionNuevoComponente,
    String concentracionMetano,
    String foto,
    String fotoTermodinamica) async {
  await db.collection('inspeccion').add({
    'equipoComponente': equipoComponente,
    'fechaInicioInspeccion': fechaInicioInspeccion,
    'horaInicioInspeccion': horaInicioInspeccion,
    'fechafinalizacionInspeccion': fechafinalizacionInspeccion,
    'temperatura': temperatura,
    'fuga': fuga,
    // FUGA SI
    'concentracion': concentracion,
    'reparado': reparado,
    // FUGA NO
    // REPARADO SI
    'fechaReparacion': fechaReparacion,
    'horaReparacion': horaReparacion,
    'concentracionFuga': concentracionFuga,
    // REPARADO NO
    'faltaComponentes': faltaComponentes,
    'fechaCompraNuevoComponente': fechaCompraNuevoComponente,
    'fechaReparacionNuevoComponente': fechaReparacionNuevoComponente,
    'concentracionMetano': concentracionMetano,
    // IMAGENES
    'foto': foto,
    'fotoTermografica': fotoTermodinamica,
  });
}
