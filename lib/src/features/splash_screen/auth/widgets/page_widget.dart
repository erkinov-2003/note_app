import 'package:flutter/material.dart';

class PageWidget extends StatefulWidget {
  final bool isRegistration;
  final void Function() onTap;

  const PageWidget({
    required this.onTap,
    required this.isRegistration,
    super.key,
});

  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 220,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1B),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: widget.onTap,
              child: SizedBox(
                height: 40,
                width: 100,
                child: widget.isRegistration
                    ? const DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                            ),
                          ],
                          color: Color(0x663E3E41),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF575758),
                          ),
                        ),
                      ),
              ),
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: SizedBox(
                height: 40,
                width: 100,
                child: !widget.isRegistration
                    ? const DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                            ),
                          ],
                          color: Color(0x663E3E41),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF575758),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
