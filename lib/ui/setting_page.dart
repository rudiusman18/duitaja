// ignore_for_file: equal_elements_in_set

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:duidku/cubit/auth_cubit.dart';
import 'package:duidku/shared/modal_alert.dart';
import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int selectedIndex = 0;

  // Employee
  TextEditingController employeeNameTextField = TextEditingController(text: "");
  TextEditingController employeeIDTextField = TextEditingController(text: "");
  TextEditingController passwordTextField = TextEditingController(text: "");
  List<CameraDescription>? cameras;

  // Image from temp directory
  File? croppedFile;

  File? _selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    initCamera();
    super.initState();
  }

  void initCamera() async {
    cameras = await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    // Employee
    Widget generateTextField({
      required TextEditingController controller,
      required String hintText,
      required bool isObscureText,
    }) {
      return TextFormField(
        controller: controller,
        obscureText: isObscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
      );
    }

    Future modalDialog() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Tambah Pengguna",
                        style: inter.copyWith(
                          fontWeight: semiBold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 31,
                ),
                Text(
                  "Nama",
                  style: inter.copyWith(
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                generateTextField(
                  controller: employeeNameTextField,
                  hintText: "Masukkan Nama",
                  isObscureText: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "ID Karyawan",
                  style: inter.copyWith(
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: generateTextField(
                        controller: employeeIDTextField,
                        hintText: "Masukkan ID Karyawan",
                        isObscureText: true,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Generate",
                        style: inter,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Password",
                  style: inter.copyWith(
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                generateTextField(
                  controller: passwordTextField,
                  hintText: "Masukkan Password",
                  isObscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Simpan",
                      style: inter,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Future<void> _pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    }
    // End of Employee

    Future<void> _showImagePickerDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Image Source'),
            content: Text('Choose an option to pick an image.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                child: Text('Gallery'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    }

    Widget profilePicture() {
      return GestureDetector(
        onTap: () async {
          _showImagePickerDialog(context);
        },
        child: Center(
          child: ClipOval(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular profile image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: _selectedImage != null
                        ? DecorationImage(image: FileImage(_selectedImage!))
                        : const DecorationImage(
                            image: AssetImage(
                              'assets/default picture.png',
                            ),
                          ),
                  ),
                ),
                // Camera icon overlay
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(90),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget settingItem({
      required String name,
      required int index,
      required bool isSelected,
    }) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            name,
            style: inter.copyWith(
              color: isSelected ? Colors.black : greyColor2,
            ),
          ),
        ),
      );
    }

    Widget settings() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [
              settingItem(
                name: "Informasi Pengguna",
                index: 0,
                isSelected: selectedIndex == 0 ? true : false,
              ),
              const SizedBox(
                width: 20,
              ),
              settingItem(
                name: "Informasi Usaha",
                index: 1,
                isSelected: selectedIndex == 1 ? true : false,
              ),
              const SizedBox(
                width: 20,
              ),
              settingItem(
                name: "karyawan",
                index: 2,
                isSelected: selectedIndex == 2 ? true : false,
              ),
              const SizedBox(
                width: 20,
              ),
              settingItem(
                name: "Log Aktivitas",
                index: 3,
                isSelected: selectedIndex == 3 ? true : false,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Pengaturan",
          style: inter.copyWith(
            fontWeight: medium,
            fontSize: 20,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            size: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          profilePicture(),
          const SizedBox(
            height: 47,
          ),
          settings(),
          if (selectedIndex == 0) ...{
            Expanded(
              child: ListView(
                children: const [
                  UserInfo(),
                ],
              ),
            ),
          } else if (selectedIndex == 1) ...{
            Expanded(
              child: ListView(
                children: const [
                  BusinessInfo(),
                ],
              ),
            ),
          } else if (selectedIndex == 2) ...{
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Karyawan : 14",
                        style: inter.copyWith(
                          color: greyColor2,
                          fontWeight: semiBold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          modalDialog();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nama",
                        style: inter.copyWith(
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        "Status",
                        style: inter.copyWith(
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: const [
                  Employee(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Simpan Data Karyawan",
                  style: inter,
                ),
              ),
            ),
          } else ...{
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Aktivitas Terbaru",
                    style: inter.copyWith(
                      color: greyColor2,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  ActivityLog(),
                ],
              ),
            ),
          }
        ],
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController nameTextField = TextEditingController(text: "");
  TextEditingController emailTextField = TextEditingController(text: "");
  TextEditingController passwordTextField = TextEditingController(text: "");
  TextEditingController confirmPasswordTextField =
      TextEditingController(text: "");
  TextEditingController phoneNumberTextField = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    nameTextField.text =
        "${context.read<AuthCubit>().profileModel.payload?.profile?.name}";
    emailTextField.text =
        "${context.read<AuthCubit>().profileModel.payload?.profile?.email}";
    phoneNumberTextField.text =
        "${context.read<AuthCubit>().profileModel.payload?.profile?.phone}";

    Widget generateTextField({
      required TextEditingController controller,
      required String hintText,
      required bool isObscureText,
    }) {
      return TextFormField(
        controller: controller,
        obscureText: isObscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
      );
    }

    Future modalDialog({
      required String title,
    }) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Ganti $title",
                        style: inter.copyWith(
                          fontWeight: semiBold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 31,
                ),
                if (title.toLowerCase().contains("password")) ...{
                  Text(
                    "Password Lama",
                    style: inter.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  generateTextField(
                    controller: passwordTextField,
                    hintText: "Masukkan Password Lama",
                    isObscureText: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Password Lama",
                    style: inter.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  generateTextField(
                    controller: confirmPasswordTextField,
                    hintText: "Masukkan Password Lama",
                    isObscureText: true,
                  ),
                } else if (title.toLowerCase().contains("nomor")) ...{
                  Text(
                    "Nomor Baru",
                    style: inter.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  generateTextField(
                    controller: phoneNumberTextField,
                    hintText: "Masukkan Nomor Baru",
                    isObscureText: false,
                  ),
                },
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Simpan",
                      style: inter,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget generateuserInfoItem({
      required String title,
      required String value,
      required bool isPassword,
      required bool isChangable,
    }) {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: inter.copyWith(
                    fontWeight: semiBold,
                    color: greyColor2,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  isPassword ? value.replaceAll(RegExp("."), "*") : value,
                  style: inter,
                ),
              ],
            ),
          ),
          isChangable
              ? GestureDetector(
                  onTap: () {
                    modalDialog(title: title);
                  },
                  child: const Icon(
                    Icons.edit,
                  ),
                )
              : const SizedBox(),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          generateuserInfoItem(
            title: "Nama",
            value: nameTextField.text,
            isPassword: false,
            isChangable: false,
          ),
          const SizedBox(
            height: 32,
          ),
          generateuserInfoItem(
            title: "Email",
            value: emailTextField.text,
            isPassword: false,
            isChangable: false,
          ),
          const SizedBox(
            height: 32,
          ),
          generateuserInfoItem(
            title: "Password",
            value: "Ini adalah percobaan password",
            isPassword: true,
            isChangable: true,
          ),
          const SizedBox(
            height: 32,
          ),
          generateuserInfoItem(
            title: "Nomor",
            value: phoneNumberTextField.text,
            isPassword: false,
            isChangable: true,
          ),
          const SizedBox(
            height: 32,
          ),
          TextButton(
            style: TextButton.styleFrom(
              iconColor: Colors.red,
              foregroundColor: Colors.red,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ModalAlert(
                        title: "Warning",
                        message: "Anda yaking untuk keluar?",
                        completion: () {
                          context.read<AuthCubit>().logout();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (route) => false);
                        });
                  });
            },
            child: Row(
              children: [
                const Icon(
                  Icons.logout,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Keluar",
                  style: inter,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({super.key});

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  @override
  Widget build(BuildContext context) {
    Widget generateuserInfoItem({
      required String title,
      required String value,
      required bool isDropdown,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: inter.copyWith(
              fontWeight: semiBold,
              color: greyColor2,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            value,
            style: inter,
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          generateuserInfoItem(
            title: "Nama Usaha",
            value:
                "${context.read<AuthCubit>().profileModel.payload?.profile?.companyName}",
            isDropdown: false,
          ),
          const SizedBox(
            height: 32,
          ),
          generateuserInfoItem(
            title: "Jenis Usaha",
            value: "Kuliner",
            isDropdown: false,
          ),
          const SizedBox(
            height: 32,
          ),
          generateuserInfoItem(
            title: "Tanggal Didirikan",
            value: "10/03/1997",
            isDropdown: false,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    Widget generateEmployeeItem({
      required String name,
      required String status,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 0,
        ),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: greyColor400,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: inter,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: status.toLowerCase() == "aktif"
                    ? primaryColor.withAlpha(30)
                    : Colors.red,
              ),
              child: Text(
                status,
                style: inter.copyWith(
                  color: status.toLowerCase() == "aktif"
                      ? primaryColor
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          generateEmployeeItem(
            name: "Henry",
            status: "Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          generateEmployeeItem(
            name: "Henry",
            status: "Non-Aktif",
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class ActivityLog extends StatelessWidget {
  const ActivityLog({super.key});

  @override
  Widget build(BuildContext context) {
    Widget generateLogItem({
      required String name,
      required String dateTime,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: greyColor2,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: inter,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              dateTime,
              style: inter.copyWith(
                color: greyColor2,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          for (var i = 0; i < 20; i++)
            generateLogItem(
              name: "Login",
              dateTime: "05/01/2024, 05.30",
            ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

// INI TENTANG KAMERA PERCOBAAN

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras![0], ResolutionPreset.high);
    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _captureAndCropImage() async {
    if (_cameraController != null) {
      final image = await _cameraController!.takePicture();
      final imageFile = File(image.path);

      // Load the image using the image package
      final originalImage = img.decodeImage(imageFile.readAsBytesSync())!;

      // Get the dimensions for the crop
      final width = originalImage.width;
      final height = originalImage.height;

      final double circleSize = 300.0; // Circle size from the UI
      final double x = (width / 2) - (circleSize / 2);
      final double y = (height / 2) - (circleSize / 2);

      // Crop the image
      final croppedImage = img.copyCrop(
        originalImage,
        x: x.toInt(),
        y: y.toInt(),
        width: circleSize.toInt(),
        height: circleSize.toInt(),
      );

      // Save the cropped image
      final tempDir = await getTemporaryDirectory();
      final croppedFile = File('${tempDir.path}/cropped_image.png');

      croppedFile.delete(recursive: true);

      croppedFile.writeAsBytesSync(img.encodePng(croppedImage));

      print('Cropped image saved at ${croppedFile.path}');

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _isCameraInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    child: CameraPreview(_cameraController!),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                onPressed: _captureAndCropImage,
                child: Icon(Icons.camera),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
