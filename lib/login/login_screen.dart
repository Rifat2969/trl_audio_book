import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trl_audio_book/utils/size_config.dart';

import '../bottom_sheets/domain_selection.dart';
import '../screens/forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _topController;
  late AnimationController _bottomController;
  late Animation<Offset> _topAnimation;
  late Animation<Offset> _bottomAnimation;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _topController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _bottomController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _topAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _topController,
      curve: Curves.easeOut,
    ));

    _bottomAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bottomController,
      curve: Curves.easeOut,
    ));

    _topController.forward();
    _bottomController.forward();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
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

            // Background image (animated from top)
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

            // Overlay gradient (animated from top)
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

            SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                  top: 44.height,
                  left: 5.width,
                  right: 5.width,
                ),
                physics: const BouncingScrollPhysics(),
                child: SlideTransition(
                  position: _bottomAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg_icons/Logo.svg',
                          height: 6.height,
                        ),
                        SizedBox(height: 10.height),
                        const SizedBox(
                          width: 342,
                          child: Text(
                            'Make Travel Time Pay',
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
                        SizedBox(height: 1.height),
                        const SizedBox(
                          width: 342,
                          child: Text(
                            'Check out our collection of business titles',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFEFF3FB),
                              fontSize: 14,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w300,
                              height: 1.43,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.height),
                        Container(
                          width: 90.width,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFF737F97)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Type password here',
                              hintStyle: const TextStyle(color: Colors.white54),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Minimum 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPassword()));
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFFFCFCFF),
                                fontSize: 14,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.height),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              debugPrint('Password submitted: ${_passwordController.text}');
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const DomainSelection(),
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
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7.height)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
