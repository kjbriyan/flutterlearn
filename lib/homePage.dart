import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'beranda.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'ApiInterface/AuthModel.dart' as authModel;

final emailController = TextEditingController();
final passController = TextEditingController();

class homePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 180,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/light-1.png'))),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    width: 80,
                    height: 140,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/light-2.png'))),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    width: 40,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/clock.png'))),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .4),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: emailController,
                                keyboardType: TextInputType.name,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter
                                ],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(0.0),
                              child: TextField(
                                controller: passController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, .5),
                            Color.fromRGBO(143, 148, 251, .9),
                          ])),
                      child: Center(
                          child: new GestureDetector(
                        onTap: () async {
                          if (emailController.text.length <= 0) {
                            text(context, "Usernmae tidak boleh kosong");
                          } else if (passController.text.length < 0) {
                            text(context, "Password tidak boleh kurang dari 6");
                          } else {
                            var client = http.Client();
                            var response = await client.post(
                                Uri.https('reqres.in', '/api/login'),
                                headers: {
                                  "Content-Type":
                                      "application/x-www-form-urlencoded",
                                },
                                body: {
                                  'email': emailController.text,
                                  'password': passController.text
                                });
                            if (response.statusCode == 200) {
                              var jsonResponse =
                                  convert.jsonDecode(response.body) as Map;
                              var data = jsonResponse['token'];
                              // var jsonResponse2 =
                              //     convert.jsonDecode(data) as Map;

                              // var name = jsonResponse2['name'];
                              // print('response body : ${response.body}');
                              print('is success : $data');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Beranda(
                                            email: emailController.text,
                                            password: passController.text,
                                          )));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Username dan password salah"),
                              ));
                            }
                          }
                        },
                        child: Text("Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Forgot Password?",
                        style:
                            TextStyle(color: Color.fromRGBO(143, 148, 251, 1))),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void text(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
