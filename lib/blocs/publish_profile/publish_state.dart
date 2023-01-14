abstract class PublishImageState {
  List<Object> get props => [];
}

class ImageInit extends PublishImageState {
  final cropper;
  ImageInit({this.cropper});
}

class ImagePublished extends PublishImageState {
  bool? ispublished;
  ImagePublished({this.ispublished});
}

class DontImagePublished extends PublishImageState {
  bool? dontispublished;
  DontImagePublished({this.dontispublished});
}

// bool? isEnabled = true;
//   bool? isLoading = false;
//   void publish() async {
//     isEnabled = true;
//     isLoading = true;

//     try {
//       userModel usermodel11 = userModel(
//         id: FirebaseAuth.instance.currentUser!.uid,
//       );
//       file = File(image!.path);
//       final isPublished = await FireDatabaseService.createPost(
//           usermodel: usermodel11, image: file);

//       if (isPublished != null) {
//         debugPrint('PUBLISHED');
//         isLoading = false;

//  // Blocga Otqazish uchun

//        // setState(() {});


       
//       }
//       debugPrint('PUBLISHED');
//       // setState(() {});
//     } catch (e) {
//       log(e.toString());
//     }
//   }
