import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _hostelController = TextEditingController();
  final _roomController = TextEditingController();
  String _gender = 'Male';
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  bool _otpSent = false;
  int _resendSeconds = 0;

  void _sendOTP() {
    setState(() {
      _otpSent = true;
      _resendSeconds = 30;
    });
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP sent!')));
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration("Full Name"),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration("Email (use @vitstudent.ac.in)"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  } else if (!value.endsWith('@vitstudent.ac.in')) {
                    return "Only VIT student email allowed";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: _inputDecoration("Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _hostelController,
                      decoration: _inputDecoration("Hostel Block"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _roomController,
                      decoration: _inputDecoration("Room No."),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: _inputDecoration("Gender"),
                items: ['Male', 'Female'].map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
                onChanged: (val) => setState(() => _gender = val!),
              ),
              const SizedBox(height: 24),
              if (_otpSent) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (i) => SizedBox(
                    width: 40,
                    child: TextField(
                      controller: _otpControllers[i],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  )),
                ),
                const SizedBox(height: 8),
                _resendSeconds > 0
                  ? Text('Resend OTP in $_resendSeconds s', style: const TextStyle(color: Colors.grey))
                  : TextButton(
                      onPressed: _sendOTP,
                      child: const Text('Resend OTP'),
                    ),
              ] else ...[
                ElevatedButton(
                  onPressed: _sendOTP,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Send OTP'),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final otp = _otpControllers.map((c) => c.text).join();
                    if (otp.length != 6) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter 6-digit OTP')));
                      return;
                    }
                    // All credentials entered, navigate to home screen
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text("Create Account"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already signed up?", style: TextStyle(color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text("Login", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
