import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
import 'package:stockvision_app/feature/Product/data/model/product_api_model.dart';

part 'order_api_model.g.dart';

@JsonSerializable()
class OrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? orderId;
  final String customerId;
  final String customerUsername;
  final List<ProductApiModel?> products;
  final String totalPrice;
  final String shippingAddress;
  final String status;
  final String paymentStatus;
  final DateTime orderDate;

  const OrderApiModel({
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

  factory OrderApiModel.fromJson(Map<String, dynamic> json) {
    try {
      print(
          'Full JSON: $json'); // Print the entire JSON structure for debugging

      if (json['products'] != null) {
        print(
            'PRODUCTS:: ${json['products'].runtimeType}'); // Type of products field

        // Ensure products is a list before iterating over it
        if (json['products'] is List) {
          for (var product in json['products']) {
            print(
                'Product runtimeType: ${product.runtimeType}'); // Check type of each product entry

            // Check for the 'product' key and print fields inside the product
            if (product is Map && product.containsKey('product')) {
              var productDetails = product['product'];
              if (productDetails is Map) {
                productDetails.forEach((key, value) {
                  print('Product Field: $key, Type: ${value.runtimeType}');
                });
              } 
            }
          }
        } else {
          print(
              'Expected products to be a List, but got: ${json['products'].runtimeType}');
        }
      } else {
        print('No products found in the JSON response.');
      }

      return OrderApiModel(
        orderId: json['_id'] ?? '', // Handle null
        customerId: json['customer']?['_id'] ?? '', // Handle null
        customerUsername: json['customer']?['username'] ?? '', // Handle null
        products: json['products'] != null
            ? (json['products'] as List<dynamic>).map((productJson) {
                // Access the 'product' field within each product
                var product = productJson['product'];
                return product != null
                    ? ProductApiModel.fromJson(product)
                    : null; // Handle null product
              }).toList()
            : [],
        totalPrice: json['totalPrice'] ?? '',
        shippingAddress: json['shippingAddress'] ?? '',
        status: json['status'] ?? '',
        paymentStatus: json['paymentStatus'] ?? '',
        orderDate: json['orderDate'] != null
            ? DateTime.parse(json['orderDate'])
            : DateTime.now(), // Handle null safely
      );
    } catch (e, stackTrace) {
      print("Error parsing OrderApiModel: $e");
      print("StackTrace: $stackTrace");
      return OrderApiModel(
        orderId: '',
        customerId: '',
        customerUsername: '',
        products: const [],
        totalPrice: '',
        shippingAddress: '',
        status: '',
        paymentStatus: '',
        orderDate: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toJson() => _$OrderApiModelToJson(this);

  // To Entity
  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId,
      customerId: customerId,
      customerUsername: customerUsername,
      products: products.map((product) => product?.toEntity()).toList(),
      totalPrice: totalPrice,
      shippingAddress: shippingAddress,
      status: status,
      paymentStatus: paymentStatus,
      orderDate: orderDate,
    );
  }

  // From Entity
  factory OrderApiModel.fromEntity(OrderEntity entity) {
    return OrderApiModel(
      orderId: entity.orderId,
      customerId: entity.customerId,
      customerUsername: entity.customerUsername,
      products: entity.products
          .map((product) => ProductApiModel.fromEntity(product!))
          .toList(),
      totalPrice: entity.totalPrice,
      shippingAddress: entity.shippingAddress,
      status: entity.status,
      paymentStatus: entity.paymentStatus,
      orderDate: entity.orderDate,
    );
  }

  // Convert Api List  to entity list
  static List<OrderEntity> toEntityList(List<OrderApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

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
}
