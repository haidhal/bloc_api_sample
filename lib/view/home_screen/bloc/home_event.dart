
 import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class DeleteProductsEvent extends HomeEvent {
  int productId;
  DeleteProductsEvent({required this.productId});
  @override
  List<Object> get props => [];
}
