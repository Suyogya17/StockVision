import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockvision_app/feature/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear all stored user session data
    await prefs.clear();

    // Emit a new state or perform other logic if necessary
    emit(HomeState.initial());
  }
}
