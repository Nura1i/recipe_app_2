import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';
import 'package:recipe_app/pages/add_page.dart';

Widget choosePers(ctx, count) {
  return AlertDialog(
    insetPadding: EdgeInsets.only(
        top: scrolController.offset < 0 ? 100 : scrolController.offset + 50,
        left: 40,
        right: 40),
    actions: [
      Container(
        height: 400,
        width: 350,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 200, 200, 200),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            BlocProvider.of<CameraCubit>(ctx).acceptCount(count),
            Expanded(
                child: ListWheelScrollView.useDelegate(
                    physics: const FixedExtentScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    onSelectedItemChanged: (index) {
                      final player = AudioPlayer();
                      player.play(AssetSource('sounds/choosingNumber.wav'),
                          volume: 0.1);
                      player.stop();

                      count = index;

                      BlocProvider.of<CameraCubit>(ctx).acceptCount(count);
                    },
                    perspective: 0.002,
                    diameterRatio: 0.9,
                    itemExtent: 30,
                    childDelegate:
                        ListWheelChildBuilderDelegate(builder: (_, int index) {
                      if (index < 0 || index > 20) {
                        return null;
                      }

                      return Container(
                        // height: 20,
                        width: 250,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 175, 167, 167),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          "  $index KISHI",
                          style: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        ),
                      );
                    }))),
          ],
        ),
      ),
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: () {
          BlocProvider.of<CameraCubit>(ctx).isCloseServes();
        },
        child: const Text('Accept'),
      ),
    ],
  );
}
