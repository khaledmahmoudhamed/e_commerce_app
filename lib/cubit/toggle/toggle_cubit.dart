import 'package:e_commerce_app/cubit/toggle/toggle_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleCubit extends Cubit<ToggleState> {
  ToggleCubit() : super(ToggleState());

  void togglePasswordVisibility() {
    emit(
      state.copyWith(togglePasswordVisibility: !state.togglePasswordVisibility),
    );
  }

  void toggleCheckBoxVisibility() {
    emit(state.copyWith(toggleTermsVisibility: !state.toggleTermsVisibility));
  }
}
