import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
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
                      color: Color(0xFF4D4D4D)
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                ),
                Container(
                  width: 150,
                  margin: EdgeInsets.only(top: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegScreen()));
                },
                child: Text("Нет аккаунта"),
              ),
            )
          ),
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
                        color: Color(0xFF4D4D4D)
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                ),
                Container(
                  width: 150,
                  margin: EdgeInsets.only(top: 60),
                  child: ElevatedButton(
                    onPressed: () {},
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen()));
                  },
                  child: Text("Есть аккаунт"),
                ),
              )
          ),
        ],
      ),
    );
  }
}
