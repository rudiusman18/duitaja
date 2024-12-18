import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        children: [
          const SizedBox(
            height: 40,
          ),
          profilePicture(),
          const SizedBox(
            height: 47,
          ),
          settings(),
          Expanded(
            child: ListView(
              children: [
                if (selectedIndex == 0) ...{
                  const UserInfo()
                } else if (selectedIndex == 1) ...{
                  const BusinessInfo()
                } else if (selectedIndex == 2) ...{
                  const Employee()
                } else ...{
                  const ActivityLog()
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text("ini adalah halaman user info"),
        ),
      ],
    );
  }
}

class BusinessInfo extends StatelessWidget {
  const BusinessInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text("ini adalah halaman business info"),
        ),
      ],
    );
  }
}

class Employee extends StatelessWidget {
  const Employee({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text("ini adalah halaman employee"),
        ),
      ],
    );
  }
}

class ActivityLog extends StatelessWidget {
  const ActivityLog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text("ini adalah halaman user activity log"),
        ),
      ],
    );
  }
}
