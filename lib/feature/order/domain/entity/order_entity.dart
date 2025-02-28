import 'package:equatable/equatable.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class OrderEntity extends Equatable {
  final String? orderId;
  final String customerId;
  final String customerUsername;
  final List<ProductEntity?> products;
  final String totalPrice;
  final String shippingAddress;
  final String status;
  final String paymentStatus;
  final String orderDate;

  const OrderEntity({
    this.orderId,
    required this.customerId,
    required this.customerUsername,
    required this.products,
    required this.totalPrice,
    required this.shippingAddress,
    required this.status,
    required this.paymentStatus,
    required this.orderDate,
  });

  @override
  List<Object?> get props => [
        orderId,
        customerId,
        customerUsername,
        products,
        totalPrice,
        shippingAddress,
        status,
        paymentStatus,
        orderDate,
      ];
  // from JSON
  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
      orderId: json['_id'],
      customerId: json['customer']?['_id'],
      customerUsername: json['customer']?['username'] ?? '',
      products: (json['products'] as List)
          .map((productJson) => ProductEntity.fromJson(productJson['product']))
          .toList(),
      totalPrice: json['totalPrice'],
      shippingAddress: json['shippingAddress'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      orderDate: json['orderDate'],
    );
  }

  // to Json
  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'customer': {
          '_id': customerId,
          'username': customerUsername,
        },
        'products': products.map((product) => product?.toJson()).toList(),
        'totalPrice': totalPrice,
        'shippingAddress': shippingAddress,
        'status': status,
        'paymentStatus': paymentStatus,
        'orderDate': orderDate,
      };
}