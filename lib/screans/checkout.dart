import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/order/order_bloc.dart';
import 'package:pos/bloc/order/order_event.dart';
import 'package:pos/bloc/order/order_state.dart';
import 'package:pos/utls/colors.dart';
import 'package:pos/utls/spaces.dart';
import 'package:pos/utls/styles.dart';

class Checkout extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final order;
  const Checkout({super.key, required this.order});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0,
        child: ClayContainer(
          color: AppColors.white,
          borderRadius: 15,
          spread: 1,
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Checkout",
                    style: StylesApp.titleDescStyle,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.cancel_presentation_outlined,
                        color: AppColors.grey,
                      ))
                ],
              ),
            ),
            const Divider(
              thickness: 0,
            ),
            (state is OrderSaved)
                ? Column(
                    children: [
                      ClayContainer(
                        borderRadius: 250,
                        color: AppColors.checkSucss,
                        surfaceColor: AppColors.checkSucss,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.05,
                        spread: 2,
                        child: Icon(
                          size: 40,
                          Icons.check,
                          color: AppColors.white,
                        ),
                      ),
                      SpaceApp.spaceH_10,
                      const Text(
                        "Success",
                        style: StylesApp.titleDescStyle,
                      ),
                      SpaceApp.spaceH_10,
                      Text(
                        state.message,
                        style: StylesApp.normalStyle,
                      ),
                    ],
                  )
                : Container(),
            SpaceApp.spaceH_20,
            ClayContainer(
              color: AppColors.backGroundCategoryColor,
              borderRadius: 15,
              spread: 1,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                        right: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SubTotal",
                            style: StylesApp.calcStyle,
                          ),
                          Text(
                            widget.order == null
                                ? "0.0"
                                : widget.order.subTotal.toString(),
                            style: StylesApp.calcStyle,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount",
                            style: StylesApp.calcStyle,
                          ),
                        
                          Text(
                            widget.order.discount == null
                                ? "0.0"
                                : widget.order.discount.toString(),
                            style: StylesApp.calcStyle,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "VAT",
                            style: StylesApp.calcStyle,
                          ),
                          Text(
                            widget.order.vat.toString(),
                            style: StylesApp.calcStyle,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: StylesApp.totalStyle,
                          ),
                          Text(
                            widget.order.total != null
                                ? widget.order.total.toString()
                                : '0.00',
                            style: StylesApp.totalStyle,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SpaceApp.spaceH_20,
            BlocConsumer<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is OrderSaved) {
                  Future.delayed(const Duration(seconds: 1), () {
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<OrderBloc>(context).add(ClearOrder());
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  });
                } else if (state is OrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                    content: Text(state.error),
                    backgroundColor: AppColors.primaryColor,
                  ));
                }
              },
              builder: (BuildContext context, OrderState state) {
                if (state is OrderSaving) {
                  return CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  );
                }
                return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.1,
                            MediaQuery.of(context).size.height * 0.05)),
                    onPressed: () async {
                      BlocProvider.of<OrderBloc>(context).add(SaveOrder());
                    },
                    child: Center(
                        child: Text(
                      "Okay",
                      style: StylesApp.itemNameStyle,
                    )));
              },
            ),
          ]),
        ),
      );
    });
  }
}
