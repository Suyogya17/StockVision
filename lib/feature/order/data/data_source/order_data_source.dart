import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';

abstract interface class IOrderDataSource {
  Future<List<OrderEntity>> getOrder(String? token, String userId);
  Future<void> createOrder(OrderEntity order);
  Future<void> deleteOrder(String id);
}
