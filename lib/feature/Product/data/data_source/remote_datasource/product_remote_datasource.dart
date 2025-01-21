import 'package:dio/dio.dart';
import 'package:stockvision_app/app/constants/api_endpoints.dart';
import 'package:stockvision_app/feature/Product/data/data_source/product_data_source.dart';
import 'package:stockvision_app/feature/Product/data/model/product_api_model.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';

class ProductRemoteDatasource implements IProductDataSource {
  final Dio _dio;

  ProductRemoteDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> createProduct(ProductEntity product) async {
    try {
      //Convert entity into model
      var productApiModel = ProductApiModel.fromEntity(product);
      var response = await _dio.post(
        ApiEndpoints.createProduct,
        data: productApiModel.toJson(),
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
  Future<List<ProductEntity>> getProduct() {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
}
