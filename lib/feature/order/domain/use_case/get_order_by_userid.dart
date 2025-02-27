// import 'package:dartz/dartz.dart';
// import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
// import 'package:stockvision_app/app/shared_prefs/userId_shared_prefs.dart';
// import 'package:stockvision_app/app/usecase/usease.dart';
// import 'package:stockvision_app/core/error/failure.dart';
// import 'package:stockvision_app/feature/Order/domain/entity/order_entity.dart';
// import 'package:stockvision_app/feature/Order/domain/repository/order_repository.dart';

// class GetOrderByUserIdParams {
//   final String userId;

//   GetOrderByUserIdParams({required this.userId});
// }

// class GetOrderByUserIdUsecase
//     implements UsecaseWithParams<List<OrderEntity>, GetOrderByUserIdParams> {
//   final IOrderRepository _orderRepository;
//   final TokenSharedPrefs _tokenSharedPrefs;
//   final UserIdSharedPrefs _useridSharedPrefs;

//   GetOrderByUserIdUsecase({
//     required IOrderRepository orderRepository,
//     required TokenSharedPrefs tokenSharedPrefs,
//     required UserIdSharedPrefs useridSharedPrefs,
//   })  : _orderRepository = orderRepository,
//         _tokenSharedPrefs = tokenSharedPrefs,
//         _useridSharedPrefs = useridSharedPrefs;

//   @override
//   Future<Either<Failure, List<OrderEntity>>> call(
//       GetOrderByUserIdParams params) async {
//     try {
//       // Get token from SharedPrefs
//       final token = await _tokenSharedPrefs.getToken();
//       final userId = await _useridSharedPrefs.getUserId();

//       // First check token
//       return token.fold(
//         (failure) => Left(failure),
//         (token) async {
//           if (token.isEmpty) {
//             return const Left(
//                 SharedPrefsFailure(message: 'No token available'));
//           }

//           // Check userId after token is valid
//           return userId.fold(
//             (failure) => Left(failure),
//             (userId) async {
//               if (userId.isEmpty) {
//                 return const Left(
//                     SharedPrefsFailure(message: 'No userId available'));
//               }

//               // Pass userId and token to repository to fetch the orders
//               return await _orderRepository.getOrderByCustomerId(
//                   params.userId, token);
//             },
//           );
//         },
//       );
//     } catch (e) {
//       return Left(SharedPrefsFailure(
//           message: 'Unexpected error occurred: ${e.toString()}'));
//     }
//   }
// }
