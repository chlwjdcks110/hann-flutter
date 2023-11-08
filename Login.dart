import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hann/api.dart';
import 'package:hann/User.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}






class _LoginState extends State<Login> {

  var emailController1 = TextEditingController();
  var passwordController1 = TextEditingController();

  /*LoginUserEmail() async {
    try {
      var response = await http.post(Uri.parse(API.validateEmail),
          body: {'user_password': passwordController1.text.trim()});

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['existPassword'] == true) {
          Fluttertoast.showToast(
            msg: "패스워드가 일치하지 않습니다.",
          );
        }else{
          Login();
        }
      }

      Login();

    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }*/

  Future<String> connect() async {
      var res = await http.get(
          Uri.parse('http://10.0.2.2:8080/hann/login/${emailController1.text}'),
      );
      var emailcheck = res.body;
      return emailcheck;
  }

  Login() async {

    try {
        var emailtext1 = await connect();
        var emailtext2 = passwordController1.text.trim();
        print(emailtext1);
    
        if(emailtext1 == emailtext2){
          Fluttertoast.showToast(msg: 'Login sucy');
          setState(() {
            emailController1.clear();
            passwordController1.clear();
          });
          Navigator.pushNamedAndRemoveUntil(context, '/home',(route)=>false);
        }else{
          
          Fluttertoast.showToast(msg: 'asdfasdf');
        }
      
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  Future<dynamic> Newuser(BuildContext context) async {
    return showDialog(
        context:context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('회원가입'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: passwordController1,
                              validator: (val) =>
                              val == "" ? "이메일을 입력해주세요" : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'email'),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: passwordController1,
                              validator: (val) =>
                              val == "" ? "비밀번호를 입력해주세요" : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password'),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed:() {
                  Navigator.pop(context);
                })
            ],
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Center(
            // child: Image(
            //   image: AssetImage('assets/ex.png',),
            //   width: 170.0,
            //   height: 90.0,
          child: Text('CMB',style: TextStyle(
            fontSize : 30.0,
          ),
          ),
          ),
          Form(
              child: Theme(
                data: ThemeData(
                    primaryColor: Colors.grey,
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                            color: Colors.teal, fontSize: 15.0))),
                child: Container(
                    padding: EdgeInsets.all(40.0),
                    // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                    // SingleChildScrollView으로 감싸 줌
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: emailController1,
                              validator: (val) =>
                              val == "" ? "이메일을 입력해주세요" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email'),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                          Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: passwordController1,
                              validator: (val) =>
                              val == "" ? "비밀번호를 입력해주세요" : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password'),
                            ),
                          ),
                        ),
                      ),
                          SizedBox(height: 40.0,),
                          Container(
                            child: Column(
                              children: [
                                  ButtonTheme(
                                    minWidth: 100.0,
                                     height: 50.0,
                                      child: ElevatedButton(
                                       onPressed: (){
                                         Login();
                                     },
                                          child: Icon(
                                           Icons.arrow_forward,
                                           color: Colors.white,
                                            size: 35.0,
                                        ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlueAccent,
                                ),
                              ),
                              ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Container(
                                    height: 20.0,
                                    width: 60.0,
                                    child: Text('회원가입'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text('아이디 찾기'),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text('비밀번호 찾기')
                              ],
                          )
                          )
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}