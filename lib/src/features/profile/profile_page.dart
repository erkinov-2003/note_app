import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants/app_icons.dart';
import '../../common/localization/generated/l10n.dart';
import '../../common/providers/theme_provider.dart';
import '../../common/utils/storage.dart';
import '../secret_notes/new_pass.dart';
import '../secret_notes/update_pass.dart';

import 'widgets/camera_dialog.dart';
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
  ValueNotifier<String?> profileImage = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    profileImage.value = $users.currentUser.image;
    name.value = $users.currentUser.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = GeneratedLocalization();
    final screenSize = MediaQuery.sizeOf(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 450,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: theme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(
            localization.profile,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              color: theme.primaryColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ListView(
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ValueListenableBuilder(
                          valueListenable: profileImage,
                          builder: (context, value, child) {
                            return Badge(
                              largeSize: 30,
                              backgroundColor: const Color(0xFF797979),
                              alignment: const Alignment(.8, 1.2),
                              label: GestureDetector(
                                onTap: () async {
                                  String? image = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        const CameraBottomSheet(),
                                  );
                                  $users.updateUser($users.currentUser
                                      .copyWith(image: image));
                                  profileImage.value = image;
                                },
                                child: const SizedBox(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: value != null
                                    ? FileImage(File(value))
                                    : null,
                                backgroundColor: theme.primaryColor,
                                radius: 50,
                                child: value == null
                                    ? Center(
                                        child: Icon(
                                          Icons.person,
                                          color: theme.scaffoldBackgroundColor,
                                          size: 80,
                                        ),
                                      )
                                    : null,
                              ),
                            );
                          }),
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
                            style: TextStyle(
                              fontSize: 25,
                              color: theme.primaryColor,
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Image(
                          height: 40,
                          width: 40,
                          color: theme.primaryColor,
                          image: const AssetImage(AppIcons.editIcon),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const CustomSwitch(),
                CustomListTile(
                  title: localization.language,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const LanguageBottomSheet(),
                    );
                  },
                  trailing: const Image(
                    width: 25,
                    height: 25,
                    image: AssetImage(AppIcons.lockIcon),
                  ),
                ),
                CustomListTile(
                  title: localization.secretPassword,
                  trailing: const Image(
                    width: 25,
                    height: 25,
                    image: AssetImage(AppIcons.lockIcon),
                  ),
                  onTap: () async {
                    if ((await $secureStorage.read(
                                key: StorageKeys.notesPassword.key)) ==
                            null &&
                        mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewSecretPassword()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdatePassword()));
                    }
                  },
                ),
                SizedBox(height: screenSize.height * .1),
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
                Center(
                  child: Text(
                    "Note App for IOS\nv01.0.1(2023) by Flutter G7",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      // color: Color(0xFF262629),
                      color: Theme.of(context).primaryColor,
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
  // bool switchValue = $storage.getBool(StorageKeys.theme.key) ?? false;

  void onChanged(bool newValue, ThemeProvider value) {
    value.changeTheme(newValue);
    $storage.setBool(StorageKeys.theme.key, newValue);
  }

  @override
  Widget build(BuildContext context) {
    final localization = GeneratedLocalization.of(context);
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return CustomListTile(
        title: localization.theme,
        trailing: Switch(
            value: value.themeMode == ThemeMode.dark,
            onChanged: (newValue) => onChanged(!newValue, value)),
        onTap: () => onChanged(value.themeMode == ThemeMode.dark, value),
      );

      //   SwitchListTile.adaptive(
      //   title: Text(localization.theme),
      //   value: value.themeMode == ThemeMode.light,
      //   onChanged: (newValue) {
      //     value.changeTheme(newValue);
      //     $storage.setBool(StorageKeys.theme.key, newValue);
      //   },
      // );
    });
  }
}
