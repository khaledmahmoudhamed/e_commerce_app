import 'package:equatable/equatable.dart';

class AuthErrorModel extends Equatable {
  final String error;
  const AuthErrorModel({required this.error});

  factory AuthErrorModel.fromJson(Map<String, dynamic> error) {
    return AuthErrorModel(error: error['error']);
  }

  @override
  List<Object> get props => [error];
}
