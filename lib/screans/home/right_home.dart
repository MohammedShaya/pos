import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/order/order_bloc.dart';
import 'package:pos/bloc/order/order_event.dart';
import 'package:pos/bloc/order/order_state.dart';
import 'package:pos/screans/checkout.dart';
import 'package:pos/utls/colors.dart';
import 'package:pos/utls/spaces.dart';
import 'package:pos/utls/styles.dart';

class RightHome extends StatefulWidget {
  const RightHome({super.key});

  @override
  State<RightHome> createState() => _RightHomeState();
}

class _RightHomeState extends State<RightHome> {
 final TextEditingController _discountController = TextEditingController();
 @override
  void initState() {
    _discountController.text='0.00';
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      if (state is OrderIntial) {
        return Container();
      } else if (state is OrderUpdeted) {
        _discountController.text=state.order.discount==null?'0':state.order.discount.toString();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClayContainer(
              color: AppColors.backGroundCategoryColor,
              spread: 1,
              borderRadius: 10,
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "My Cart "
                                "${state.order.items == null ? 0 : state.order.items!.length}",
                                style: StylesApp.titleDescStyle,
                              )),
                          Flexible(
                              flex: 1,
                              child: InkWell(
                                child: const Text(
                                  "Clear All ",
                                  style: StylesApp.normalStyle,
                                ),
                                onTap: () {
                                  BlocProvider.of<OrderBloc>(context)
                                      .add(ClearOrder());
                                },
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: state.order.items!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                width: MediaQuery.of(context).size.width * 0.06,
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                state.order.items![index].imagePath.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    );
                                  }
                                },
                              ),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.order.items![index].name.toString(),
                                      style: StylesApp.itemNameStyle,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          BlocProvider.of<OrderBloc>(context)
                                              .add(AddToOrder('d',
                                                  product: state
                                                      .order.items![index]));
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: AppColors.scondaryColor,
                                          size: 20,
                                        ))
                                  ],
                                ),
                                SpaceApp.spaceH_10,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<OrderBloc>(context)
                                                .add(AddToOrder('-',
                                                    product: state
                                                        .order.items![index]));
                                          },
                                          child: ClayContainer(
                                            spread: 0,
                                            color: AppColors.primaryColor,
                                            borderRadius: 5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.025,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.045,
                                            child: Center(
                                              child: Text(
                                                "-",
                                                style:
                                                    StylesApp.minusStyleSelect,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SpaceApp.spaceW_10,
                                        Text(
                                          state.order.items![index].quantity
                                              .toString(),
                                          style: StylesApp.itemNameStyle,
                                        ),
                                        SpaceApp.spaceW_10,
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<OrderBloc>(context)
                                                .add(AddToOrder('+',
                                                    product: state
                                                        .order.items![index]));
                                          },
                                          child: ClayContainer(
                                            spread: 0,
                                            color: AppColors.primaryColor,
                                            borderRadius: 5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.025,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.045,
                                            child: Center(
                                              child: Text(
                                                "+",
                                                style:
                                                    StylesApp.minusStyleSelect,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      state.order.items![index].price
                                          .toString(),
                                      style: StylesApp.itemNameStyle,
                                    ),
                                  ],
                                ),
                                SpaceApp.spaceH_20,
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SpaceApp.spaceH_10,

                    ///calc
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
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
                            state.order.subTotal.toString(),
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
                          SizedBox(
                            height:30,
                            width: 40,
                            child: TextField(
                              controller: _discountController,
                              textAlign: TextAlign.end,
                              style: StylesApp.calcStyle,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            autofocus: false,
                            onChanged:(value){
                              int? dis=value !=''?int.tryParse(value):0 ;
                              if(dis!>state.order.subTotal){
                                dis=0;
                                _discountController.clear();
                              }
                               BlocProvider.of<OrderBloc>(context).add(AddDiscountOrder(dis));
                            },
                            ),
                          )
                          
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
                            state.order.vat.toString(),
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
                            state.order.total.toString(),
                            style: StylesApp.totalStyle,
                          ),
                        ],
                      ),
                    ),
                    SpaceApp.spaceH_20,
                    //bun Payment

                    FilledButton(
                      style: FilledButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                            MediaQuery.of(context).size.height * 0.07),
                        backgroundColor: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        if (state.order.items!.isNotEmpty) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Checkout(
                                  order: state.order,
                                );
                              });
                        }
                      },
                      child: const Text("Checkout"),
                    )
                  ],
                ),
              )),
        );
      } else {
        return Container();
      }
    });
  }
}
