import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trl_audio_book/model/domain_selection_model.dart';
import 'package:trl_audio_book/utils/size_config.dart';

import '../login/login_screen.dart';

class DomainSelection extends StatefulWidget {
  const DomainSelection({super.key});

  @override
  State<DomainSelection> createState() => _DomainSelectionState();
}

class _DomainSelectionState extends State<DomainSelection> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.width),
      decoration: const BoxDecoration(
        color: Color(0xFF2B2F3D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    'Domain Selection',
                    style: TextStyle(
                      color: Color(0xFFBCC9E2),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/svg_icons/Close_Circle.svg'),
              )
            ],
          ),
          SizedBox(height: 2.height),
          SizedBox(
            height: 33.height,
            child: ListView.separated(
              itemCount: all_domains.length,
              separatorBuilder: (context, index) => Divider(color: Colors.white24, height: 2.height),
              itemBuilder: (context, index) {
                var domains = all_domains[index];
                bool isSelected = selectedIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.8.height),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg_icons/GlobeIcon.svg',
                        ),
                        SizedBox(width: 4.width),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${domains.domainType}',
                              style: const TextStyle(
                                color: Color(0xFFBCC9E2),
                                fontSize: 14,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                            SizedBox(height: 0.5.height),
                            Text(
                              '${domains.domain}',
                              style: const TextStyle(
                                color: Color(0xFF8C98AF),
                                fontSize: 12,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w300,
                                height: 1.33,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (isSelected) const Icon(Icons.check, color: Colors.white, size: 22),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 5.5.height,
              width: 90.width,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF737F97)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 2.height),
          GestureDetector(
            onTap: () {
              if (selectedIndex != null) {
                // handle selection action
                debugPrint('Selected: ${all_domains[selectedIndex!].domain}');
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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
    );
  }
}
