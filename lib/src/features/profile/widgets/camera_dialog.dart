import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/functions.dart';
import 'package:note_app/src/common/utils/translate.dart';

import '../../../common/constants/app_colors.dart';

class CameraBottomSheet extends StatefulWidget {
  const CameraBottomSheet({Key? key}) : super(key: key);

  @override
  State<CameraBottomSheet> createState() => _CameraBottomSheetState();
}

class _CameraBottomSheetState extends State<CameraBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: 210,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
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
                  child: Translate(
                    builder: (context, localization, child) {
                      return Text(
                        localization.addPhoto,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      );
                    }
                  ),
                ),
                Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context, null),
                    icon: Icon(
                      Icons.cancel,
                      color: Theme.of(context).primaryColor,
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
                  onPressed: () async {
                    String? image = await pickImageFromGallery();
                    if (mounted) Navigator.pop(context, image);
                  },
                  child: Translate(
                    builder: (context, localization, child) {
                      return Text(
                        localization.openGallery,
                        style: const TextStyle(
                          fontSize: 17,
                          color: AppColors.white
                        ),
                      );
                    }
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
                  onPressed: () async {
                    final image = await pickImageFromCamera();
                    if (mounted) Navigator.pop(context, image);
                  },
                  child: Translate(
                    builder: (context, localization, child) {
                      return Text(
                        localization.openCamera,
                        style: const TextStyle(
                          fontSize: 17,
                          color: AppColors.white
                        ),
                      );
                    }
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
