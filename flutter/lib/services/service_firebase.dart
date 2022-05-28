import 'package:firebase_database/firebase_database.dart';
import 'package:at_coffee/models/Bill.dart';

class FireBaseService {
  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Future<void> addBill(Bill bill) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("bills/" + bill.code);

    await ref.set(bill.toFirebaseJson());
  }

  static List<Bill> getBill() {
    List<Bill> bills = [];
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('bills');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<Object, Object> mydata = data;
      mydata.forEach((key, values) {
        //print(values);
        bills.add(Bill.fromDocumentSnapshot(values));
      });
      //print("my data");
      //print(bills.length);
      return bills;
    });
    return [];
  }
}
