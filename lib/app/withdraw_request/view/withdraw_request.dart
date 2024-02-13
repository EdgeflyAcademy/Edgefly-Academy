import 'package:edgefly_academy/general/common%20widzet/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class WithdrawRequest extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final ballance;
  const WithdrawRequest({super.key, required this.ballance});

  @override
  // ignore: library_private_types_in_public_api
  _WalletRechargePageState createState() => _WalletRechargePageState();
}

class _WalletRechargePageState extends State<WithdrawRequest> {
  final TextEditingController paymentAmountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxString selectedPaymentMethod = "bKash".obs;
  final RxBool isRechargePending = false.obs;

  @override
  void initState() {
    super.initState();
    checkRechargeStatus(); // Check recharge status on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet Recharge'),
      ),
      body: Obx(() {
        if (isRechargePending.value) {
          return buildPendingStatus();
        } else {
          return buildRechargeForm();
        }
      }),
    );
  }

  void checkRechargeStatus() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userwithdraw')
        .doc(userID)
        .collection('recharge_request')
        .get();

    isRechargePending.value = querySnapshot.docs.isNotEmpty;
  }

  Widget buildPendingStatus() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/expired.png',
            scale: 5,
          ), // Replace with actual image path
          const SizedBox(height: 10),
          const Text(
            'Your last recharge request is pending...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Please keep patience.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRechargeForm() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1st section - Instructions (static, not scrollable)
                const Text(
                  'Instructions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  // ... (Your existing instruction text)
                  "Dear user, you can now withdraw request . The minimum recharge amount is TK. 100 (BDT) and the maximum amount is TK. 10,000 (BDT).",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),

                // 2nd section - Form (scrollable)
                Obx(() => DropdownButtonFormField<String>(
                      value: selectedPaymentMethod.value,
                      items: ["bKash", "Nagad", "Rocket", "Upay"]
                          .map((method) => DropdownMenuItem(
                                value: method,
                                child: Text(method),
                              ))
                          .toList(),
                      onChanged: (value) {
                        selectedPaymentMethod.value = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Choose payment method',
                      ),
                    )),
                const SizedBox(height: 10),
                TextFormField(
                  controller: paymentAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Recharge Amount',
                  ),
                  validator: (value) {
                    double amount =
                        value != "" ? double.parse(value!) : double.parse("0");
                    if (value!.isEmpty) {
                      return 'Please enter recharge amount';
                    } else if (amount < 10 || amount >= 10000) {
                      return 'Recharge amount must be between 10 to 10,000';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (double.parse(widget.ballance.toString()) >=
                  double.parse(paymentAmountController.text)) {
                rechargeWallet();
                Get.back();
              } else {
                Get.showSnackbar(const GetSnackBar(
                  title: "insufficient balance",
                  message: "You don't have enough ballance",
                  snackPosition: SnackPosition.TOP,
                  duration: Duration(seconds: 4),
                  borderRadius: 20,
                  backgroundColor: Color.fromARGB(255, 129, 129, 129),
                  margin: EdgeInsets.all(10),
                  boxShadows: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                    )
                  ],
                ));
              }
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              // Use different colors for different states if needed
              return states.contains(MaterialState.pressed)
                  ? Colors.blueAccent
                  : Colors.blue;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: const Text(
            'Submit Recharge Request',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void rechargeWallet() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      },
      barrierDismissible: false,
    );

    String userID = FirebaseAuth.instance.currentUser!.uid;
    String formattedDate =
        DateFormat('MMM d, y hh:mm a').format(DateTime.now());
    String timestamp = generateTimestamp();

    // Save the recharge request to Firestore
    await FirebaseFirestore.instance
        .collection('userwithdraw')
        .doc(timestamp)
        .set({
      'status': 'pending',
      'paymentMethod': selectedPaymentMethod.value,
      'rechargeAmount': paymentAmountController.text != ""
          ? double.parse(paymentAmountController.text)
          : double.parse("0"),
      'timestamp': timestamp,
      'type': 'withdraw',
      'time': formattedDate,
      'uid': userID,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('transaction')
          .doc(timestamp)
          .set({
        'status': 'pending',
        'paymentMethod': selectedPaymentMethod.value,
        'rechargeAmount': paymentAmountController.text != ""
            ? double.parse(paymentAmountController.text)
            : double.parse("0"),
        'timestamp': timestamp,
        'time': formattedDate,
        'type': 'withdraw',
        'uid': userID,
      });
    });

    paymentAmountController.clear();

    Get.back();
    Get.snackbar(
      'Success',
      'Recharge request submitted successfully',
      snackPosition: SnackPosition.TOP,
      shouldIconPulse: true,
      icon: Icon(Icons.check_circle_rounded, color: Colors.green[900]),
    );
  }

//   String generateTimestamp() {
//     // Implement your timestamp generation logic here
//     return DateTime.now().millisecondsSinceEpoch.toString();
//   }
}
