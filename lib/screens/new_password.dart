import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trl_audio_book/screens/password_updated.dart';
import 'package:trl_audio_book/utils/size_config.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late AnimationController _topController;
  late AnimationController _bottomController;
  late Animation<Offset> _topAnimation;
  late Animation<Offset> _bottomAnimation;

  @override
  void initState() {
    super.initState();
    _topController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _bottomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _topAnimation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _topController, curve: Curves.easeOut));
    _bottomAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _bottomController, curve: Curves.easeOut));

    _topController.forward();
    _bottomController.forward();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Must include an uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(value)) return 'Must include a lowercase letter';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Must include a number';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm your password';
    if (value != _newPasswordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PopScope(
        canPop: false,
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1C2037), Color(0xFF191C23)],
                ),
              ),
            ),
            // Background image
            SlideTransition(
              position: _topAnimation,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Frame 1171275791.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Overlay gradient
            SlideTransition(
              position: _topAnimation,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF191C23).withOpacity(0.85),
                      const Color(0xFF191C23).withOpacity(0.90),
                      const Color(0xFF0F111A),
                      const Color(0xFF000000),
                    ],
                    stops: const [0.0, 0.4, 0.75, 1.0],
                  ),
                ),
              ),
            ),
            // Content
            // Content
            SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(top: 8.height, left: 5.width, right: 5.width),
                physics: const BouncingScrollPhysics(),
                child: SlideTransition(
                  position: _bottomAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Add vertical space before logo
                        SizedBox(height: 22.height),

                        SvgPicture.asset('assets/svg_icons/Logo.svg', height: 6.height),
                        SizedBox(height: 5.height),

                        const SizedBox(
                          width: 342,
                          child: Text(
                            'Set New Password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w600,
                              height: 1.27,
                              letterSpacing: 0.60,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.height,
                        ),
                        Text(
                          'Let’s set a strong a password for your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFEFF3FB) /* Offwhite-Offwhite-1 */,
                            fontSize: 14,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w300,
                            height: 1.43,
                          ),
                        ),
                        SizedBox(height: 6.height),

                        /// New Password Field
                        Container(
                          width: 90.width,
                          margin: EdgeInsets.only(bottom: 3.height),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2B2F3D),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFF454B5F)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: TextFormField(
                            controller: _newPasswordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'New Password',
                              hintStyle: TextStyle(color: Colors.white54),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                              border: InputBorder.none,
                            ),
                            validator: _validatePassword,
                          ),
                        ),

                        /// Confirm Password Field
                        Container(
                          width: 90.width,
                          margin: EdgeInsets.only(bottom: 3.height),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2B2F3D),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFF454B5F)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Retype New Password',
                              hintStyle: TextStyle(color: Colors.white54),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                              border: InputBorder.none,
                            ),
                            validator: _validateConfirmPassword,
                          ),
                        ),

                        // Flexible space before button
                        SizedBox(height: 5.height),

                        /// Continue Button
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              debugPrint('Password Reset Successful');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PasswordUpdated()),
                              );
                            }
                          },
                          child: Container(
                            height: 5.5.height,
                            width: 90.width,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFCD2F25),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
