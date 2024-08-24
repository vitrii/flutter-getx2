import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/kategori_model.dart';
import '../../../utils/api.dart';

class KategoriController extends GetxController {
  var KategoriList = <DataKategori>[].obs;
  var isLoading = false.obs;

  final String baseUrl = '${BaseUrl.api}/kategori';

  @override
  void onInit() {
    fetchKategories();
    super.onInit();
  }

  void fetchKategories() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var kategori = Kategori.fromJson(jsonResponse);
        KategoriList.value = kategori.data!;
      } else {
        Get.snackbar("Error", "Failed to fetch Categories");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch Categories");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addKategori(DataKategori newKategori) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newKategori.toJson()),
      );
      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar("Success", "Category added successfully");
        fetchKategories();
      } else {
        Get.snackbar("Error", "Failed to add Category");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add Categori: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateKategori(int id, DataKategori updatedKategori) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedKategori.toJson()),
      );
      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar("Success", "Category added successfully");
        fetchKategories();
      } else {
        Get.snackbar("Error", "Failed to update Category");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update Categori: $e");
    } finally {
      isLoading(false);
    }
  }

   Future<void> deleteKategori(int id) async {
    try {
      isLoading(true);
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        fetchKategories();
        Get.snackbar("Success", "Category deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete Category");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to delete Categori: $e");
    } finally {
      isLoading(false);
    }
  }
}
