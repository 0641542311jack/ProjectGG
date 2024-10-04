import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(User_Admin());
}

class User_Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Member Management',
      debugShowCheckedModeBanner: false,
      home: MemberScreen(),
    );
  }
}

class Member {
  String name;
  String email;
  String password;
  String? uid; // เก็บ UID ของ Firebase Authentication

  Member(
      {required this.name,
      required this.email,
      required this.password,
      this.uid});
}

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  List<Member> members = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _membersCollection =
      FirebaseFirestore.instance.collection('members');

  // ฟังก์ชันเพิ่มผู้ใช้ใน Firebase Authentication
  Future<void> _registerMember(Member member) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: member.email,
        password: member.password,
      );
      member.uid = userCredential.user?.uid;

      // เพิ่มข้อมูลผู้ใช้ใน Firestore หลังจากสมัครสมาชิกสำเร็จ
      await _membersCollection.doc(member.uid).set({
        'name': member.name,
        'email': member.email,
        // ไม่ควรเก็บรหัสผ่านใน Firestore
      });

      print("Member registered: ${member.name}");
    } catch (e) {
      print("Failed to register member: $e");
    }
  }

  // ฟังก์ชันเพิ่มสมาชิก
  void _addMember() {
    setState(() {
      Member newMember = Member(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      members.add(newMember);
      _registerMember(
          newMember); // เรียกฟังก์ชันเพื่อเพิ่มผู้ใช้ใน Firebase Authentication
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
    });
  }

  // ฟังก์ชันลบผู้ใช้จาก Firebase Authentication และ Firestore
  Future<void> _deleteMemberFromFirebase(String? uid) async {
    if (uid != null) {
      try {
        // ลบผู้ใช้จาก Firebase Authentication
        User? user = _auth.currentUser;
        if (user != null && user.uid == uid) {
          await user.delete();
        }

        // ลบข้อมูลผู้ใช้จาก Firestore
        await _membersCollection.doc(uid).delete();

        print("Member deleted: $uid");
      } catch (e) {
        print("Failed to delete member: $e");
      }
    }
  }

  // ฟังก์ชันลบสมาชิก
  void _deleteMember(int index) {
    String? memberId = members[index].uid;
    _deleteMemberFromFirebase(
        memberId); // ลบจาก Firebase Authentication และ Firestore
    setState(() {
      members.removeAt(index); // ลบจาก UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 37, 72),
      appBar: AppBar(
        title: Text(
          'เพิ่มข้อมูลผู้ใช้งาน',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 72),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
            ),
            TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white)),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMember,
              child: Text('ตกลง'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange, // เปลี่ยนสีของข้อความในปุ่ม
                padding: EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12), // เพิ่ม padding ในปุ่ม
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      members[index].name,
                      style: TextStyle(
                          color: Colors.blue), // เปลี่ยนสีของข้อความชื่อ
                    ),
                    subtitle: Text(
                      members[index].email,
                      style: TextStyle(
                          color: Colors.grey), // เปลี่ยนสีของข้อความอีเมล
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,
                          color: Colors.red), // เปลี่ยนสีไอคอนลบ
                      onPressed: () => _deleteMember(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
