import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/image_picker_controller.dart';

class ImagePickerView extends GetView<ImagePickerController> {
  const ImagePickerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImagePickerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ImagePickerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
