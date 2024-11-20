import 'dart:io';
import 'dart:math';
import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:expense_tracker/screen/add_expense/blocs/income_bloc/add_income/add_income_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import '../user/settings/AddUserIncome.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

final userNameController = TextEditingController();

class _HeaderState extends State<Header> {
  File? _selectedImage;
  var userBox = Hive.box('user');
  String userName = 'Save your name';

  void _onImageSelected(File image) async {
    setState(() {
      _selectedImage = image;
    });

    // Open the Hive box and save the image path
    var box = await Hive.openBox('user');
    await box.put('imagePath', image.path);
  }


  @override
  void initState() {
    // TODO: implement initState
    fetchUserName();
    super.initState();
  }

  Future<void> fetchUserName() async {
    // Open the box (if not opened already)
    var box = await Hive.openBox('user');

    // Retrieve the userName field from the box
    String? userNames = box.get('userName');
    String? imagePath = box.get('imagePath'); // Retrieve saved image path

    setState(() {
      userName = userNames ?? 'Save your name'; // Handle null if no name saved
      if (imagePath != null) {
        _selectedImage = File(imagePath); // If image path exists, load it
      }
    });
    print('The User name is $userName');
    print('The saved image path is $imagePath');
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to ImageUploadWidget when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => imageUploadWidget(
                      onImageSelected: _onImageSelected,
                      context: context,
                    ),
                  ),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow[700],
                ),
                child: _selectedImage == null
                    ? const Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.camera_alt,
                        color: Colors.white), // Default icon
                    Icon(CupertinoIcons.person_fill,
                        color: Colors.yellow), // Background icon
                  ],
                )
                    : ClipOval(
                  child: Image.file(
                    _selectedImage!, // Display the selected image
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ), // Display selected image
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _saveName(context);
                  },
                  child: Text(
                    userName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) =>
                            AddIncomeBloc(FirebaseExpenseRepo())),
                  ],
                  child: const AddYourIncome(),
                ),
              ),
            );
          },
          icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.tertiary,
                  ], transform: const GradientRotation(pi / 4))),
              child: const Icon(
                CupertinoIcons.add,
              )),
        ),
      ],
    );

  }

  Future<void> _saveName(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Save Name'),
          content: TextField(
            controller: userNameController,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(CupertinoIcons.profile_circled),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              hintText: 'Enter your name',
            ),
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            // Save Button
            TextButton(
              onPressed: () async {
                // Open the Hive box named 'user'
                final box = await Hive.openBox('user');

                // Save the userName to the box
                await box.put('userName', userNameController.text);

                // Retrieve the saved name
                final savedName = box.get('userName') ?? '';

                // Update the state to reflect the new name
                setState(() {
                  userName = savedName;
                  userNameController.clear();
                });

                // Close the dialog
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

///name store

// Function-based image upload widget
Widget imageUploadWidget(
    {required Function(File) onImageSelected, required BuildContext context}) {
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // Pass the selected image back to the previous screen
      Navigator.pop(context);
      onImageSelected(File(pickedFile.path));
    }
  }

  // Function to show the popup to select between Camera or Gallery
  void showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          title: const Text("Choose Image Source",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera, color: Colors.blue),
                title: const Text("Camera", style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.green),
                title: const Text("Gallery", style: TextStyle(fontSize: 16)),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Ensure the build method always returns a Widget.
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => showImageSourceDialog(context), // Show dialog on tap
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary,
              ]), // Change color for a more polished look
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.green,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(CupertinoIcons.photo_camera,
                color: Colors.white, size: 200), // Professional icon
          ),
        ),
      ],
    ),
  );
}
