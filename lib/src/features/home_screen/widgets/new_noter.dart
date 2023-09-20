
import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';

class CustomNewNote extends StatelessWidget {
  const CustomNewNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: size.height * .2,
        width: size.width * .46,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.black,
            border: Border.all(color: AppColors.white),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(AppIcons.avatar),
                height: 50,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              const Text(
                "New note",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}