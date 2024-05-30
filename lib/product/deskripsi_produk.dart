import 'package:flutter/material.dart';
import 'package:projectakhir_tpm_123210006/api/api_data_source.dart';
import 'package:projectakhir_tpm_123210006/api/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
        backgroundColor: const Color(0xff254252),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiDataSource.instance.loadDetailProduct(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading product details'));
          } else {
            final product = Products.fromJson(snapshot.data!);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          product.thumbnail ?? '',
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error, size: 100);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.title ?? '',
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff254252),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: \$${product.price}',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(color: Colors.grey[800]),
                    const SizedBox(height: 8),
                    Text(
                      product.description ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add to cart functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff254252),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () {
                            // Buy now functionality
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xff254252), side: const BorderSide(color: Color(0xff254252)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Buy Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
