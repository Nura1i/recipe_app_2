import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';
import 'package:recipe_app/pages/profile_page/profile_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class profielOnOpen extends StatefulWidget {
  final data;
  const profielOnOpen({super.key, this.data});

  @override
  State<profielOnOpen> createState() => _profielOnOpenState();
}

class _profielOnOpenState extends State<profielOnOpen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      // AppBar Qismi...!
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).focusColor,
            ),
          ),
          scrolledUnderElevation: 10,
          toolbarHeight: 50.h,
          shadowColor: Colors.grey.shade100,
          backgroundColor: Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(40).r,
              bottomRight: const Radius.circular(40).r,
            ),
          ),
          foregroundColor: Colors.black,
          title: Text(widget.data['username'] ?? 'username',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14.sp,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.bold,
                  )),
          centerTitle: true,
          elevation: 1,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        primary: false,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Users Avatar qismi...!
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: CircleAvatar(
                  radius: 50.r,
                  foregroundImage: CachedNetworkImageProvider(widget
                          .data['avatarImage'] ??
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
              ),
              // users Name qismi...!
              Text(widget.data['username'] ?? 'username',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 16.sp,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold,
                      )),
              // Users Bio qismi...!
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: Text(
                  widget.data['bio'] ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontFamily: "Lora",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50.h),
              // Recipes and likes qismi...!
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  counter(
                      widget.data['recepts'] != null
                          ? widget.data['recepts'].length.toString()
                          : '0',
                      translation(context).recipes,
                      //'Recipes',
                      context),
                  SizedBox(
                    width: 80.w,
                  ),
                  counter(
                    widget.data['totalLikes'] != null
                        ? widget.data['totalLikes'].length.toString()
                        : '0',
                    translation(context).likes,
                    //'Likes',
                    context,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Dvider qismi...!
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 2.h,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.white,
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 2.h,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.white,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              widget.data['recepts'] != null
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.data['recepts'].length,
                      itemBuilder: (contex, index) {
                        return Padding(
                          padding: const EdgeInsets.all(1),
                          child: showPersonsPosts(
                              widget.data['recepts'][index], widget.data),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget showPersonsPosts(dataaId, userdata) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Recipes').snapshots(),
      builder: (context, snapshots) {
        return (snapshots.connectionState == ConnectionState.waiting)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshots.data!.docs[index].data()
                      as Map<String, dynamic>;
                  if (data['id'] == dataaId) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => recipeOpen(
                              postData: data,
                              userData: userdata,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 120.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.w,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8).r,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              data['photo'],
                            ),
                          ),
                          // borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              );
      },
    );
  }
}
