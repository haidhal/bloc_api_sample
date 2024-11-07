//part of 'login_bloc.dart';

 import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}
final class LOginLoadingState extends LoginState{}
final class LoginLoadedstate extends LoginState{}
final class Errorstate extends LoginState{
  String errorMessage;
  Errorstate({required this.errorMessage});
}