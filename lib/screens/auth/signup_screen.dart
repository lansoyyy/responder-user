import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responder/screens/home_screen.dart';
import 'package:responder/services/add_user.dart';
import 'package:responder/widgets/button_widget.dart';
import 'package:responder/widgets/text_widget.dart';
import 'package:responder/widgets/textfield_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../widgets/toast_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  final contactnumberController = TextEditingController();

  final addressController = TextEditingController();

  late String idFileName1 = '';

  late File idImageFile1;

  late String idImageURL1 = '';

  Future<void> uploadImage1(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      idFileName1 = path.basename(pickedImage.path);
      idImageFile1 = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Document/$idFileName1')
            .putFile(idImageFile1);
        idImageURL1 = await firebase_storage.FirebaseStorage.instance
            .ref('Document/$idFileName1')
            .getDownloadURL();

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    setState(() {});
  }

  late String idFileName = '';

  late File idImageFile;

  late String idImageURL = '';

  Future<void> uploadImage2(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      idFileName = path.basename(pickedImage.path);
      idImageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Document/$idFileName')
            .putFile(idImageFile);
        idImageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Document/$idFileName')
            .getDownloadURL();

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextWidget(
                text: 'Register here',
                fontSize: 24,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    text: 'Front ID Picture',
                    fontSize: 12,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  uploadImage1('gallery');
                },
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: idImageURL1 != ''
                          ? DecorationImage(
                              image: NetworkImage(idImageURL1),
                              fit: BoxFit.cover)
                          : null),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    text: 'Back ID Picture',
                    fontSize: 12,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2('gallery');
                },
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: idImageURL != ''
                          ? DecorationImage(
                              image: NetworkImage(idImageURL),
                              fit: BoxFit.cover)
                          : null),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Name',
                controller: nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Contact Number',
                controller: contactnumberController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Address',
                controller: addressController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                isObscure: true,
                label: 'Password',
                controller: passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                label: 'Signup',
                onPressed: () {
                  if (idImageURL1 != '' && idImageURL != '') {
                    register(context);
                  } else {
                    showToast('Please upload picture of your ID');
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // addUser(nameController.text, contactnumberController.text,
      //     addressController.text, emailController.text);

      addUser(
          nameController.text,
          contactnumberController.text,
          addressController.text,
          emailController.text,
          idImageURL1,
          idImageURL);

      showToast('Account created succesfully!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
