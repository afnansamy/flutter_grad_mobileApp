import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grad_app/screens/components/BalanceCard.dart';
import 'package:grad_app/screens/components/bottomNavBar.dart';
import 'package:grad_app/screens/components/sideMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grad_app/screens/components/MainTitle.dart';
import 'components/HorizontalCard.dart';

int finalAvailableBalance,finalRewardPoints;
class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isloading=true;

  List <Transaction> transactions=[];
  Transaction transaction;
  @override
  void initState() {
    getWallet().whenComplete(() async {
    });
    getTransactions().whenComplete(() async {
    });


    super.initState();
  }

  Future <void> getWallet () async{

    final Dio dio=new Dio();
    final sharedPreferences = await SharedPreferences.getInstance();
    var card_id= await sharedPreferences.getString('card_id');
    Response res = await dio.get("http://localhost:8000/wallets/${card_id}",
        options: Options(
          headers: {},
        ));
    if(res.statusCode==200) {
      var preferences =await SharedPreferences.getInstance();
      preferences.setInt("available_balance", res.data['wallet']['available_balance']);
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
        setState(() {
          transaction.other_name=res.data['other_data']['name'];
        });
      });


    }
    else
    {
      print(res.statusCode);
    }



  }
  void stoploading()
  {
    isloading=false;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF1E212D)),
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/chargewallet');
                  },
                  child: Text(
                    'Charge Wallet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1E212D),
                    ),
                  )),

            ),
          ]),
   body: SingleChildScrollView(
     child: Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,

           children: <Widget>[
             BalanceCard(size: size,text:"$finalAvailableBalance",SubText: "Current Balance",),
             BalanceCard(size: size,text:"$finalRewardPoints",SubText: "Current RewardPoints",),
           ],
         ),
         SizedBox(height: 50),
         Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             MainTitle(Maintitle: "New Transactions"),
             SizedBox(height: 15),
             ...transactions.map(


               //   (transaction) => Text("${transaction.type}")),
                   (transaction) => HorizontalCard(size: size, Title: "Transaction from ${transaction.other_name}",
                     type: "${transaction.type}",time: "${transaction.accepted_at}",icon:  Icon(
                         Icons.attach_money_outlined,

                         ),)),
           ],
         )

           //(transaction)=>  DateTime time= DateTime.parse(accepted_at)
       ],

     ),
   ),
      bottomNavigationBar: NavBar(),
    );
  }
}

class Transaction{
  final String type;
  final int other_id;
  final String accepted_at;
  String other_name;

  Transaction(this.type,this.other_id,this.accepted_at);

  Transaction.fromJson(Map<String,dynamic> json)
      :type=json['type'] ?? '',
        other_id=json['other_id'] ??'',
        accepted_at=json['accepted_at'] ??'';

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'other_id': other_id,
      'accepted_at':accepted_at
    };
  }

}