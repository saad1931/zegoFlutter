// ignore_for_file: must_be_immutable

import 'dart:math' as math;
import 'package:callapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

final String localUserId = math.Random().nextInt(10000).toString();

class Calling extends StatefulWidget {
  const Calling({super.key});

  @override
  State<Calling> createState() => _CallingState();
}

class _CallingState extends State<Calling> {
  final callingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: callingController,
              decoration: const InputDecoration(
                  hintText: "Enter Call Id", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LiveCall(
                              callingId: callingController.text.toString())));
                },
                child: const Text("Join"))
          ],
        ),
      ),
    );
  }
}

class LiveCall extends StatelessWidget {
  String callingId;
  LiveCall({super.key, required this.callingId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: Utils.appId,
        appSign: Utils.appSign,
        callID: callingId,
        userID: localUserId,
        userName: "user_$localUserId",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
          ..onOnlySelfInRoom = (context) {
            Navigator.pop(context);
          },
      ),
    );
  }
}
