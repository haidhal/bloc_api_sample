import 'package:bloc_api_sample/pages/splash_screen.dart';
import 'package:bloc_api_sample/view/add_screen.dart/bloc/addproduct_bloc.dart';
import 'package:bloc_api_sample/view/home_screen/bloc/home_bloc.dart';
import 'package:bloc_api_sample/view/login_screen/bloc/login_bloc.dart';
import 'package:bloc_api_sample/view/login_screen/login_screen.dart';
import 'package:bloc_api_sample/view/registration_screen/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
runApp(
 MultiBlocProvider(providers: [
  BlocProvider(create: (context)=> LoginBloc()),
   BlocProvider(create: (context)=> HomeBloc()),
    BlocProvider(create: (context)=> AddproductBloc()),
    BlocProvider(create: (context)=> RegistrationBloc())
 ], child:  MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}