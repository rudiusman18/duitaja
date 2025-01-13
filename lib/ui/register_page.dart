import 'package:duidku/cubit/auth_cubit.dart';
import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameTextField = TextEditingController(text: "");
  TextEditingController emailTextField = TextEditingController(text: "");
  TextEditingController passwordTextField = TextEditingController(text: "");
  TextEditingController confirmPasswordTextField =
      TextEditingController(text: "");
  TextEditingController phoneTextField = TextEditingController(text: "");
  TextEditingController companyNameTextField = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Widget generateTextFormField({
      required String title,
      required TextEditingController controller,
      TextInputType inputType = TextInputType.text,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: inter.copyWith(
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            keyboardType: inputType,
            controller: controller,
            obscureText:
                title.toLowerCase().contains("password") ? true : false,
            decoration: InputDecoration(
              hintText: title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      );
    }

    Widget form() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daftar",
              style: inter.copyWith(
                fontWeight: semiBold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            generateTextFormField(
              title: "Nama",
              controller: nameTextField,
            ),
            const SizedBox(
              height: 36,
            ),
            generateTextFormField(
              title: "No Hp",
              controller: phoneTextField,
              inputType: TextInputType.phone,
            ),
            const SizedBox(
              height: 36,
            ),
            generateTextFormField(
              title: "email",
              controller: emailTextField,
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 36,
            ),
            generateTextFormField(
              title: "Nama Perusahaan",
              controller: companyNameTextField,
            ),
            const SizedBox(
              height: 36,
            ),
            generateTextFormField(
              title: "Password",
              controller: passwordTextField,
            ),
            const SizedBox(
              height: 36,
            ),
            generateTextFormField(
              title: "Konfirmasi Password",
              controller: confirmPasswordTextField,
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      if (passwordTextField.text ==
                          confirmPasswordTextField.text) {
                        context.read<AuthCubit>().register(
                              name: nameTextField.text,
                              phoneNumber: phoneTextField.text,
                              email: emailTextField.text,
                              companyName: companyNameTextField.text,
                              password: passwordTextField.text,
                            );
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Password tidak cocok",
                              style: inter,
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(
                              seconds: 5,
                            ),
                          ),
                        );
                      }
                    },
                    child: context.read<AuthCubit>().state is AuthLoading
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(
                            "Daftar",
                            style: inter.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Sudah punya akun?",
                  style: inter.copyWith(
                    fontWeight: medium,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  child: Text(
                    " Masuk disini",
                    style: inter.copyWith(
                      fontWeight: medium,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
          ],
        ),
      );
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, registerState) {
        if (registerState is RegisterSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Akun Berhasil Didaftarkan",
                style: inter,
              ),
              backgroundColor: Colors.green,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
          Navigator.pushNamed(context, "/");
        } else if (registerState is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                registerState.error,
                style: inter,
              ),
              backgroundColor: Colors.red,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      builder: (context, loginState) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 83,
                    vertical: 40,
                  ),
                  child: Image.asset(
                    'assets/app logo.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                form(),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
