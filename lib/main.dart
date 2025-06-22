import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/keranjang_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Map<String, dynamic>> keranjang = [];

  MyApp({super.key});

  void addToCart(Map<String, dynamic> item, BuildContext context, int quantity) {
    // Cari apakah item sudah ada di keranjang berdasarkan nama
    final existingIndex = keranjang.indexWhere((cartItem) => 
        cartItem['nama'] == item['nama']);
    
    if (existingIndex != -1) {
      // Jika item sudah ada, tambahkan jumlahnya
      keranjang[existingIndex]['jumlah'] = (keranjang[existingIndex]['jumlah'] ?? 0) + quantity;
    } else {
      // Jika item belum ada, tambahkan ke keranjang dengan jumlah yang dipilih
      keranjang.add({
        ...item,
        'jumlah': quantity,
      });
    }
    
    // Tampilkan Snackbar dengan durasi singkat
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['nama']} (${quantity}x) ditambahkan ke keranjang'),
        duration: const Duration(milliseconds: 450),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardPage(addToCart: (item, context, quantity) => addToCart(item, context, quantity)),
        '/keranjang': (context) => KeranjangPage(keranjang: keranjang),
      },
    );
  }
}