import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitialState()) {
    on<onRegistrationEvent>((event, emit) async {
      emit(RegistrationLoadingState());
      final url =
          Uri.parse("https://freeapi.luminartechnohub.com/registration/");
      try {
        final response =await http.post(url, body: {
          "name": "${event.name}",
          "phone": "${event.phone}",
          "place": "${event.place}",
          "pincode": "${event.pincode}",
          "email": "${event.email}",
          "password": "${event.password}",
        });
        if(response.statusCode == 200){
         log(response.body.toString());
         emit(RegistrationLoadedState()) ;
        }
      } catch (e) {
        emit(RegistrationErrorState(errorMessage: e.toString()));
      }
    });
  }
}
