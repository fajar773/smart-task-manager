import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {

  @override
  List<Object?> get props => [];

}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String uid;

  Authenticated(this.uid);

  @override
  List<Object?> get props => [uid];
}

class Unauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

