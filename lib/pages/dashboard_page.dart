import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final Function(Map<String, dynamic>, BuildContext, int) addToCart;

  const DashboardPage({super.key, required this.addToCart});

  final List<Map<String, dynamic>> items = const [
    {'nama': 'Baju T-Shirt', 'harga': 150000, 'gambar': 'assets/tshirt.png'},
    {'nama': 'Celana Jeans', 'harga': 200000, 'gambar': 'assets/jeans.png'},
    {'nama': 'Sepatu Sneakers', 'harga': 350000, 'gambar': 'assets/sneakers.png'},
    {'nama': 'Topi Baseball', 'harga': 80000, 'gambar': 'assets/cap.png'},
    {'nama': 'Sweater', 'harga': 250000, 'gambar': 'assets/sweater.png'},
    {'nama': 'Jaket', 'harga': 300000, 'gambar': 'assets/jaket.png'},
    {'nama': 'Kaos Polos', 'harga': 120000, 'gambar': 'assets/kaos.png'},
    {'nama': 'Sandal', 'harga': 100000, 'gambar': 'assets/sandal.png'},
  ];

  void _showAddToCartDialog(BuildContext context, Map<String, dynamic> item) {
    int quantity = 1; // Default quantity

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Konfirmasi Tambah ke Keranjang'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    item['gambar'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item['nama'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${item['harga']}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Total: Rp ${item['harga'] * quantity}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    addToCart(item, context, quantity);
                    Navigator.pop(context);
                  },
                  child: const Text('Tambah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Kasir'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/keranjang');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Expanded(
                              child: Center(
                                child: Image.asset(
                                  item['gambar'],
                                  fit: BoxFit.contain,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    item['nama'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${item['harga']}',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _showAddToCartDialog(context, item);
                                    },
                                    icon: const Icon(Icons.add_shopping_cart),
                                    label: const Text('Tambah'),
                                  ),
                                ],
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