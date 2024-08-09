import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/API/update_product.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_text_field.dart';

//updating the product and uploading the data to the api
class UpdateProduct extends StatefulWidget {
  const UpdateProduct({
    super.key,
  });

  static String id = 'update product';

  @override
  State<UpdateProduct> createState() => _ProductDetailsState();
}

String? productName, description, price, image;

class _ProductDetailsState extends State<UpdateProduct> {
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Product Name',
                  onChanged: (data) {
                    productName = data;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  hintText: 'Description',
                  onChanged: (data) {
                    description = data;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  hintText: 'Price',
                  inputType: TextInputType.number,
                  onChanged: (data) {
                    price = data;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  hintText: 'Image',
                  onChanged: (data) {
                    image = data;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                    text: 'Update Product',
                    onTap: () async {
                      await updateProduct(product);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await UpdateProductService().updateProduct(
          id: product.id,
          title: productName == null ? product.title : productName!,
          price: price == null ? product.price.toString() : price!,
          description: description == null ? product.description : description!,
          image: image == null ? product.image : image!,
          category: product.category);
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }
}
