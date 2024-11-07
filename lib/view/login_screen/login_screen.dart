// ignore_for_file: prefer_const_constructors

// import 'package:bloc_api_sample/pages/home_screen.dart';
// import 'package:bloc_api_sample/view/login_screen/bloc/login_bloc.dart';
// import 'package:bloc_api_sample/view/login_screen/bloc/login_state.dart';
// import 'package:bloc_api_sample/view/registration_screen/registration_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController loginemailcontroller = TextEditingController();
//     TextEditingController loginpasscontroller = TextEditingController();
//     final _formkey = GlobalKey<FormState>();
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Login Here",
//               style: TextStyle(fontWeight: FontWeight.w800),
//             ),
//             TextFormField(
//               controller: loginemailcontroller,
//               decoration: const InputDecoration(hintText: "enter username"),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return " Email id required";
//                 }
//               },
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: loginpasscontroller,
//               decoration: const InputDecoration(hintText: "enter password"),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return " password required";
//                 }
//               },
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             //bloc listener
//             BlocListener<LoginBloc, LoginState>(
//               listener: (context, state) {
//                 // TODO: implement listener
//               },
//               child:
//                   BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
//                 if (state is LOginLoadingState) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (state is LoginInitial) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => HomeScreen()));
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 150,
//                       color: Colors.blue,
//                       child: Center(
//                         child: Text(
//                           "Sign in",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//                 return SizedBox();
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(UserLoginEvent(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 20),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoadedstate) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  }
                  if (state is Errorstate) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)));
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LOginLoadingState) {
                      return CircularProgressIndicator();
                    }
                    if (state is LoginInitial) {
                      return ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Login'),
                      );
                    }
                    if (state is LoginLoadedstate) {
                      return SizedBox();
                    }
                    if (state is Errorstate) {
                      return ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Login'),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
