import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/blocs/auth_bloc.dart';
import 'package:grad_app/blocs/auth_state.dart';
import 'package:grad_app/screens/Notification.dart';
import 'package:grad_app/screens/chargeWallet.dart';
import 'package:grad_app/screens/login.dart';
import 'package:grad_app/screens/home.dart';
import 'package:grad_app/screens/profile.dart';
import 'package:grad_app/screens/scanQr.dart';
import 'package:grad_app/screens/wallet.dart';
import 'repository/auth_repo.dart';
import 'screens/editProfile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context)=> AuthBloc(LoginInitState(), AuthRepository()))
      ],
      child: MaterialApp(


        //initialRoute: _initialRoute,

        initialRoute : '/login',
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeScreen(),
          '/notification': (BuildContext context) => NotificationScreen(),
          '/mywallet': (BuildContext context) => WalletScreen(),
          '/scanqr': (BuildContext context) => QrScreen(),
          '/login': (BuildContext context) => LoginScreen(),
          '/editprofile': (BuildContext context) => EditProfileScreen(),
          '/profile': (BuildContext context) => ProfileScreen(),
          '/chargewallet': (BuildContext context) => ChargeWalletScreen(),
        },
      ),
    );
  }
}

