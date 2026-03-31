import 'package:flutter/material.dart';
import 'package:flutter_application_1/addcar.dart';
import 'package:flutter_application_1/history.dart';
import 'package:flutter_application_1/notify.dart';
import 'package:flutter_application_1/edit.dart';
import 'package:flutter_application_1/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isHidden = true;

  // ✅ Profile state variables
  String userName = "";
  String userPhone = "(+976) 8061 6678";
  String userEmail = "";

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 24;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: horizontalPadding),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.arrow_back_ios_rounded,
                    size: 20, color: Colors.black),
              ),
            ),
          ),
        ),
        title: const Text(
          "Хэрэглэгчийн булан",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ✅ User Info Card — now shows updated data
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 345,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF0071DB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(Icons.person,
                          size: 30, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userPhone,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          userName.isEmpty ? "Хэрэглэгчийн мэдээлэл дутуу" : userName,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Wallet Card
              Container(
                width: 345,
                height: 145,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color.fromARGB(255, 0, 113, 219)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset("assets/images/white.png",
                          fit: BoxFit.cover),
                      Container(
                          color: const Color.fromARGB(34, 0, 113, 219)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Хэтэвч",
                                  style: TextStyle(
                                      color: Color.fromARGB(
                                          255, 0, 113, 219)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isHidden = !isHidden;
                                    });
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(4),
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 0, 113, 219),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      isHidden
                                          ? Icons.visibility_off_sharp
                                          : Icons.remove_red_eye,
                                      color: const Color.fromARGB(
                                          255, 0, 113, 219),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              isHidden ? "*,***,*** ₮" : "1,250,000 ₮",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 113, 219),
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Menu Items
              Container(
                width: 345,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      buildMenuItem(
                        Icons.person_outline,
                        "Профайл засах",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditPage(
                                initialName: userName,
                                initialPhone: userPhone,
                                initialEmail: userEmail,
                                // ✅ Callback updates profile state
                                onSave: (name, phone, email) {
                                  setState(() {
                                    userName = name;
                                    userPhone = phone;
                                    userEmail = email;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(color: Colors.grey.shade300),
                      buildMenuItem(
                        Icons.time_to_leave_outlined,
                        "Миний машин",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Addcar()),
                          );
                        },
                      ),
                      Divider(color: Colors.grey.shade300),
                      buildMenuItem(
                        Icons.notification_add_outlined,
                        "Мэдэгдэл",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NotifyPage()),
                          );
                        },
                      ),
                      Divider(color: Colors.grey.shade300),
                      buildMenuItem(
                        Icons.history,
                        "Үйлчилгээний түүх",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HistoryPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 80, horizontal: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyApp()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 244, 244, 245),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.exit_to_app,
                              color: Colors.red),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Гарах",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color.fromARGB(120, 158, 158, 158),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 158, 158, 158),
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    );
  }
}