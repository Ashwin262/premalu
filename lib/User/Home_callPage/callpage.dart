import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {

  final int appID;
  final String callID;
  final String userID;
  final String userName;

  const CallPage({
    Key? key,
    required this.appID,
    required this.callID,
    required this.userID,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appID,
      callID: callID,
      userID: userID,
      userName: userName,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}