// import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grad_app/repository/auth_repo.dart';
import 'package:grad_app/screens/components/BalanceCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HorizontalCard.dart';
import 'MainTitle.dart';
import 'TitleWithHorizontalCard.dart';


String finalname,finalCardId;
int finalAvailableBalance,finalRewardPoints;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  List <Transaction> transactions=[];
  int startIndex = 0;
  int endIndex = 3;
  List<Transaction> recentTransactions =[];
  Transaction transaction;
  @override
  void initState() {
    getdata().whenComplete(() async {
      // Timer(Duration(seconds: 2),
      //       () =>  print(finalname),
      // );
    });
    getWallet().whenComplete(() async {
    });
    getTransactions().whenComplete(() async {
    });
    super.initState();

  }

  Future getdata() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    setState(() {
      finalname = name;
    });
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
      preferences.setInt("blocked_balance", res.data['wallet']['blocked_balance']);
      preferences.setInt("reward_point", res.data['wallet']['reward_point']);

      var available_balance= sharedPreferences.getInt('available_balance');
      var reward_point= sharedPreferences.getInt('reward_point');
        //print(available_balance);
      // print(res.data);
      setState(() {
        finalAvailableBalance = available_balance;
        finalRewardPoints=reward_point;
      });
    }
    else
    {
      print(res.statusCode);
    }


  }

  Future <void> getTransactions () async{

    final Dio dio=new Dio();
    final sharedPreferences = await SharedPreferences.getInstance();
    var card_id= await sharedPreferences.getString('card_id');

    //Response res = await dio.get("http://localhost:8000/wallets/${card_id}",
    Response res = await dio.get("http://localhost:8000/wallets/students/${card_id}/Transaction",

        options: Options(
          headers: {},
        ));
    if(res.statusCode==200) {

      transactions = List<Transaction>.from(res.data["transactions"].map((transaction) => Transaction.fromJson(transaction)).toList());
      transactions.forEach((transaction) async {
        final Dio dio=new Dio();
        //${transaction.other_id}
        Response res = await dio.get("http://127.0.0.1:8000/wallets/other/${transaction.other_id}/data",

            options: Options(
              headers: {},
            ));
       // transaction.notifyListeners();
        setState(() {
          transaction.other_name=res.data['other_data']['name'];
        });

        // print(transaction.other_name);
      });
      int len = transactions.length;
      print(len);

      if(len>=3) {
        recentTransactions = transactions.sublist(startIndex, endIndex);
      }
      else
        {
          recentTransactions=transactions;
        }

    }
    else
    {
      print(res.statusCode);
    }



  }

  @override
  Widget build(BuildContext context) {

    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    //allows scrolling on smal dev
    return SingleChildScrollView(
      child: Column(

        children: <Widget>[
          Container(
            //covers 20% of the total height
            height: size.height * 0.2,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  //covers 20% of the total height
                  height: size.height * 0.2 - 40,
                  decoration: BoxDecoration(
                      color: Color(0xFF1E212D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 10.0, 10.0, 10.0),
                  child: Text(
                    'Welcome, $finalname',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: 'roboto'),
                  ),
                ),
                // Positioned(
                //   left: 50,
                //   right: 50,
                //   bottom: 0,
                //   top: 50,
                //   child: Text(
                //     'Lorem ipsum dolor sit amet, con ? ',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 15.0,
                //         fontFamily: 'roboto'),
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BalanceCard(
                size: size,
                text: "$finalAvailableBalance",
                SubText: "Current Balance",
              ),
              BalanceCard(
                size: size,
                text: "$finalRewardPoints",
                SubText: "Current RewardPoints",
              ),
            ],
          ),
          SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: Row(

              children: [
                MainTitle(Maintitle: "New Transactions"),
              ],
            ),
          ),
          SizedBox(height: 15),

          ...recentTransactions.map(
                  (recentTransaction) => HorizontalCard(size: size, Title: "Transaction from  ${recentTransaction.other_name}",
                type: "${recentTransaction.type} ${recentTransaction.amount} EGP",time: "${recentTransaction.accepted_at}",icon:  Icon(
                  Icons.attach_money_outlined,

                ),)),
          SizedBox(height: 30),

          TitleWithHorizontalCard(size: size, Maintitle: "New Notifications"),

        ],
      ),
    );
  }
}
class Transaction with ChangeNotifier{
  final String type;
  final int other_id;
  final String accepted_at;
  final int amount;
  String other_name;

  Transaction(this.type, this.other_id, this.accepted_at, this.amount);

  Transaction.fromJson(Map<String, dynamic> json)
      :type=json['type'] ?? '',
        other_id=json['other_id'] ?? '',
        accepted_at=json['accepted_at'] ?? '',
        amount=json['amount'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'other_id': other_id,
      'accepted_at': accepted_at,
      'amount':amount
    };
  }
}