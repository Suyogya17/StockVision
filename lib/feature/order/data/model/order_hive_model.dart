import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stockvision_app/app/constants/hive_table_constant.dart';
import 'package:stockvision_app/feature/order/domain/entity/order_entity.dart';
import 'package:uuid/uuid.dart';

part 'order_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.orderTableId)
class OrderHiveModel extends Equatable {
  @HiveField(0)
  final String? orderId;
  @HiveField(1)
  final String orderName;

  OrderHiveModel({
    String? orderId,
    required this.orderName,
  }) : orderId = orderId ?? const Uuid().v4();

  // Initail Constructor
  const OrderHiveModel.initial()
      : orderId = '',
        orderName = '';

  // From Entity
  factory OrderHiveModel.fromEntity(OrderEntity entity) {
    return OrderHiveModel(
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

  // From Entity List
  static List<OrderHiveModel> fromEntityList(List<OrderEntity> entityList) {
    return entityList
        .map((entity) => OrderHiveModel.fromEntity(entity))
        .toList();
  }

  // To Entity List
  static List<OrderEntity> toEntityList(List<OrderHiveModel> hiveList) {
    return hiveList.map((hive) => hive.toEntity()).toList();
  }

  @override
  List<Object?> get props => [orderId, orderName];
}
