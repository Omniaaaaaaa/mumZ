import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _childBirthController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _childNameController.dispose();
    _childBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFEF4E9),
              Color(0xFFFBD8BA),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                  const SizedBox(height: 40),

                  // Logo + Text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              'مرحباً',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF173F7B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'يرجى إدخال البيانات لإنشاء حسابك وحساب طفلك.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF7F8C8D),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Logo
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/images/image-removebg-preview 1.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Child Name
                  _buildTextField(
                    controller: _childNameController,
                    hint: 'اسم الطفل',
                    icon: Icons.child_care_outlined,
                  ),

                  const SizedBox(height: 16),

                  // Child Birth Date Picker
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2020, 1, 1),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _childBirthController.text =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: _buildTextField(
                        controller: _childBirthController,
                        hint: 'تاريخ ميلاد الطفل',
                        icon: Icons.calendar_today_outlined,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Name Field
                  _buildTextField(
                    controller: _nameController,
                    hint: 'اسم المستخدم',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 16),

                  // Email Field
                  _buildTextField(
                    controller: _emailController,
                    hint: 'البريد الإلكتروني',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'كلمة السر',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 15,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey[400],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Terms & Conditions
                  Row(
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreedToTerms = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF173F7B),
                      ),
                      Expanded(
                        child: Text(
                          'أوافق على شروط الخدمة وسياسة الخصوصية المعمول بها BabyCare الخاصة',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Already have account
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7F8C8D),
                          ),
                          children: [
                            const TextSpan(text: 'لديك حساب بالفعل؟ '),
                            TextSpan(
                              text: 'تسجيل الدخول',
                              style: TextStyle(
                                color: Colors.red[400],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_agreedToTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يرجى الموافقة على الشروط والأحكام'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              userName: _nameController.text,
                              childName: _childNameController.text,
                              childBirth: _childBirthController.text,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9E8B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'متابعة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
          ),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
