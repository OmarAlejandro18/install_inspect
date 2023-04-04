class Cliente {
  final String cliente;
  final String ciudad;
  final String trimestre;
  final int timestamp;

  Cliente(
      {
      //required this.instalacionID,
      required this.cliente,
      required this.ciudad,
      required this.trimestre,
      required this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      //'instalacionID': instalacionID,
      'cliente': cliente,
      'ciudad': ciudad,
      'trimestre': trimestre,
      'timestamp': timestamp
    };
  }
}
