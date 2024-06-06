import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:projectakhir_tpm_123210006/hive/hive_database.dart';
import 'package:projectakhir_tpm_123210006/login/register.dart';
import 'package:projectakhir_tpm_123210006/login/session_manager.dart';
import 'package:projectakhir_tpm_123210006/product/mainpage.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
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
            children: [
              _buildHeader(screenHeight, screenWidth),
              _buildLoginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.4,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          _buildAnimatedImage('assets/images/light-1.png', left: 30, width: 80, height: 200, duration: Duration(seconds: 1)),
          _buildAnimatedImage('assets/images/light-2.png', left: 140, width: 80, height: 150, duration: Duration(milliseconds: 1200)),
          _buildAnimatedImage('assets/images/clock.png', right: 40, top: 40, width: 80, height: 150, duration: Duration(milliseconds: 1300)),
          Positioned(
            child: FadeInUp(
              duration: Duration(milliseconds: 1600),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedImage(String asset, {double? left, double? top, double? right, double? width, double? height, required Duration duration}) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      width: width,
      height: height,
      child: FadeInUp(
        duration: duration,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(asset),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(_usernameController, "Username", false),
              SizedBox(height: 10),
              _buildTextField(_passwordController, "Password", true),
              SizedBox(height: 20),
              _buildLoginButton(context),
              SizedBox(height: 20),
              Text(
                "Lupa Password?",
                style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
              ),
              SizedBox(height: 20),  // Tambahkan SizedBox untuk memberi jarak sebelum link register
              _buildRegisterLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, bool isPassword) {
    return FadeInUp(
      duration: Duration(milliseconds: isPassword ? 1800 : 1900),
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
        child: TextField(
          controller: controller,
          obscureText: isPassword && !_passwordVisible,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[700]),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 1900),
      child: GestureDetector(
        onTap: () {
          _processLogin();
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
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Buat Akun!",
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  _usernameController.clear();
                  _passwordController.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => register_page()),
                  );
                },
                child: Text(
                  "Register!",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final hive = HiveDatabase(); // Ini bagian yang tidak selesai

    if (username.isNotEmpty && password.isNotEmpty) {
      if (hive.checkLogin(username, password)) {
        await SessionManager.setLoggedIn(username); // Simpan informasi login ke SharedPreferences
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainPage(username: username)),
        );
      } else {
        _showSnackBar("Username atau Password salah.");
      }
    } else {
      _showSnackBar("Username atau Password tidak boleh kosong.");
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
