import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/language/language_event.dart';
import 'package:pos/bloc/language/language_state.dart';


class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {

  LanguageBloc() : super(LanguageState(const Locale('en'))) {
    on<ChangeLanguage>((event, emit) async {
      emit(LanguageState(event.locale));
    });
  }

}
