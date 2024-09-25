import 'package:barberapp/services/database.dart';
import 'package:barberapp/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    String savedName = await SharedpreferenceHelper().getUserName() ?? '';
    String savedEmail = await SharedpreferenceHelper().getUserEmail() ?? '';
    String savedImage = await SharedpreferenceHelper().getUserImage() ?? '';

    setState(() {
      nameController.text = savedName;
      emailController.text = savedEmail;
      imageController.text = savedImage;
    });
  }

  updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        String userId = await SharedpreferenceHelper().getUserId() ?? '';
        if (userId.isEmpty) {
          throw Exception("User ID is empty.");
        }

        // อัปเดตข้อมูลใน Shared Preferences
        await SharedpreferenceHelper().saveUserName(nameController.text);
        await SharedpreferenceHelper().saveUserEmail(emailController.text);
        await SharedpreferenceHelper().saveUserImage(imageController.text);

        // ข้อมูลที่จะอัปเดตใน Firestore
        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": emailController.text,
          "Image": imageController.text,
        };

        // เรียกใช้ Firebase Firestore เพื่ออัปเดตข้อมูล
        await DatabaseMethods().updateUserDetails(userInfoMap, userId);
        print("User info updated: $userInfoMap");

        // อัปเดตอีเมลใน Firebase Authentication
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updateEmail(emailController.text);
          await user.reload();
        }

        // แสดงข้อความสำเร็จ
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "แก้ไขข้อมูลเรียบร้อยแล้ว",
            style: TextStyle(fontSize: 20),
          ),
        ));
      } catch (e) {
        // จัดการข้อผิดพลาด
        print("Error updating profile: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "เกิดข้อผิดพลาดในการแก้ไขข้อมูล",
            style: TextStyle(fontSize: 20),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 19, left: 30),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 4, 37, 72),
                    Color.fromARGB(255, 11, 52, 96)
                  ],
                ),
              ),
              child: Text(
                "Edit Your\nProfile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 10),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 37, 72),
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อ';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Gmail",
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 37, 72),
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอก E-mail';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Gmail",
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        updateProfile();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 4, 37, 72),
                              Color.fromARGB(255, 11, 52, 96)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "UPDATE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
