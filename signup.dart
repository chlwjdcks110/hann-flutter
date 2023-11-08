import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hann/api.dart';
import 'package:hann/User.dart';
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

// 저장기능
Future<String> postUserRequest(userNameController,  emailController,  passwordController) async { 
  var response = await http.post(
    Uri.parse('http://10.0.2.2:8080/hann/join'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "username": userNameController.text,
      "useremail": emailController.text,
      "userpwd": passwordController.text,
    }),
  );

   if(response.statusCode == 200){
        Fluttertoast.showToast(msg: '회원가입이 완료되었습니다.');
          setState(() {
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
        }
      );
    }
        

  return response.body; //반환받은 데이터(이메일) 반환
} 
   Future<String> check() async {
      var response2 = await http.get(
          Uri.parse('http://10.0.2.2:8080/hann/check/${emailController.text}'),
      );
      var returnemail = response2.body;
      return returnemail;
  }



  checkUserEmail() async {
    try {
        var cem=await check();
        var test=emailController.text.trim();

        if(test == cem) {
            Fluttertoast.showToast(msg : ' 중복된 이메일 입니다.');
            
           } else{
            postUserRequest(userNameController, emailController, passwordController);
          }
        
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  } 

  saveInfo() async {
    User userModel = User(userNameController.text.trim(),
        emailController.text.trim(), passwordController.text.trim());

    try {
      var res = await http.post(
          Uri.parse('http://10.0.2.2:8080/hann/join'),
          body: userModel.toJson()
      );

      if(res.statusCode == 200){
        var resSignup = jsonDecode(res.body);
        if(resSignup['success'] == true){
          Fluttertoast.showToast(msg: 'Signup successfully');
          setState(() {
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
          });
        }else{
          Fluttertoast.showToast(msg: 'Error occurred. Please try again');
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.card_travel_outlined,
                  color: Colors.deepPurple,
                  size: 100,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '회원가입',
                  style: TextStyle(fontSize: 36.0)
                ),
                SizedBox(
                  height: 10,
                ),
                Text('반갑습니다.',
                    style: TextStyle(fontSize: 28)),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: userNameController,
                              validator: (val) =>
                              val == "" ? "이름을 입력하세요. " : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'User'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: emailController,
                              validator: (val) =>
                              val == "" ? "이메일을 입력하세요." : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Email'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                              controller: passwordController,
                              validator: (val) =>
                              val == "" ? "비밀번호를 입력하세요." : null,
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
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if(formKey.currentState!.validate()){
                      checkUserEmail();
                    }
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('이미 등록하신 회원이십니까?'),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/Login'),
                      child: Text(
                        ' 로그인 페이지로 돌아가세요.',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}