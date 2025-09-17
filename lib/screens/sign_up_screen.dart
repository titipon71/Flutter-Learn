import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // ใช้ AbstractBackground + shared atoms

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _agree = true;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbstractBackground(
        child: SafeArea(
          child: Column(
            children: [
              const BackButtonBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Get Started',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 22),
                              AppTextField(
                                label: 'Full Name',
                                hint: 'Enter Full Name',
                                controller: _name,
                                textInputAction: TextInputAction.next,
                                validator: (v) =>
                                    v!.trim().isEmpty ? 'Required' : null,
                              ),
                              const SizedBox(height: 12),
                              AppTextField(
                                label: 'Email',
                                hint: 'Enter Email',
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (v) => v != null && v.contains('@')
                                    ? null
                                    : 'Invalid email',
                              ),
                              const SizedBox(height: 12),
                              AppTextField(
                                label: 'Password',
                                hint: 'Enter Password',
                                controller: _password,
                                obscureText: _obscure,
                                suffix: IconButton(
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () =>
                                      setState(() => _obscure = !_obscure),
                                ),
                                validator: (v) => v != null && v.length >= 6
                                    ? null
                                    : 'Min 6 chars',
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _agree,
                                    onChanged: (v) =>
                                        setState(() => _agree = v ?? false),
                                  ),
                                  const Flexible(
                                    child: Wrap(
                                      children: [
                                        Text('I agree to the processing of '),
                                        LinkText('Personal data'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 50,
                                child: FilledButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        _agree) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Sign up tapped'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Sign up'),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const DividerWithText('Sign up with'),
                              const SizedBox(height: 12),
                              const SocialRow(),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Already have an account? '),
                                  LinkText('Sign in'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
}
