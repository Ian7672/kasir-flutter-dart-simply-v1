import 'package:flutter/material.dart';
import '../widgets/cart_item_widget.dart';

class KeranjangPage extends StatefulWidget {
  final List<Map<String, dynamic>> keranjang;

  const KeranjangPage({
    super.key,
    required this.keranjang,
  });

  @override
  State<KeranjangPage> createState() => KeranjangPageState();
}

class KeranjangPageState extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
    double totalHarga = widget.keranjang.fold(0, (sum, item) {
      double harga = item['harga']?.toDouble() ?? 0.0;
      return sum + (harga * (item['jumlah'] ?? 1));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: widget.keranjang.isEmpty
          ? const Center(child: Text('Keranjang Kosong'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item dalam Keranjang',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.keranjang.length,
                      itemBuilder: (context, index) {
                        final item = widget.keranjang[index];
                        return CartItemWidget(
                          item: item,
                          onRemove: () {
                            setState(() {
                              widget.keranjang.removeAt(index);
                            });
                          },
                          onIncrease: () {
                            setState(() {
                              item['jumlah'] = (item['jumlah'] ?? 1) + 1;
                            });
                          },
                          onDecrease: () {
                            setState(() {
                              if ((item['jumlah'] ?? 1) > 1) {
                                item['jumlah'] = (item['jumlah'] ?? 1) - 1;
                              } else {
                                widget.keranjang.removeAt(index);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Total Harga: Rp ${totalHarga.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Checkout'),
                            content: Text(
                                'Total yang harus dibayar: Rp ${totalHarga.toStringAsFixed(2)}'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    widget.keranjang.clear();
                                  });
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Pembayaran berhasil! Keranjang dikosongkan.')),
                                  );
                                },
                                child: const Text('Bayar'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}