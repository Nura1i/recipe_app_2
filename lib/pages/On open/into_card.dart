import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class openedCard extends StatefulWidget {
  final carrd;

  const openedCard(this.carrd, {super.key});

  @override
  State<openedCard> createState() => _openedCardState();
}

class _openedCardState extends State<openedCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            shadowColor: Colors.orange,
            backgroundColor: Colors.orange,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            elevation: 10,
          ),
        ),
        body: _intoCard()

        // BlocBuilder<SavedCubit, SavedState>(
        //     builder: (BuildContext context, SavedState state) {
        //   BlocBuilder<LikedCubit, LikedState>(
        //       builder: (BuildContext context, LikedState state) {
        //     if (state is LikedSuccess) {
        //       Liked = state.success;
        //     }
        //     return _intoCard(Saved, Liked);
        //   });
        //   if (state is SavedSuccess) {
        //     Saved = state.success;
        //     _intoCard(Saved, Liked);
        //   }
        //   return _intoCard(Saved, Liked);
        // }),
        );
  }

  // Widget like<bool>(bool liked) {
  //   return liked;
  // }

  Widget _intoCard() {
    return SafeArea(
      child: Theme(
        data: Theme.of(context).copyWith(
            scrollbarTheme: ScrollbarThemeData(
                thumbColor: MaterialStateProperty.all(Colors.orange))),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 20, left: 20, right: 10),
                  child: Text(
                    widget.carrd.header,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Hero(
                    tag: '${int.parse(widget.carrd!.id!)}',
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.27,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  widget.carrd!.photo!),
                              fit: BoxFit.cover)),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 29,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '1391',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 10, bottom: 10),
                  child: Text(
                    widget.carrd.about,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
