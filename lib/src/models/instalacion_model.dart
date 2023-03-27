class Instalacion {
  //final int instalacionID;
  final String nombre;
  final String inspector;
  final String instrumento;
  final String lugar;
  final String ubicacion;

  Instalacion({
    //required this.instalacionID,
    required this.nombre,
    required this.inspector,
    required this.instrumento,
    required this.lugar,
    required this.ubicacion,
  });
  Map<String, dynamic> toMap() {
    return {
      //'instalacionID': instalacionID,
      'nombre': nombre,
      'inspector': inspector,
      'instrumento': instrumento,
      'lugar': lugar,
      'ubicacion': ubicacion
    };
  }
}
