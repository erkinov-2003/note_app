import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app/src/common/localization/generated/l10n.dart';
import 'package:note_app/src/features/profile/widgets/camera_dialog.dart';
import 'package:note_app/src/features/secret_notes/new_pass.dart';
import 'package:note_app/src/features/secret_notes/update_pass.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import '../../common/models/user_model.dart';
import '../../common/utils/storage.dart';
import 'widgets/log_out_dialog.dart';
import 'widgets/custom_list_tile.dart';
import 'widgets/language_bottom_sheet.dart';
import 'widgets/name_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ValueNotifier<String> name = ValueNotifier("");

  @override
  void didChangeDependencies() async {
    name.value = User.fromJson(jsonDecode(
                await $secureStorage.read(key: StorageKeys.oneUser.key) ??
                    "Your Name"))
            .name ??
        "";
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localization = GeneratedLocalization();
    final screenSize = MediaQuery.sizeOf(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 450,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        appBar: AppBar(
          leading: BackButton(
            color: AppColors.white,
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: const Color(0xFF000000),
          title: Text(
            localization.profile,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Badge(
                        largeSize: 30,
                        backgroundColor: const Color(0xFF797979),
                        alignment: const Alignment(.8, 1.2),
                        label: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => const CameraBottomSheet(),
                            );
                          },
                          child: const SizedBox(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 80,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: name,
                      builder: (context, value, _) {
                        return SizedBox(
                          width: screenSize.width * .4,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => NameDialog(
                            name: name,
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(AppIcons.editIcon),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const CustomSwitch(),
                CustomListTile(
                  title: localization.language,
                  trailing: const Image(
                    width: 25,
                    height: 25,
                    image: AssetImage(AppIcons.globe),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const LanguageBottomSheet(),
                    );
                  },
                ),
                CustomListTile(
                  title: localization.secretPassword,
                  trailing: const Image(
                    width: 25,
                    height: 25,
                    image: AssetImage(AppIcons.lockIcon),
                  ),
                  onTap: () async {
                    if((await $secureStorage.read(key: StorageKeys.notesPassword.key))==null&&mounted){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NewSecretPassword()));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdatePassword()));
                    }
                  },
                ),
                const Spacer(),
                CustomListTile(
                  title: localization.logOut,
                  trailing: const Image(
                    width: 25,
                    height: 25,
                    image: AssetImage(AppIcons.logOut),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CustomLogOutDialog(),
                    );
                  },
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    "Note App for IOS\nv01.0.1(2023) by Flutter G7",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF262629),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool switchValue = $storage.getBool(StorageKeys.theme.key) ?? false;
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: "Theme",
      trailing: Switch(
        value: switchValue,
        onChanged: (value) {
          switchValue = value;
          $storage.setBool(StorageKeys.theme.key, switchValue);
          setState(() {});
        },
      ),
      onTap: () {},
    );
  }
}
