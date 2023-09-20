import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/src/features/home_screen/widgets/new_noter.dart';

import '../../common/constants/app_colors.dart';
import 'widgets/note.dart';
import 'package:note_app/src/features/home_screen/widgets/bottom_sheet.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
            padding: const EdgeInsets.only(right: 10,top: 10),
            child: GestureDetector(
              onTap: () {},
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
      body: MasonryGridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        itemCount: 100,
        itemBuilder: (context, index) {
          return Column(
            children: [
              index == 0 ? const CustomNewNote() : const SizedBox(),
              index == 0 ? const SizedBox(height: 10) : const SizedBox(),
              Note(
                title: 'krnvfnrjfnrrf jmjhbhjbjhbjbhbjbhbbjbf',
                subTitle: 'EBUhdijhubhrijrifrubhfbnjik'
                    'ojfwnienfirnfinrifnnnnnnnnnnnnnnnnnnnn'
                    'nnnnnnnnnnnnnnnnnnnnnnnnnnn'
                    'nnribhnjiko3efrijb  ',
                dateTime: DateTime.now(),
                isLogget: true,
                path: "assets/images/facebook.png",
              ),
            ],
          );
        },
      ),
    );
  }
}
