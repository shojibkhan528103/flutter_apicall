import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data with GetX'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(
              child: Text(controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red)));
        }
        if (controller.dataList.isEmpty) {
          return const Center(child: Text('No data available.'));
        }
        return ListView.builder(
          itemCount: controller.dataList.length,
          itemBuilder: (context, index) {
            final item = controller.dataList[index];
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text(item.title ?? 'No Title'),
                subtitle: Text(item.body ?? 'No Body'),
                trailing: Text(item.id?.toString() ?? 'No ID'),
              ),
            );
          },
        );
      }),
    );
  }
}
