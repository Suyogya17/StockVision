// //esma table create update delete haru CRUD ko queries hunxa
// import 'package:hive_flutter/adapters.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:stockvision_app/app/constants/hive_table_constant.dart';
// import 'package:stockvision_app/feature/Product/data/model/product_hive_model.dart';
// import 'package:stockvision_app/feature/auth/data/model/auth_hive_model.dart';
// import 'package:stockvision_app/feature/order/data/model/order_hive_model.dart';

// class HiveService {
//   Future<void> init() async {
//     var directory = await getApplicationDocumentsDirectory();
//     var path = '${directory.path}stockvision.db';

//     Hive.init(path);
//   }

//   // Auth Queries
//   Future<void> register(AuthHiveModel customer) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
//     await box.put(customer.customerId, customer);
//   }

//   Future<void> deleteAuth(String id) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
//     await box.delete(id);
//   }

//   Future<List<AuthHiveModel>> getAllAuth() async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
//     return box.values.toList();
//   }

//   // (Batch) Product Queries

//   Future<void> addProduct(ProductHiveModel product) async {
//     var box =
//         await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
//     await box.put(product.productId, product);
//   }

//   Future<void> deleteProduct(String id) async {
//     var box =
//         await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
//     await box.delete(id);
//   }

//   Future<List<ProductHiveModel>> getAllProduct() async {
//     var box =
//         await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
//     var products = box.values.toList();
//     return products;
//   }

// // Order Queries
//   Future<void> addOrder(OrderHiveModel order) async {
//     var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
//     await box.put(order.orderId, order);
//   }

//   Future<void> deleteOrder(String id) async {
//     var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
//     await box.delete(id);
//   }

//   Future<List<OrderHiveModel>> getAllOrder() async {
//     var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
//     var order = box.values.toList();
//     return order;
//   }

// // Customer Queries
//   Future<void> addCustomer() async {}

//   Future<void> deleteCustomer() async {
//     await Hive.deleteBoxFromDisk(HiveTableConstant.customerBox);
//   }

//   Future<void> getAllCustomers() async {}

//   Future<AuthHiveModel> loginCustomer(String username, String password) async {
//     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
//     var customer = box.values.firstWhere((element) =>
//         element.username == username && element.password == password);
//     box.close();
//     return customer;
//   }
// }

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stockvision_app/app/constants/hive_table_constant.dart';
import 'package:stockvision_app/feature/Product/data/model/product_hive_model.dart';
import 'package:stockvision_app/feature/auth/data/model/auth_hive_model.dart';
import 'package:stockvision_app/feature/order/data/model/order_hive_model.dart';

class HiveService {
  // Initialize Hive
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}stockvision.db';

    Hive.init(path);
  }

  // Auth Queries
  Future<void> register(AuthHiveModel customer) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    await box.put(customer.customerId, customer);
  }

  // Update Auth (Customer) Query
  Future<void> updateAuth(AuthHiveModel customer) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    await box.put(customer.customerId, customer);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    return box.values.toList();
  }

  // Product Queries
  Future<void> addProduct(ProductHiveModel product) async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    await box.put(product.productId, product);
  }

  // Update Product Query
  Future<void> updateProduct(ProductHiveModel product) async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    await box.put(product.productId, product);
  }

  Future<void> deleteProduct(String id) async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    await box.delete(id);
  }

  Future<List<ProductHiveModel>> getAllProduct() async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    var products = box.values.toList();
    return products;
  }

  // Order Queries
  Future<void> addOrder(OrderHiveModel order) async {
    var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
    await box.put(order.orderId, order);
  }

  // Update Order Query
  Future<void> updateOrder(OrderHiveModel order) async {
    var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
    await box.put(order.orderId, order);
  }

  Future<void> deleteOrder(String id) async {
    var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
    await box.delete(id);
  }

  Future<List<OrderHiveModel>> getAllOrder() async {
    var box = await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderBox);
    var order = box.values.toList();
    return order;
  }

  // Customer Queries
  Future<void> addCustomer() async {
    // Add customer-related logic here if necessary
  }

  Future<void> deleteCustomer() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.customerBox);
  }

  Future<List<AuthHiveModel>> getAllCustomers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    return box.values.toList();
  }

  Future<AuthHiveModel> loginCustomer(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    var customer = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    return customer;
  }
}
