import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/common/global.dart';

import '../common/color_util.dart';
import '../network/base.dart';
import '../network/server_api.dart';
import '../widgets/base_stateful_widget.dart';
import '../widgets/custom_button.dart';

class LoginPage extends BaseStatefulWidget {
  final Object? arguments;

  LoginPage({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool canLogin = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  Timer? timer;
  int countdownTime = 0;
  bool canSendMms = true;

  void startSendMmsCountdown() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    setState(() {
      countdownTime = 60;
      canSendMms = false;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print("验证码倒计时");
      if (countdownTime <= 0) {
        stopSendMmsCountdown();
        setState(() {
          canSendMms = true;
        });
      }
      setState(() {
        countdownTime--;
      });
    });
  }

  void stopSendMmsCountdown() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void sendSms() async {
    if (phoneController.text.isEmpty || phoneController.text.length != 11) {
      return EasyLoading.showToast('请输入手机号');
    }
    try {
      await ServerApi.sendCode(phoneController.text);
      startSendMmsCountdown();
      EasyLoading.showSuccess('发送成功');
    } on HttpError catch (e) {
      EasyLoading.showError(e.errMsg);
    }
  }

  void login() async {
    if (phoneController.text.isEmpty || phoneController.text.length != 11) {
      return EasyLoading.showToast('请输入手机号');
    }
    if (codeController.text.isEmpty || codeController.text.length != 6) {
      return EasyLoading.showToast('请输入验证码');
    }
    try {

      final user = await ServerApi.loginByCode(phoneController.text, codeController.text);
      Global.userInfo = user;
      EasyLoading.showSuccess('登录成功${user.uid}');
    } on HttpError catch (e) {
      EasyLoading.showError(e.errMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, // 设置返回箭头颜色为白色
      ),
      elevation: 0,
      backgroundColor: const Color(0x00FFFFFF),
      title: const Text(
        '',
        style: TextStyle(color: ColorUtil.navBlackTitleTextColor),
      ),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      // extendBodyBehindAppBar: true,
      body: Container(
          color: ColorUtil.mainBgColor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Text(
                "欢迎来到llano私有云",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: const Color(0xFF3D3D3D),
                  // fontWeight: FontWeight.w600,
                ),
              ),
              Image.asset('assets/images/login_logo.png', width: 169.w, height: 148.w,),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Container(
                  width: double.infinity,
                  height: 224.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 24.w, right: 24.w, top: 24.w),
                    child: Column(
                      children: [
                        _inputPhoneWidget(),
                        SizedBox(
                          height: 12.w,
                        ),
                        _inputCodeWidget(),
                        SizedBox(
                          height: 40.w,
                        ),
                        CustomButton(
                          titleStr: "登录",
                          bgStyle:
                              CustomButtonBG.customButtonLoginGreenButtonStyle,
                          onTap: canLogin
                              ? () {
                                  unFocus();
                                  login();
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _inputPhoneWidget() {
    return Container(
      height: 48.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(312.w),
          color: const Color(0xFFF5F5F5)),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 27.w, right: 27.w),
      child: TextField(
        autofocus: false,
        autocorrect: false,
        controller: phoneController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: '请输入手机号',
          hintStyle: TextStyle(
              fontSize: 18.sp,
              color: Colors.black.withOpacity(0.2),
              fontWeight: FontWeight.w600),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        onChanged: (String text) {
          canLogin = false;
          if (text.isNotEmpty &&
              text.replaceAll(" ", "").length == 11 &&
              codeController.text.length == 6) {
            canLogin = true;
          }
          phoneController.clearComposing();
          phoneController.selection =
              TextSelection(baseOffset: text.length, extentOffset: text.length);
          setState(() {});
        },
      ),
    );
  }

  Widget _inputCodeWidget() {
    return Container(
      height: 48.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(312.w),
          color: const Color(0xFFF5F5F5)),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 27.w, right: 27.w),
      child: TextField(
        autofocus: false,
        autocorrect: false,
        controller: codeController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: '请输入验证码',
          hintStyle: TextStyle(
              fontSize: 18.sp,
              color: Colors.black.withOpacity(0.2),
              fontWeight: FontWeight.w600),
          suffixIcon: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (canSendMms) {
                sendSms();
              }
            },
            child: Padding(
              padding: EdgeInsets.all(12.5.w),
              child: Text(
                canSendMms ? "获取验证码" : "$countdownTime秒重新获取",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: canSendMms ? Colors.black : const Color(0xFF888888)),
              ),
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        onChanged: (String text) {
          canLogin = false;
          if (text.isNotEmpty &&
              text.length == 6 &&
              phoneController.text.replaceAll(" ", "").length == 11) {
            canLogin = true;
          }
          phoneController.clearComposing();
          phoneController.selection =
              TextSelection(baseOffset: text.length, extentOffset: text.length);
          setState(() {});
        },
      ),
    );
  }
}
