import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:store_app/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<ProductModel> cartItems = [];

  List<List<ProductModel>> cartList = [];

//adding products to cart list
  void addProduct(ProductModel product) {
    cartItems.add(product);
  }

  //removing products from cart
  void removeProduct(ProductModel product) {
    cartItems.remove(product);
    if (cartItems.isEmpty) {
      emit(CartEmpty());
    } else {
      emit(CartLoaded(cartProducts: cartItems));
    }
  }

  //return cartloaded state if the list is not empty
  void getCart() {
    if (cartItems.isEmpty) {
      emit(CartEmpty());
    } else {
      emit(CartLoaded(cartProducts: cartItems));
    }
  }

  //clearing cart
  void clearCart() {
    emit(CartEmpty());
    cartItems.clear();
  }

  //checkout to save the items in the order history and clear cart
  void checkOut() {
    if (cartItems.isEmpty) {
      emit(CartEmpty());
    } else {
      cartList.add(cartItems);
      emit(CartCheckout(cartList: cartList));
    }
  }
}
