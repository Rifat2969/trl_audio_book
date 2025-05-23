import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trl_audio_book/utils/size_config.dart';

import 'new_password.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with TickerProviderStateMixin {
  String _currentOtp = '';
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
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (_currentOtp.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewPassword()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the 4-digit OTP'),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initMediaQuery(context);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5.height),
                      const Text(
                        'Submit OTP',
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
                      SizedBox(height: 1.5.height),
                      const Text(
                        'Submit the OTP we have sent to your email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFEFF3FB),
                          fontSize: 14,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w300,
                          height: 1.43,
                        ),
                      ),
                      SizedBox(height: 4.height),

                      // OTP boxes
                      Container(
                        width: 100.width,
                        padding: EdgeInsets.symmetric(horizontal: 1.width),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          keyboardType: TextInputType.number,
                          textStyle: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 70,
                            fieldWidth: 70,
                            activeColor: const Color(0xFF454B5F),
                            selectedColor: const Color(0xFF454B5F),
                            inactiveColor: const Color(0xFF454B5F),
                            activeFillColor: const Color(0xFF2B2F3D),
                            selectedFillColor: const Color(0xFF2B2F3D),
                            inactiveFillColor: const Color(0xFF2B2F3D),
                            borderWidth: 1,
                          ),
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          onChanged: (value) {
                            setState(() {
                              _currentOtp = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 3.height),

                      // Verify Button
                      GestureDetector(
                        onTap: _verifyOtp,
                        child: Container(
                          height: 5.5.height,
                          width: 90.width,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFCD2F25),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            'Verify OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.height),
                    ],
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
