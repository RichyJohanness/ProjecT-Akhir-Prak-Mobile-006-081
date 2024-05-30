import 'package:flutter/material.dart';
import 'package:projectakhir_tpm_123210006/product/view_produk.dart';
import 'konversi.dart';

const primaryColor = Color(0xff254252);
const accentColor = Color(0xffa3c4bc);
const backgroundColor = Color(0xfff2f5f8);

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  static List<ProductBox> cartItems = [];

  static void addToCart(ProductBox product) {
    cartItems.add(product);
  }

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<bool> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = List<bool>.filled(CartPage.cartItems.length, false);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = CartPage.cartItems.asMap().entries.fold(
      0.0,
          (sum, entry) => sum + (entry.value.price * (_selectedItems[entry.key] ? 1 : 0)),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Keranjang',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: CartPage.cartItems.length,
                itemBuilder: (context, index) {
                  final product = CartPage.cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.image,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      subtitle: Text(
                        'Price: \$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: accentColor,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      trailing: Checkbox(
                        value: _selectedItems[index],
                        checkColor: Colors.white,
                        activeColor: primaryColor,
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedItems[index] = value!;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontFamily: 'Raleway',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedItems.contains(true)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CurrencyConversionPage(totalPrice: totalPrice),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Pilih produk terlebih dahulu.')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _removeSelectedItems();
                          });
                        },
                        backgroundColor: primaryColor,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeSelectedItems() {
    setState(() {
      CartPage.cartItems.removeWhere((product) => _selectedItems[CartPage.cartItems.indexOf(product)]);
      _selectedItems = List<bool>.filled(CartPage.cartItems.length, false);
    });
  }
}
