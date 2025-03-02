// single_order_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockvision_app/feature/Product/domain/entity/product_entity.dart';
import 'package:stockvision_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'single_order_event.dart';
part 'single_order_state.dart';

class SingleOrderBloc extends Bloc<SingleOrderEvent, SingleOrderState> {
  final SharedPreferences sharedPreferences;
  final TokenSharedPrefs tokenSharedPrefs;

  SingleOrderBloc({
    required this.sharedPreferences,
    required this.tokenSharedPrefs,
  }) : super(SingleOrderInitialState());

  Stream<SingleOrderState> mapEventToState(SingleOrderEvent event) async* {
    if (event is PlaceOrderEvent) {
      yield SingleOrderLoadingState();

      try {
        // Check if user is authenticated by checking the token
        String? token = (await tokenSharedPrefs.getToken()) as String?;

        if (token == null) {
          yield SingleOrderFailureState(errorMessage: 'No token found! Please log in.');
          return;
        }

        // Simulate network delay for placing the order
        await Future.delayed(const Duration(seconds: 2));

        // Logic to place the order using the product details, address, and quantity
        // For this, we can make API calls or perform other business logic here.

        yield SingleOrderSuccessState(message: 'Order placed successfully!');
      } catch (error) {
        yield SingleOrderFailureState(errorMessage: 'Failed to place the order. Please try again.');
      }
    }
  }
}
