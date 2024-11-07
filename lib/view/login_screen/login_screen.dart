

import 'package:bloc_api_sample/pages/home_screen.dart';
import 'package:bloc_api_sample/view/login_screen/bloc/login_bloc.dart';
import 'package:bloc_api_sample/view/login_screen/bloc/login_event.dart';
import 'package:bloc_api_sample/view/login_screen/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:free_api_sample_may/blocs/login/login_bloc.dart';
// import 'package:free_api_sample_may/blocs/login/login_event.dart';
// import 'package:free_api_sample_may/blocs/login/login_state.dart';
// import 'package:free_api_sample_may/pages/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePassword,
              ),
              const SizedBox(height: 20),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                 if(state is LoginLoadedstate){
                  Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (context)=>const HomeScreen()));
                 }
                },
                builder: (context, state) {
                 if(state is LOginLoadingState){
                  return const CircularProgressIndicator();
                 }if(state is Errorstate){
                  return const Text("no data");
                 } return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                         context.read<LoginBloc>().add(UserLoginEvent(
                              email: _emailController.text,
                              password: _passwordController.text));
                        }
                      },
                      child: const Text('Login'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
