import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers.dart';

class RegisterController extends GetxController {
  final isLoading = false.obs;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  TextEditingController instanceNameCtrl = TextEditingController();
  TextEditingController instanceAddressCtrl = TextEditingController();
  TextEditingController instanceEmailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  final currentRegisterStep = 1.obs;

  final chechkbox = false.obs;
  final isValidForm = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  checkIsValidForm() {
    if (currentRegisterStep.value.isEqual(1)) {
      isValidForm.value = nameCtrl.text.isNotEmpty &&
          addressCtrl.text.isNotEmpty &&
          phoneNumberCtrl.text.isPhoneNumber &&
          emailCtrl.text.isEmail;
    } else if (currentRegisterStep.value.isEqual(2)) {
      isValidForm.value = instanceNameCtrl.text.isNotEmpty &&
          instanceAddressCtrl.text.isNotEmpty &&
          instanceEmailCtrl.text.isEmail &&
          passwordCtrl.text.isNotEmpty &&
          confirmPasswordCtrl.text.isNotEmpty &&
          passwordCtrl.text == confirmPasswordCtrl.text &&
          chechkbox.value == true;
    }
  }

  void nextStep() {
    isLoading.value = true;

    Timer(const Duration(seconds: 1), () async {
      currentRegisterStep.value = 2;
      isValidForm.value = false;
      isLoading.value = false;
    });
  }

  void register() async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      user = userCredential.user;

      if (user != null) {
        await user!.updateDisplayName(nameCtrl.text);
        await user!.updatePhotoURL(Helpers.generatePhotoUrl(nameCtrl.text));
        await user!.sendEmailVerification();

        saveUserDataToFirestore();
      }

      Fluttertoast.showToast(msg: 'Registrasi berhasil');

      Get.back();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Alamat email sudah digunakan!');
      } else {
        Fluttertoast.showToast(msg: 'Terjadi kesalahan! coba lagi nanti.');
      }
    }

    isLoading.value = false;
  }

  void saveUserDataToFirestore() {
    final usersRef = FirebaseFirestore.instance.collection('users');
    usersRef.doc(user?.uid).set({
      'id': user?.uid,
      'name': nameCtrl.text,
      'address': addressCtrl.text,
      'phone_number': phoneNumberCtrl.text,
      'email': user?.email,
      'instance_name': instanceNameCtrl.text,
      'instance_address': instanceAddressCtrl.text,
      'instance_email': instanceEmailCtrl.text,
      'photo_url': Helpers.generatePhotoUrl(nameCtrl.text),
      'created_at': user?.metadata.creationTime!.toIso8601String(),
    });
  }
}
