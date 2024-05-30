import 'package:flutter/material.dart';
import 'package:projectakhir_tpm_123210006/product/view_produk.dart';
import 'package:projectakhir_tpm_123210006/product/cart.dart';
import 'package:projectakhir_tpm_123210006/product/akun.dart';

class MainPage extends StatefulWidget {
  final String username;

  const MainPage({Key? key, required this.username}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    ProductPage(),
    CartPage(),
    AccountPage(username: ''), // Placeholder, to be replaced in initState
  ];

  late List<Widget> _updatedPages;

  @override
  void initState() {
    super.initState();
    _updatedPages = [
      const ProductPage(),
      const CartPage(),
      AccountPage(username: widget.username),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _updatedPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff254252),
        onTap: _onItemTapped,
      ),
    );
  }
}
