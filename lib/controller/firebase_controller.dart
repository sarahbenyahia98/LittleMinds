import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_v1/controller/global_controller.dart';
import 'package:project_v1/models/user_model.dart';
import 'package:project_v1/models/pdf_model.dart';
import 'package:project_v1/models/role_enum.dart';
import 'package:project_v1/models/youtube_model.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  Future<String> getCourseImage(String name) async {
    print(name);
    final url = await _storage.ref().child('images/$name').getDownloadURL();
    return url;
  }

  Future<String> uploadPDFFileAndSaveToFirestore(String filePath,
      {required String pdf}) async {
    File file = File(filePath);

    try {
      // Upload file to Firebase Storage
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('pdfs')
          .child(
              '${pdf + DateTime.now().toIso8601String()}.pdf'); // Use a dynamic name, e.g., based on user ID or a random ID

      firebase_storage.UploadTask uploadTask = ref.putFile(
        file,
        firebase_storage.SettableMetadata(contentType: 'application/pdf'),
      );

      // Get download URL of uploaded file
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Save download URL to Firestore
      PdfModel pdfModel = PdfModel(
          pdfName: pdf,
          userName: FirebaseController().getCurrentUser()?.email ?? "",
          createdAt: DateTime.now().toIso8601String(),
          pdfUrl: downloadUrl);
      await FirebaseFirestore.instance.collection('pdfs').add(pdfModel.toMap());

      return downloadUrl;
    } catch (e) {
      print('Error uploading and saving PDF file: $e');
      return '';
    }
  }

  Future<List<PdfModel>?> getAllPdfs() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('pdfs').get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      List<PdfModel> pdfs = docs
          .map((doc) => PdfModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return pdfs;
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<YoutubeModel>?> getAllYoutubes() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('vidoes').get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      List<YoutubeModel> pdfs = docs
          .map(
              (doc) => YoutubeModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return pdfs;
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<UserModel>?> getAllKids() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: "Child")
          .where('parentUid',
              isEqualTo: FirebaseController().getCurrentUser()?.uid ?? "")
          .get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      print(docs);
      print(FirebaseController().getCurrentUser());
      List<UserModel> kids = docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return kids;
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<UserModel>?> getAllKidsForA() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: "Child")
          .get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      print(docs);
      print(FirebaseController().getCurrentUser());
      List<UserModel> kids = docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return kids;
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<UserModel>?> getAllParent() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: "Parent")
          .get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      print(docs[0].data());

      List<UserModel> parent = docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return parent;
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  Future<UserModel?> getKid({required String kidId}) async {
    try {
      print(kidId);
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('kids').doc(kidId).get();
      print(documentSnapshot.data());
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        print(data);
        return UserModel.fromMap(data);
      } else {
        return null;
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  Future<void> updateKid({required UserModel kid}) async {
    try {
      await _firestore.collection('users').doc(kid.id).update(kid.toMap());
      await Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> updateVideo({required YoutubeModel video}) async {
    try {
      await _firestore.collection('vidoes').doc(video.id).update(video.toMap());
      await Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> deleteKid(String kidId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(kidId).delete();
      await Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> deleteParent(String parentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(parentId)
          .delete();
      await Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> deleteVideo(YoutubeModel video) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('vidoes')
          .where("id", isEqualTo: video.id)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        await doc.reference.delete();
        await Fluttertoast.showToast(
            msg: "Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        await Fluttertoast.showToast(
            msg: "somthing wrong happend",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> deletePdf(String pdfName, String userEmail, String date) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('pdfs')
          .where("createdAt", isEqualTo: date)
          .where("pdfName", isEqualTo: pdfName)
          .where("userName", isEqualTo: userEmail)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        await doc.reference.delete();
        await Fluttertoast.showToast(
            msg: "Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        await Fluttertoast.showToast(
            msg: "somthing wrong happend",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> addKid(BuildContext context,
      {required String email,
      required String? parentUid,
      required String password,
      required String displayName,
      required String parentPassword}) async {
    try {
      String parentEmail = getCurrentUser()?.email ?? "";
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      GlobalController provider =
          Provider.of<GlobalController>(context, listen: false);
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'password': password,
          'displayName': displayName,
          'role': RoleEnum.Child.name,
          'parentUid': parentUid,
          'values': [0.0],
          'childs': [],
          'id': user.uid
        });
        await _auth.signInWithEmailAndPassword(
            email: parentEmail, password: parentPassword);
        await Fluttertoast.showToast(
            msg: "Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      // Handle error
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> addYoutubeVideo({required YoutubeModel youtube}) async {
    try {
      await _firestore
          .collection('vidoes')
          .doc(youtube.id)
          .set(youtube.toMap());
      await Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        String role = userDoc['role'];
        GlobalController provider =
            Provider.of<GlobalController>(context, listen: false);

        // Navigate to different screens based on the role
        if (role == 'Admin') {
          provider.onChangeRole(RoleEnum.Admin);
          Navigator.pushReplacementNamed(context, AppRoute.mainAdminScreen);
        } else if (role == 'Parent') {
          provider.onChangeRole(RoleEnum.Parent);
          Navigator.pushReplacementNamed(context, AppRoute.mainParentScreen);
        } else if (role == 'Child') {
          provider.onChangeRole(RoleEnum.Child);
          Navigator.pushReplacementNamed(context, AppRoute.mainScreen);
        }
      } else {
        await Fluttertoast.showToast(
            msg: "You are not parent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> updateParent({required UserModel parent}) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;

      if (user != null) {
        String userId = user.uid;
        await _firestore.collection('users').doc(userId).update(parent.toMap());

        await Fluttertoast.showToast(
            msg: "Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        await Fluttertoast.showToast(
            msg: "No user is currently signed in.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> updateChild({required UserModel child}) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;

      if (user != null) {
        String userId = user.uid;
        await _firestore.collection('users').doc(userId).update(child.toMap());

        await Fluttertoast.showToast(
            msg: "Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        await Fluttertoast.showToast(
            msg: "No user is currently signed in.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> updateAdmin({required UserModel parent}) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;

      if (user != null) {
        String userId = user.uid;
        await _firestore.collection('users').doc(userId).update(parent.toMap());

        await Fluttertoast.showToast(
            msg: "Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        await Fluttertoast.showToast(
            msg: "No user is currently signed in.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<UserModel?> getParentData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: _auth.currentUser?.email ?? "")
          .where('role', isEqualTo: 'Parent')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs.first.data());
        return UserModel.fromMap(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

   Future<UserModel?> getKidData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: _auth.currentUser?.email ?? "")
          .where('role', isEqualTo: 'Child')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs.first.data());
        return UserModel.fromMap(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<UserModel?> getAdminData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: _auth.currentUser?.email ?? "")
          .where('role', isEqualTo: 'Admin')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs.first.data());
        return UserModel.fromMap(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<void> signUp(BuildContext context,
      {required String email,
      required String password,
      required String displayName,
      required RoleEnum role}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      GlobalController provider =
          Provider.of<GlobalController>(context, listen: false);
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'password': password,
          'displayName': displayName,
          'role': role.name,
          'values': [],
          'childs': [],
          'id': user.uid
        });
        if (role == RoleEnum.Parent) {
          Navigator.pushReplacementNamed(context, AppRoute.mainParentScreen);
          await Fluttertoast.showToast(
              msg: "Sign in ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } catch (e) {
      // Handle error
      await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  bool isUserConnected() {
    return _auth.currentUser != null;
  }
}
