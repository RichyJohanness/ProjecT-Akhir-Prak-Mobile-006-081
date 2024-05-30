import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:projectakhir_tpm_123210006/hive/datauser_model.dart';
import 'package:projectakhir_tpm_123210006/hive/hive_database.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class register_page extends StatefulWidget {
  @override
  State<register_page> createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.4,
                width: screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInUp(
                        duration: Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1200),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1300),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeInUp(
                        duration: Duration(milliseconds: 1800),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Color.fromRGBO(143, 148, 251, 1)),
                                  ),
                                ),
                                child: TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey[700]),
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: TextField(
                                  controller: _password1Controller,
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[700]),
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: TextField(
                                  controller: _password2Controller,
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Ulangi Password",
                                    hintStyle: TextStyle(color: Colors.grey[700]),
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: GestureDetector(
                          onTap: () {
                            String currentUsername = _usernameController.value.text;
                            String currentPassword1 = _password1Controller.value.text;
                            String currentPassword2 = _password2Controller.value.text;
                            _processRegister(currentUsername, currentPassword1, currentPassword2);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sudah punya akun? Login disini",
                            style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processRegister(String username, String password1, String password2) async {
    final HiveDatabase _hive = HiveDatabase();
    String message = "";

    if (_usernameController.text.isNotEmpty &&
        _password1Controller.text.isNotEmpty &&
        _password2Controller.text.isNotEmpty) {
      if (_password1Controller.text == _password2Controller.text) {
        _hive.addData(DataUserModel(
            username: _usernameController.text,
            password: _password2Controller.text));
        _usernameController.clear();
        _password1Controller.clear();
        _password2Controller.clear();
        setState(() {});

        message = "Berhasil mendaftarkan akun.";

        final snackBar = SnackBar(
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green);

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      } else {
        message = "Password harus sama.";

        final snackBar = SnackBar(
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      message = "Lengkapi data terlebih dahulu.";

      final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
