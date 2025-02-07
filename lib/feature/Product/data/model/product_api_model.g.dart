// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      productId: json['_id'] as String?,
      productName: json['productName'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
      type: json['type'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'productName': instance.productName,
      'image': instance.image,
      'description': instance.description,
      'type': instance.type,
      'quantity': instance.quantity,
      'price': instance.price,
    };
