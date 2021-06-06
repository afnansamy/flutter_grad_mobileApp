import 'package:equatable/equatable.dart';
class AuthState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginInitState extends AuthState{}

class LoginLoadingState extends AuthState{}

class UserLoginSuccessState extends AuthState{
  // var data;
  // UserLoginSuccessState({this.data});

}

class LoginErrorState extends AuthState{
  final String message;

  LoginErrorState({this.message});

}
