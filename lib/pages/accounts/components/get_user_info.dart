import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';

class GetUserInfo extends StatefulWidget {
  final String documentId;

  const GetUserInfo({
    super.key,
    required this.documentId,
  });

  @override
  State<GetUserInfo> createState() => _GetUserInfoState();
}

class _GetUserInfoState extends State<GetUserInfo> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            children: [
              Text(
                'Username: ${data['username']}',
                style: const TextStyle(color: kPrimaryColor),
              ),
              Text(
                'Email: ${data['email']}',
                style: const TextStyle(color: kPrimaryColor),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    Flushbar(
                      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                      flushbarStyle: FlushbarStyle.FLOATING,
                      reverseAnimationCurve: Curves.decelerate,
                      forwardAnimationCurve: Curves.elasticOut,
                      flushbarPosition: FlushbarPosition.TOP,
                      isDismissible: true,
                      message: (!data['enable'])
                          ? '${data['username']}\'s account has been enabled'
                          : '${data['username']}\'s account has been disabled',
                      // '$data['username']\' account has been ',
                      icon: Icon(
                        Icons.info_outline,
                        size: 28.0,
                        color: Colors.blue[300],
                      ),
                      duration: const Duration(seconds: 2),
                      leftBarIndicatorColor: kLightColor,
                    ).show(context);

                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.documentId)
                        .update({
                      'enable': !data['enable'],
                    });
                  });
                },
                icon: Icon(
                  (!data['enable']) ? Icons.no_accounts : Icons.account_circle,
                  color: kPrimaryColor,
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
