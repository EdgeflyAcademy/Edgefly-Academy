import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../exam/view/terms_condition.dart';
import '../controller/subject_select_controller.dart';
import 'terms_condition.dart';

class SelectSubjectChapter extends StatefulWidget {
  const SelectSubjectChapter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelectSubjectChapterState createState() => _SelectSubjectChapterState();
}

class _SelectSubjectChapterState extends State<SelectSubjectChapter> {
  final GlobalKey<FormState> formkeys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SelectSubjectController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4bb050),
        title: const Text(
          'Select Subject & Chapter',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkeys,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: context.screenWidth * .05),
                decoration: BoxDecoration(
                  color: const Color(0xff4bb050),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: context.screenHeight * .035),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: controller.validDropdownbutton,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: const Text('Select Subject'),
                        onChanged: (value) {
                          setState(() {
                            controller.selectedField2 = value!;
                          });
                        },
                        items: controller.field2Items.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        validator: controller.validDropdownbutton,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: const Text('Select Chapter'),
                        onChanged: (value) {
                          setState(() {
                            controller.selectedField3 = value!;
                          });
                        },
                        items: controller.field3Items.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: context.screenHeight * .035),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: context.screenWidth * .5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4bb050)),
                      onPressed: () async {
                        if (formkeys.currentState!.validate()) {
                          Get.to(() => TermCondition(
                                subject: controller.selectedField2,
                                chapter: controller.selectedField3,
                              ));
                        } else {
                          VxToast.show(context,
                              msg: "Please select subject and chapter first");
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  30.heightBox,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
