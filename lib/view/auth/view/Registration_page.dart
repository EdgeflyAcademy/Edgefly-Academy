// ignore_for_file: file_names, use_build_context_synchronously
import 'package:edgefly_academy/view/auth/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../home_screen/home_screen/home.dart';
import '../../widgets/loading_indicator.dart';
import '../component/coustom_textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static String verify = "";

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool? isCheck = false;
  GlobalKey buttonKey = GlobalKey();
  String selectedValue = "ssc";
  @override
  Widget build(BuildContext context) {
    SignupController controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Registration".text.color(Colors.black87).make(),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.formkey,
            child: Column(
              children: [
                coustomtextfield(
                  controller: controller.namecontroller,
                  hint: "Enter your full name",
                  title: "Full Name",
                  isPass: false,
                  validator: controller.validname,
                ),
                coustomtextfield(
                  controller: controller.emailcontroller,
                  hint: "Enter your Email",
                  title: "Email",
                  isPass: false,
                  validator: controller.validateemail,
                ),
                coustomtextfield(
                    controller: controller.phonecontroller,
                    hint: "Enter your phone",
                    title: "phone",
                    isPass: false,
                    validator: controller.validPhone),
                coustomtextfield(
                  controller: controller.passcontroller,
                  hint: "********",
                  title: "Password",
                  isPass: true,
                  validator: controller.validpass,
                ),
                coustomtextfield(
                  hint: "********",
                  title: "Confirm Password",
                  isPass: true,
                  validator: controller.validpass,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: "Category"
                        .text
                        .color(const Color(0xFF134668))
                        .size(18)
                        .make()),
                GestureDetector(
                  onTapDown: (details) {
                    // controller.showDropdownMenu(
                    //   context,
                    // );
                  },
                  child: TextFormField(
                    validator: controller.validfield,
                    controller: controller.categorycontroller,
                    readOnly: true,
                    onTap: () {},
                    decoration: InputDecoration(
                      hintText: "Select a category",
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      fillColor: Colors.black12,
                      prefixIcon: const Icon(Icons.more_vert),
                      suffixIcon: DropdownButton(
                        items: const [
                          DropdownMenuItem(value: 'ssc', child: Text('SSC')),
                          DropdownMenuItem(value: 'hsc', child: Text('HSC')),
                          DropdownMenuItem(
                              value: 'admition', child: Text('Admition')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                            controller.selectedValue = value;
                            controller.categorycontroller.text = value;
                          });
                        },
                        iconSize: 50,
                      ),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide()),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF134668))),
                    ),
                  ),
                ),
                coustomtextfield(
                  controller: controller.institutioncontroller,
                  hint: "Dhaka International University",
                  title: "Institution",
                  isPass: false,
                  validator: controller.validfield,
                ),
                10.heightBox,
                Row(
                  children: [
                    Checkbox(
                      activeColor: const Color(0xFF134668),
                      checkColor: Colors.white,
                      value: isCheck,
                      onChanged: (newvalue) {
                        setState(() {
                          isCheck = newvalue;
                        });
                      },
                    ),
                    "Terms & Condition".text.make()
                  ],
                ),
                10.heightBox,
                SizedBox(
                  width: context.screenWidth * .7,
                  height: 55,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isCheck == true
                            ? const Color(0xFF134668)
                            : const Color.fromARGB(255, 86, 158, 206),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        if (isCheck = false) {
                          VxToast.show(context,
                              msg: "make sure to agree our terms & conditon");
                        } else if (selectedValue != null) {
                          await controller.signupUser(context);
                          if (controller.userCredential != null) {
                            Get.offAll(() => const Home());
                          }
                        } else {}
                      },
                      child: controller.isLoading.value
                          ? const LoadingIndicator()
                          : "Registration".text.white.make(),
                    ),
                  ),
                ),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
