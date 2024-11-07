part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

final class RegistrationInitialState extends RegistrationState {}

final class RegistrationLoadingState extends RegistrationState {}

final class RegistrationSuccessState extends RegistrationState {}

final class RegistrationErrorState extends RegistrationState {
  String errorMessage;
  RegistrationErrorState({required this.errorMessage});
  @override
  List<Object> get props => [];
}
