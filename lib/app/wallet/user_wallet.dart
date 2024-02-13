import 'package:edgefly_academy/app/wallet/view/recharge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'view/transactions.dart';
import 'widgets/wallet_list_item.dart';

class UserWallet extends StatefulWidget {
  @override
  _UserWalletState createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Wallet"),
      ),
      body: Column(
        children: [
          // Upper part
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue[300]!,
                    Colors.blue[100]!,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side row (Balance information)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Current Balance",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "1000.00",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(WalletRechargePage());
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Recharge Now",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Right side row (Number of coins, withdraw amount, last recharge amount)
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Earned Coins",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "50",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Stipend Amount",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "50.00",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Lower part with scrolling list
          const SizedBox(height: 25),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // WalletListItem(
                    //   onTap: () {},
                    //   leadingIcon: Icons.send,
                    //   title: "Request Withdraw",
                    //   trailingIcon: Icons.arrow_circle_left_rounded,
                    // ),
                    Card(
                      color: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        onTap: () {},
                        // tileColor: Colors.blue[100],
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child:
                              Image.asset("assets/icons/wallet.png", scale: 18),
                        ),
                        title: const Text("Request Withdraw"),
                        trailing: CircleAvatar(
                            backgroundColor: Colors.blue[300],
                            child: const Icon(Icons.arrow_forward_rounded)),
                        // Add more properties as needed
                      ),
                    ),

                    Card(
                      color: Colors.purple[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.to(() => TransactionScreen());
                        },
                        // tileColor: Colors.orange[100],
                        leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/icons/transactions.png",
                                scale: 18)),
                        title: const Text("Transactions"),
                        trailing: CircleAvatar(
                            backgroundColor: Colors.purple[300],
                            child: const Icon(Icons.arrow_forward_rounded)),
                      ),
                    ),

                    Card(
                      color: Colors.teal[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        // tileColor: Colors.purple[100],
                        leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/icons/stiphend.png",
                                scale: 15)),
                        title: const Text("My Stiphend"),
                        trailing: CircleAvatar(
                            backgroundColor: Colors.teal[300],
                            child: const Icon(Icons.arrow_forward_rounded)),
                      ),
                    ),

                    Card(
                      color: Colors.orange[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        // tileColor: Colors.purple[100],
                        leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/icons/coin.png",
                                scale: 20)),
                        title: const Text("My Coins"),
                        trailing: CircleAvatar(
                            backgroundColor: Colors.orange[300],
                            child: const Icon(Icons.arrow_forward_rounded)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}








/***********************************************/
// class UserWallet extends StatelessWidget {
//   final UserWalletController userController = Get.put(UserWalletController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Wallet'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(() => Text('Balance: \$${userController.balance}')),
//             ElevatedButton(
//               onPressed: () {
//                 // Simulate adding money to the wallet
//                 double newBalance = userController.balance.value + 10.0;
//                 userController.updateBalance(newBalance);

//                 // Update balance in Firestore (replace with your implementation)
//                 updateBalanceInFirestore(newBalance);
//               },
//               child: const Text('Add Money'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Replace this with your Firebase Firestore update logic
//   void updateBalanceInFirestore(double newBalance) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc('aTyLumqycpdNfN11fpftoCtTDKF2')
//         .update({
//       'balance': newBalance,
//     });
//   }
// }
