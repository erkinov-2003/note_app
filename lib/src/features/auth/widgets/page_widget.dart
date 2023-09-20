import 'package:flutter/material.dart';
import 'package:note_app/src/common/constants/app_colors.dart';

import '../controller/main_controller.dart';

class PageWidget extends StatefulWidget {
  const PageWidget({super.key});

  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {
  @override
  Widget build(BuildContext context) {
    final isRegistration = Provider.of(context, listen: true).isRegistration;
    final onTap = Provider.of(context).onTap2;
    return SizedBox(
      height: 50,
      width: 220,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                height: 40,
                width: 100,
                child: isRegistration
                    ? const DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black54,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                            ),
                          ],
                          color: Color(0x663E3E41),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                height: 40,
                width: 100,
                child: !isRegistration
                    ? const DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black54,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                            ),
                          ],
                          color: Color(0x663E3E41),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF575758),
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
