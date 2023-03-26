class Inspeccion {
  final int inspeccionID;

  // INSPECCIÓN (REQUERIDO)
  final String equipoComponente;
  final String fechaInicioInspeccion;
  final String horaInicioInspeccion;
  final String fechafinalizacionInspeccion;
  final String horafinalizacionInspeccion;
  final String temperatura;
  final String corrienteAireKMH;
  final String fuga;

  // FUGA = SI
  final String concentracion;
  final String reparado;
  //final String fechaReparacion;

  // REPARADO SI
  final String fechaReparacion;
  final String horaReparacion;
  final String concentracionFuga;

  // REPARADO NO
  final String faltaComponentes;
  final String fechaCompraNuevoComponente;
  final String fechaReparacionNuevoComponente;
  final String concentracionMetano;

  // FUGA NO

  // IMAGENES
  final String foto;
  final String fotoTermografica;

  Inspeccion(
      this.inspeccionID,
      this.fuga,
      this.concentracion,
      this.reparado,
      this.fechaReparacion,
      this.horaReparacion,
      this.concentracionFuga,
      this.faltaComponentes,
      this.fechaCompraNuevoComponente,
      this.fechaReparacionNuevoComponente,
      this.concentracionMetano,
      {required this.equipoComponente,
      required this.fechaInicioInspeccion,
      required this.horaInicioInspeccion,
      required this.fechafinalizacionInspeccion,
      required this.horafinalizacionInspeccion,
      required this.temperatura,
      required this.corrienteAireKMH,
      required this.foto,
      required this.fotoTermografica});

  Map<String, dynamic> toMap() {
    return {
      'inspeccionID': inspeccionID,
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
      'fotoTermografica': fotoTermografica,
    };
  }
}
