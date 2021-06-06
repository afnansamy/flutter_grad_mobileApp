import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grad_app/screens/components/BalanceCard.dart';
import 'package:grad_app/screens/components/MainTitle.dart';
import 'package:grad_app/screens/components/TextFieldsRow.dart';
import 'package:grad_app/screens/components/sideMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

int finalAvailableBalance,finalRewardPoints;
class ChargeWalletScreen extends StatefulWidget {
  @override
  _ChargeWalletScreenState createState() => _ChargeWalletScreenState();
}

class _ChargeWalletScreenState extends State<ChargeWalletScreen> {

  @override
  void initState() {
    getWallet().whenComplete(() async {
    });

    super.initState();
  }

  Future <void> getWallet () async{
    final Dio dio=new Dio();
    final sharedPreferences = await SharedPreferences.getInstance();
    var card_id= await sharedPreferences.getString('card_id');

    //var url="http://localhost:3000/wallets/"+finalCardId;
    Response res = await dio.get("http://localhost:8000/wallets/${card_id}",
        options: Options(
          headers: {},
        ));
    if(res.statusCode==200) {
      var preferences =await SharedPreferences.getInstance();
      preferences.setInt("available_balance", res.data['wallet']['available_balance']);

      var available_balance= sharedPreferences.getInt('available_balance');

      setState(() {
        finalAvailableBalance = available_balance;
      });
    }
    else
    {
      print(res.statusCode);
    }


  }


  int _value = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Color(0xFF1E212D),
            ),
            onPressed: () {Navigator.of(context).pushNamed('/mywallet');}),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: BalanceCard(
              size: size,
              text: "$finalAvailableBalance",
              SubText: "Current Balance",
            )),
            SizedBox(
              height: 33.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 39.0),
              child: MainTitle(Maintitle: 'Choose Payment Method'),
            ),
            SizedBox(height: 28.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _value = 0;
                        RechargeFields(size: size);
                      });

                      // final snackBar = SnackBar(content: RechargeFields(size: size));
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(
                            color: _value == 0
                                ? Color(0xFF719fb0).withOpacity(0.4)
                                : Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.2)),
                          ]),
                      height: 126,
                      width: 126,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(
                            image: AssetImage('assets/images/credit-card.png')),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _value = 1),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(
                            color: _value == 1
                                ? Color(0xFF719fb0).withOpacity(0.4)
                                : Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.2)),
                          ]),
                      height: 126,
                      width: 126,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(
                            image: AssetImage('assets/images/paypal.png')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 38.0),
              if(_value==0)
                RechargeFields(size: size),

          ],
        ),
      ),
    );
  }
}

class RechargeFields extends StatelessWidget {
  const RechargeFields({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: MainTitle(Maintitle: 'Charge By Credit Card'),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                width: size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: new InputDecoration(
                        hintText: "Enter your Credit Card Number",
                        hintStyle:
                            new TextStyle(color: const Color(0xFFACACAC)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF719fb0).withOpacity(0.7)),
                        ),
                      ),
                    ),
                    TextFieldsRow(
                      size: size,
                      field1: "CVV",
                      field2: "MM/YY",
                    ),
                    TextFieldsRow(
                      size: size,
                      field1: "Holder Name",
                      field2: "Amount",
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      width: size.width * 0.8,
                      height: 100,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () => print('Login Button Pressed'),
                        padding: EdgeInsets.all(15.0),
                        color: Color(0xFF1E212D),
                        child: Text(
                          'RECHARGE',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
