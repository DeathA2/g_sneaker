import 'package:json_annotation/json_annotation.dart';
part 'added_product.g.dart';

@JsonSerializable()
class AddedProduct {
  final String name;
  final int id;
  final double price;
  int quantity;
  final String image;
  final String color;
  AddedProduct(
      {required this.image,
      required this.name,
      required this.price,
      required this.id,
      required this.color,
      required this.quantity});

  factory AddedProduct.fromJson(Map<String, dynamic> json) =>
      _$AddedProductFromJson(json);

  Map<String, dynamic> toJson() => _$AddedProductToJson(this);
}
