import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/catagroies/category_bloc.dart';
import 'package:pos/bloc/catagroies/category_event.dart';
import 'package:pos/bloc/catagroies/category_state.dart';
import 'package:pos/bloc/language/language_bloc.dart';
import 'package:pos/bloc/language/language_event.dart';
import 'package:pos/bloc/product/product_bloc.dart';
import 'package:pos/bloc/product/product_event.dart';
import 'package:pos/bloc/product/product_state.dart';
import 'package:pos/models/product_model.dart';
import 'package:pos/screans/home/item_page.dart';
import 'package:pos/utls/colors.dart';
import 'package:pos/utls/images.dart';
import 'package:pos/utls/spaces.dart';
import 'package:pos/utls/styles.dart';

class LeftHome extends StatefulWidget {
  const LeftHome({super.key});

  @override
  State<LeftHome> createState() => _LeftHomeState();
}

class _LeftHomeState extends State<LeftHome> {
  late int selectedCategroy = 1;
  late List<ProductModel> productList;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
    // selectedCategroy =
    //     BlocProvider.of<CategoryBloc>(context).selectedCategoryIndex;
    BlocProvider.of<ProductBloc>(context)
        .add(FetchProduct(catIndex: selectedCategroy));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          final categroyList = state.categoryList;
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageApp.logo,
                      height: 30,
                    ),
                    InkWell(onTap: (){
                      final  newLocale=context.read<LanguageBloc>().state.locale.languageCode=='en'?const Locale('ar'):const Locale('en');
                      context.read<LanguageBloc>().add(ChangeLanguage(locale: newLocale));
                    },child: 
                    Image.asset(
                      ImageApp.imgLng,
                      height: 30,
                    )),
                  ],
                ),
                SpaceApp.spaceH_10,
                ClayContainer(
                    color: AppColors.backGroundCategoryColor,
                    borderRadius: 10,
                    width: MediaQuery.of(context).size.width,
                    spread: 1,
                    emboss: true,
                    depth: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Choose from Main categories",
                            style: StylesApp.titleDescStyle,
                          ),
                          SpaceApp.spaceH_10,
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categroyList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCategroy = index+1;
                                    });
                                    BlocProvider.of<ProductBloc>(context).add(
                                        FetchProduct(
                                            catIndex: selectedCategroy));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClayContainer(
                                      color: AppColors.white,
                                      surfaceColor:
                                          selectedCategroy == index + 1
                                              ? AppColors.scondaryColor
                                              : null,
                                      parentColor: AppColors.scondaryColor,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      spread: 1,
                                      child: Center(
                                          child: Text(
                                        categroyList[index].name,
                                        style: selectedCategroy == index + 1
                                            ? StylesApp
                                                .categoryNormalStyleSelect
                                            : StylesApp.categoryNormalStyle,
                                      )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SpaceApp.spaceH_10,
                        ],
                      ),
                    )),
                SpaceApp.spaceH_10,
                BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  if (state is ProductLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  } else if (state is ProductLoaded) {
                    return itemPage(
                        context, state.productList.cast<ProductModel>());
                  } else if (state is ProductError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return const Center(
                      child: Text("No Product Available"),
                    );
                  }
                })
              ],
            ),
          );
        } else if (state is CategoryError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: Text("No Categroies Available"),
          );
        }
      },
    );
  }
}
