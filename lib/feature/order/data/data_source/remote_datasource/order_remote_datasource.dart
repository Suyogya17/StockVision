import 'package:dio/dio.dart';
import 'package:stockvision_app/app/constants/api_endpoints.dart';
import 'package:stockvision_app/feature/Order/data/data_source/order_data_source.dart';
import 'package:stockvision_app/feature/Order/data/model/order_api_model.dart';
import 'package:stockvision_app/feature/order/domain/entity/order_entity.dart';

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio _dio;

  OrderRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> createOrder(OrderEntity order) async {
    try {
      //Convert entity into model
      var orderApiModel = OrderApiModel.fromEntity(order);
      var response = await _dio.post(
        ApiEndpoints.createOrder,
        data: orderApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteOrder(String id) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<List<OrderEntity>> getOrder() {
    // TODO: implement getOrder
    throw UnimplementedError();
  }
}
