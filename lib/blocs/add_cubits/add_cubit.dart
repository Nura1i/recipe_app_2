import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/add_cubits/add_state.dart';
import 'package:recipe_app/models/Recipe%20Model/recipe_model.dart';
import 'package:recipe_app/models/ingredient%20Model/ingredient_model.dart';
import 'package:recipe_app/pages/Menu/menu_page.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/widgets/add_ingredients.dart';
import 'package:uuid/uuid.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInit());
  bool isOpen = false;

  File? image;
  Future pickImageFromGalery(ctx) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
      );
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
    } on Exception catch (e) {
      log('Failed to pick image: $e');
    }
    emit(imagePick(image));
    Navigator.of(ctx).pop();
  }

  clearItems(context) {
    emit(imagePick(null));
    emit(
      AcceptCount(0),
    );
    emit(
      AcceptTime(0),
    );
    ls = [];
    emit(addItemState(ls));
    emit(imagePick(null));

    Navigator.of(context).pop();
  }

  Future pickImageFromCamera(ctx) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
      );

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

  acceptCount(ctx, int count) {
    emit(
      AcceptCount(count),
    );

    return Container(
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20).r,
          topRight: const Radius.circular(20).r,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$count  ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: "Lora",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                translation(ctx).accept,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: "Lora",
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  cookTime(BuildContext context) {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    ).then(
      (TimeOfDay? value) {
        if (value != null) {
          emit(
            AcceptTime(
              value.format(context),
            ),
          );
        }
      },
    );
  }

  List<IngredientModel> ls = [];
  addItem(ctx, String? uuid) {
    TextEditingController textController = TextEditingController();
    TextEditingController quantController = TextEditingController();
    ls.add(
      IngredientModel(
        uuid: uuid!,
        textController: textController,
        quantController: quantController,
        widget: IngredientsWidget(
          controllerName: textController,
          controllerQuant: quantController,
          key: ValueKey<String>(uuid),
          uuid: uuid,
          clear: true,
        ),
      ),
    );
    emit(addItemState(ls));
  }

  removeItem(ctx, String? uuid) {
    ls.removeWhere((element) => element.uuid == uuid!);

    emit(addItemState(ls));
    log('removed uuid:  ${uuid.toString()}');
  }

  List<String> ingredients = [];
  String? ingredientsString;
  bool isPosted = false;
  bool load = false;
  postRecipe(ctx, head, serves, cookTime, bodyText, photo, allIngredients,
      categorie) async {
    load = true;
    emit(loadingg(load));
    recipeModel recipe = recipeModel(
      cookTime: cookTime,
      head: head,
      categorie: categorie,
      serves: serves,
      userId: FirebaseAuth.instance.currentUser!.uid.toString(),
      id: const Uuid().v1().toString(),
      text: bodyText,
      items: allIngredients,
    );

    await FireDatabaseService.SaveRecipeToCollection(
        recipe: recipe, image: photo);

    log('Saved');
    isPosted = true;
    emit(
      successPost(isPosted),
    );
    isPosted = false;
    emit(imagePick(null));
    emit(
      AcceptCount(0),
    );
    emit(
      AcceptTime(0),
    );
    ls = [];
    emit(addItemState(ls));
    emit(imagePick(null));
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MenuPage(),
        ),
        (route) => false);
    load = false;
    // emit(
    //   successPost(isPosted),
    // );

    //emit(loadingg(load));
  }
}
