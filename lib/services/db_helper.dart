//
// import 'package:flutter/cupertino.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper{
//   Database? database;
//
//   void createDatabase() {
//     openDatabase('mira.db', version: 1, onCreate: (database, version){
//       database.execute('CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, note TEXT. date TEXT, time TEXT, status TEXT)').then((value) {
//         print('table created');
//       }).catchError((error){
//         print('Error while creating table ${error.toString()}');
//       });
//     },
//       onOpen: (database){
//       print('database opened');
//       }
//     ).then((value) {
//       database = value;
//     });
//   }
//
//   void insertToDatabase({@required title, @required String? note, @required String? date, @required String? time}) async{
//     await database?.transaction((txn) async{
//       txn.rawInsert(sql)
//     });
//   }
// }