class LayerModel {
  final String id;
  final String type; // 'image', 'shape', 'text'
  final dynamic data;

  LayerModel({required this.id, required this.type, required this.data});
}
