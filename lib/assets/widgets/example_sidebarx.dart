import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({super.key, required this.controller});

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        decoration: const BoxDecoration(
          color: Colors.black, // พื้นหลัง sidebar
        ),
        width: 250,
        
        // 🎨 ไอคอน & ข้อความปกติ
        iconTheme: const IconThemeData(color: Colors.white),
        textStyle: const TextStyle(color: Colors.white),

        // 🎨 สีตอน hover
        hoverColor: const Color.fromARGB(255, 255, 6, 6),
        hoverTextStyle: const TextStyle(color: Colors.white),
        hoverIconTheme: const IconThemeData(color: Colors.white),

        // 🎨 การจัดระยะ
        itemTextPadding: const EdgeInsets.only(left: 16),
        selectedItemTextPadding: const EdgeInsets.only(left: 16),
        itemMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),

        // 🎨 ตอนเลือก (selected)
        selectedItemDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedTextStyle: const TextStyle(color: Colors.white),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('lib/assets/images/logo.png'),
          ),
        );
      },
      items: const [
        SidebarXItem(icon: Icons.login, label: 'Sign In'),
        SidebarXItem(icon: Icons.app_registration, label: 'Sign Up'),
        SidebarXItem(icon: Icons.workspace_premium, label: 'Top up VIP'),
        SidebarXItem(icon: Icons.contact_support, label: 'Contact Us'),
        SidebarXItem(icon: Icons.settings, label: 'Settings'),
      ],
    );
  }
}
