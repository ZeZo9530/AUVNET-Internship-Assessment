import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/cart/cart_cubit.dart';
import 'package:store_app/cubits/order_history/order_history_cubit.dart';
import 'package:store_app/widgets/cart_widget/cart_custom.dart';

class CartProducts extends StatefulWidget {
  CartProducts({super.key});
  static const String id = "CartProducts";

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        //handling the checkout state
        if (state is CartCheckout) {
          //calling the orderHistory and clearing the cart
          BlocProvider.of<OrderHistoryCubit>(context).addOrder(state.cartList);
          print(state.cartList);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Checkout Successful!')));
        }
      },
      builder: (context, state) {
        //handling the cartloaded state
        if (state is CartLoaded) {
          return ListView.builder(
              itemCount: state.cartProducts.length,
              itemBuilder: (context, index) {
                return CustomCart(product: state.cartProducts[index]);
              });
        }
        if (state is CartEmpty || state is CartInitial) {
          return const Center(child: Text('No Items In Cart'));
        }
        if (state is CartCheckout) {
          return const Center(child: Text('Checkout Successful!'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
