import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _onLogin() {
    String name = _nameController.text.trim();
    String ageText = _ageController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // 1. NAME CHECK
    if (name.isEmpty) {
      _showError("Please Enter Your Name!");
      return;
    }
    if (name.length < 3) {
      _showError("Name Must Be At Least 3 Characters!");
      return;
    }

    // 2. AGE CHECK
    if (ageText.isEmpty) {
      _showError("Please Enter Your Age!");
      return;
    }
    int? age = int.tryParse(ageText);
    if (age == null) {
      _showError("Age Must Be In Numbers Only!");
      return;
    }
    if (age < 10 || age > 100) {
      _showError("Age Must Be Between 10 And 100!");
      return;
    }

    // 3. EMAIL CHECK
    if (email.isEmpty) {
      _showError("Please Enter Your Email!");
      return;
    }
    if (!email.endsWith("@gmail.com")) {
      _showError("Only @gmail.com Is Allowed!");
      return;
    }
    String beforeAt = email.split("@")[0];
    if (beforeAt.length < 3) {
      _showError("Email Must Have At Least 3 Characters Before @!");
      return;
    }

    // 4. PASSWORD CHECK
    if (password.isEmpty) {
      _showError("Please Enter Your Password!");
      return;
    }
    if (password.length < 6) {
      _showError("Password Must Be At Least 6 Characters!");
      return;
    }

    // SUCCESS - GO TO HOME PAGE
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          name: name,
          age: ageText,
          email: email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.lock, size: 80, color: Colors.blue),
            const SizedBox(height: 30),

            // NAME
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // AGE
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Age",
                prefixIcon: Icon(Icons.cake),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // EMAIL
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "example@gmail.com",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // PASSWORD
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),

            // LOGIN BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _onLogin,
                child: const Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}