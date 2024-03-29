import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/search%20Page/searchCubit.dart';
import 'package:recipe_app/blocs/search%20Page/searchState.dart';
import 'package:recipe_app/pages/On%20open/profile_open.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

String username = '';
TextEditingController controller = TextEditingController();

class SearchPerson extends StatelessWidget {
  SearchPerson({super.key});
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.orange,
        // AppBar qismi...1
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(translation(context).searchUsers,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16.sp,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.bold,
                  )),
          centerTitle: true,
          elevation: 0,
        ),
        // Search Page qismi...!
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, searchState) {
            if (searchState is searched) {
              username = searchState.user;
            }

            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40).r,
                  topRight: const Radius.circular(40).r,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: SizedBox(
                      child: Container(
                        height: size.height * 0.06,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.03),
                          border: Border.all(
                            width: 1.5.w,
                            color: Colors.orange,
                          ),
                          borderRadius: BorderRadius.circular(25).r,
                        ),
                        child: TextField(
                          textAlign: TextAlign.start,
                          maxLength: 30,
                          autocorrect: false,
                          enableSuggestions: false,
                          controller: controller,
                          focusNode: focusNode,
                          onChanged: (user) {
                            username = user;
                            BlocProvider.of<SearchCubit>(context)
                                .userSearch(username);
                          },
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: "Lora",
                                  ),
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: translation(context).searchUsers,
                            hintStyle: TextStyle(
                              color: Colors.orange.shade500,
                              fontSize: 14.sp,
                              fontFamily: "Lora",
                            ),
                            isDense: false,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.orange.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState ==
                              ConnectionState.waiting)
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.orange,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: snapshots.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        final data = snapshots.data!.docs[index]
                                            .data() as Map<String, dynamic>;

                                        if (username.isEmpty) {
                                          return allUsers(
                                            context,
                                            data,
                                          );
                                        }
                                        if (data['username']
                                            .toString()
                                            .toLowerCase()
                                            .startsWith(
                                              username.toLowerCase().toString(),
                                            )) {
                                          return allUsers(context, data);
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Search Users qismi...!
allUsers(
  contex,
  data,
) {
  return GestureDetector(
    onTap: () {
      Navigator.of(contex).push(
        MaterialPageRoute(
          builder: (context) => profielOnOpen(data: data),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.w,
            color: Colors.grey.shade200,
          ),
          color: Theme.of(contex).splashColor,
          borderRadius: BorderRadius.circular(25).r,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 5.w,
            ),
            CircleAvatar(
              radius: 20.r,
              foregroundImage: CachedNetworkImageProvider(data['avatarImage'] ??
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(data['username'] ?? 'username',
                  style: Theme.of(contex).textTheme.titleSmall!.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lora",
                      )),
            ),
          ],
        ),
      ),
    ),
  );
}
