import 'package:flutter/material.dart';
import 'package:note_app/src/features/create_note/create_note.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';

class CustomNewNote extends StatelessWidget {
  const CustomNewNote({Key? key}) : super(key: key);

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
