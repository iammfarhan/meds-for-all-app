// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  bool loading = false;
  File? imageFile;
  List<File> workImageFile = [];
  final picker = ImagePicker();

  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController company_name = TextEditingController();
  TextEditingController services = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController quanti = TextEditingController();
  bool avail = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  Future<void> SelectImageFromGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  Future SelectImageOfWork() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        workImageFile.add(File(pickedImage.path));
      });
    }
  }

  Future OnSave() async {
    var service = services.text;
    var phon = phone.text;
    var company_nam = company_name.text;
    var descripton = description.text;
    var addres = address.text;
    var quant = int.parse(quanti.text);
    setState(
      () {
        Future.delayed(
          Duration(seconds: 10),
          () {
            Navigator.pushReplacementNamed(context, '/donation');
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

    final cover_image = await saveFileToFireBase(imageFile!);

    List<String> portfolio = [];
    if (workImageFile.length > 0) {
      for (var eachFile in workImageFile) {
        String portfolioImageUrl = await saveFileToFireBase(eachFile);
        portfolio.add(portfolioImageUrl);
      }
    }

    return sizes
        .add({
          'userid': FirebaseAuth.instance.currentUser!.uid,
          'address': addres,
          'med_name': company_nam,
          'cover_image': cover_image.toString(),
          'details': portfolio.toList(),
          'description': descripton,
          'phone': phon,
          'quant': quant.toDouble(),
          'name': service,
          'avail': avail,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  CollectionReference sizes = FirebaseFirestore.instance.collection('meds');

  Future saveFileToFireBase(File file) async {
    if (file != null) {
      List<String> extensionLists = file.path.split(".");
      String extension = extensionLists.last;
      String fileName = const Uuid().v4();
      try {
        await FirebaseStorage.instance
            .ref('appImages/$fileName.$extension')
            .putFile(File(file.path));

        String fileUrl = await FirebaseStorage.instance
            .ref('appImages/$fileName.$extension')
            .getDownloadURL();

        return fileUrl;
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        print("errorsss => $e");
      }
      return 'null';
    }
  }

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
            'Donate Medicine ',
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
                      Stack(children: [
                        Container(
                          color: Colors.grey.shade400,
                          width: double.maxFinite,
                          height: 250,
                          child: imageFile != null
                              ? Image.file(imageFile!)
                              : Container(
                                  color: Colors.grey,
                                  height: 300,
                                  child: Center(
                                    child: Text(
                                      "Upload Image",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300.withOpacity(.7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: IconButton(
                                  onPressed: SelectImageFromGallery,
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 34.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: company_name,
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
                              controller: services,
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
                                  hintText: 'Name',
                                  labelText: "Name"),
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
                              controller: phone,
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
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: quanti,
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
                                  hintText: 'Quantity',
                                  labelText: "Quantity"),
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
                              controller: description,
                              style: TextStyle(fontSize: 14),
                              maxLines: 2,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 15, 15, 3),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  hintText: 'Description',
                                  labelText: "Description"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  addError(error: 'DescriptionNullError');
                                  removeError(error: 'DescriptionNullError');
                                  return 'Description is required!';
                                }
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Upload Images of Medicine",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GridView.count(
                                    primary: false,
                                    shrinkWrap: true,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    children: [
                                      ...List.generate(
                                        workImageFile.length,
                                        (index) => Container(
                                          width: 100,
                                          height: 100,
                                          clipBehavior: Clip.hardEdge,
                                          child: Image.file(
                                            workImageFile[index],
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                            height: 100,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Tooltip(
                                              message: "Add your photos",
                                              child: IconButton(
                                                  onPressed: SelectImageOfWork,
                                                  icon: Icon(Icons.add,
                                                      size: 30)),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
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
                                        "Save",
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
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
