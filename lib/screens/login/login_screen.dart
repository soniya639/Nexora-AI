import 'package:flutter/material.dart';

import '../../utils/page_transition.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleLogin() {
    String name = _nameController.text.trim();
    String ageText = _ageController.text.trim();
    String email = _emailController.text.trim().toLowerCase();
    String password = _passwordController.text.trim();

    // 1. NAME CHECK
    if (name.isEmpty) {
      _showError("Name Enter Chey ra!");
      return;
    }
    if (name.length < 3) {
      _showError("Name Minimum 3 Letters Undali!");
      return;
    }

    // 2. AGE CHECK
    if (ageText.isEmpty) {
      _showError("Age Enter Chey ra!");
      return;
    }
    int? age = int.tryParse(ageText);
    if (age == null) {
      _showError("Age lo Only Numbers Pettali!");
      return;
    }
    if (age <= 0 || age > 120) {
      _showError("Correct Age Enter Chey! (1 - 120)");
      return;
    }

    // 3. EMAIL CHECK - FAKE AYINA PARLEDHU, KANI @gmail.com THO NE END AVVALI
    if (email.isEmpty) {
      _showError("Email Enter Chey ra!");
      return;
    }
    if (!email.endsWith("@gmail.com")) {
      _showError("Only @gmail.com Mail Matrame! Ex: abc@gmail.com");
      return;
    }
    String beforeAt = email.replaceAll("@gmail.com", "");
    if (beforeAt.isEmpty) {
      _showError("Correct Gmail Enter Chey!");
      return;
    }
    if (beforeAt.contains(" ") || beforeAt.contains("@")) {
      _showError("Correct Gmail Enter Chey!");
      return;
    }

    // 4. PASSWORD CHECK
    if (password.isEmpty) {
      _showError("Password Enter Chey ra!");
      return;
    }
    if (password.length < 4) {
      _showError("Password Minimum 4 Letters Undali!");
      return;
    }

    // ANNI CORRECT - SUCCESS
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Welcome $name! Login Success!"),
        backgroundColor: const Color(0xFF00BFA6),
        behavior: SnackBarBehavior.floating,
      ),
    );

  Navigator .pushReplacement(
    context,
    smoothRoute(const HomeScreen()),
  );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? !_isPasswordVisible : false,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF00BFA6)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00BFA6), width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.health_and_safety,
                  size: 45,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Welcome to Nexora AI Healthcare",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // NAME
              _buildTextField(
                controller: _nameController,
                label: "Name",
                hint: "Ex: Ramu",
                icon: Icons.person,
              ),
              const SizedBox(height: 16),

              // AGE
              _buildTextField(
                controller: _ageController,
                label: "Age",
                hint: "Ex: 22",
                icon: Icons.cake,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // EMAIL
              _buildTextField(
                controller: _emailController,
                label: "Email",
                hint: "Ex: abc@gmail.com",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // PASSWORD
              _buildTextField(
                controller: _passwordController,
                label: "Password",
                hint: "Minimum 4 Letters",
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 30),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Fake mail ayina parledhu,\nkani @gmail.com tho ne end avvali!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}