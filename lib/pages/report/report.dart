import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';

class Report extends StatefulWidget {
  const Report({Key? key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int reportCount = snapshot.data!.docs.length;
            
            if (reportCount > 3) {
              // Disable the account
              // You can implement the account disabling logic here
              // For demonstration, let's print a message
              print('Account disabled: Too many reports.');
            }

            List<Widget> wid = [];

            snapshot.data!.docs.forEach((doc) {
              Map<String, dynamic> reportData = doc.data() as Map<String, dynamic>;
              reportData.forEach((key, value) {
                wid.add(
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kFixPadding),
                    ),
                    color: kAccentColor,
                    shadowColor: Colors.amber,
                    elevation: 10,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '$key: $value',
                            style: kSmallTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            });

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Column(children: wid),
                  const SizedBox(height: 60,),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
