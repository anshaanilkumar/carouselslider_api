import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OffersController extends GetxController {
  var offers = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchOffers();
    super.onInit();
  }

  void fetchOffers() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('http://btobapi-production.up.railway.app/api/offers/'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        offers.value = jsonData; // Assuming API returns a list of offers
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch offers");
    } finally {
      isLoading(false);
    }
  }
}
