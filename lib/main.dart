import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/catagroies/category_bloc.dart';
import 'package:pos/bloc/language/language_bloc.dart';
import 'package:pos/bloc/language/language_state.dart';
import 'package:pos/bloc/login/login_bloc.dart';
import 'package:pos/bloc/order/order_bloc.dart';
import 'package:pos/bloc/product/product_bloc.dart';
import 'package:pos/repositories/order_repository.dart';
import 'package:pos/repositories/auth_repository.dart';
import 'package:pos/repositories/category_repositry.dart';
import 'package:pos/repositories/product_repository.dart';
import 'package:pos/routes/route.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LanguageBloc()),
          BlocProvider(create: (context) => LoginBloc(AuthRepository())),
          BlocProvider(create: (context) => CategoryBloc(CategoryRepository())),
          BlocProvider(create: (context) => ProductBloc(ProductRepository())),
          BlocProvider(create: (context) => OrderBloc(OrderRepository()))
        ],
        child:
            BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
          return MaterialApp(
            locale: state.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
             GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            //   useMaterial3: true,
            // ),
            initialRoute: '/login',
            onGenerateRoute: OnGenerateRoute.generateRoute,
          );
        }));
  }
}
