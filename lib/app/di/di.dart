import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stockvision_app/core/network/api_service.dart';
import 'package:stockvision_app/core/network/hive_service.dart';
import 'package:stockvision_app/feature/Order/data/data_source/remote_datasource/order_remote_datasource.dart';
import 'package:stockvision_app/feature/Product/data/data_source/product_local_data_source.dart';
import 'package:stockvision_app/feature/Product/data/data_source/remote_datasource/product_remote_datasource.dart';
import 'package:stockvision_app/feature/Product/data/repository/product_local_repository.dart';
import 'package:stockvision_app/feature/Product/data/repository/product_remote_repository.dart';
import 'package:stockvision_app/feature/Product/domain/use_case/create_product_usecase.dart';
import 'package:stockvision_app/feature/Product/domain/use_case/delete_product_usecase.dart';
import 'package:stockvision_app/feature/Product/domain/use_case/get_all_product_usecase.dart';
import 'package:stockvision_app/feature/Product/presentation/view_model/bloc/product_bloc.dart';
import 'package:stockvision_app/feature/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:stockvision_app/feature/auth/data/repository/auth_local_repository.dart';
import 'package:stockvision_app/feature/auth/domain/use_case/login_use_usecase.dart';
import 'package:stockvision_app/feature/auth/domain/use_case/register_use_usecase.dart';
import 'package:stockvision_app/feature/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:stockvision_app/feature/auth/presentation/view_model/registration/bloc/registration_bloc.dart';
import 'package:stockvision_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:stockvision_app/feature/order/data/data_source/order_local_data_source.dart';
import 'package:stockvision_app/feature/order/data/repository/order_local_repository.dart';
import 'package:stockvision_app/feature/order/data/repository/order_remote_datasource.dart';
import 'package:stockvision_app/feature/order/domain/use_case/create_order_usecase.dart';
import 'package:stockvision_app/feature/order/domain/use_case/delete_order_usecase.dart';
import 'package:stockvision_app/feature/order/domain/use_case/get_all_order_usecase.dart';
import 'package:stockvision_app/feature/order/presentation/view_model/bloc/order_bloc.dart';
import 'package:stockvision_app/feature/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();

  await _initProductDependencies();
  await _initOrderDependencies();
  await _initRegisterDependencies();
  await _initHomeDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegistrationBloc>(
    () => RegistrationBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initOrderDependencies() {
  // local Data Source order
  getIt.registerFactory<OrderLocalDataSource>(
      () => OrderLocalDataSource(hiveService: getIt<HiveService>()));

  //  Remote Data Source order
  getIt.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  // local Repository order
  getIt.registerLazySingleton<OrderLocalRepository>(() => OrderLocalRepository(
      orderLocalDataSource: getIt<OrderLocalDataSource>()));

  // remote Repository order
  getIt.registerLazySingleton(
    () => OrderRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  // local Usecases order
  getIt.registerLazySingleton<CreateOrderUsecase>(
    () => CreateOrderUsecase(
      orderRepository: getIt<OrderLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetAllOrderUsecase>(
    () => GetAllOrderUsecase(
      orderRepository: getIt<OrderRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeleteOrderUsecase>(
    () => DeleteOrderUsecase(
      orderRepository: getIt<OrderLocalRepository>(),
    ),
  );

  // Bloc

  getIt.registerFactory<OrderBloc>(
    () => OrderBloc(
      getAllOrderUsecase: getIt<GetAllOrderUsecase>(),
      createOrderUsecase: getIt<CreateOrderUsecase>(),
      deleteOrderUsecase: getIt<DeleteOrderUsecase>(),
    ),
  );
}

_initProductDependencies() async {
  // local Data Source Product
  getIt.registerFactory<ProductLocalDataSource>(
      () => ProductLocalDataSource(hiveService: getIt<HiveService>()));

  //  Remote Data Source product
  getIt.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasource(
      dio: getIt<Dio>(),
    ),
  );

  // local Repository Product
  getIt.registerLazySingleton<ProductLocalRepository>(() =>
      ProductLocalRepository(
          productLocalDataSource: getIt<ProductLocalDataSource>()));

  // remote Repository Product
  getIt.registerLazySingleton(
    () => ProductRemoteDatasource(
      dio: getIt<Dio>(),
    ),
  );

  // Usecases Product
  getIt.registerLazySingleton<CreateProductUseCase>(
    () => CreateProductUseCase(
        productRepository: getIt<ProductRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetAllProductUseCase>(
    () => GetAllProductUseCase(
        productRepository: getIt<ProductLocalRepository>()),
  );

  getIt.registerLazySingleton<DeleteProductUsecase>(
    () => DeleteProductUsecase(
        productRepository: getIt<ProductLocalRepository>()),
  );

  // Bloc
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      createProductUseCase: getIt<CreateProductUseCase>(),
      getAllProductUseCase: getIt<GetAllProductUseCase>(),
      deleteProductUsecase: getIt<DeleteProductUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegistrationBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
