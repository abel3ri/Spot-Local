import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_wrapper_controller.dart';

class HomeWrapperView extends GetView<HomeWrapperController> {
  const HomeWrapperView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeWrapperView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeWrapperView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
