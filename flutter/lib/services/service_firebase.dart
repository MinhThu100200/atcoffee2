import 'package:firebase_database/firebase_database.dart';
import 'package:at_coffee/models/bill.dart';

class FireBaseService {
  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Future<void> addBill(Bill bill) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("bills/" + bill.code);

    await ref.set(bill.toFirebaseJson());
  }
}
