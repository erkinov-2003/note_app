import 'package:flutter/material.dart';
import 'package:note_app/src/features/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/localization/generated/l10n.dart';

class CameraBottomSheet extends StatefulWidget {
  const CameraBottomSheet({Key? key}) : super(key: key);

  @override
  State<CameraBottomSheet> createState() => _CameraBottomSheetState();
}

class _CameraBottomSheetState extends State<CameraBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final image = context.read<ProfileController>().image;
    final localization = GeneratedLocalization();
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 250,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 15),
                  child: Text(
                    localization.addPhoto,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Icon(
                  Icons.camera_alt,
                  color: AppColors.white,
                  size: 25,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppColors.white,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: sizeH * 0.062,
              width: sizeW * 0.93,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xFF36BFFA)),
                  onPressed: () {
                    context.read<ProfileController>().openGallery();
                  },
                  child: Text(
                    localization.openGallery,
                    style: const TextStyle(
                      fontSize: 17,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: sizeH * 0.062,
              width: sizeW * 0.93,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFF36BFFA),
                  ),
                  onPressed: () {
                    context.read<ProfileController>().openCamera();
                  },
                  child: Text(
                    localization.openCamera,
                    style: const TextStyle(
                      fontSize: 17,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
