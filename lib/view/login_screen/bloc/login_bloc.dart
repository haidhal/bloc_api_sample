//import 'dart:math';

//import 'package:bloc/bloc.dart';
import 'package:bloc_api_sample/model/res_model.dart';
import 'package:bloc_api_sample/view/login_screen/bloc/login_event.dart';
import 'package:bloc_api_sample/view/login_screen/bloc/login_state.dart';
//import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// part 'login_event.dart';
// part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    
    on<UserLoginEvent>((event, emit) async {
      // shared preference initialization
      final SharedPreferences prefs = await SharedPreferences.getInstance();
     final url = Uri.parse("https://freeapi.luminartechnohub.com/login");
     try {
       final res =await http.post(url,body: {
        "email" : event.email,
        "password" : event.password
       }

       );
       if(res.statusCode == 200){
      final responseobj = resModelFromJson(res.body);
      
      // storing access token to shared preference
      prefs.setString("access", responseobj.access.toString());
      prefs.setString("refresh", responseobj.refresh.toString());
       emit(LoginLoadedstate());
       }else{
        
       }
     } catch (e) {
       emit (Errorstate(errorMessage: e.toString()));
     }
    });
  }
}
