import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman home'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Selamat Datang di',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Center(
            child: Text(
              'Projek Ujian Vitri Rajbina Soliha',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}