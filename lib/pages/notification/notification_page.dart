import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/search%20Page/searchCubit.dart';
import 'package:recipe_app/blocs/search%20Page/searchState.dart';
import 'package:recipe_app/pages/On%20open/profile_open.dart';

String username = '';
TextEditingController controller = TextEditingController();

class SearchPerson extends StatelessWidget {
  const SearchPerson({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SEARCH USERS'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, searchState) {
        if (searchState is searched) {
          username = searchState.user;
        }

        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: size.width / 0.7.w,
              height: size.height / 17.h,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  border: Border.all(width: 1, color: Colors.orange),
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: controller,
                onChanged: (user) {
                  username = user;
                  BlocProvider.of<SearchCubit>(context).userSearch(username);
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 13),
                  hintText: 'Search users',
                  isDense: false,
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: snapshots.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final data = snapshots.data!.docs[index]
                                          .data() as Map<String, dynamic>;

                                      if (username.isEmpty) {
                                        return allUsers(context, data);
                                      }
                                      if (data['username']
                                          .toString()
                                          .toLowerCase()
                                          .startsWith(username
                                              .toLowerCase()
                                              .toString())) {
                                        return allUsers(context, data);
                                      }
                                      return const SizedBox();
                                    }),
                              ]),
                        );
                }),
          ],
        );
      }),
    );
  }
}

allUsers(contex, data) {
  return GestureDetector(
      onTap: () {
        Navigator.of(contex).push(MaterialPageRoute(
          builder: (context) => profielOnOpen(data: data),
        ));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              CircleAvatar(
                radius: 26,
                foregroundImage: NetworkImage(data['avatarImage'] ??
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                data['username'] ?? 'username',
                style: const TextStyle(color: Colors.white, fontSize: 19),
              )
            ],
          ),
        ),
      ));
}
