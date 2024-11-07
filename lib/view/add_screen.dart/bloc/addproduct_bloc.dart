
import 'package:bloc_api_sample/view/add_screen.dart/bloc/addproduct_event.dart';
import 'package:bloc_api_sample/view/add_screen.dart/bloc/addproduct_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AddproductBloc extends Bloc<AddproductEvent, AddproductState> {
  AddproductBloc() : super(AddproductInitial()) {
    on<AddproductEvent>((event, emit) {
      emit(AddingproductState());
       
    });
  }
}
