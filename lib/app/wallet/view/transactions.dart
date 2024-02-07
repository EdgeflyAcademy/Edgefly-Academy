import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String transactionType;
  final String time;
  final String transID;
  final String date;
  final String amount;

  Transaction({
    required this.transactionType,
    required this.time,
    required this.transID,
    required this.date,
    required this.amount,
  });
}

// class TransactionController extends GetxController {
//   RxList<Transaction> transactions = <Transaction>[].obs;
//   RxBool isLoading = false.obs;
//   Rxn<QueryDocumentSnapshot<Map<String, dynamic>>> lastDocument =
//       Rxn<QueryDocumentSnapshot<Map<String, dynamic>>>();

//   final int batchLimit = 10;

//   Future<void> loadTransactions() async {
//     isLoading.value = true;

//     final uid =
//         FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID

//     final snapshot = await FirebaseFirestore.instance
//         .collection("userWallet")
//         .doc(uid)
//         .collection("transactions")
//         .orderBy('time', descending: true)
//         .limit(batchLimit)
//         .get();

//     transactions.assignAll(snapshot.docs.map((doc) {
//       return Transaction(
//         transactionType: doc['transactionType'],
//         time: doc['time'],
//         transID: doc['transID'],
//         date: doc['date'],
//         amount: doc['amount'],
//       );
//     }));

//     lastDocument.value = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

//     isLoading.value = false;
//   }

//   Future<void> loadMoreTransactions() async {
//     final uid =
//         FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID

//     if (lastDocument.value == null) return;

//     final snapshot = await FirebaseFirestore.instance
//         .collection("userWallet")
//         .doc(uid)
//         .collection("transactions")
//         .orderBy('time', descending: true)
//         .startAfterDocument(lastDocument.value!)
//         .limit(batchLimit)
//         .get();

//     transactions.addAll(snapshot.docs.map((doc) {
//       return Transaction(
//         transactionType: doc['transactionType'],
//         time: doc['time'],
//         transID: doc['transID'],
//         date: doc['date'],
//         amount: doc['amount'],
//       );
//     }));

//     lastDocument.value = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
//   }
// }

class TransactionScreen extends StatelessWidget {
  // final TransactionController transactionController =
  //     Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return TransactionCard();
        },
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  // final Transaction transaction;

  const TransactionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: CircleAvatar(
          // Set logo based on transaction type
          backgroundImage: AssetImage(_getLogoPath("recharge")),
        ),
        title: Text(
          "recharge",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trans ID: DSSDVDFVDF'),
            Text('Amount: 200'),
          ],
        ),
        trailing: Text('01/5/21 8:25 PM'),
      ),
    );
  }

  String _getLogoPath(String transactionType) {
    switch (transactionType) {
      case 'withdraw':
        return 'assets/icons/wallet.png'; // Replace with actual path
      case 'recharge':
        return 'assets/icons/recharge.png'; // Replace with actual path
      case 'exam fee':
        return 'assets/icons/receipt.png'; // Replace with actual path
      default:
        return 'assets/icons/stiphend.png'; // Replace with default logo path
    }
  }
}




// class TransactionController extends GetxController {
//   RxList<Transaction> transactions = <Transaction>[].obs;
//   RxBool isLoading = false.obs;
//   RxInt batchLimit = 10.obs;

//   void loadTransactions() async {
//     isLoading.value = true;

//     final uid = 'your_user_id'; // Replace with actual user ID

//     final snapshot = await FirebaseFirestore.instance
//         .collection("userWallet")
//         .doc(uid)
//         .collection("transactions")
//         .orderBy('time', descending: true)
//         .limit(batchLimit.value)
//         .get();

//     transactions.assignAll(snapshot.docs.map((doc) {
//       return Transaction(
//         transactionType: doc['transactionType'],
//         time: doc['time'],
//         transID: doc['transID'],
//         date: doc['date'],
//         amount: doc['amount'],
//       );
//     }));

//     isLoading.value = false;
//   }

//   void loadMoreTransactions() async {
//     final uid = 'your_user_id'; // Replace with actual user ID

//     final snapshot = await FirebaseFirestore.instance
//         .collection("userWallet")
//         .doc(uid)
//         .collection("transactions")
//         .orderBy('time', descending: true)
//         .startAfterDocument(transactions.last)
//         .limit(batchLimit.value)
//         .get();

//     transactions.addAll(snapshot.docs.map((doc) {
//       return Transaction(
//         transactionType: doc['transactionType'],
//         time: doc['time'],
//         transID: doc['transID'],
//         date: doc['date'],
//         amount: doc['amount'],
//       );
//     }));
//   }
// }

