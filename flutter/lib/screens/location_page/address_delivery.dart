import 'package:at_coffee/controllers/address_controller.dart';
import 'package:at_coffee/models/city.dart';
import 'package:at_coffee/models/district.dart';
import 'package:at_coffee/models/ward.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:get/get.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;
import 'package:location/location.dart';
import 'package:at_coffee/common/utils_common/utils_common.dart';

class AddressDelivery extends StatefulWidget {
  @override
  _addressDeliveryState createState() => _addressDeliveryState();
}

class _addressDeliveryState extends State<AddressDelivery> {
  final AddressController addressController = Get.put(AddressController());
  final StoreController storeController = Get.put(StoreController());
  City cityChoose;
  District districtChoose;
  Ward wardChoose;
  String noStreet = '';
  final _noStreet = TextEditingController();
  bool _validateNoStreet = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //city = addressController.districtList[0];
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      addressController.fetchWardByDistrict(addressController.districtList[0]);
    });
    print("Build Completed");
  }

  void _onDropDownItemSelectedWard(Ward newSelectedWard) {
    setState(() {
      wardChoose = newSelectedWard;
    });
  }

  void _onDropDownItemSelectedCity(City newSelectedCity) {
    setState(() {
      cityChoose = newSelectedCity;
    });
  }

  void _onDropDownItemSelectedDistrict(District newSelectedDistrict) {
    addressController.fetchWardByDistrict(newSelectedDistrict);
    setState(() {
      districtChoose = newSelectedDistrict;
      wardChoose = null;
    });
  }

  void saveAddress() {
    print("minht htu");
    if (_noStreet.text.isEmpty) {
      setState(() {
        _validateNoStreet = true;
      });
    } else {
      print("minht htu íni");
      setState(() {
        _validateNoStreet = false;
      });
      if (wardChoose == null) {
        storeController.updateMyAddress("Thành phố Hồ Chí Minh",
            districtChoose.name, districtChoose.wards[0].name, _noStreet.text);
      } else {
        storeController.updateMyAddress("Thành phố Hồ Chí Minh",
            districtChoose.name, wardChoose.name, _noStreet.text);
      }

      Get.back();
    }
  }

  Ward getValue() {
    if (wardChoose == null && addressController.wardList.length > 0) {
      return addressController.wardList[0];
    } else {
      return wardChoose;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: Container(
          color: primary,
          child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    child: SizedBox(
                  width: size.width,
                  child: Stack(alignment: Alignment.centerLeft, children: [
                    Positioned(
                      child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                              "Chọn địa chỉ" +
                                  addressController.wardList.length.toString(),
                              style: TextStyle(
                                  color: white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ]),
                )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(top: 20.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: white),
                  child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Text("Tỉnh/Thành phố",
                                style: TextStyle(fontSize: 16))),
                        Form(
                          child: Center(
                            child: Container(
                              //color: Colors.grey[300],
                              margin:
                                  EdgeInsets.only(left: 15, top: 6, right: 15),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 10, 20, 20),
                                        // labelText: "hi",
                                        // labelStyle: textStyle,
                                        // labelText: _dropdownValue == null
                                        //     ? 'Where are you from'
                                        //     : 'From',
                                        // errorText: "Wrong Choice",
                                        // errorStyle: TextStyle(
                                        //     color: Colors.redAccent,
                                        //     fontSize: 16.0),
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<City>(
                                        //iconDisabledColor: Colors.grey[200],

                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: "verdana_regular",
                                        ),
                                        // hint: Text(
                                        //   "Chọn tỉnh/thành phố",
                                        //   style: TextStyle(
                                        //     color: Colors.grey,
                                        //     fontSize: 16,
                                        //     fontFamily: "verdana_regular",
                                        //   ),
                                        // ),
                                        disabledHint: Text(
                                          "Thành phố Hồ Chí Minh",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: "verdana_regular",
                                          ),
                                        ),
                                        items: addressController.addressList
                                            .map<DropdownMenuItem<City>>(
                                                (City value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // new CircleAvatar(
                                                //   backgroundImage: new NetworkImage(
                                                //       value.bank_logo),
                                                // ),
                                                // Icon(valueItem.bank_logo),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(value.name),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        isExpanded: true,
                                        isDense: true,
                                        // onChanged: (City newSelectedCity) {
                                        //   _onDropDownItemSelectedCity(
                                        //       newSelectedCity);
                                        // },
                                        onChanged: null,
                                        value: cityChoose,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Text("Quận/Huyện",
                                style: TextStyle(fontSize: 16))),
                        Form(
                          child: Center(
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 15, top: 6, right: 15),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 10, 20, 20),
                                        // labelText: "hi",
                                        // labelStyle: textStyle,
                                        // labelText: _dropdownValue == null
                                        //     ? 'Where are you from'
                                        //     : 'From',
                                        // errorText: "Wrong Choice",
                                        // errorStyle: TextStyle(
                                        //     color: Colors.redAccent,
                                        //     fontSize: 16.0),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<District>(
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: "verdana_regular",
                                        ),
                                        hint: Text(
                                          "Chọn quận/huyện",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: "verdana_regular",
                                          ),
                                        ),
                                        items: addressController.districtList
                                            .map<DropdownMenuItem<District>>(
                                                (District value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // new CircleAvatar(
                                                //   backgroundImage: new NetworkImage(
                                                //       value.bank_logo),
                                                // ),
                                                // Icon(valueItem.bank_logo),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(value.name),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        isExpanded: true,
                                        isDense: true,
                                        onChanged: (District newSelectedCity) {
                                          _onDropDownItemSelectedDistrict(
                                              newSelectedCity);
                                        },
                                        value: districtChoose,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Text("Phường/Xã",
                                style: TextStyle(fontSize: 16))),
                        Obx(() {
                          if (addressController.isLoading.value)
                            return Center(child: CircularProgressIndicator());
                          else {
                            return Form(
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 15, top: 6, right: 15),
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 10, 20, 20),
                                            // labelText: "hi",
                                            // labelStyle: textStyle,
                                            // labelText: _dropdownValue == null
                                            //     ? 'Where are you from'
                                            //     : 'From',
                                            // errorText: "Wrong Choice",
                                            // errorStyle: TextStyle(
                                            //     color: Colors.redAccent,
                                            //     fontSize: 16.0),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Ward>(
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontFamily: "verdana_regular",
                                            ),
                                            hint: Text(
                                              "Chọn phường/xã",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontFamily: "verdana_regular",
                                              ),
                                            ),
                                            items: addressController.wardList
                                                .map<DropdownMenuItem<Ward>>(
                                                    (Ward value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // new CircleAvatar(
                                                    //   backgroundImage: new NetworkImage(
                                                    //       value.bank_logo),
                                                    // ),
                                                    // Icon(valueItem.bank_logo),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(value.name),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            isDense: true,
                                            onChanged: (Ward newSelectedWard) {
                                              _onDropDownItemSelectedWard(
                                                  newSelectedWard);
                                            },
                                            value: getValue(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Text("Số nhà, Tên đường",
                                style: TextStyle(fontSize: 16))),
                        Container(
                          height: 58,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 15, right: 15, top: 6),
                          decoration: BoxDecoration(
                              //color: bgTextField,
                              border: Border.all(color: lightGray2),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.house,
                                  color: black.withOpacity(0.5),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: TextField(
                                    cursorColor: black.withOpacity(0.5),
                                    style: TextStyle(fontSize: 15),
                                    cursorHeight: 20,
                                    controller: _noStreet,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                      hintText: "Vd: 2/5 đường 68",
                                      border: InputBorder.none,
                                      errorText: _validateNoStreet
                                          ? 'Không đươc để trống'
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height / 4),
                        Container(
                            width: size.width,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: primary),
                                color: primary,
                                borderRadius: BorderRadius.circular(12)),
                            child: GestureDetector(
                                onTap: saveAddress,
                                child: Text("Xong",
                                    style: TextStyle(fontSize: 18))))
                      ]),
                ),
              ],
            )),
          )),
    );
  }
}
