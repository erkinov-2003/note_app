import 'package:flutter/material.dart';


import 'custom_dialog.dart';
import 'custom_list_tile.dart';

class ProfilePage extends StatelessWidget {

  ValueNotifier<int> selected=ValueNotifier(-1);
  List<Widget> imagesPath = [
    const Image(
      image: AssetImage("assets/icons/ic_eng.png"),
      height: 25,
    ),
    const Image(
      image: AssetImage("assets/icons/ic_rus.png"),
      height: 25,
    ),
    const Image(
      image: AssetImage("assets/icons/ic_uzb.png"),
      height: 25,
    ),
  ];

  List<String> list = [
    "English",
    "Russia",
    "Uzbek",
  ];

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH=MediaQuery.of(context).size.height;
    final sizeW=MediaQuery.of(context).size.width;
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
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                              ),
                              context: context,
                              builder: (context) =>  SizedBox(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 20,left: 20),
                                            child: Text("Profile Images",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 20,left: 5),
                                            child: Icon(Icons.camera_alt_rounded,size: 25,),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: sizeH*0.062,
                                        width: sizeW*0.93,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                              backgroundColor: const Color(0xFF36BFFA)
                                          ),
                                          onPressed: (){},
                                          child: const Text("Open Gallery",style: TextStyle(fontSize: 17),),
                                        ),
                                      ),
                                      SizedBox(
                                        height: sizeH*0.062,
                                        width: sizeW*0.93,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            backgroundColor: const Color(0xFF36BFFA),
                                          ),
                                          onPressed: (){},
                                          child: const Text("Open Camera",style: TextStyle(fontSize: 17),),
                                        ),
                                      )
                                    ],
                                  )
                              ),
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
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context)=>Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 17,top: 20),
                            child: Row(
                              children: [
                                Text("Language",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w700),),
                                Image(image: AssetImage("assets/images/Vector.png"),height: 20,),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15,),
                          ValueListenableBuilder(
                              valueListenable: selected,
                              builder: (context,value, child) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: list.length, // 10 ta element
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                        title: SizedBox(
                                          height: 45,
                                          width: 100,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                              backgroundColor: index==value ? const Color(0xFF36BFFA) : const Color(0xFF575758),
                                            ),
                                            onPressed: () {
                                              selected.value = index;
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(list[index]),
                                                imagesPath[index],
                                              ],
                                            ),
                                          ),
                                        )
                                    );
                                  },
                                );
                              }
                          ),
                          const SizedBox(height: 15,),
                        ],
                      ),
                    );
                  },
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
      onTap: () {
        }

    );
  }
}
