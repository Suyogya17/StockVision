// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApiModel _$OrderApiModelFromJson(Map<String, dynamic> json) =>
    OrderApiModel(
      orderId: json['_id'] as String?,
      customerId: json['customerId'] as String,
      customerUsername: json['customerUsername'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : ProductApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as String,
      shippingAddress: json['shippingAddress'] as String,
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      orderDate: json['orderDate'] as String,
    );

Map<String, dynamic> _$OrderApiModelToJson(OrderApiModel instance) =>
    <String, dynamic>{
      '_id': instance.orderId,
      'customerId': instance.customerId,
      'customerUsername': instance.customerUsername,
      'products': instance.products,
      'totalPrice': instance.totalPrice,
      'shippingAddress': instance.shippingAddress,
      'status': instance.status,
      'paymentStatus': instance.paymentStatus,
      'orderDate': instance.orderDate,
    };
