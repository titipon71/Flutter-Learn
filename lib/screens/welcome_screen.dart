import 'package:flutter/material.dart';

// ---------- Shared Background & UI Atoms ----------
class AbstractBackground extends StatelessWidget {
  const AbstractBackground({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // soft page gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 10, 47, 138),
                Color.fromARGB(255, 68, 103, 227),
                Color.fromARGB(255, 5, 18, 50),
              ],
            ),
          ),
        ),
        // curved header
        Positioned(
          left: -40,
          right: -40,
          top: -120,
          child: Container(
            height: 340,
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [Color.fromARGB(255, 10, 47, 138), Color.fromARGB(255, 68, 103, 227), Color.fromARGB(255, 5, 18, 50)],
              // ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(48),
                bottomRight: Radius.circular(48),
              ),
            ),
          ),
        ),
        const _Blob(top: 40, left: 24, size: 68, color: Color(0xFF2B3A67)),
        const _Blob(top: 120, right: 30, size: 100, color: Color(0xFF7FA7FF)),
        const _Blob(top: 190, left: 90, size: 36, color: Color(0xFF132347)),
        const _Blob(top: 250, right: 80, size: 44, color: Color(0xFF274FBE)),
        const _Blob(
          top: 130,
          right: 80,
          size: 44,
          color: Color.fromARGB(255, 73, 111, 216),
        ),

        // ✅ เพิ่มอีก 10 blobs
        const _Blob(top: 300, left: 40, size: 60, color: Color(0xFF4158D0)),
        const _Blob(top: 350, right: 50, size: 72, color: Color(0xFF6A11CB)),
        const _Blob(top: 400, left: 100, size: 40, color: Color(0xFF2575FC)),
        const _Blob(top: 450, right: 120, size: 56, color: Color(0xFF5C258D)),
        const _Blob(top: 500, left: 60, size: 90, color: Color(0xFF673AB7)),
        const _Blob(top: 550, right: 30, size: 64, color: Color(0xFF3F51B5)),
        const _Blob(top: 600, left: 20, size: 50, color: Color(0xFF2196F3)),
        const _Blob(top: 650, right: 80, size: 84, color: Color(0xFF1E88E5)),
        const _Blob(top: 700, left: 140, size: 36, color: Color(0xFF0D47A1)),
        const _Blob(top: 750, right: 60, size: 60, color: Color(0xFF283593)),
        if (child != null) child!,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    this.top,
    this.left,
    this.right,
    required this.size,
    required this.color,
  });
  final double? top;
  final double? left;
  final double? right;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.white.withOpacity(.85), color],
            center: Alignment.topLeft,
            radius: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.25),
              blurRadius: 24,
              spreadRadius: 4,
              offset: const Offset(0, 10),
            ),
          ],
        ),
      ),
    );
  }
}

class BackButtonBar extends StatelessWidget {
  const BackButtonBar({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    child: Row(
      children: [
        IconButton.filledTonal(
          style: IconButton.styleFrom(
            backgroundColor: const Color.fromARGB(
              0,
              255,
              255,
              255,
            ).withOpacity(.9),
          ),
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ],
    ),
  );
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.suffix,
    this.validator,
  });
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE6E8EF)),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Color(0xFFBFCBFF)),
            ),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}

class DividerWithText extends StatelessWidget {
  const DividerWithText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Expanded(child: Divider()),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(text, style: const TextStyle(color: Color(0xFF6B7280))),
      ),
      const Expanded(child: Divider()),
    ],
  );
}

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _socialIcon(Icons.facebook),
      const SizedBox(width: 18),
      _socialIcon(Icons.alternate_email),
      const SizedBox(width: 18),
      _socialIcon(Icons.g_mobiledata),
      const SizedBox(width: 18),
      _socialIcon(Icons.apple),
    ],
  );
  Widget _socialIcon(IconData icon) => InkResponse(
    onTap: () {},
    radius: 28,
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, size: 22, color: const Color(0xFF374151)),
    ),
  );
}

class LinkText extends StatelessWidget {
  const LinkText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w600,
    ),
  );
}

// ------------------------- Welcome Screen -------------------------
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: AbstractBackground(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter personal details to your\nemployee account',
                  style: TextStyle(color: Colors.white.withOpacity(.9)),
                ),
                const SizedBox(height: 48),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/signin'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          
                          child: const Text('Sign in'),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/signup'),
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 10, 47, 138),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              side: BorderSide( // เพิ่มขอบ
                                color: Colors.white, // สีขอบ
                                width: 2, // ความหนาขอบ
                              ),
                            ),
                          ),
                          child: const Text('Sign up'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
