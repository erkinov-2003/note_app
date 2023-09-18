import 'package:flutter/material.dart';


import 'custom_dialog.dart';
import 'custom_list_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                          onTap: () {},
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
                    const Text(
                      "Your Name",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Image(
                        height: 40,
                        width: 40,
                        image: AssetImage(
                          "assets/icons/edit.png",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const CustomSwitch(),
                CustomListTile(
                  title: "Language",
                  trailing: const Image(
                    width: 25,
                    height: 25,
                    image: AssetImage("assets/icons/globe.png"),
                  ),
                  onTap: () {},
                ),
                CustomListTile(
                  title: "Secret note Password",
                  trailing: const Image(
                    width: 25,
                    height: 25,
                    image: AssetImage("assets/icons/lock.png"),
                  ),
                  onTap: () {},
                ),
                const Spacer(),
                CustomListTile(
                  title: "Log out",
                  trailing: const Image(
                    width: 25,
                    height: 25,
                    image: AssetImage("assets/icons/log_out.png"),
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
                const SizedBox(height: 10),
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
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: "Theme",
      trailing: Switch(
        value: switchValue,
        onChanged: (value) {
          switchValue = value;
          setState(() {});
        },
      ),
      onTap: () {},
    );
  }
}
