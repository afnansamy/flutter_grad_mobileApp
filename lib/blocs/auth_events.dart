import 'package:equatable/equatable.dart';
class AuthEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StartEvents extends AuthEvents{}

class LoginButtonPressed extends AuthEvents
{
  final String email;
  final String password;

  LoginButtonPressed({this.email, this.password});

}


