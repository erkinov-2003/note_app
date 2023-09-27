import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/localization/generated/l10n.dart';
import '../controller/main_controller.dart';

class PageWidget extends StatefulWidget {
  const PageWidget({super.key});

  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {
  final localization = GeneratedLocalization();

  @override
  Widget build(BuildContext context) {
    final isRegistration = ProviderRegistration.of(context, listen: true).isRegistration;
    final onTap = ProviderRegistration.of(context).onTap2;
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
                    ?   DecoratedBox(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black54,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                            ),
                          ],
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            localization.register,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    :  Center(
                        child: Text(
                          localization.register,
                          style: const TextStyle(
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
                    ?   DecoratedBox(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black54,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                            ),
                          ],
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            localization.logIn,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    :  Center(
                        child: Text(
                          localization.logIn,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor,
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
