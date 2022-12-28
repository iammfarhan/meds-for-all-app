// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMedicineRequestScreen extends StatefulWidget {
  const AddMedicineRequestScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddMedicineRequestScreenState createState() =>
      _AddMedicineRequestScreenState();
}

class _AddMedicineRequestScreenState extends State<AddMedicineRequestScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController medicineName = TextEditingController();
  TextEditingController medicineQuantity = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController personName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool avail = true;
  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future OnSave() async {
    setState(
      () {
        Future.delayed(
          Duration(seconds: 10),
          () {
            Navigator.pushReplacementNamed(context, '/medicinerequestscreen');
          },
        );
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saving in Progress..'),
        duration: Duration(seconds: 10),
      ),
    );

    return addMedReqData
        .add({
          'userid': FirebaseAuth.instance.currentUser!.uid,
          'address': address.text,
          'medname': medicineName.text,
          'quant': medicineQuantity.text,
          'name': personName.text,
          'phone': contactNumber.text,
          'avail': avail,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  CollectionReference addMedReqData =
      FirebaseFirestore.instance.collection('medsreq');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE9E6E6),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff8C52FF),
          title: const Text(
            'Request Medicine ',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 4,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/mainfeaturescreen');
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.all(0),
                  child: Column(
                    children: [
                      if (loading)
                        LinearProgressIndicator(
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: medicineName,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 15, 15, 3),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  hintText: 'Medicine Name',
                                  labelText: "Medicine  Name"),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]+|\s'),
                                ),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  addError(error: 'MedicineNameNullError');
                                  removeError(error: 'MedicineNameNullError');
                                  return 'Medicine name is required!';
                                }
                              },
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: medicineQuantity,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 15, 15, 3),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  hintText: 'Medicine Quantity',
                                  labelText: "Medicine Quantity"),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]'),
                                ),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  addError(error: 'quantityNullError');
                                  removeError(error: 'quantityNullError');
                                  return 'Medicine quantity is required!';
                                }
                              },
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: personName,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 15, 15, 3),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  hintText: 'Person Name',
                                  labelText: "Person Name"),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]+|\s'),
                                ),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  addError(error: 'PersonNameNullError');
                                  removeError(error: 'PersonNameNullError');
                                  return 'Person name is required!';
                                }
                              },
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: contactNumber,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 15, 15, 3),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  hintText: 'Contact Number',
                                  labelText: "Contact Number"),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]'),
                                ),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  addError(error: 'numberNullError');
                                  removeError(error: 'numberNullError');
                                  return 'Contact No is required!';
                                }
                              },
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: address,
                              maxLines: 2,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 15, 15, 3),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                hintText: 'Address',
                                labelText: "Address",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  addError(error: 'AddressNullError');
                                  removeError(error: 'AddressNullError');
                                  return 'Address is required!';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    OnSave();
                                  }
                                },
                                child: Text(
                                  "Save!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xff8C52FF),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: const BorderSide(
                                        color: Color(0xff8C52FF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
