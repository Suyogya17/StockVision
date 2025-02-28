import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stockvision_app/app/constants/hive_table_constant.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Product/data/model/product_hive_model.dart';
import 'package:uuid/uuid.dart';

part 'order_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.orderTableId)
class OrderHiveModel extends Equatable {
  @HiveField(0)
  final String? orderId;
  @HiveField(1)
  final String customerId;
  @HiveField(2)
  final String customerUserName;
  @HiveField(3)
  final List<ProductHiveModel> products;
  @HiveField(4)
  final String totalPrice;
  @HiveField(5)
  final String shippingAddress;
  @HiveField(6)
  final String status;
  @HiveField(7)
  final String paymentStatus;
  @HiveField(8)
  final String orderDate;

  OrderHiveModel({
    String? orderId,
    required this.customerId,
    required this.customerUserName,
    required this.products,
    required this.totalPrice,
    required this.shippingAddress,
    required this.status,
    required this.paymentStatus,
    required this.orderDate,
  }) : orderId = orderId ?? const Uuid().v4();

  // Initial Constructor
  OrderHiveModel.initial()
      : orderId = '',
        customerId = '',
        customerUserName = '',
        products = const [],
        totalPrice = '',
        shippingAddress = '',
        status = 'pending',
        paymentStatus = 'pending',
        orderDate = '';

  // From Entity
  factory OrderHiveModel.fromEntity(OrderEntity entity) {
    return OrderHiveModel(
      orderId: entity.orderId,
      customerId: entity.customerId,
      customerUserName: entity.customerUsername,
      products: entity.products
          .map((product) => ProductHiveModel.fromEntity(product!))
          .toList(),
      totalPrice: entity.totalPrice,
      shippingAddress: entity.shippingAddress,
      status: entity.status,
      paymentStatus: entity.paymentStatus,
      orderDate: entity.orderDate,
    );
  }

  // To Entity
  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId,
      customerId: customerId,
      customerUsername: customerUserName,
      products: products.map((product) => product.toEntity()).toList(),
      totalPrice: totalPrice,
      shippingAddress: shippingAddress,
      status: status,
      paymentStatus: paymentStatus,
      orderDate: orderDate,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        orderId,
        customerId,
        customerUserName,
        products,
        totalPrice,
        shippingAddress,
        status,
        orderDate,
      ];
}