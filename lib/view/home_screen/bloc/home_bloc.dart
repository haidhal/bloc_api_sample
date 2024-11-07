import 'dart:developer';

import 'package:bloc_api_sample/model/product_model.dart';
import 'package:bloc_api_sample/utils/apputils.dart';
import 'package:bloc_api_sample/view/home_screen/bloc/home_event.dart';
import 'package:bloc_api_sample/view/home_screen/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;



class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(HomeLoadingState());
      final url =
          Uri.parse("https://freeapi.luminartechnohub.com/products-all/");
      try {
        final res = await http.get(url, headers: {
          "Authorization": "Bearer ${await Apputils.getTokenAccess()}"
        });
        if (res.statusCode == 200) {
          ProductResModel responseModel = productResModelFromJson(res.body);
          emit(HomeLoadedState(productsList: responseModel.productsList ?? []));
        }else{
          emit(HomeInitial());
        }
      } catch (e) {
        emit(HomeErrorState(errorMessage: e.toString()));
      }
    });

    on<DeleteProductsEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        final url = Uri.parse(
            "https://freeapi.luminartechnohub.com/product-delete/${event.productId}/");
        try {
          final res = await http.delete(url, headers: {
            "Authorization": "Bearer ${await Apputils.getTokenAccess()}"
          });
          if (res.statusCode == 200) {
            log(res.body);
            add(FetchProductsEvent());
          }
        } catch (e) {
          emit(HomeErrorState(errorMessage: e.toString()));
        }
      },
    );
  }
}
