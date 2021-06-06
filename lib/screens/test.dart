// import 'package:flutter/material.dart';
// import 'package:grad_app/screens/components/bottomNavBar.dart';
// import 'package:grad_app/screens/components/sideMenu.dart';
//
// import 'dart:io';
// //import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// //import 'package:http/http.dart';
//
// import 'package:dio/dio.dart';
// //http: ^0.12.0+2
// //dio: ^4.0.0
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
//
// class _ProfileScreenState extends State<ProfileScreen> {
//
//
//   List <Student> students=[];
//   Student student;
//   bool isloading=true;
//
//   void _getStudentData() async{
//     final Dio dio=new Dio();
//     try{
//       // var dio = Dio();
//       // Response response = await dio.get('http://127.0.0.1:3005/');
//
//       var response =await dio.get("http://127.0.0.1:3000/");
//       //var response =await dio.get("http://127.0.0.1:3005/234");
//       print("heloooo in try");
//       print(response.statusCode);
//      print(response.data["students"]);
//       //var responseData=response.data as List;
//
//
//
//      //setState(() {
//         students = List<Student>.from(response.data["students"].map((student) => Student.fromJson(student)).toList());
//
//       //  student = Student.fromJson(response.data["student"]);
//        // print(student.name);
//       setState(stoploading);
//
//       // print(students[0]);
//     //  });
//     }on DioError catch(e)
//     {
//       print("heloooo");
//       print(e);
//     }
//   }
//   @override
//   void initState() {
//     _getStudentData();
//     super.initState();
//   }
//   setState(_getStudentData);
//
//   void stoploading()
//   {
//     isloading=false;
//   }
//
//   @override
//   Widget build(BuildContext context)   {
//     //initState();
//     // print(students);
//
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//
//       drawer: NavDrawer(),
//       appBar: AppBar(
//           iconTheme: IconThemeData(color: Color(0xFF1E212D)),
//           backgroundColor: Colors.white.withOpacity(0.0),
//           elevation: 0,
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pushNamed('/editprofile');
//                   },
//                   child: Text(
//                     'Edit',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xFF1E212D),
//                     ),
//                   )),
//
//             ),
//           ]),
//
//       body: Center(
//         child: Container(
//           width: size.width*0.9,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               //${students}
//               // isloading ? Text("isloading") : Text("${students[0].name}"),
//
//               //  isloading ? Text("isloading") : Text("${students[0].name}"),
//
//
//               ...students.map(
//                       (student) => Text("${student.name}")),
//
//
//
//               // SizedBox(height: 30),
//               // CircleAvatar(
//               //   backgroundImage: NetworkImage('https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'),
//               //   radius: 70,
//               // ),
//               //
//               // SizedBox(height: 40,),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: <Widget>[
//               //
//               //
//               //     Expanded(
//               //       flex: 2,
//               //       child: Icon(Icons.person,
//               //         color: Color(0xFF777A7D),),
//               //     ),
//               //     //Spacer(),
//               //     Expanded(
//               //       flex: 8,
//               //       child: Text("Jhon Doe",
//               //         style: TextStyle(
//               //           color: Color(0xFF777A7D),
//               //           fontSize: 20.0,
//               //           fontFamily: 'roboto',
//               //         ),),
//               //     ),
//               //   ],
//               // ),
//               // SizedBox(height: 30,),
//               // Row(
//               //   // mainAxisAlignment: MainAxisAlignment.start,
//               //   children: <Widget>[
//               //     Expanded(
//               //       flex: 2,
//               //       child: Icon(Icons.mail,
//               //         color: Color(0xFF777A7D),),
//               //     ),
//               //     //Spacer(),
//               //     Expanded(
//               //       flex: 8,
//               //       child: Text("JhonDoe@gmail.com",
//               //         style: TextStyle(
//               //           color: Color(0xFF777A7D),
//               //           fontSize: 20.0,
//               //           fontFamily: 'roboto',
//               //         ),),
//               //     ),
//               //   ],
//               // ),
//               // SizedBox(height: 30,),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: <Widget> [
//               //     Expanded(
//               //       flex: 2,
//               //       child: Icon(Icons.phone,
//               //         color: Color(0xFF777A7D),),
//               //     ),
//               //     //Spacer(),
//               //     Expanded(
//               //       flex: 8,
//               //       child: Text("+0200300500",
//               //         style: TextStyle(
//               //           color: Color(0xFF777A7D),
//               //           fontSize: 20.0,
//               //           fontFamily: 'roboto',
//               //         ),),
//               //     ),
//               //   ],
//               // ),
//
//
//             ],),
//         ),
//       ),
//
//       bottomNavigationBar: NavBar(),
//     );
//   }
//
// }
//
//
// Future<List> getStudentData () async{
//
//
//
//   final Dio dio = new Dio();
//   Response res = await dio.post(
//       "http://127.0.0.1:8000/lectures/record_attendance",
//       data: {
//       },
//       options: Options(
//         headers: {},
//       ));
//   if (res.statusCode == 200) {
//
//     print(jsonDecode(res.data));
//
//     //return List<Map<String, dynamic>>.from(json.decode(res.data));
//     }
//   else {
//     print(res.statusCode);
//   }
//
//
//
//
//
//
//
//
//   return jsonDecode(response.body);
//
//   // Map data = jsonDecode(response.body);
//   // Map<String, dynamic> map = jsonDecode(response.body);
//   // List<dynamic> newdata = map["dataKey"];
//   // print(newdata);
//
//
//
//   // var x=6;
//   // List<Student> students=[];
//   //
//   // print(data);
//     //((k, v) => students.add(Student('name', 'email', 'student_phone_number')));
//
//   // for(var s in data)
//   //   {
//   //      Student student=Student(s['name'],s['email'],s['student_phone_number']);
//   //      students.add(student);
//   //   }
//   // print(students.length);
//  // print(data);
//
// }
//
// // void main()async{
// //   List data= await getStudentData();
// //   print(data);
// //
// // }
//
//
//
//
//
// class Student{
//   final String card_id,fcm_code,name,email,password,birth_date,student_phone_number,parent_phone_number;
//
//
//   Student(this.name, this.email, this.student_phone_number, this.card_id, this.fcm_code, this.password, this.birth_date, this.parent_phone_number);
//
//   Student.fromJson(Map<String,dynamic> json)
//       :card_id=json['card_id'] ?? '',
//         fcm_code=json['fcm_code'] ??'',
//         name=json['name'] ?? '',
//         email=json['email'] ?? '',
//         password=json['password'] ?? '',
//         birth_date=json['birth_date'] ?? '',
//         student_phone_number=json['student_phone_number'] ?? '',
//         parent_phone_number=json['parent_phone_number'] ?? '';
//
//   Map<String, dynamic> toJson() {
//     return {
//       'card_id': card_id,
//       'fcm_code': fcm_code,
//       'name': name,
//       'email': email,
//       'password': password,
//       'birth_date': birth_date,
//       'student_phone_number': student_phone_number,
//       'parent_phone_number': parent_phone_number,
//
//     };
//   }
//
//
//
//
//
//
//
//
// }