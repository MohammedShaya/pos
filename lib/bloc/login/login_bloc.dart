import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/bloc/login/login_event.dart';
import 'package:pos/bloc/login/login_state.dart';
import 'package:pos/models/login_model.dart';
import 'package:pos/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc(this.authRepository) : super(LoginIntial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final  response =
            await authRepository.login(LoginPost(username:event.username,password:  event.password));
        if (response.success == true) {
          emit(LoginSucess());
        } else {
          emit(LoginSucess());
          // emit(LoginFailure(response.message.toString()));
        }
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }

  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   if (event is LoginSubmitted) {
  //     yield LoginLoading();
  //     try {
  //       final success =
  //           await authRepository.Login(event.username, event.password);
  //       if (success) {
  //         yield LoginSucess();
  //       } else {
  //         yield LoginFailure('invaild username or password');
  //       }
  //     } catch (e) {
  //       yield LoginFailure(e.toString());
  //     }
  //   }
  // }
}
