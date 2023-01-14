import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/add_cubits/add_state.dart';
import 'package:recipe_app/models/Recipe%20Model/recipe_model.dart';
import 'package:recipe_app/models/ingredient%20Model/ingredient_model.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/widgets/add_ingredients.dart';
import 'package:uuid/uuid.dart';

TextEditingController? controlerMain;
TextEditingController? controllerBody;
// TextEditingController itemNameController = TextEditingController();
// TextEditingController itemQuanityController = TextEditingController();

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInit());
  bool isOpen = false;

  File? image;
  Future pickImageFromGalery(ctx) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
    } on Exception catch (e) {
      log('Failed to pick image: $e');
    }
    emit(imagePick(image));
    Navigator.of(ctx).pop();
  }

  Future pickImageFromCamera(ctx) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
    } on Exception catch (e) {
      log('Failed to pick image: $e');
    }
    emit(imagePick(image));
    Navigator.of(ctx).pop();
  }

  Future deletePhoto() async {
    emit(imagePick(null));
  }

  bool chosed = false;
  isOpenServes() {
    chosed = true;
    emit(choose(chosed));
  }

  isCloseServes() {
    chosed = false;
    emit(choose(chosed));
  }

  acceptCount(int count) {
    emit(AcceptCount(count));

    return count != null
        ? Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              left: 13,
              right: 13,
            ),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Colors.grey, Color.fromARGB(255, 214, 126, 122)]),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              '$count Kishi',
              style: const TextStyle(color: Colors.white),
            ),
          )
        : const Text('0');
  }

  cookTime(BuildContext context) {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    ).then((TimeOfDay? value) {
      if (value != null) {
        emit(AcceptTime(value.format(context)));
      }
    });
  }

  List<IngredientModel> ls = [];
  addItem(ctx, String? uuid, controllerName, controllerQuant) {
    ls.add(IngredientModel(
        uuid: uuid!,
        widget: IngredientsWidget(
          controllerName: controllerName,
          controllerQuant: controllerQuant,
          key: ValueKey<String>(uuid),
          uuid: uuid,
          clear: true,
        )));
    emit(addItemState(ls));
  }

  removeItem(ctx, String? uuid) {
    //ls.removeWhere((element) => element.widget.key == ValueKey<String>(uuid!));
    ls.removeWhere((element) => element.uuid == uuid!);

    emit(addItemState(ls));
    log('removed at Index:  ${uuid.toString()}');
  }

  List<String> ingredients = [];
  String? ingredientsString;

  postRecipe(ctx, head, serves, cookTime, bodyText, photo, items) async {
    // List<String> toList() {
    //   for (var item in items) {
    //     ingredients.add(item.toString());
    //   }

    //   return ingredients.toList();
    // }

    List items = [
      // Item(ItemName: 'Olma', ItemQuanity: '300 gram'),
      // Item(ItemName: 'kartoshka', ItemQuanity: '100 gram'),
      // Item(ItemName: 'sabzi', ItemQuanity: '200 gram')
    ];
    recipeModel recipe = recipeModel(
        cookTime: cookTime,
        head: head,
        serves: serves,
        userId: FirebaseAuth.instance.currentUser!.uid.toString(),
        id: const Uuid().v1().toString(),
        text: bodyText,
        items: items.map<Map>((e) => e.toMap()).toList());

    final recipeSavedToData = await FireDatabaseService.SaveRecipeToCollection(
        recipe: recipe, image: photo);

    log('Saved');
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MenuPage()),
        (route) => false);
  }
}
