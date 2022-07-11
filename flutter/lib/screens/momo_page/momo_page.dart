import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/screens/cart_page/cart_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MomoPage extends StatefulWidget {
  MomoPage({Key key, this.idOrder, this.amount}) : super(key: key);
  String idOrder;
  double amount;
  @override
  _MomoPageState createState() => _MomoPageState();
}

class _MomoPageState extends State<MomoPage> {
  MomoVn _momoPay;
  PaymentResponse _momoPaymentResult;
  // ignore: non_constant_identifier_names
  String _paymentStatus;

  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Thanh toán qua Momo'),
            backgroundColor: primary,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: Center(
          child: Column(
            children: <Widget>[
              Column(
                children: [],
              ),
              Image.asset("assets/images/momo.png"),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(8)),
                child: GestureDetector(
                  child: const Text('Thanh toán với Momo',
                      style: TextStyle(fontSize: 18, color: white)),
                  onTap: () async {
                    MomoPaymentInfo options = MomoPaymentInfo(
                        merchantName: "AT Coffee",
                        appScheme: "momoshfw20201230",
                        merchantCode: 'MOMO28TI20220531', //MOMO28TI20220531
                        partnerCode: 'MOMO28TI20220531',
                        amount: widget.amount,
                        orderId: widget.idOrder,
                        orderLabel: 'Thanh toán đơn hàng ${widget.idOrder}',
                        merchantNameLabel: "AT Coffee",
                        fee: 0,
                        description: 'Thanh toán đơn hàng ${widget.idOrder}',
                        username: '0346279377', // cửa hàng
                        partner: 'merchant',
                        extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                        isTestMode: true);
                    try {
                      _momoPay.open(options);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                ),
              ),
              const SizedBox(height: 5),
              Text(_paymentStatus.isEmpty ? "CHƯA THANH TOÁN" : _paymentStatus)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nTình trạng: Thành công.";
      _paymentStatus +=
          "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra;
      _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CartPage(isPaid: true, idOrder: widget.idOrder)));

    Fluttertoast.showToast(
        msg: "THÀNH CÔNG: " + response.phoneNumber.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CartPage(isPaid: false, idOrder: "")));

    Fluttertoast.showToast(
        msg: "THẤT BẠI: " + response.message.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }
}
