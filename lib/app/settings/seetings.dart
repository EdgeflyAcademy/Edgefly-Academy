import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../auth/view/signin_screen.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.green[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () {
                  Get.to(ChangePasswordPage());
                },
                // tileColor: Colors.blue[100],
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/icons/notification-settings.png",
                      scale: 17),
                ),
                title: const Text("Notification Settings"),

                // Add more properties as needed
              ),
            ),
            Card(
              color: Colors.blue[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () {
                  Get.to(ChangePasswordPage());
                },
                // tileColor: Colors.blue[100],
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/icons/change_password.png",
                      scale: 17),
                ),
                title: const Text("Change Password"),

                // Add more properties as needed
              ),
            ),
            Card(
              color: Colors.red[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() => const SigninScreen());
                },
                // tileColor: Colors.blue[100],
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/icons/exit.png", scale: 22),
                ),
                title: const Text("Logout"),

                // Add more properties as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  // Controller to handle the old password input
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  late String oldPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // StreamBuilder to read the old password from Firestore
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                }

                // Retrieve old password from Firestore
                oldPassword = snapshot.data!.get('password') ??
                    ''; // Replace 'password' with the actual field name

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Old Password'),
                    TextField(
                      controller: _oldPasswordController,
                      obscureText: _obscureText1,
                      decoration: InputDecoration(
                        hintText: 'Enter old password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Colors.black), // Set underline color to black
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .black), // Set focused underline color to black
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText1
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: Colors.black, // Set icon color to black
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText1 = !_obscureText1;
                              // Toggle obscure text on icon press
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                );
              },
            ),

            Text('New Password'),
            TextField(
              controller: _newPasswordController,
              obscureText: _obscureText2,
              decoration: InputDecoration(
                hintText: 'Enter new password',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // Set underline color to black
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Colors.black), // Set focused underline color to black
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText2
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: Colors.black, // Set icon color to black
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                      // Toggle obscure text on icon press
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Implement password change functionality here
                // Compare old password entered by the user with the one retrieved from Firestore
                if (_oldPasswordController.text == oldPassword &&
                    _oldPasswordController.text !=
                        _newPasswordController.text) {
                  // Show a confirmation dialog
                  bool confirmed = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Password Change'),
                        content: Text(
                            'Are you sure you want to change your password?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false); // No
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true); // Yes
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmed != null && confirmed) {
                    // User clicked "Yes" in the confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: SpinKitFadingCircle(
                            // You can choose a different loading style
                            color: Colors
                                .blue, // Set the color of the loading indicator
                            size: 50.0, // Set the size of the loading indicator
                          ),
                        );
                      },
                      barrierDismissible:
                          false, // Prevent dialog dismissal by tapping outside
                    );

                    // Rest of your password update logic here
                    // Get the current user
                    User? user = FirebaseAuth.instance.currentUser!;

                    // Create a credential with the current password
                    AuthCredential credential = EmailAuthProvider.credential(
                      email: user.email!,
                      password: _oldPasswordController.text,
                    );

                    try {
                      // Re-authenticate the user with their current password
                      await user.reauthenticateWithCredential(credential);

                      // Now the user is re-authenticated, update the password to a new one
                      String newPassword = _newPasswordController
                          .text; // replace with the new password
                      await user.updatePassword(newPassword);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        'password': _newPasswordController.text,
                        // Update other fields as needed
                      });
                      // Password has been updated successfully
                      print("Password changed successfully!");
                      Navigator.of(context, rootNavigator: true).pop();
                      Get.back(); // Navigate back to the profile screen
                      Get.snackbar(
                        'Success',
                        'Your Password is changed',
                        snackPosition: SnackPosition.TOP,
                        shouldIconPulse: true,
                        icon: Icon(Icons.check_circle_rounded,
                            color: Colors.green[900]),
                      );
                    } catch (error) {
                      Navigator.of(context, rootNavigator: true).pop();
                      // Handle re-authentication error or password update error
                      Get.snackbar(
                        'Error',
                        'Password Changing Error',
                        snackPosition: SnackPosition.TOP,
                        shouldIconPulse: true,
                        icon: Icon(Icons.error_rounded, color: Colors.red[900]),
                      );
                      print("Error: $error");
                    }
                  }
                } else if (_oldPasswordController.text ==
                    _newPasswordController.text) {
                  Get.snackbar(
                    'Error',
                    'Try new password',
                    snackPosition: SnackPosition.TOP,
                    shouldIconPulse: true,
                    icon: Icon(Icons.error_rounded, color: Colors.red[900]),
                  );
                } else {
                  // Passwords do not match, you can show an error message
                  print('Old Password does not matched. Try Again');
                  Get.snackbar(
                    'Error',
                    'Old Password does not matched. Try Again',
                    snackPosition: SnackPosition.TOP,
                    shouldIconPulse: true,
                    icon: Icon(Icons.error_rounded, color: Colors.red[900]),
                  );
                }
              },
              child: Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
