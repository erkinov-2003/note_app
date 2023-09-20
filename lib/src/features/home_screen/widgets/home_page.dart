import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/src/features/home_screen/widgets/bottom_sheet.dart';
import 'package:note_app/src/features/profile/profile_page.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  void openProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        toolbarHeight: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: GestureDetector(
              onTap: openProfile,
              child: const SizedBox(
                width: 57,
                height: 57,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image(
                      image: AssetImage("assets/images/person.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Note.d",
              style: TextStyle(color: AppColors.white, fontSize: 24),
            ),
            Text(
              "Enjoy note taking with friends",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: 10,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: index == 0 ? 1 : 16 / 9,
              child: const CustomButton(),
            );
          },
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () => customBottomSheet(context),
      child: SizedBox(
        height: 171,
        width: 166,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xE6FFFFFF),
            border: Border.all(color: const Color(0xFF36BFFA), width: 3),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(AppIcons.avatar),
                height: 40,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              const Text(
                "New note",
                style: TextStyle(
                  color: Color(0xFF36BFFA),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
