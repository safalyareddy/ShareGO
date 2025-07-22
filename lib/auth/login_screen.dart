import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignup = false;
  bool _showLoginOtp = false;

  // Signup controllers
  final _signupFormKey = GlobalKey<FormState>();
  final _signupNameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPhoneController = TextEditingController();
  final _signupHostelController = TextEditingController();
  final _signupRoomController = TextEditingController();
  String _signupGender = 'Male';
  final List<TextEditingController> _signupOtpControllers = List.generate(6, (_) => TextEditingController());
  bool _signupOtpSent = false;
  int _signupResendSeconds = 0;

  // Login controllers
  final _loginEmailController = TextEditingController();
  final List<TextEditingController> _loginOtpControllers = List.generate(6, (_) => TextEditingController());
  bool _loginOtpSent = false;
  int _loginResendSeconds = 0;

  void _sendSignupOTP() {
    setState(() {
      _signupOtpSent = true;
      _signupResendSeconds = 30;
    });
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP sent!')));
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_signupResendSeconds > 0) {
        setState(() => _signupResendSeconds--);
        return true;
      }
      return false;
    });
  }

  void _sendLoginOTP() {
    setState(() {
      _loginOtpSent = true;
      _loginResendSeconds = 30;
    });
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP sent!')));
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_loginResendSeconds > 0) {
        setState(() => _loginResendSeconds--);
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.directions_car_filled, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 10),
                  const Text('ShareGo', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Welcome Buddy!', style: TextStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(height: 6),
              const Text('Share rides, save money, make friends', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 24),
              // Feature icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _featureIcon(Icons.search, 'Find Rides'),
                  const SizedBox(width: 16),
                  _featureIcon(Icons.attach_money, 'Share Costs'),
                  const SizedBox(width: 16),
                  _featureIcon(Icons.verified_user, 'Safe & Verified'),
                ],
              ),
              const SizedBox(height: 32),
              // Login/Signup toggle
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: !_isSignup ? Colors.white : Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          setState(() => _isSignup = false);
                        },
                        child: Text('Login', style: TextStyle(color: !_isSignup ? Colors.green : Colors.grey[700], fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _isSignup ? Colors.white : Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          setState(() => _isSignup = true);
                        },
                        child: Text('Sign Up', style: TextStyle(color: _isSignup ? Colors.green : Colors.grey[700])),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _isSignup ? _buildSignupForm(context) : _buildLoginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 12)),
      ],
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    return Form(
      key: _signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          const Text('Join your hostel\'s ride-sharing community', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          TextFormField(
            controller: _signupNameController,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            decoration: _inputDecoration('Full Name'),
            validator: (value) => value!.isEmpty ? "Enter your name" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _signupEmailController,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            decoration: _inputDecoration('Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter your email";
              } else if (!value.contains('@')) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _signupPhoneController,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            decoration: _inputDecoration('Phone Number'),
            keyboardType: TextInputType.phone,
            validator: (value) => value!.isEmpty ? "Enter your phone number" : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _signupHostelController,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  decoration: _inputDecoration('Hostel'),
                  validator: (value) => value!.isEmpty ? "Enter hostel" : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _signupRoomController,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  decoration: _inputDecoration('Room No.'),
                  validator: (value) => value!.isEmpty ? "Enter room no." : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _signupGender,
            decoration: _inputDecoration('Gender'),
            dropdownColor: Colors.grey[200],
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            items: ['Male', 'Female'].map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
            onChanged: (val) => setState(() => _signupGender = val!),
          ),
          const SizedBox(height: 24),
          if (_signupOtpSent) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: SizedBox(
                  width: 40,
                  child: TextField(
                    controller: _signupOtpControllers[i],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (val) {
                      if (val.length == 1 && i < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (val.isEmpty && i > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              )),
            ),
            const SizedBox(height: 12),
            _signupResendSeconds > 0
              ? Text('Resend OTP in $_signupResendSeconds s', style: const TextStyle(color: Colors.grey))
              : TextButton(
                  onPressed: _sendSignupOTP,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Resend OTP'),
                ),
          ] else ...[
            ElevatedButton(
              onPressed: _sendSignupOTP,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                elevation: 0,
              ),
              child: const Text('Send OTP'),
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_signupFormKey.currentState?.validate() ?? false) {
                final otp = _signupOtpControllers.map((c) => c.text).join();
                if (otp.length != 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Enter 6-digit OTP'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
                Navigator.pushReplacementNamed(context, '/createRide');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please fill all fields'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              elevation: 0,
            ),
            child: const Text("Create Account"),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 8),
        const Text('Enter your VIT student email to continue', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        if (!_showLoginOtp) ...[
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _loginEmailController,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  decoration: _inputDecoration('Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email";
                    } else if (!value.endsWith('@vitstudent.ac.in')) {
                      return "Only VIT student email allowed";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_loginEmailController.text.isEmpty || !_loginEmailController.text.endsWith('@vitstudent.ac.in')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Enter valid VIT student email'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              setState(() => _showLoginOtp = true);
              _sendLoginOTP();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              elevation: 0,
            ),
            child: const Text('Send OTP'),
          ),
        ] else ...[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.green),
                onPressed: () => setState(() => _showLoginOtp = false),
                tooltip: 'Back to credentials',
              ),
              const SizedBox(width: 8),
              const Text('Enter OTP', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: SizedBox(
                width: 40,
                child: TextField(
                  controller: _loginOtpControllers[i],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (val) {
                    if (val.length == 1 && i < 5) {
                      FocusScope.of(context).nextFocus();
                    } else if (val.isEmpty && i > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                ),
              ),
            )),
          ),
          const SizedBox(height: 12),
          _loginResendSeconds > 0
            ? Text('Resend OTP in $_loginResendSeconds s', style: const TextStyle(color: Colors.grey))
            : TextButton(
                onPressed: _sendLoginOTP,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: const Text('Resend OTP'),
              ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final otp = _loginOtpControllers.map((c) => c.text).join();
              if (_loginEmailController.text.isEmpty || !(_loginEmailController.text.endsWith('@vitstudent.ac.in'))) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Enter valid VIT student email'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              if (otp.length != 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Enter 6-digit OTP'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              Navigator.pushReplacementNamed(context, '/createRide');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              elevation: 0,
            ),
            child: const Text("Login"),
          ),
        ],
      ],
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
