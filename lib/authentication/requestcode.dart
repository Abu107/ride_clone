import 'dart:async';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:ride/map.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class OtpRequest extends StatefulWidget {
  OtpRequest({super.key});

  @override
  State<OtpRequest> createState() => _OtpRequestState();
}

class _OtpRequestState extends State<OtpRequest> {
  final _codeController = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool doAgreed = false;
  /* final scaffoldKey = GlobalKey();
  late OTPTextEditController controller1;
  late OTPInteractor _otpInteractor;
  late TextEditingController textEditingController1;

  String _comingSms = 'Unknown';
  Future<void> initSmsListener() async {
    String comingSms;
    try {
      comingSms = (await AltSmsAutofill().listenForSms)!;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms;
      print("====>Message: ${_comingSms}");
      print("${_comingSms[32]}");
      textEditingController1.text = _comingSms[32] + _comingSms[33] + _comingSms[34] + _comingSms[35]
          + _comingSms[36] + _comingSms[37]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
    });
  }*/
  /*
  @override
  void initState() {
  //  initSmsListener();
    super.initState();
    _initInteractor();
    controller1 = OTPTextEditController(
      codeLength: 6,
      //ignore: avoid_print
      onCodeReceive: (code) => print('Your Application receive code - $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          SampleStrategy(),
        ],
      );
  }
   Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();
    // You can receive your app signature by using this method.
    final appSignature = await _otpInteractor.getAppSignature();

    if (kDebugMode) {
      print('Your app signature: $appSignature');
    }
  }

  @override
  void dispose() {
    controller1.stopListen();
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text(
              "Enter your phone number to start",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: _formKey1,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(width: .5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: CountryCodePicker(
                          flagWidth: 20,
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.black),
                          padding: EdgeInsets.all(0),
                          //     closeIcon: Icon(Icons.close,size: 30),
                          showDropDownButton: true,
                          initialSelection: 'ET',
                          //onChanged: print,
                          favorite: ['+251', 'ET'],
                          //showCountryOnly: false,
                          // showOnlyCountryWhenClosed: false,
                          //alignLeft: false,

                          onChanged: (value) => countryCode = value.toString(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 9 ||
                                  value.length > 9) {
                                return "please enter a valid contact number.";
                              }
                              //return null;
                              phone = value;
                            },
                            onChanged: (value) {},
                            autofocus: true,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'phone number'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: doAgreed,
                      onChanged: (value) {
                        setState(() {
                          doAgreed = value!;
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () {},
                        child: TextButton(
                          onPressed: () {},
                          child: Text("I agree to terms and conditions",
                              style: TextStyle(color: Colors.black54)),
                        ))
                  ],
                ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(right: 30, left: 30),
                    child: ElevatedButton(
                        onPressed: doAgreed
                            ? () async{
                                 bool result = await InternetConnectionChecker().hasConnection;
                              if(result == true) {
                                 if (_formKey1.currentState!.validate()) {
                                  registerUser(countryCode + phone, context);
                                }
                              } else {
                                Fluttertoast.showToast(msg: 'No Internet connection');
                              }
                              }
                            : null,
                        style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(2),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber),
                        ),
                        child: Text("Request Code")))
              ],
            ),
          )
        ],
      ),
    );
  }

  String phone = "";
  String countryCode = "+251";
  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth
              .signInWithCredential(authCredential)
              .then((value) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapSample(),
                  )))
              .catchError((e) {
            Fluttertoast.showToast(
                msg: e.toString(), gravity: ToastGravity.BOTTOM);
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          Fluttertoast.showToast(
              msg: authException.message.toString(),
              gravity: ToastGravity.BOTTOM);
        },
        codeSent: (String verificationId, int? resendToken) async {
          FirebaseAuth auth = FirebaseAuth.instance;
          // Update the UI - wait for the user to enter the SMS code
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => sg(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          // print(verificationId);
          Fluttertoast.showToast(msg: "Time Out", gravity: ToastGravity.BOTTOM);
          // print("Timout");
        });
  }

  Widget sg(String verificationId) {
    return Dialog.fullscreen(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text("Try again in 15 minutes")
                ],
              ),
            ),
            Text(
              "We have sent you an SMS with the code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            separate(15),
            Text(
              "to",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            separate(10),
            Text(
              countryCode + phone,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
            separate(20),
            Form(
                key: _formKey2,
                child: TextFormField(
                  autofocus: true,
                  //controller: controller1,
                 // maxLength: 6,
                  //autofillHints: [AutofillHints.oneTimeCode],
                 // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "XXXXXX",
                      hintStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length < 6 ||
                        value.length > 6) {
                      return "please enter a code sent.";
                    }
                  },
                  onChanged: (value) async {
                    if (value.length == 6) {
                      if (_formKey1.currentState!.validate()) {
                        //  setState(() async {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        String smsCode = value.toString();
                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: smsCode);
                        // Sign the user in (or link) with the credential

                        await auth
                            .signInWithCredential(credential)
                            .then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapSample()));
                        }).catchError((e) {
                          Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM);
                        });
                      }
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }

  Widget separate(double height) {
    return SizedBox(
      height: height,
    );
  }

  TextStyle txtStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
}
/*class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 5),
      () => 'Your code is 543210',
    );
  }
}*/