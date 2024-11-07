// ignore_for_file: prefer_const_constructors

import 'package:bloc_api_sample/pages/add_screen.dart';
import 'package:bloc_api_sample/view/home_screen/bloc/home_bloc.dart';
import 'package:bloc_api_sample/view/home_screen/bloc/home_event.dart';
import 'package:bloc_api_sample/view/home_screen/bloc/home_state.dart';
import 'package:bloc_api_sample/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomeBloc>().add(FetchProductsEvent());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context,
           MaterialPageRoute(builder:(context)=>AddProductScreen() ));
      },
      child: Icon(Icons.add),),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  final prefs =await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        title: Text(state.productsList[index].name!),
                        trailing: IconButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(DeleteProductsEvent(
                                  productId: state.productsList[index].id!));
                            },
                            icon: Icon(Icons.delete)),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: state.productsList.length);
            }
            return SizedBox();
          },
        ));
  }
}
