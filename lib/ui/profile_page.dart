import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Widget profilePicture() {
      return Container(
        alignment: Alignment.bottomCenter,
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
            border: Border.all(
              color: primaryColor,
            ),
            image: const DecorationImage(
              image: AssetImage(
                'assets/default picture.png',
              ),
              fit: BoxFit.contain,
            )),
        child: Column(
          children: [
            Container(
              width: 100,
              color: greyColor1,
              child: Text(
                "data",
                style: inter.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Profil",
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
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          profilePicture(),
        ],
      ),
    );
  }
}
