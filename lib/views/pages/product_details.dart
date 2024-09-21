import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/views/widgets/drop_down_menu.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:e_commerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/constant.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
 late String dropDownValue;
  Future<void> _addToCart(Database database)async{
    // final database=Provider.of<Database>(context,listen: false);
    try{
      final addToCartProduct= AddToCartModel(
        id: documentIdFromLocalData(),
        productId:widget.product.id,
        title: widget.product.title,
        price: widget.product.price,
        imgUrl: widget.product.imgUrl,
        size: dropDownValue,
      );
      await database.addToCart(addToCartProduct);
    }catch(e){
      MainDialog(
          context: context,
          title: 'Error',
          content: 'could\,t add to the cart, please try again!',
      ).showAlertDialog();
    }

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dataBase=Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        title: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.55,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Expanded(
                          child:  SizedBox(
                            height: 55,
                              child:
                              DropDownMenuComponent(
                                hint:'Size',
                                items: const ['S','M','L','XL','XXL'],
                                onChanged: (String? newValue){
                                  setState(() {
                                    dropDownValue =newValue!;
                                  });
                                },
                              ),
                          ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${widget.product.price}',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.product.category,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                 const  Text(
                    'this is dummy description for this product! I think we well add  it in the future! I need  to add more lines , so I add these words just to have more than two lines   ',
                  ),
                  const SizedBox(height: 24,),
                  MainButton(
                      onPressed:()=>_addToCart(dataBase),
                      text:'Add to cart',
                  ),
                  const SizedBox(height: 32,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
