import 'package:flutter/material.dart';

class recipeOpen extends StatelessWidget {
  final data;
  const recipeOpen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.grey),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: data['photo'] != null
                    ? Image(
                        image: NetworkImage(data['photo']),
                      )
                    : const SizedBox(),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text('headText: ${data['head']}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('text:  ${data['text']}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('serves:  ${data['serves']} kishi'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('cookTime:  ${data['cookTime']}')
                ],
              ),
            ),
            // ListTile(
            //   title: RichText(
            //     text: TextSpan(children: [
            //       TextSpan(
            //           text: ' ${data['head']}',
            //           style:
            //               const TextStyle(color: Colors.black, fontSize: 20)),
            //       TextSpan(
            //           text: '       ${data['serves']} kishi',
            //           style: const TextStyle(color: Colors.black, fontSize: 15))
            //     ]),
            //   ),
            //   subtitle: Text(data['text']),
            //   // leading: Text(data['cookTime']),
            //   trailing: Text('cookTime:  ${data['cookTime']}'),
            // )
          ],
        ),
      ),
    );
  }
}
