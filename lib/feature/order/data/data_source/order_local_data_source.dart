import 'package:stockvision_app/core/error/failure.dart';
import 'package:stockvision_app/core/network/hive_service.dart';
import 'package:stockvision_app/feature/order/data/data_source/order_data_source.dart';
import 'package:stockvision_app/feature/order/data/model/order_hive_model.dart';
import 'package:stockvision_app/feature/order/domain/entity/order_entity.dart';

class OrderLocalDataSource implements IOrderDataSource {
  final HiveService _hiveService;

  OrderLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> createOrder(OrderEntity order) async {
    try {
      // Convert order entity to order model
      final courseHiveModel = OrderHiveModel.fromEntity(order);
      _hiveService.addOrder(courseHiveModel);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<void> deleteOrder(String id) async {
    try {
      _hiveService.deleteOrder(id);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<List<OrderEntity>> getOrder() async {
    try {
      final orderHiveModelList = await _hiveService.getAllOrder();
      return OrderHiveModel.toEntityList(orderHiveModelList);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }
}
