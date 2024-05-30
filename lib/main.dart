import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectakhir_tpm_123210006/hive/datauser_model.dart';
import 'package:projectakhir_tpm_123210006/login/login.dart';
import 'package:projectakhir_tpm_123210006/login/session_manager.dart';
import 'package:projectakhir_tpm_123210006/product/mainpage.dart';

void main() async {
  await initiateLocalDB();
  runApp(const MyApp());
}

Future<void> initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataUserModelAdapter());
  await Hive.openBox<DataUserModel>('data_user');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROJECT AKHIR',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: SessionManager.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              // Ganti 'nama_pengguna' dengan nilai yang sesuai
              return MainPage(username: '');
            } else {
              return const LoginPage();
            }
          }
        }, // Tambahkan kembali kurung kurawal penutup di sini
      ), // Kurung tutup tambahan untuk FutureBuilder
    ); // Kurung tutup tambahan untuk MaterialApp
  }
}
