import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stockvision_app/feature/order/domain/entity/order_entity.dart';

@JsonSerializable()
class OrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? orderId;
  final String orderName;

  const OrderApiModel({
    this.orderId,
    required this.orderName,
  });
  const OrderApiModel.empty()
      : orderId = '',
        orderName = '';

  // from Json, write full code without generator
  factory OrderApiModel.fromJson(Map<String, dynamic> json) {
    return OrderApiModel(
      orderId: json['_id'],
      orderName: json['courseName'],
    );
  }

  // Too Json, write full code without generator

  Map<String, dynamic> toJson() {
    return {
      // '_id': orderId,
      'orderName': orderName,
    };
  }

  // From Entity
  factory OrderApiModel.fromEntity(OrderEntity entity) {
    return OrderApiModel(
      orderId: entity.orderId,
      orderName: entity.orderName,
    );
  }

  // To Entity
  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId,
      orderName: orderName,
    );
  }

  // Convert Api Listy  to entity list
  List<OrderEntity> toEntityList(List<OrderApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [orderId, orderName];
}
