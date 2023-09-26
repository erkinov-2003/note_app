import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';

class IconsButton extends StatefulWidget {
  final String image;

  const IconsButton({
    required this.image,
    super.key,
  });

  @override
  State<IconsButton> createState() => _IconsButtonState();
}

class _IconsButtonState extends State<IconsButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: 44,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Image(
              width: 24,
              height: 24,
              image: AssetImage(widget.image),
            ),
          ),
        ),
      ),
    );
  }
}
