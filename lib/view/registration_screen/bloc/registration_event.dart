part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class onRegistrationEvent extends RegistrationEvent {
  final String name;
  final int phone;
  final String place;
  final int pincode;
  final String email;
  final String password;
  onRegistrationEvent(
      {required this.email,
      required this.name,
      required this.password,
      required this.phone,
      required this.pincode,
      required this.place});
       @override
  List<Object> get props => [];
}
