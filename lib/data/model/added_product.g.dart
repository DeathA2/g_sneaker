// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'added_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddedProduct _$AddedProductFromJson(Map<String, dynamic> json) => AddedProduct(
      image: json['image'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      id: json['id'] as int,
      color: json['color'] as String,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$AddedProductToJson(AddedProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'price': instance.price,
      'quantity': instance.quantity,
      'image': instance.image,
      'color': instance.color,
    };
