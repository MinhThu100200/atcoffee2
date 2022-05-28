import 'package:get/state_manager.dart';
import 'package:at_coffee/models/category.dart';
import 'package:at_coffee/services/service_category.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoriesList = <Category>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      var categories = await RemoteServices.fetchCategories();
      if (categories != null) {
        categoriesList.value = categories;
      }
    } finally {
      isLoading(false);
    }
  }
}
