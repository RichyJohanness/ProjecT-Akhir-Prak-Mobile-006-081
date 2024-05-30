import 'package:flutter/material.dart';
import 'package:projectakhir_tpm_123210006/api/api_data_source.dart';
import 'package:projectakhir_tpm_123210006/api/product_model.dart';
import 'package:projectakhir_tpm_123210006/product/deskripsi_produk.dart';
import 'package:projectakhir_tpm_123210006/product/cart.dart';

const primaryColor = Color(0xff254252);
const secondaryColor = Color(0xffeab56f);
const accentColor = Color(0xffa3c4bc);
const backgroundColor = Color(0xfff2f5f8);

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'SMARTPHONE', 'endpoint': 'smartphones', 'icon': Icons.phone_android},
    {'name': 'LAPTOP', 'endpoint': 'laptops', 'icon': Icons.laptop},
    {'name': 'SKINCARE', 'endpoint': 'skincare', 'icon': Icons.spa},
    {'name': 'FURNITURE', 'endpoint': 'furniture', 'icon': Icons.chair},
    {'name': 'DECORATIONS', 'endpoint': 'home-decorations', 'icon': Icons.home},
    {'name': 'FRAGRANCES', 'endpoint': 'fragrances', 'icon': Icons.local_florist},
    {'name': 'MEN SHIRTS', 'endpoint': 'mens-shirts', 'icon': Icons.checkroom},
    {'name': 'MEN SHOES', 'endpoint': 'mens-shoes', 'icon': Icons.directions_walk},
    {'name': 'MEN WATCHES', 'endpoint': 'mens-watches', 'icon': Icons.watch},
    {'name': 'MOTORCYCLE', 'endpoint': 'motorcycle', 'icon': Icons.motorcycle},
    {'name': 'WOMEN SHOES', 'endpoint': 'womens-shoes', 'icon': Icons.shopping_bag},
    {'name': 'WOMEN BAGS', 'endpoint': 'womens-bags', 'icon': Icons.shopping_bag},
    {'name': 'JEWELLERY', 'endpoint': 'womens-jewellery', 'icon': Icons.diamond},
    {'name': 'WOMEN WATCHES', 'endpoint': 'womens-watches', 'icon': Icons.watch},
  ];

  TextEditingController searchController = TextEditingController();
  String searchText = '';

  void _onCategoryTap(String endpoint) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListPage(endpoint: endpoint),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories.where((category) {
      final nameLower = category['name']!.toLowerCase();
      final searchLower = searchText.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "KATEGORI BARANG",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Raleway',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Cari kategori...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.search, color: primaryColor),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final int crossAxisCount = (constraints.maxWidth / 150).floor();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => _onCategoryTap(category['endpoint']),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              category['icon'],
                              size: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              category['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListPage extends StatelessWidget {
  final String endpoint;

  const ProductListPage({Key? key, required this.endpoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          endpoint.toUpperCase(),
          style: TextStyle(fontFamily: 'Raleway'),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiDataSource.instance.loadProductCategory(endpoint),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading products'));
          } else {
            final products = (snapshot.data!['products'] as List)
                .map((e) => Products.fromJson(e))
                .toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          productId: product.id ?? 0,
                        ),
                      ),
                    );
                  },
                  child: ProductBox(
                    name: product.title ?? '',
                    price: product.price ?? 0.0,
                    image: product.thumbnail ?? '',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final String name;
  final double price;
  final String image;

  ProductBox({
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontFamily: 'Raleway',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Price: \$${price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    fontFamily: 'Raleway',
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_shopping_cart, color: accentColor),
            onPressed: () {
              CartPage.addToCart(ProductBox(
                name: name,
                price: price,
                image: image,
              ));
            },
          ),
        ],
      ),
    );
  }
}
