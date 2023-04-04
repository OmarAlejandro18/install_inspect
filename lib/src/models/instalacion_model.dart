class Instalacion {
  //final int instalacionID;
  final String nombreInstalacion;
  final String ubicacion;
  final String tipoComponente;
  final String equipoCritico;
  final String inspeccionTecnica;
  final bool completed;
  final int timestamp;

  Instalacion(
      {
      //required this.instalacionID,
      required this.nombreInstalacion,
      required this.ubicacion,
      required this.tipoComponente,
      required this.equipoCritico,
      required this.inspeccionTecnica,
      required this.completed,
      required this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      //'instalacionID': instalacionID,
      'nombreInstalacion': nombreInstalacion,
      'ubicacion': ubicacion,
      'tipoComponente': tipoComponente,
      'equipoCritico': equipoCritico,
      'inspeccionTecnica': inspeccionTecnica,
      'completed': completed,
      'timestamp': timestamp
    };
  }
}
