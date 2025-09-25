import 'package:flutter/material.dart';
import 'package:my_app/screens/sign_in_screen.dart';
import 'package:my_app/screens/sign_up_screen.dart';
import 'package:sidebarx/sidebarx.dart';

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({super.key, required this.controller});

  final SidebarXController controller;



  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      showToggleButton: false,
      theme: SidebarXTheme(
        decoration: const BoxDecoration(
          color: Colors.black, // พื้นหลัง sidebar
        ),
        width: 250,
        
        // 🎨 ไอคอน & ข้อความปกติ
        iconTheme: const IconThemeData(color: Colors.white),
        textStyle: const TextStyle(color: Colors.white),

        // 🎨 สีตอน hover
        hoverColor: Colors.grey,
        hoverTextStyle: const TextStyle(color: Colors.white),
        hoverIconTheme: const IconThemeData(color: Colors.white),

        // 🎨 การจัดระยะ
        itemTextPadding: const EdgeInsets.only(left: 16),
        selectedItemTextPadding: const EdgeInsets.only(left: 16),
        itemMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),

        // 🎨 ตอนเลือก (selected)
        selectedItemDecoration: BoxDecoration(
          color: const Color.fromARGB(136, 158, 158, 158).withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedTextStyle: const TextStyle(color: Colors.white),
      ),
      extendedTheme: SidebarXTheme(
        width: 250,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: extended
                ? Image.asset('lib/assets/images/logo.png')
                : const Icon(Icons.menu, color: Colors.white, size: 24),
          ),
        );
      },
      items: [
        SidebarXItem(icon: Icons.login, label: 'Sign In', onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }),
        SidebarXItem(icon: Icons.app_registration, label: 'Sign Up', onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        }),
        SidebarXItem(icon: Icons.workspace_premium, label: 'Top up VIP'),
        SidebarXItem(icon: Icons.contact_support, label: 'Contact Us'),
        SidebarXItem(icon: Icons.settings, label: 'Settings'),
      ],
    );
  }
}
