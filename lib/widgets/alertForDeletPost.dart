import 'package:flutter/material.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

DeletePostDialog(BuildContext context, postData) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: .0,
        title: const Text('Delete Post'),
        content: const Text(
          'Do you want to delete Post?',
        ),
        titleTextStyle: Theme.of(context).textTheme.bodySmall,
        contentTextStyle: Theme.of(context).textTheme.bodySmall,
        backgroundColor: Theme.of(context).backgroundColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.orange, width: 2)),
        actions: [
          MaterialButton(
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodySmall,
              )),
          SizedBox(
            width: 100,
            child: MaterialButton(
                color: Colors.orange,
                onPressed: () {
                  FireDatabaseService.deletePost(postData);
                  var count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Yes',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )
                  ],
                )),
          ),
        ],
      );
    },
  );
}
