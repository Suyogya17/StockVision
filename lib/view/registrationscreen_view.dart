import 'package:flutter/material.dart';
import 'package:stockvision_app/model/user.dart';

class RegistrationScreen extends StatefulWidget {
  final Function(User) onUserRegistered;

  const RegistrationScreen({super.key, required this.onUserRegistered});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _gap = const SizedBox(height: 15);
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _addressController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phonenumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _registerUser() {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String phoneNumberStr = _phonenumberController.text.trim();
    String address = _addressController.text.trim();
    String password = _passwordController.text.trim();

    double? phonenumber = double.tryParse(phoneNumberStr);

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        phoneNumberStr.isEmpty ||
        address.isEmpty) {
      _showSnackBar("Please fill in all fields.", Colors.red);
    } else if (!email.contains('@') || !email.endsWith('.com')) {
      _showSnackBar("Please enter a valid email address.", Colors.red);
    } else if (phonenumber == null || phoneNumberStr.length != 10) {
      _showSnackBar("Phone number must be exactly 10 digits.", Colors.red);
    } else {
      User newUser = User(
        fname: username,
        email: email,
        phonenumber: phonenumber,
        password: password,
        address: address,
      );
      widget.onUserRegistered(newUser);
      _showSnackBar("Registered as $username", Colors.green);
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: _usernameController,
                  label: "Username",
                  icon: Icons.person,
                ),
                _gap,
                _buildTextField(
                  controller: _emailController,
                  label: "Email",
                  icon: Icons.email,
                ),
                _gap,
                _buildTextField(
                  controller: _phonenumberController,
                  label: "Phone Number",
                  icon: Icons.phone,
                  inputType: TextInputType.number,
                ),
                _gap,
                _buildTextField(
                  controller: _addressController,
                  label: "Address",
                  icon: Icons.home,
                ),
                _gap,
                _buildPasswordField(),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                _gap,
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Already have an Account? SIGN-IN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: "Password",
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
