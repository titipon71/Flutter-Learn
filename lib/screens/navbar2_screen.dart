// lib/screens/navbar2_screen.dart
import 'package:flutter/material.dart';

class Navbar2 extends StatefulWidget implements PreferredSizeWidget {
  const Navbar2({
    Key? key,
    this.height = 112,
    this.onMenuTap,
  }) : super(key: key);

  final double height;
  final VoidCallback? onMenuTap;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<Navbar2> createState() => _Navbar2State();
}

class _Navbar2State extends State<Navbar2> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _alignmentAnim;

  @override
  void initState() {
    super.initState();
    // เลื่อนภาพแบบวนลูปช้า ๆ จาก -1 -> 1
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(); // วนซ้ำ

    _alignmentAnim = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDrawer(BuildContext context) {
    // ถ้ามี callback จากภายนอกให้ใช้ก่อน
    if (widget.onMenuTap != null) {
      widget.onMenuTap!.call();
      return;
    }
    // ถ้าไม่มี callback ใช้ Scaffold จาก context โดยตรง
    final scaffold = Scaffold.maybeOf(context);
    scaffold?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // ✅ ไม่มีสีพื้นหลัง
      elevation: 0,                         // ✅ ไม่มีเงา
      title: null,                          // ✅ ไม่แสดงข้อความ
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () => _openDrawer(context),
        tooltip: 'Menu',
      ),
      // ใช้ flexibleSpace ใส่พื้นหลังภาพเลื่อน
      flexibleSpace: PreferredSize(
        preferredSize: widget.preferredSize,
        child: AnimatedBuilder(
          animation: _alignmentAnim,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final t = (_alignmentAnim.value + 1) / 2; // 0..1
                final dx = -t * width;

                return Stack(
                  children: [
                    Positioned(
                      left: dx,
                      top: 0,
                      width: width,
                      height: widget.height,
                      child: Image.asset(
                        'lib/assets/images/top.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: dx + width,
                      top: 0,
                      width: width,
                      height: widget.height,
                      child: Image.asset(
                        'lib/assets/images/top.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
