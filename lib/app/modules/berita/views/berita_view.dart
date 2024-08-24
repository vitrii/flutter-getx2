import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/berita_controller.dart'; // Ensure this path is correct

class BeritaView extends GetView<BeritaController> {
  // Use Get.find to get the controller if it's already initialized somewhere else
  @override
  Widget build(BuildContext context) {
    final BeritaController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berita',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: 28),
            onPressed: () => Get.toNamed('/berita/create'),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: controller.beritaList.length,
          itemBuilder: (context, index) {
            final item = controller.beritaList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              shadowColor: Colors.pinkAccent.withOpacity(0.5),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                leading: item.foto != null && item.foto!.isNotEmpty
                    ? Image.network(
                        item.foto!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image, size: 50, color: Colors.grey),
                title: Text(
                  item.judul ?? 'No Title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                subtitle: Text(
                  item.deskripsi ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.deepPurple),
                      onPressed: () =>
                          Get.toNamed('/berita/edit', arguments: item),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteBerita(item.id!),
                    ),
                  ],
                ),
                onTap: () => Get.toNamed('/berita/show', arguments: item),
              ),
            );
          },
        );
      }),
    );
  }
}
