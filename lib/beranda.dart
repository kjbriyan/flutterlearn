import 'package:flutter/material.dart';

class Beranda extends StatelessWidget{
  //this for send data to another layar
  final email;
  final password;
  Beranda({this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(password)
      ),
      body: Center(
        child: ElevatedButton
      (onPressed: (){
        Navigator.pop(context);
      }, child: Text(email)),)
    );
  }
} 