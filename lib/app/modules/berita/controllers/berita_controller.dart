import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/berita_model.dart';  // Pastikan pathnya sesuai
import '../../../utils/api.dart';

class BeritaController extends GetxController {
  var beritaList = <DataBerita>[].obs;
  var isLoading = false.obs;

  final String baseUrl = '${BaseUrl.api}/berita';  // Sesuaikan dengan endpoint API berita

  @override
  void onInit() {
    fetchBeritas();
    super.onInit();
  }

  void fetchBeritas() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var berita = Berita.fromJson(jsonResponse);
        beritaList.value = berita.data ?? [];
      } else {
        Get.snackbar("Error", "Failed to fetch Beritas");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch Beritas");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addBerita(DataBerita newBerita) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newBerita.toJson()),
      );
      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar("Success", "Berita added successfully");
        fetchBeritas();
      } else {
        Get.snackbar("Error", "Failed to add Berita");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add Berita: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateBerita(int id, DataBerita updatedBerita) async {
    try {
      isLoading(true);
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedBerita.toJson()),
      );
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar("Success", "Berita updated successfully");
        fetchBeritas();
      } else {
        Get.snackbar("Error", "Failed to update Berita");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update Berita: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteBerita(int id) async {
    try {
      isLoading(true);
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        fetchBeritas();
        Get.snackbar("Success", "Berita deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete Berita");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to delete Berita: $e");
    } finally {
      isLoading(false);
    }
  }
}
