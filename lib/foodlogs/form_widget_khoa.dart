// import 'dart:io';
//
// import 'package:calorie_app_danika/authentication/auth.dart';
// import 'package:calorie_app_danika/main.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart' as intl;
//
// class FormWidget extends StatefulWidget {
//   const FormWidget({super.key});
//
//   @override
//   State<FormWidget> createState() => _FormWidgetState();
// }
//
// class _FormWidgetState extends State<FormWidget> {
//   final database = FirebaseDatabase.instance.ref();
//   final storageRef = FirebaseStorage.instance.ref();
//
//
//   late User user;
//   late TextEditingController controller;
//   final phoneController = TextEditingController();
//
//   String? photoURL;
//
//   bool showSaveButton = false;
//   bool isLoading = false;
//
//   final _formKey = GlobalKey<FormState>();
//   String title = '';
//   String description = '';
//   DateTime date = DateTime.now();
//   double maxValue = 0;
//   bool? brushedTeeth = false;
//   bool enableFeature = false;
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   File? _imageLunch;
//   File? _imageDinner;
//
//   @override
//   void initState() {
//     user = auth.currentUser!;
//     controller = TextEditingController(text: user.displayName);
//
//     auth.userChanges().listen((event) {
//       if (event != null && mounted) {
//         setState(() {
//           user = event;
//         });
//       }
//     });
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     //controller.removeListener(_onNameChanged);
//     super.dispose();
//   }
//
//   void setIsLoading() {
//     setState(() {
//       isLoading = !isLoading;
//     });
//   }
//
//
//   _imgFromCamera() async {
//     final image =
//         await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
//
//     setState(() {
//       _image = File(image!.path);
//     });
//   }
//
//   _imgFromGallery() async {
//     final image =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//
//     setState(() {
//       _image = File(image!.path);
//     });
//   }
//
//   void _showPicker() {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                     leading: const Icon(Icons.photo_library),
//                     title: const Text('Photo Library'),
//                     onTap: () {
//                       _imgFromGallery();
//                       Navigator.of(context).pop();
//                     }),
//                 ListTile(
//                   leading: const Icon(Icons.photo_camera),
//                   title: const Text('Camera'),
//                   onTap: () {
//                     _imgFromCamera();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Image.asset('assets/replace.jpg'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text("Do you want to change the current image?")
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Yes'),
//               onPressed: () {
//                 _image = null;
//                 Navigator.of(context).pop();
//                 _showPicker();
//               },
//             ),
//             TextButton(
//               child: const Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Padding buildImageContainer() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: Container(
//         child: _image == null
//             ? Column(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.camera_alt_outlined,
//                     ),
//                     iconSize: 40,
//                     onPressed: () {
//                       _showPicker();
//                     },
//                   ),
//                   const Text('Input your lovely Breakfast here!'),
//                 ],
//               )
//             : Stack(children: [
//                 Image.file(
//                   File(_image!.path),
//                 ),
//                 Positioned(
//                     top: 5,
//                     right: 0, //give the values according to your requirement
//                     child: MaterialButton(
//                       onPressed: () {
//                         _showMyDialog();
//                       },
//                       color: const Color.fromRGBO(243, 222, 186, 1),
//                       // padding: EdgeInsets.all(16),
//                       shape: const CircleBorder(),
//                       child: const Icon(
//                         Icons.edit,
//                         size: 24,
//                       ),
//                     ))
//               ]),
//       ),
//     );
//   }
//
//   Future<String> uploadBreakfastPics() async {
//     String breakfastPicUrl = "";
//     final breakfastUrl = storageRef.child("Users/${user.uid}/${date.year}-${date.month}-${date.day}-breakfast.jpg");
//     UploadTask uploadBreakfast = breakfastUrl.putFile(_image!);
//     await uploadBreakfast.whenComplete(() async => {
//       print("love: ${breakfastUrl.getDownloadURL()}"),
//       breakfastPicUrl = await breakfastUrl.getDownloadURL(),
//     });
//     return breakfastPicUrl.toString();
//   }
//
//   Future<String> uploadLunchPics() async {
//     String lunchPicUrl = "";
//     final lunchUrl = storageRef.child("Users/${user.uid}/${date.year}-${date.month}-${date.day}-lunch.jpg");
//     UploadTask uploadLunch = lunchUrl.putFile(_imageLunch!);
//     await uploadLunch.whenComplete(() async => {
//       lunchPicUrl = await lunchUrl.getDownloadURL(),
//     });
//     return lunchPicUrl.toString();
//   }
//
//   Future<String> uploadDinnerPics() async {
//     String dinnerPicUrl = "";
//     final dinnerUrl = storageRef.child("Users/${user.uid}/${date.year}-${date.month}-${date.day}-dinner.jpg");
//     UploadTask uploadDinner = dinnerUrl.putFile(_imageDinner!);
//     await uploadDinner.whenComplete(() async => {
//       dinnerPicUrl = await dinnerUrl.getDownloadURL(),
//     });
//     return dinnerPicUrl;
//   }
//
//   _imgFromCameraLunch() async {
//     final image =
//         await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
//
//     setState(() {
//       _imageLunch = File(image!.path);
//     });
//   }
//
//   _imgFromGalleryLunch() async {
//     final image =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//
//     setState(() {
//       _imageLunch = File(image!.path);
//     });
//   }
//
//   void _showPickerLunch() {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: Wrap(
//                 children: <Widget>[
//                   ListTile(
//                       leading: const Icon(Icons.photo_library),
//                       title: const Text('Photo Library'),
//                       onTap: () {
//                         _imgFromGalleryLunch();
//                         Navigator.of(context).pop();
//                       }),
//                   ListTile(
//                     leading: const Icon(Icons.photo_camera),
//                     title: const Text('Camera'),
//                     onTap: () {
//                       _imgFromCameraLunch();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Future<void> _showMyDialogLunch() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Image.asset('assets/replace.jpg'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text("Do you want to change the current image?")
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Yes'),
//               onPressed: () {
//                 _imageLunch = null;
//                 Navigator.of(context).pop();
//                 _showPickerLunch();
//               },
//             ),
//             TextButton(
//               child: const Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Padding buildImageContainerLunch() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: Container(
//         child: _imageLunch == null
//             ? Column(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.camera_alt_outlined,
//                     ),
//                     iconSize: 40,
//                     onPressed: () {
//                       _showPickerLunch();
//                     },
//                   ),
//                   const Text('Input your Delicious Lunch here!'),
//                 ],
//               )
//             : Stack(children: [
//                 Container(
//                   child: Image.file(
//                     File(_imageLunch!.path),
//                   ),
//                 ),
//                 Positioned(
//                     top: 5,
//                     right: 0, //give the values according to your requirement
//                     child: MaterialButton(
//                       onPressed: () {
//                         _showMyDialogLunch();
//                       },
//                       color: const Color.fromRGBO(243, 222, 186, 1),
//                       // padding: EdgeInsets.all(16),
//                       shape: const CircleBorder(),
//                       child: const Icon(
//                         Icons.edit,
//                         size: 24,
//                       ),
//                     ))
//               ]),
//       ),
//     );
//   }
//
//   _imgFromCameraDinner() async {
//     final image =
//         await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
//
//     setState(() {
//       _imageDinner = File(image!.path);
//     });
//   }
//
//   _imgFromGalleryDinner() async {
//     final image =
//         await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//
//     setState(() {
//       _imageDinner = File(image!.path);
//     });
//   }
//
//   void _showPickerDinner() {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: Wrap(
//                 children: <Widget>[
//                   ListTile(
//                       leading: const Icon(Icons.photo_library),
//                       title: const Text('Photo Library'),
//                       onTap: () {
//                         _imgFromGalleryDinner();
//                         Navigator.of(context).pop();
//                       }),
//                   ListTile(
//                     leading: const Icon(Icons.photo_camera),
//                     title: const Text('Camera'),
//                     onTap: () {
//                       _imgFromCameraDinner();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Future<void> _showMyDialogDinner() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Image.asset('assets/replace.jpg'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text("Do you want to change the current image?")
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Yes'),
//               onPressed: () {
//                 _imageDinner = null;
//                 Navigator.of(context).pop();
//                 _showPickerDinner();
//               },
//             ),
//             TextButton(
//               child: const Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Padding buildImageContainerDinner() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: Container(
//         child: _imageDinner == null
//             ? Column(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.camera_alt_outlined,
//                     ),
//                     iconSize: 40,
//                     onPressed: () {
//                       _showPickerDinner();
//                     },
//                   ),
//                   const Text('Put Your Lovely Dinner here!'),
//                 ],
//               )
//             : Stack(children: [
//                 Container(
//                   child: Image.file(
//                     File(_imageDinner!.path),
//                   ),
//                 ),
//                 Positioned(
//                     top: 5,
//                     right: 0, //give the values according to your requirement
//                     child: MaterialButton(
//                       onPressed: () {
//                         _showMyDialogDinner();
//                       },
//                       color: const Color.fromRGBO(243, 222, 186, 1),
//                       // padding: EdgeInsets.all(16),
//                       shape: const CircleBorder(),
//                       child: const Icon(
//                         Icons.edit,
//                         size: 24,
//                       ),
//                     ))
//               ]),
//       ),
//     );
//   }
//
//   Future updateYourDay() async {
//     // ignore: use_build_context_synchronously
//     ScaffoldSnackbar.of(context).show('Your Day has been updated');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final todayFoodRef = database.child("/users/${user.uid}");
//     final healthLogRef = database.child("/healthlog");
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Form widgets'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Scrollbar(
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Card(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ...[
//                         _FormDatePicker(
//                           date: date,
//                           onChanged: (value) {
//                             setState(() {
//                               date = value;
//                             });
//                           },
//                         ),
//                         buildImageContainer(),
//                         buildImageContainerLunch(),
//                         buildImageContainerDinner(),
//                         //buildImageSuperContainer(context,3),
//                         // ElevatedButton(
//                         //     onPressed: () async {
//                         //       final todayFood = <String, dynamic> {
//                         //         "date": date.millisecondsSinceEpoch + 7.2e+7,
//                         //         "breakfast": "Cereal",
//                         //         "breakfastPicUrl": await uploadBreakfastPics(),
//                         //         "lunch": "Tacos",
//                         //         "lunchPicUrl": await uploadLunchPics(),
//                         //         "dinner": "Spaghetti",
//                         //         "dinnerPicUrl": await uploadDinnerPics(),
//                         //       };
//                         //       var key = database.push().key;
//                         //       healthLogRef
//                         //           .child(key!)
//                         //           .set(todayFood)
//                         //           .then((_) => print('Food has been posted'))
//                         //           .catchError((error) => print("You got error on $error"));
//                         //       todayFoodRef
//                         //           .child("/foodlogs/${key}")
//                         //           .set("true")
//                         //           .then((_) => print('UID of Food Log has been posted to user'))
//                         //           .catchError((error) => print("You got error on $error"));
//                         //       updateYourDay();
//                         //       },
//                         //     child: const Text("Update your Diet today!"),
//                         // ),
//                       ].expand(
//                         (widget) => [
//                           widget,
//                           const SizedBox(
//                             height: 24,
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _FormDatePicker extends StatefulWidget {
//   final DateTime date;
//   final ValueChanged<DateTime> onChanged;
//
//   const _FormDatePicker({
//     required this.date,
//     required this.onChanged,
//   });
//
//   @override
//   State<_FormDatePicker> createState() => _FormDatePickerState();
// }
//
// class _FormDatePickerState extends State<_FormDatePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               'Date',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             Text(
//               intl.DateFormat.yMd().format(widget.date),
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ],
//         ),
//         TextButton(
//           child: const Text('Edit'),
//           onPressed: () async {
//             var newDate = await showDatePicker(
//               context: context,
//               initialDate: widget.date,
//               firstDate: DateTime(1900),
//               lastDate: DateTime(2100),
//             );
//
//             // Don't change the date if the date picker returns null.
//             if (newDate == null) {
//               return;
//             }
//
//             widget.onChanged(newDate);
//           },
//         )
//       ],
//     );
//   }
// }
//
//
