import 'dart:ui';

abstract class LanguageEvent {}

class Letchlanguage extends LanguageEvent {
}

class ChangeLanguage extends LanguageEvent {
     final Locale locale;
   ChangeLanguage({required this.locale});
}
