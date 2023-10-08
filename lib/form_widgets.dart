import 'dart:io';

import 'package:calorie_app_danika/authentication/auth.dart';
import 'package:calorie_app_danika/exercises_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';

class FormWidgetsDemo extends StatefulWidget {
  const FormWidgetsDemo({super.key});

  @override
  State<FormWidgetsDemo> createState() => _FormWidgetsDemoState();
}

class _FormWidgetsDemoState extends State<FormWidgetsDemo> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String breakfast = ' ';
  String lunch = ' ';
  String dinner = ' ';
  String snacks = ' ';
  DateTime date = DateTime.now();
  double maxValue = 0;
  double breakfastValue = 0;
  double lunchValue = 0;
  double dinnerValue = 0;
  double snackValue = 0;
  bool? brushedTeeth = false;
  bool enableFeature = false;

  final database = FirebaseDatabase.instance.ref();
  final storageRef = FirebaseStorage.instance.ref();


  late User user;
  late TextEditingController controller;
  final phoneController = TextEditingController();

  String? photoURL;

  bool showSaveButton = false;
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? _imageLunch;
  File? _imageDinner;
  late File love;

  Future<File> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/smiley_face.jpg');
    final file = File('${(await getTemporaryDirectory()).path}/smiley_face.jpg');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    love = file;
    return love;
  }

  @override
  void initState() {
    super.initState();
    getImageFileFromAssets();
  }


  _imgFromCamera() async {
    final image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    final image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  void _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Image.asset('assets/replace.jpg'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Do you want to change the current image?")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _image = null;
                Navigator.of(context).pop();
                _showPicker();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Padding buildImageContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        child: _image == null
            ? Column(
          children: [
            IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
              ),
              iconSize: 40,
              onPressed: () {
                _showPicker();
              },
            ),
            const Text('Input your amazing breakfast here!'),
          ],
        )
            : Stack(children: [
          Image.file(
            File(_image!.path),
          ),
          Positioned(
              top: 5,
              right: 0, //give the values according to your requirement
              child: MaterialButton(
                onPressed: () {
                  _showMyDialog();
                },
                color: const Color.fromRGBO(243, 222, 186, 1),
                // padding: EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.edit,
                  size: 24,
                ),
              ))
        ]),
      ),
    );
  }

  Future<String> uploadBreakfastPics() async {
    String breakfastPicUrl = "";
    final breakfastUrl = storageRef.child("Users/${user.uid}/${date.year}-${date.month}-${date.day}-breakfast.jpg");
    UploadTask uploadBreakfast = breakfastUrl.putFile(_image!);
    await uploadBreakfast.whenComplete(() async => {
      print("love: ${breakfastUrl.getDownloadURL()}"),
      breakfastPicUrl = await breakfastUrl.getDownloadURL(),
    });
    return breakfastPicUrl.toString();
  }

  Future<String> uploadLunchPics() async {
    String lunchPicUrl = "";
    final lunchUrl = storageRef.child("Users/${user.uid}/${date.year}-${date.month}-${date.day}-lunch.jpg");
    UploadTask uploadLunch = lunchUrl.putFile(_imageLunch!);
    await uploadLunch.whenComplete(() async => {
      lunchPicUrl = await lunchUrl.getDownloadURL(),
    });
    return lunchPicUrl.toString();
  }

  Future<String> uploadDinnerPics() async {
    String dinnerPicUrl = "";
    final dinnerUrl = storageRef.child("Users/${user.uid}/${date.year}-${date.month}-${date.day}-dinner.jpg");
    UploadTask uploadDinner = dinnerUrl.putFile(_imageDinner!);
    await uploadDinner.whenComplete(() async => {
      dinnerPicUrl = await dinnerUrl.getDownloadURL(),
    });
    return dinnerPicUrl;
  }

  _imgFromCameraLunch() async {
    final image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageLunch = File(image!.path);
    });
  }

  _imgFromGalleryLunch() async {
    final image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageLunch = File(image!.path);
    });
  }

  void _showPickerLunch() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGalleryLunch();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCameraLunch();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showMyDialogLunch() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Image.asset('assets/replace.jpg'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Do you want to change the current image?")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _imageLunch = null;
                Navigator.of(context).pop();
                _showPickerLunch();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Padding buildImageContainerLunch() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        child: _imageLunch == null
            ? Column(
          children: [
            IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
              ),
              iconSize: 40,
              onPressed: () {
                _showPickerLunch();
              },
            ),
            const Text('Input your delicious lunch here!'),
          ],
        )
            : Stack(children: [
          Container(
            child: Image.file(
              File(_imageLunch!.path),
            ),
          ),
          Positioned(
              top: 5,
              right: 0, //give the values according to your requirement
              child: MaterialButton(
                onPressed: () {
                  _showMyDialogLunch();
                },
                color: const Color.fromRGBO(243, 222, 186, 1),
                // padding: EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.edit,
                  size: 24,
                ),
              ))
        ]),
      ),
    );
  }

  _imgFromCameraDinner() async {
    final image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageDinner = File(image!.path);
    });
  }

  _imgFromGalleryDinner() async {
    final image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imageDinner = File(image!.path);
    });
  }

  void _showPickerDinner() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGalleryDinner();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCameraDinner();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showMyDialogDinner() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Image.asset('assets/replace.jpg'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Do you want to change the current image?")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _imageDinner = null;
                Navigator.of(context).pop();
                _showPickerDinner();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Padding buildImageContainerDinner() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        child: _imageDinner == null
            ? Column(
          children: [
            IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
              ),
              iconSize: 40,
              onPressed: () {
                _showPickerDinner();
              },
            ),
            const Text('Input Your lovely dinner here!'),
          ],
        )
            : Stack(children: [
          Container(
            child: Image.file(
              File(_imageDinner!.path),
            ),
          ),
          Positioned(
              top: 5,
              right: 0, //give the values according to your requirement
              child: MaterialButton(
                onPressed: () {
                  _showMyDialogDinner();
                },
                color: const Color.fromRGBO(243, 222, 186, 1),
                // padding: EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.edit,
                  size: 24,
                ),
              ))
        ]),
      ),
    );
  }

  Future updateYourDay() async {
    // ignore: use_build_context_synchronously
    ScaffoldSnackbar.of(context).show('Your Day has been updated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Log'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        _FormDatePicker(
                          date: date,
                          onChanged: (value) {
                            setState(() {
                              date = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter what you ate for breakfast...',
                            labelText: 'Breakfast',
                          ),
                          onChanged: (value) {
                            breakfast = value;
                          },
                          maxLines: 5,
                        ),
                        buildImageContainer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                hintText: 'Enter the amount of calories you ate for breakfast...',
                                labelText: 'Calorie Amount',
                              ),
                              onChanged: (value) {
                                breakfastValue = double.parse(value);
                              },
                              maxLines: 1,
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter what you ate for lunch...',
                            labelText: 'Lunch',
                          ),
                          onChanged: (value) {
                            lunch = value;
                          },
                          maxLines: 5,
                        ),
                        buildImageContainerLunch(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                hintText: 'Enter the amount of calories you ate for lunch...',
                                labelText: 'Calorie Amount',
                              ),
                              onChanged: (value) {
                                breakfastValue = double.parse(value);
                              },
                              maxLines: 1,
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter what you ate for dinner...',
                            labelText: 'Dinner',
                          ),
                          onChanged: (value) {
                            dinner = value;
                          },
                          maxLines: 5,
                        ),
                        buildImageContainerDinner(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                hintText: 'Enter the amount of calories you ate for dinner...',
                                labelText: 'Calorie Amount',
                              ),
                              onChanged: (value) {
                                breakfastValue = double.parse(value);
                              },
                              maxLines: 1,
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ExercisesLogPage(date: date, breakfastInfo: breakfast, breakfastCalories: breakfastValue, lunchInfo: lunch, lunchCalories: lunchValue, dinnerInfo: dinner, dinnerCalories: dinnerValue, breakfastImage: _image ?? love, lunchImage: _imageLunch ?? love, dinnerImage: _imageDinner ?? love),
                                ),
                              );
                            },
                            child: const Text('Log Your Health Results')
                        )
                      ].expand(
                            (widget) => [
                          widget,
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        TextButton(
          child: const Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
