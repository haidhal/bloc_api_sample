import 'package:bloc_api_sample/view/login_screen/login_screen.dart';
import 'package:bloc_api_sample/view/registration_screen/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController regemailcontroller = TextEditingController();
    TextEditingController regpasscontroller = TextEditingController();
    TextEditingController phonecontroller = TextEditingController();
    TextEditingController namecontroller = TextEditingController();
    TextEditingController placecontroller = TextEditingController();
    TextEditingController pincodecontroller = TextEditingController();

    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const Text(
                "Register Now",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              TextFormField(
                controller: namecontroller,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter your name"
                    : null,
              ),
              TextFormField(
                controller: phonecontroller,
                decoration: const InputDecoration(labelText: "phone No"),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter your phone no"
                    : null,
              ),
              TextFormField(
                controller: pincodecontroller,
                decoration: const InputDecoration(labelText: "pincode"),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter your pincode"
                    : null,
              ),
              TextFormField(
                controller: regemailcontroller,
                decoration: const InputDecoration(hintText: "enter email"),
                validator: (value) => value == null || value.isEmpty
                    ? "please enter email"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: regpasscontroller,
                decoration: const InputDecoration(hintText: "enter password"),
                validator: (value) => value == null || value.length < 6
                    ? "password must contain at least 6 characters"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<RegistrationBloc, RegistrationState>(
                listener: (context, state) {
                 if(state is RegistrationSuccessState){
                  Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (context)=>LoginScreen()));
                 }
                },
                builder: (context, state) {
                  if (state is RegistrationLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is RegistrationErrorState) {
                    return const Text("no data");
                  }
                  return InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        context.read<RegistrationBloc>().add(
                            onRegistrationEvent(
                                email: regemailcontroller.text,
                                name: namecontroller.text,
                                password: regpasscontroller.text,
                                phone: int.parse(phonecontroller.text),
                                pincode: int.parse(pincodecontroller.text),
                                place: placecontroller.text));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
