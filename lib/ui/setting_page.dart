import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget profilePicture() {
      return Center(
        child: ClipOval(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Circular profile image
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
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
                      Container(
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
    nameTextField.text = "Riza Rahman";
    emailTextField.text = "rizarahman23@gmail.com";
    passwordTextField.text = "ini adalah percobaan password";
    phoneNumberTextField.text = "081234567598";

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
              ? const Icon(
                  Icons.edit,
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
            value: passwordTextField.text,
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
            value: "Warung Pak Kris",
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

class Employee extends StatelessWidget {
  const Employee({super.key});

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
