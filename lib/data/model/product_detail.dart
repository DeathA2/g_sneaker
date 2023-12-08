import 'package:json_annotation/json_annotation.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetail {
  final int id;
  final String? image;
  final String? name;
  final String? description;
  final String? color;
  final double? price;

  ProductDetail(
    this.id,
    this.image,
    this.name,
    this.description,
    this.color,
    this.price,
  );

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);
}
