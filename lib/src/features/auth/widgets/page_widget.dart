import 'package:flutter/material.dart';
import 'package:note_app/src/common/providers/theme_provider.dart';
import 'package:provider/provider.dart';

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
    return SizedBox(
      height: 50,
      width: 220,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          bool isDark = value.themeMode == ThemeMode.dark;
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: context.read<MainController>().onTap2,
                  child: Selector<MainController, bool>(
                    builder: (context, isRegistration, child) {
                      return SizedBox(
                        height: 40,
                        width: 100,
                        child: isRegistration
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                  boxShadow: isDark
                                      ? [
                                          const BoxShadow(
                                            color: AppColors.black54,
                                            offset: Offset(0, 4),
                                            blurRadius: 2,
                                          ),
                                        ]
                                      : null,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    localization.register,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  localization.register,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                      );
                    },
                    selector: (_, model) => model.isRegistration,
                  ),
                ),
                GestureDetector(
                  onTap: context.read<MainController>().onTap2,
                  child: Selector<MainController, bool>(
                    builder: (context, isRegistration, child) {
                      return SizedBox(
                        height: 40,
                        width: 100,
                        child: !isRegistration
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                  boxShadow: isDark
                                      ? [
                                          const BoxShadow(
                                            color: AppColors.black54,
                                            offset: Offset(0, 4),
                                            blurRadius: 2,
                                          ),
                                        ]
                                      : null,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    localization.logIn,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  localization.logIn,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                      );
                    },
                    selector: (_, model) => model.isRegistration,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
