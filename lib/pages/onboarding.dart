import 'package:barberapp/Admin/admin_login.dart';
import 'package:barberapp/pages/home.dart';
import 'package:barberapp/pages/login.dart';
import 'package:barberapp/pages/signup.dart';
import 'package:barberapp/shop_owner/login_owner.dart';
import 'package:barberapp/shop_owner/signup_owner.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 10, 36, 66),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "images/welcome.png",
                  width: 350,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                // TextFormField(
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'กรุณากรอกชื่อ';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //       hintText: "Name", prefixIcon: Icon(Icons.person_outline)),
                // ),
                SizedBox(
                  height: 55,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 120, //ขนาดปุ่ม
                  child: Padding(
                      padding: EdgeInsets.only(top: 42),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.5), //สีเงา
                            spreadRadius: 3, //รัศมีการกระจาย
                            blurRadius: 30, //ความเบลอ
                            offset: Offset(0, 10),
                          ),
                        ]),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AdminLogin();
                            }));
                          },
                          child: Text(
                            "Admin",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 10, 36, 66),
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 130, //ขนาดปุ่ม
                  child: Padding(
                      padding: EdgeInsets.only(top: 42),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.5), //สีเงา
                            spreadRadius: 3, //รัศมีการกระจาย
                            blurRadius: 30, //ความเบลอ
                            offset: Offset(0, 10),
                          ),
                        ]),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Signup_Owner();
                            }));
                          },
                          child: Text(
                            "เจ้าของร้าน",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 10, 36, 66),
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: Padding(
                        padding: EdgeInsets.only(top: 22),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black26.withOpacity(0.5), //สีเงา
                              spreadRadius: 7, //รัศมีการกระจาย
                              blurRadius: 30, //ความเบลอ
                              offset: Offset(0, 10),
                            ),
                          ]),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return LogIn(); //เชื่อมไปหน้า login
                              }));
                            },
                            child: Text(
                              "ลูกค้า",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: const Color.fromARGB(255, 10, 36, 66)),
                            ),
                          ),
                        ))),
              ],
            ),
          ),
        ));
  }
}
