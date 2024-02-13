import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/transaction_controller.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionController controller = Get.put(TransactionController());
    return Scaffold(
      backgroundColor: const Color(0xff4db6e7),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 160, 206),
        elevation: 2,
        title: "All transaction".text.white.bold.make(),
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !controller.loadingMore.value) {
            // Fetch more data when the user reaches the end of the list
            controller.fetchMoreData();
            log("fetching more data");
          }
          return false;
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            20.heightBox,
            Obx(
              () => controller.transactionList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            60.heightBox,
                            Text(
                              "You Don't have any transaction history",
                              style: TextStyle(
                                  fontSize: context.screenWidth * .06,
                                  fontWeight: FontWeight.w500),
                            ),
                            Image.asset(
                              'assets/images/empty.png',
                              width: context.screenWidth * .7,
                            )
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.transactionList.length,
                      itemBuilder: (context, index) {
                        var questionData =
                            controller.transactionList[index].data();
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: EdgeInsets.only(
                            left: context.screenWidth * .05,
                            right: context.screenWidth * .05,
                            bottom: context.screenWidth * .04,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              )
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      actionsPadding: const EdgeInsets.all(0.0),
                                      actions: [
                                        Container(
                                          height: context.screenHeight * .6,
                                          width: context.screenWidth * .8,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 90, 90, 90),
                                                blurRadius: 10,
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height:
                                                    context.screenHeight * .2,
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 89, 215, 247),
                                                      Color(0xff3777c8),
                                                    ],
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.outbox_outlined,
                                                      color: Colors.white,
                                                      size: 65,
                                                    ),
                                                    "${questionData['type']}"
                                                        .text
                                                        .white
                                                        .size(25)
                                                        .make()
                                                  ],
                                                ),
                                              ),
                                              10.heightBox,
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  "Account No "
                                                      .text
                                                      .size(18)
                                                      .make(),
                                                  "${questionData['transactionNumber'] ?? ""}"
                                                      .text
                                                      .make(),
                                                  8.heightBox,
                                                  "Amount".text.size(18).make(),
                                                  "${questionData['rechargeAmount']}"
                                                      .numCurrency
                                                      .text
                                                      .make(),
                                                  8.heightBox,
                                                  "Transaction ID"
                                                      .text
                                                      .size(18)
                                                      .make(),
                                                  "${questionData['timestamp']}"
                                                      .text
                                                      .make(),
                                                  8.heightBox,
                                                  "Time and Date"
                                                      .text
                                                      .size(18)
                                                      .make(),
                                                  "${questionData['time']}"
                                                      .text
                                                      .make(),
                                                  8.heightBox,
                                                  "Status".text.size(18).make(),
                                                  "${questionData['status']}"
                                                      .text
                                                      .size(16)
                                                      .semiBold
                                                      .make(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ]);
                                },
                              );
                            },
                            subtitle: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Trans ID: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: context.screenWidth * .012,
                                          ),
                                          Text(
                                            "${questionData['timestamp']}",
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Amount: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: context.screenWidth * .012,
                                          ),
                                          Text(
                                            "${questionData['rechargeAmount']}",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            title: Row(
                              children: [
                                const Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${questionData['type']}",
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Obx(
              () => Center(
                child: controller.loadingMore.value
                    ? const CircularProgressIndicator()
                    : null,
              ),
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
