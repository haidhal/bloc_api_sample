//part of 'login_bloc.dart';   remove this and import equatable package

 import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends LoginEvent{
  String password;
  String email;
  UserLoginEvent({required this.email,required this.password});
  @override
  List<Object> get props => []; 
}