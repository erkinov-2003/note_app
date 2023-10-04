import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final Function() onTap;

  const CustomListTile({
    required this.title,
    required this.trailing,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 8,
      ),
      child: SizedBox(
        height: 50,
        child: ListTile(
          splashColor: const Color(0xFF262629),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          tileColor: const Color(0xFF262629),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: onTap,
          trailing: SizedBox(
            width: 65,
            child: trailing,
          ),
        ),
      ),
    );
  }
}
