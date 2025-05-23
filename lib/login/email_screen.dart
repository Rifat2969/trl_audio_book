import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trl_audio_book/utils/size_config.dart';

import '../bottom_sheets/domain_selection.dart';

class AddEmail extends StatefulWidget {
  const AddEmail({super.key});

  @override
  State<AddEmail> createState() => _AddEmailState();
}

class _AddEmailState extends State<AddEmail> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _topController;
  late AnimationController _bottomController;
  late Animation<Offset> _topAnimation;
  late Animation<Offset> _bottomAnimation;

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
    _emailController.dispose();
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
                            controller: _emailController,
                            focusNode: FocusNode(),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.white54),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(Icons.email_outlined, color: Colors.white70),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!EmailValidator.validate(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 2.height),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              debugPrint('Email submitted: ${_emailController.text}');
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
