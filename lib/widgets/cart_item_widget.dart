import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function onRemove;
  final Function onIncrease;
  final Function onDecrease;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    // Pastikan jumlah dan harga valid
    int jumlah = item['jumlah'] ?? 1; // Defaultkan 1 jika null
    double harga = item['harga']?.toDouble() ?? 0.0; // Pastikan harga adalah angka (double)
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(item['gambar'], width: 50, height: 50),
        title: Text(item['nama']),
        subtitle: Text('Rp $harga'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => onDecrease(),
            ),
            Text('$jumlah'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onIncrease(),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onRemove(),
            ),
          ],
        ),
      ),
    );
  }
}