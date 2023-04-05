class Cliente {
  late final String cliente;
  late final String ciudad;
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

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      cliente: map['cliente'],
      ciudad: map['ciudad'],
      trimestre: map['trimestre'],
      timestamp: map['timestamp'],
    );
  }
}
