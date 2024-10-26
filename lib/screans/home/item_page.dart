import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/order/order_bloc.dart';
import 'package:pos/bloc/order/order_event.dart';
import 'package:pos/models/product_model.dart';
import 'package:pos/utls/colors.dart';
import 'package:pos/utls/styles.dart';

Widget itemPage(context, List<ProductModel> productList) {
  int x = 4;
  if (MediaQuery.of(context).size.width / 270 > 5) {
    x = 6;
  } else if (MediaQuery.of(context).size.width / 150 < 4) {
    x = 3;
  }
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text(
      "Fried",
      style: StylesApp.titleDescStyle,
    ),
    SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: x),
          itemCount: productList.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<OrderBloc>(context)
                      .add(AddToOrder('+',product: productList[index]));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.height * 0.02,
                  child:
                   Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: 
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          productList[index].imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              );
                            }
                          },
                        ),
                      )),
                      Expanded(
                        flex: 1,
                        child: 
                      Padding(
                        padding:  EdgeInsets.only(left: 8.0, 
                        top: MediaQuery.of(context).size.width*0.001),
                        child: Text(
                          productList[index].name.toString(),
                          style: StylesApp.normalStyle,
                        ),
                      )),
                        Expanded(
                        flex: 1,
                        child: 
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(productList[index].price.toString(),
                            style: StylesApp.priceNormalStyle),
                      ),
                        )
                    ],
                  ),
                ),
              ),
            );
          }),
    )
  ]);
}
