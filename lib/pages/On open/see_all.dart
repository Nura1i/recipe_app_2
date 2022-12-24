import 'package:flutter/material.dart';

import 'package:recipe_app/pages/home_page.dart';

class see_all extends StatelessWidget {
  const see_all({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.red.withOpacity(0.6),
          title: const Text('All'),
          centerTitle: true,
          elevation: 10,
        ),
      ),
      body: Column(
        children: [
          Expanded(flex: 1, child: builderAll(posts)),
          // Padding(
          //   padding: const EdgeInsets.all(3),
          //   child: CircleAvatar(
          //     backgroundColor: Colors.red,
          //     radius: 21,
          //     child: SvgPicture.asset(
          //       'assets/svg/Inactive.svg',
          //       color: Colors.white,
          //       height: 30,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
