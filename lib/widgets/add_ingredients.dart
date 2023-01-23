import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget(
      {super.key,
      required this.clear,
      required this.uuid,
      required this.controllerName,
      required this.controllerQuant});
  @override
  final bool clear;
  final controllerName;
  final controllerQuant;
  final String uuid;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Container(
              width: size.width / 2.3,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: const Color(0xffD9D9D9)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                maxLength: 20,
                controller: controllerName,
                decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: ' Item name'),
                style: const TextStyle(color: Colors.black),
              )),
          Container(
              width: size.width / 4,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: const Color(0xffD9D9D9)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                maxLength: 20,
                controller: controllerQuant,
                decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: '  Quantity'),
                style: const TextStyle(color: Colors.black),
              )),
          clear == true
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<CameraCubit>(context)
                        .removeItem(context, uuid);
                  },
                  icon: const Icon(Icons.clear))
              : const SizedBox()
        ],
      ),
    );
  }
}
