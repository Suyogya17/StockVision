import 'package:flutter/material.dart';
import 'package:stockvision_app/model/user.dart';

class LoginscreenView extends StatefulWidget {
  final List<User> registeredUsers;

  const LoginscreenView({super.key, required this.registeredUsers});

  @override
  State<LoginscreenView> createState() => _LoginscreenViewState();
}

class _LoginscreenViewState extends State<LoginscreenView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // To track password visibility
  final _gap = const SizedBox(height: 15);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    User? user = widget.registeredUsers.firstWhere(
      (user) => user.fname == username && user.password == password,
      orElse: () =>
          User(fname: '', email: '', phonenumber: 0, password: '', address: ''),
    );

    if (user.fname.isNotEmpty && user.password == password) {
      Navigator.pushNamed(context, '/dashboard', arguments: user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Welcome ${user.fname}"),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Invalid username or password."),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight, // Ensuring the container covers the full screen
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          // Vertically and horizontally centers the content
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Shrink to fit content
                children: [
                  const Icon(
                    Icons.inventory,
                    color: Colors.white,
                    size: 100,
                  ),
                  _gap,
                  const Text(
                    "StockVision",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person, color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _gap,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // "Forgot Password" logic
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      "Create New Account",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
