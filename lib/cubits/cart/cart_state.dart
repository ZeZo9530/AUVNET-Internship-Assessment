part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartEmpty extends CartState {}

class CartLoaded extends CartState {
  final List<ProductModel> cartProducts;
  CartLoaded({required this.cartProducts});
}

class CartCheckout extends CartState {
  final List<List<ProductModel>> cartList;

  CartCheckout({required this.cartList});
}
