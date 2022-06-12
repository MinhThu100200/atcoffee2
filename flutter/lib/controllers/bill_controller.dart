import 'package:at_coffee/controllers/user_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:at_coffee/models/bill.dart';

class BillController extends GetxController {
  var isLoading = false.obs;
  var selected = 'REQUESTED'.obs;
  var billsList = <Bill>[].obs;
  final UserController userController = Get.put(UserController());
  @override
  void onInit() {
    super.onInit();
  }

  void updateSelected(String index) async {
    try {
      isLoading(true);
      selected.value = index;
    } finally {
      isLoading(false);
    }
  }

  void getBill() {
    DatabaseReference listOrder = FirebaseDatabase.instance.ref('bills');
    isLoading(true);
    listOrder.onValue.listen((DatabaseEvent event) {
      List<Bill> bills = [];
      final data = event.snapshot.value;
      Map<Object, Object> mydata = data;
      mydata.forEach((key, values) {
        var mybill = Bill.fromDocumentSnapshot(values);
        if (mybill.customerId == userController.user.value.id) {
          bills.add(mybill);
        }
      });

      billsList.value = bills;
    });
    isLoading(false);
  }

  Future<void> updateBill(idBill) async {
    DatabaseReference listOrder =
        FirebaseDatabase.instance.ref('bills/${idBill}');
    isLoading(true);
    await listOrder.update({"rate": false});
    isLoading(false);
  }

  Future<void> updateBillStatus(idBill) async {
    DatabaseReference listOrder =
        FirebaseDatabase.instance.ref('bills/${idBill}');
    isLoading(true);
    await listOrder.update({"status": "CANCELED"});
    isLoading(false);
  }

  void saveData(billList) {
    try {
      isLoading(true);
      billsList.value = billList;
    } finally {
      isLoading(false);
    }
  }
}
