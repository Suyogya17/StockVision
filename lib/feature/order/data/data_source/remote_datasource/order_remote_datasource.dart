import 'package:dio/dio.dart';
import 'package:stockvision_app/app/constants/api_endpoints.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:stockvision_app/feature/Order/data/data_source/order_data_source.dart';
import 'package:stockvision_app/feature/Order/data/model/order_api_model.dart';
import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio _dio;
  final TokenSharedPrefs tokenSharedPrefs;
  OrderRemoteDataSource(this._dio, this.tokenSharedPrefs);

  @override
  Future<void> createOrder(OrderEntity order) async {
    try {
      //Convert entity into model
      var orderApiModel = OrderApiModel.fromEntity(order);
      print('ORDER ENTITY:: $order');
      var tokenResult = await tokenSharedPrefs.getToken();
      var userResult = await tokenSharedPrefs.getUser();

      var token = tokenResult.fold(
        (failure) => throw Exception("Failed to get token"),
        (token) => token,
      );

      String? id = userResult != null
          ? userResult['_id']
          : throw Exception("Failed to get user ID");

      var orderData = orderApiModel.toJson();
      print('ID:: $id');

      orderData['customerId'] = id;

      print('DATA SENT:: $orderData');

      var response = await _dio.post(
        ApiEndpoints.createOrder,
        data: orderData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        print("Order Createdd:: $orderApiModel");
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
  Future<List<OrderEntity>> getOrder(String? token, String userId) async {
    if (userId.isEmpty) {
      throw Exception("Access denied: No id provided");
    }
    try {
      print("DATA::: $token, $userId");
      var response = await _dio.get(
        ApiEndpoints.getUserOrder + userId, // Ensure proper URL formatting
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        // final List<dynamic> data = response.data['data'];
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response.data['data']);
        print("DATATYPE:: ${data.runtimeType}");
        var val = data
            .map((order) => OrderApiModel.fromJson(order).toEntity())
            .toList();
        print('VAR::: $val');
        print('VAR::: ${val.runtimeType}');
        return val;
      } else {
        throw Exception('Failed to fetch customer orders');
      }
    } catch (e) {
      throw Exception("Error from datasource: ${e.toString()}");
    }
  }
}
