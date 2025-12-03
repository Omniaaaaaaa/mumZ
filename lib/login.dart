import 'package:flutter/material.dart';
import 'package:mamyapp/signup_screen.dart';
import 'app_colors.dart';
import 'Reset _Password.dart'; // ← مهم جداً

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && _obscurePassword,
        textDirection: TextDirection.rtl,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
          ),
          suffixIcon: Icon(icon, color: Colors.grey[400]),
          prefixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey[400],
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightBeige,
        appBar: AppBar(
          backgroundColor: AppColors.lightBeige,
          elevation: 0,
          title: const Text(
            'تسجيل دخول',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.darkBlue,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // NEW: Logo + text in a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Image.asset(
                      'assets/images/image-removebg-preview 1.png',
                      height: 60,
                    ),


                    const SizedBox(width: 10),
                    const Text(
                      'مرحباً بك',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),


                  ],
                ),

                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'يرجى إدخال بريدك الإلكتروني وكلمة المرور للدخول إلى حسابك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                _buildTextField(
                  controller: _emailController,
                  hintText: 'البريد الإلكتروني',
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  controller: _passwordController,
                  hintText: 'كلمة السر',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: AppColors.loginButtonColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.loginButtonColor,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                      shadowColor:
                      AppColors.loginButtonColor.withOpacity(0.5),
                    ),
                    child: const Text(
                      'متابعة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'انشئ حساب',
                        style: TextStyle(
                          color: AppColors.loginButtonColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'ليس لديك حساب؟',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
