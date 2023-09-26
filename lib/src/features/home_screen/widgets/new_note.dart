import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import '../../../common/localization/generated/l10n.dart';
import '../../create_note/create_note.dart';

class CustomNewNote extends StatelessWidget {
  CustomNewNote({Key? key}) : super(key: key);

  final localization = GeneratedLocalization();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateNote(),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.black,
          border: Border.all(color: AppColors.white),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Image(
                image: AssetImage(AppIcons.avatar),
                height: 50,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              Text(
                localization.newNote,
                style: const TextStyle(
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
