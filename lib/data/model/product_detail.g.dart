// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) =>
    ProductDetail(
      json['id'] as int,
      json['image'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['color'] as String?,
      (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
      'price': instance.price,
    };
