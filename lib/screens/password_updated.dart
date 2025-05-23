import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trl_audio_book/login/login_screen.dart';
import 'package:trl_audio_book/utils/size_config.dart';

class PasswordUpdated extends StatefulWidget {
  const PasswordUpdated({super.key});

  @override
  State<PasswordUpdated> createState() => _PasswordUpdatedState();
}

class _PasswordUpdatedState extends State<PasswordUpdated> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _animation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Frame 1171275791.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay gradient
          Container(
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

          SafeArea(
            child: SlideTransition(
              position: _animation,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 26.height),
                    // Icon with debug container
                    SvgPicture.asset(
                      "assets/svg_icons/tic.svg",
                      height: 7.height,
                    ),
                    SizedBox(height: 5.height),

                    const SizedBox(
                      width: 342,
                      child: Text(
                        'Password Updated!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white /* Primary-White */,
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
                        'Please login to your account with new password',
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
                    SizedBox(height: 5.height),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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
                          'Go to Login',
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
        ],
      ),
    );
  }
}
