import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/api_post_model.dart';

class HomeController extends GetxController {
  var dataList = <ApiPostModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApiPosts();
  }

  Future<void> fetchApiPosts() async {
    isLoading(true);
    errorMessage('');
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        dataList.value =
            jsonData.map((data) => ApiPostModel.fromJson(data)).toList();
      } else {
        errorMessage('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
