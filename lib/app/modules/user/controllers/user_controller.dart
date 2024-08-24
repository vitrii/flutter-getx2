import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/user_model.dart'; // Adjust import based on your actual file structure
import '../../../utils/api.dart';

class UserController extends GetxController {
  var UserList = <DataUser>[].obs;
  var isLoading = false.obs;

  final String baseUrl = '${BaseUrl.api}/users';

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var user = User.fromJson(jsonResponse);
        UserList.value = user.data!;
      } else {
        Get.snackbar("Error", "Failed to fetch users");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch users");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addUser(DataUser newUser) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newUser.toJson()),
      );
      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar("Success", "User added successfully");
        fetchUsers();
      } else {
        Get.snackbar("Error", "Failed to add user");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add user: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUser(int id, User updatedUser) async {
    try {
      isLoading(true);
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedUser.toJson()),
      );
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar("Success", "User updated successfully");
        fetchUsers();
      } else {
        Get.snackbar("Error", "Failed to update user");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update user: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      isLoading(true);
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        fetchUsers();
        Get.snackbar("Success", "User deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete user");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to delete user: $e");
    } finally {
      isLoading(false);
    }
  }
}
