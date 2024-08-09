import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:store_app/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<ProductModel> cartItems = [];

  List<List<ProductModel>> cartList = [];

  void addProduct(ProductModel product) {
    cartItems.add(product);
  }

  void removeProduct(ProductModel product) {
    cartItems.remove(product);
    if (cartItems.isEmpty) {
      emit(CartEmpty());
    } else {
      emit(CartLoaded(cartProducts: cartItems));
    }
  }

  void getCart() {
    if (cartItems.isEmpty) {
      emit(CartEmpty());
    } else {
      emit(CartLoaded(cartProducts: cartItems));
    }
  }

  void clearCart() {
    emit(CartEmpty());
    cartItems.clear();
  }

  void checkOut() {
    if (cartItems.isEmpty) {
      emit(CartEmpty());
    } else {
      cartList.add(cartItems);
      emit(CartCheckout(cartList: cartList));
    }
  }
}
