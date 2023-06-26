import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swami_admin_web/constants/color_constant.dart';
import 'package:swami_admin_web/constants/firebase_controller.dart';
import 'package:swami_admin_web/utilities/buttons.dart';
import 'package:swami_admin_web/utilities/text_field.dart';

import '../../../../constants/sizeConstant.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  FireController fireController = FireController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Obx(() {
      return Form(
        key: controller.formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue.shade100,
            title:  Row(
              children: [
                Text('Swaminarayn Admin',style: TextStyle(fontWeight: FontWeight.bold,color: appTheme.primaryTheme, shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 8.0,
                    color: Colors.grey,
                  ),
                ],),),
              ],
            ),

            elevation: 0,
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
                ClipRRect(
                  // Clip it cleanly.
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.white.withOpacity(0.9),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MySize.getHeight(500),
                            height: MySize.getHeight(300),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(

                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          borderRadius: const BorderRadius.all(

                                            const Radius.circular(10.0),
                                          ),
                                        ),
                                        filled: true,
                                        focusColor: Colors.black,

                                        hintStyle: TextStyle(color: Colors.grey[800]),
                                        hintText: "Select  Type",
                                        fillColor: Colors.blue[100]),
                                    value: controller.dropdownValue.value,
                                    items: <String>['post', 'dailyThought']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      );
                                    }).toList(),
                                    // Step 5.
                                    onChanged: (String? newValue) {
                                      controller.dropdownValue.value =
                                          newValue!;
                                    },
                                  ),
                                  Spacing.height(20),
                                  getTextField(
                                    hintText: 'VideoLink',
                                    textEditingController:
                                        controller.mediaLinkController.value,
                                    validation: (value) {
                                      if (isNullEmptyOrFalse(value)) {
                                        return "Please enter mediaLink";
                                      } else {
                                        return controller.hasValidUrl(controller
                                            .mediaLinkController.value.text);
                                      }
                                    },
                                  ),
                                  Spacing.height(20),
                                  getTextField(
                                    hintText: 'ThumbnailLink',
                                    textEditingController: controller
                                        .videoThumbnaiController.value,
                                    validation: (value) {
                                      if (isNullEmptyOrFalse(value)) {
                                        return null;
                                      } else {
                                        return controller.hasValidUrl(controller
                                            .videoThumbnaiController
                                            .value
                                            .text);
                                      }
                                    },
                                  ),
                                  Spacing.height(20),
                                  InkWell(
                                    onTap: ()async {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                     await   fireController.addData(context: context,
                                            isSelected:
                                            controller.dropdownValue.value,
                                            mediaLink: controller
                                                .mediaLinkController.value.text,
                                            videoThumbnail: controller
                                                .videoThumbnaiController
                                                .value
                                                .text);

                                     controller
                                         .mediaLinkController.value.clear();
                                     controller
                                         .videoThumbnaiController
                                         .value.clear();


                                      }

                                    },
                                    child: getButton(
                                      title: 'Submit',
                                    ),
                                  ),

                                  // GestureDetector(
                                  //   onTap: (){
                                  //     controller.pickVideo();
                                  //
                                  //   },
                                  //     child: Container(height: 50,width: 50,color: Colors.blue,))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
