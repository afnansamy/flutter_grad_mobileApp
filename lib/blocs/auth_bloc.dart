import 'package:grad_app/blocs/auth_events.dart';
import 'package:grad_app/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents,AuthState>{
  AuthRepository repo;
  AuthBloc(AuthState initialState, this.repo) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
   var pref =await SharedPreferences.getInstance();
   if(event is StartEvents)
     {
       yield LoginInitState();
     }
   else if(event is LoginButtonPressed) {
     yield LoginLoadingState();

     try {
       var data = await repo.login(event.email, event.password);
       //TODO:: return user object
       //TODO:: https://pub.dev/packages/shared_preferences


       pref.setString("access_token", data['access_token']);
       pref.setString("refresh_token", data['refresh_token']);
       pref.setInt("id", data['user']['id']);
       pref.setString("email", data['user']['email']);
       pref.setString("name", data['user']['name']);
       pref.setString("card_id", data['user']['card_id']);
       pref.setString("studentPhone", data['user']['student_phone_number']);
       pref.setString("parentPhone", data['user']['parent_phone_number']);
       pref.setString("birth_date", data['user']['birth_date']);

       yield UserLoginSuccessState();
     }catch(e)
    {
      yield LoginErrorState(message: "Please enter your data correctly");
    }
   }

   else {
     yield LoginErrorState(message: "These credentials do not match our records.Please check your data");
   }


  }

}