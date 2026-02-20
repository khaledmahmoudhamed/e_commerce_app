import 'package:equatable/equatable.dart';

class ToggleState extends Equatable {
  final bool togglePasswordVisibility;
  final bool toggleTermsVisibility;
  const ToggleState({
    this.togglePasswordVisibility = true,
    this.toggleTermsVisibility = false,
  });

  ToggleState copyWith({
    bool? togglePasswordVisibility,
    bool? toggleTermsVisibility,
  }) {
    return ToggleState(
      togglePasswordVisibility:
          togglePasswordVisibility ?? this.togglePasswordVisibility,
      toggleTermsVisibility:
          toggleTermsVisibility ?? this.toggleTermsVisibility,
    );
  }

  @override
  List<Object?> get props => [togglePasswordVisibility, toggleTermsVisibility];
}
