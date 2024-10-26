import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/login/login_bloc.dart';
import 'package:pos/bloc/login/login_event.dart';
import 'package:pos/bloc/login/login_state.dart';
import 'package:pos/utls/colors.dart';
import 'package:pos/utls/images.dart';
import 'package:pos/utls/spaces.dart';
import 'package:pos/utls/styles.dart';
import 'package:pos/widgets/icon_button.dart';
import 'package:pos/widgets/text_feild.dart';

class LoginScrean extends StatefulWidget {
  const LoginScrean({super.key});

  @override
  State<LoginScrean> createState() => _LoginScreanState();
}

// ignore: camel_case_types
class _LoginScreanState extends State<LoginScrean> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
            flex: 4,
            child: Container(
                color: const Color(0xffEAFAFF),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpaceApp.spaceH_70,
                      SpaceApp.spaceH_20,
                      Image.asset(
                        ImageApp.logo,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      SpaceApp.spaceH_70,
                      Container(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: ClayContainer(
                            parentColor: AppColors.primaryColor,
                            borderRadius: 10,
                            spread: 1,
                            child: Image.asset(
                              ImageApp.loginPos,
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                          ))
                    ]))),
        Expanded(
          flex: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SpaceApp.spaceH_70,
              const Text("Login", style: StylesApp.titleStyle),
              const Text(
                "hi, user Please Login to continue",
                style: StylesApp.titleDescStyle,
              ),
              SpaceApp.spaceH_10,
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "User Name",
                          style: StylesApp.normalStyle,
                        ),
                        getTextFormField('username', _username, false),
                        const Text(
                          "Password",
                          style: StylesApp.normalStyle,
                        ),
                        getTextFormField('Password', _password, true)
                      ],
                    ),
                  )),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSucess) {
                    Navigator.of(context).pushReplacementNamed('/Home');
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error),
                      backgroundColor: AppColors.scondaryColor,
                    ));
                  }
                },
                builder: (BuildContext context, LoginState state) {
                  if (state is LoginLoading) {
                    return CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    );
                  }
                  return FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginSubmitted(_username.text, _password.text));
                      }
                    },
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text("login"),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getIconButton(Icons.desktop_mac_rounded, () {}),
                  getIconButton(Icons.tablet_android, () {}),
                  getIconButton(Icons.language, () {}),
                  getIconButton(Icons.sync, () {}),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
