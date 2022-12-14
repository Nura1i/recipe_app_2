import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.orange,
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.white,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              //scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 200,
                    width: 100,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 200,
                    width: 100,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            height: 200,
                            width: 100,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Container(
                            height: 200,
                            width: 100,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Container(
                            height: 200,
                            width: 100,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Container(
                            height: 200,
                            width: 100,
                            color: Colors.red,
                          ),
                        ],
                      )),
                  Container(
                    height: 200,
                    width: 100,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 200,
                    width: 100,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 200,
                    width: 100,
                    color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
