import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/business_details_controller.dart';

class BusinessDetailsView extends GetView<BusinessDetailsController> {
  const BusinessDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BusinessDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BusinessDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
