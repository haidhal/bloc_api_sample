import 'package:bloc_api_sample/view/login_screen/login_screen.dart';
import 'package:bloc_api_sample/view/registration_screen/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatelessWidget {
   RegistrationScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController regemailcontroller= TextEditingController();
    TextEditingController regpasscontroller = TextEditingController();
    TextEditingController phonecontroller = TextEditingController();
    TextEditingController namecontroller = TextEditingController();
    TextEditingController placecontroller = TextEditingController();
    TextEditingController pincodecontroller = TextEditingController();

    return Scaffold(
      body:Center(
        child: Form(
          key: _formkey,
          child: Column(
            
            children: [
              Text("Register Now",
              style: TextStyle(
                fontWeight: FontWeight.w800
              ),),
              TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: "Name"
                ),
                validator: (value) => value == null || value.isEmpty ?
                "Please enter your name" 
                : null,
              ),
               TextFormField(
                controller: phonecontroller,
                decoration: InputDecoration(
                  labelText: "phone No"
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ?
                "Please enter your phone no" 
                : null,
              ),
               TextFormField(
                controller: pincodecontroller,
                decoration: InputDecoration(
                  labelText: "pincode"
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ?
                "Please enter your pincode" 
                : null,
              ),
              TextFormField(
                controller: regemailcontroller,
                decoration: const InputDecoration(
                  hintText: "enter email"
                ),
                validator: (value) => value == null || value.isEmpty ?
                "please enter email"
                : null,
              ),
              SizedBox(height: 20,),
               TextFormField(
                controller: regpasscontroller,
                decoration: const InputDecoration(
                  hintText: "enter password"
                ),
                validator: (value) => value == null || value.length < 6
                ? "password must contain at least 6 characters"
                : null,
              ),
              SizedBox(height: 20,),
             BlocBuilder<RegistrationBloc,RegistrationState>(
              builder: (context, state) {
               if(state is RegistrationLoadingState){
                return Center(child: CircularProgressIndicator(),);
               }if(state is RegistrationLoadedState){
                 return  InkWell(
                onTap: (){
                  if(_formkey.currentState!.validate()){
                    context.read<RegistrationBloc>().add(onRegistrationEvent(
                      email: regemailcontroller.text,
                       name: namecontroller.text,
                        password: regpasscontroller.text,
                         phone: int.parse(phonecontroller.text),
                          pincode: int.parse(pincodecontroller.text),
                           place: placecontroller.text));
                           Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }
                },
                
                child: Container(
                  height: 50,
                  width: 150,
                  color: Colors.blue,
                  child: Center(child: Text("Sign Up",
                  style: TextStyle(
                    color: Colors.white
                  ),),),
                ),
              );
               } if(state is RegistrationErrorState){
                return Text("no data");
               }return SizedBox();
             },)
            ],
          ),
        ),
      ), 
    );
  }
}