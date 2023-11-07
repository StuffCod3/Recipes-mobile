import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
import 'package:dio/dio.dart';
import 'package:recipe/db/db_manage.dart';

TextEditingController usernameControllerAuth = TextEditingController();
TextEditingController passwordControllerAuth = TextEditingController();

TextEditingController usernameControllerReg = TextEditingController();
TextEditingController emailControllerReg = TextEditingController();
TextEditingController passwordControllerReg = TextEditingController();

DatabaseHelper helper = DatabaseHelper.instance;


class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Кулинарные рецепты"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 60),
                  child: Text(
                    "Авторизация",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4D4D4D)),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextField(
                    controller: usernameControllerAuth,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: passwordControllerAuth,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                ),
                Container(
                  width: 150,
                  margin: EdgeInsets.only(top: 60),
                  child: ElevatedButton(
                    onPressed: () async {
                      try{
                        final dio = Dio();
                        final response = await dio.post('http://10.0.2.2:8080/api/v1/app/auth', data: {
                          'username': usernameControllerAuth.text,
                          'password': passwordControllerAuth.text,
                        });

                        if(response.statusCode == 200){
                          String jwtToken = response.data['token'];
                          // Вставка данных
                          int insertedId = await helper.insert({
                            'jwt': jwtToken
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        }else {

                        }
                      }catch (error){

                      }

                    },
                    child: Text("Войти"),
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => RegScreen()));
                  },
                  child: Text("Нет аккаунта"),
                ),
              )),
        ],
      ),
    );
  }
}

class RegScreen extends StatelessWidget {
  const RegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Кулинарные рецепты"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 60),
                  child: Text(
                    "Регистрация",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4D4D4D)),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextField(
                    controller: usernameControllerReg,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: emailControllerReg,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: passwordControllerReg,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                ),
                Container(
                  width: 150,
                  margin: EdgeInsets.only(top: 60),
                  child: ElevatedButton(
                    onPressed: () async {
                      try{
                        final dio = Dio();
                        final response = await dio.post('http://10.0.2.2:8080/api/v1/app/reg', data: {
                          'username': usernameControllerReg.text,
                          'email': emailControllerReg.text,
                          'password': passwordControllerReg.text,
                        });

                        if(response.statusCode == 200){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => AuthScreen()));
                        }else {

                        }
                      }catch (error){

                      }

                    },
                    child: Text("Регистрация"),
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AuthScreen()));
                  },
                  child: Text("Есть аккаунт"),
                ),
              )),
        ],
      ),
    );
  }
}
