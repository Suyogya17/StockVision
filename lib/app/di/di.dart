import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:stockvision_app/app/shared_prefs/userId_shared_prefs.dart%207-49-15-915%E2%80%AFPM.dart';
import 'package:stockvision_app/core/network/api_service.dart';
import 'package:stockvision_app/core/network/hive_service.dart';
import 'package:stockvision_app/feature/Order/data/data_source/local_data_source/order_local_data_source.dart';
import 'package:stockvision_app/feature/Order/data/data_source/remote_datasource/order_remote_datasource.dart';
import 'package:stockvision_app/feature/Order/data/repository/order_local_repository.dart';
import 'package:stockvision_app/feature/Order/data/repository/order_remote_repository.dart';
import 'package:stockvision_app/feature/Order/domain/use_case/create_order_usecase.dart';
import 'package:stockvision_app/feature/Order/domain/use_case/delete_order_usecase.dart';
import 'package:stockvision_app/feature/Order/domain/use_case/get_all_order_usecase.dart';
import 'package:stockvision_app/feature/Order/presentation/view_model/bloc/order_bloc.dart';
import 'package:stockvision_app/feature/Product/data/data_source/product_local_datasource/product_local_data_source.dart';
import 'package:stockvision_app/feature/Product/data/data_source/remote_datasource/product_remote_datasource.dart';
import 'package:stockvision_app/feature/Product/data/repository/product_local_repository.dart';
import 'package:stockvision_app/feature/Product/data/repository/product_remote_repository.dart';
import 'package:stockvision_app/feature/Product/domain/use_case/create_product_usecase.dart';
import 'package:stockvision_app/feature/Product/domain/use_case/delete_product_usecase.dart';
import 'package:stockvision_app/feature/Product/domain/use_case/get_all_product_usecase.dart';
import 'package:stockvision_app/feature/Product/domain/use_case/upload_image_usecase.dart';
import 'package:stockvision_app/feature/Product/presentation/view_model/bloc/product_bloc.dart';
import 'package:stockvision_app/feature/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:stockvision_app/feature/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:stockvision_app/feature/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:stockvision_app/feature/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:stockvision_app/feature/auth/domain/use_case/login_use_usecase.dart';
import 'package:stockvision_app/feature/auth/domain/use_case/register_use_usecase.dart';
import 'package:stockvision_app/feature/auth/domain/use_case/uploadimage_use_usecase.dart';
import 'package:stockvision_app/feature/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:stockvision_app/feature/auth/presentation/view_model/registration/bloc/registration_bloc.dart';
import 'package:stockvision_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:stockvision_app/feature/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
import 'package:stockvision_app/feature/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPrefrences();
  await _initProductDependencies();
  await _initOrderDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initOnboardingDependencies();
  await _initSplashScreenDependencies();
}

Future<void> _initSharedPrefrences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}
// ==================================== Register =============================

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );
  //  Remote Data Source course
  getIt.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(
      getIt<Dio>(), getIt<UserIdSharedPrefs>(),
    ),
  );

  // init locsal repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // remote Repository register
  getIt.registerLazySingleton(
    () => AuthRemoteRepository(
      getIt<AuthRemoteDatasource>(),
    ),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegistrationBloc>(
    () => RegistrationBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    ),
  );
}

// ==================================== Order =============================
_initOrderDependencies() {
  // local Data Source order
  getIt.registerFactory<OrderLocalDataSource>(
      () => OrderLocalDataSource(hiveService: getIt<HiveService>()));

  //  Remote Data Source order
  getIt.registerFactory<OrderRemoteDataSource>(
    () => OrderRemoteDataSource(
      getIt<Dio>(),
    ),
  );

  // local Repository order
  getIt.registerLazySingleton<OrderLocalRepository>(() => OrderLocalRepository(
      orderLocalDataSource: getIt<OrderLocalDataSource>()));

  // remote Repository order
  getIt.registerLazySingleton<OrderRemoteRepository>(
      () => OrderRemoteRepository(getIt<OrderRemoteDataSource>()));

  //  Usecases order
  getIt.registerFactory<CreateOrderUsecase>(
    () => CreateOrderUsecase(
      orderRepository: getIt<OrderRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetAllOrderUsecase>(
    () => GetAllOrderUsecase(
      orderRepository: getIt<OrderRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      userIdSharedPrefs: getIt<UserIdSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<DeleteOrderUsecase>(
    () => DeleteOrderUsecase(
      orderRepository: getIt<OrderRemoteRepository>(),
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

// ==================================== Product =============================
_initProductDependencies() async {
  // local Data Source Product
  getIt.registerFactory<ProductLocalDataSource>(
      () => ProductLocalDataSource(hiveService: getIt<HiveService>()));

  //  Remote Data Source product
  getIt.registerFactory<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(
      getIt<Dio>(),
    ),
  );

  // local Repository Product
  getIt.registerLazySingleton<ProductLocalRepository>(() =>
      ProductLocalRepository(
          productLocalDataSource: getIt<ProductLocalDataSource>()));

  // remote Repository Product
  getIt.registerLazySingleton(
    () => ProductRemoteRepository(
      getIt<ProductRemoteDataSource>(),
    ),
  );

  // Usecases Product
  getIt.registerLazySingleton<CreateProductUseCase>(
    () => CreateProductUseCase(
        productRepository: getIt<ProductRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetAllProductUseCase>(
    () => GetAllProductUseCase(
        productRepository: getIt<ProductRemoteRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<DeleteProductUsecase>(
    () => DeleteProductUsecase(
      productRepository: getIt<ProductRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<UploadProductImageUsecase>(
    () => UploadProductImageUsecase(
      getIt<ProductRemoteRepository>(),
    ),
  );

  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      createProductUseCase: getIt<CreateProductUseCase>(),
      getAllProductUseCase: getIt<GetAllProductUseCase>(),
      deleteProductUsecase: getIt<DeleteProductUsecase>(),
      uploadProductImageUsecase: getIt<UploadProductImageUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(authRepository: getIt<AuthRemoteRepository>()),
  );
}
// ==================================== Login =============================

_initLoginDependencies() async {
  // ===========token Shared Prefrences ===================================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(
      getIt<SharedPreferences>(),
    ),
  );
  // ===========userId Shared Prefrences ===================================
  getIt.registerLazySingleton<UserIdSharedPrefs>(
    () => UserIdSharedPrefs(
      getIt<SharedPreferences>(),
    ),
  );
//  ============usecase =====================================
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
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

_initOnboardingDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(),
  );
}

// ==================================== Splash =============================

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );
}
