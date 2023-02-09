import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/shared_pref/language_prefs/preferences_2.dart';

class openedCard extends StatefulWidget {
  final carrd;

  const openedCard(this.carrd, {super.key});

  @override
  State<openedCard> createState() => _openedCardState();
}

// Uzbek National Recipes Cardni ustiga bosgandagi ichki Text qismi...!
class _openedCardState extends State<openedCard> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          scrolledUnderElevation: 10,
          toolbarHeight: 50.h,
          shadowColor: Colors.orange,
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(40).r,
              bottomRight: const Radius.circular(40).r,
            ),
          ),
          title: Text(
            translation(context).milliytaom,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: _intoCard(),
    );
  }

  Widget _intoCard() {
    return Theme(
      data: Theme.of(context).copyWith(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.orange),
        ),
      ),
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Text(
                  widget.carrd.header,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Hero(
                  tag: '${int.parse(widget.carrd!.id!)}',
                  child: Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30).r,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.carrd!.photo!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15).r,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16.sp,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            '1391',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontFamily: "Lora",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Text(
                  widget.carrd.about,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lora",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50.h)
            ],
          ),
        ),
      ),
    );
  }
}
