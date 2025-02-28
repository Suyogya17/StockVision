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
  final String orderDate;

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

      List<ProductApiModel> productList = [];
      if (json['products'] is List) {
        var products = json['products'];
        print('Product Detailsss:: ${json['products']}');

        // Iterate over the products list
        for (var productJson in json['products']) {
          if (productJson is Map && productJson.containsKey('product')) {
            var productDetails = productJson['product'];
            var quantity = productJson['quantity'];
            if (productDetails is Map<String, dynamic>) {
              productDetails.remove('__v');
              print('Parsing Product: $productDetails');
              productDetails['quantity'] = quantity;
              // productDetails['quantity'] =
              // Map product data to ProductApiModel
              productList.add(ProductApiModel.fromJson(productDetails));
            } else {
              print(
                  'Expected a Map<String, dynamic> for product details, got: ${productDetails.runtimeType}');
            }
          } else {
            print(
                'Invalid product entry, expected Map with "product" key, got: ${productJson.runtimeType}');
          }
        }
      } 

      return OrderApiModel(
        orderId: json['_id']?.toString() ?? '',
        customerId: json['customer']?['_id']?.toString() ?? '',
        customerUsername: json['customer']?['username']?.toString() ?? '',
        products: productList,
        totalPrice: json['totalPrice']?.toString() ?? '',
        shippingAddress: json['shippingAddress']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        paymentStatus: json['paymentStatus']?.toString() ?? '',
        orderDate: json['orderDate'] ?? '',
      );
    } catch (e, stackTrace) {
      print("Error parsing OrderApiModel: $e");
      print("StackTrace: $stackTrace");
      return const OrderApiModel(
        orderId: '',
        customerId: '',
        customerUsername: '',
        products: [],
        totalPrice: '',
        shippingAddress: '',
        status: '',
        paymentStatus: '',
        orderDate: '',
      );
    }
  }

  Map<String, dynamic> toJson() {
    print('INSIDE JSON ');

    return _$OrderApiModelToJson(this);
  }

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
