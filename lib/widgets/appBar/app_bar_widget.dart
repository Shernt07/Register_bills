import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF08A5C0),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 38.8,
                      width: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Image.asset(
                          'assets/img/logo.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text('LINDA VISTA',
                          style: TextStyle(fontSize: 10, color: Colors.white)),
                      SizedBox(
                        width: 5,
                      ),
                      Text('',
                          style: TextStyle(fontSize: 7, color: Colors.white)),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 220,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
