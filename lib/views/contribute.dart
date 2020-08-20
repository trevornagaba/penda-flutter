import 'dart:async';
import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rave/charge_response.dart';
import 'package:penda/services/constants.dart';
import 'package:tripledes/tripledes.dart';
// import 'package:flutter_rave/mobile_money_payload.dart';
import 'package:penda/services/networking.dart';
// import 'package:flutter_rave/requery_response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Contribute extends StatefulWidget {
  @override
  _ContributeState createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  String _phoneErrorText;
  String _amountErrorText; //TODO: Operationalize to catch bad input
  var firstName = 'user',
      lastName = 'Using',
      amount = 500,
      email = 'user@gmail.com',
      _userDismissedDialog = false,
      _requeryUrl = VALIDATE_CHARGE_ENDPOINT,
      _queryCount = 0,
      _reQueryTxCount = 0,
      _waitDuration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Contribute',
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: InputDecoration(
                errorText: _phoneErrorText,
                hintText: 'Mobile Wallet Number',
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey.shade500,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: _amountController,
              decoration: InputDecoration(
                errorText: _phoneErrorText,
                hintText: 'Amount',
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey.shade500,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _processMtnMM,
            child: Container(
              child: Text(
                'PAY',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.only(
                  left: 32.0, right: 32.0, top: 8.0, bottom: 16.0),
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> encryptJsonPayload(
      Map<String, dynamic> payload, String encryptionKey, String publicKey) {
    String encoded = jsonEncode(payload);
    var blockCipher = BlockCipher(TripleDESEngine(), encryptionKey);
    String encrypted = blockCipher.encodeB64(encoded);

    Map<String, String> encryptedPayload = {
      "PBFPubKey": publicKey,
      "client": encrypted,
      "alg": "3DES-24"
    };

    return encryptedPayload;
  }

  void _processMtnMM() {
    _phoneErrorText = '';
    if (_validatePhoneNumber(_phoneController.text) != null) {
      setState(() {
        _phoneErrorText = _validatePhoneNumber(_phoneController.text);
      });
      return;
    }

    var phone = _addCountryCodeSuffixToNumber('+256', _phoneController.text);
    var amount = _amountController.text;
    // _showMobileMoneyProcessingDialog();
    _initiateMobileMoneyPaymentFlow(phone, amount);
  }

  void _initiateMobileMoneyPaymentFlow(String phone, String amount) async {
    _userDismissedDialog = false;
    String deviceId = await DeviceId.getID;

    Map<String, dynamic> payload = {
      'PBFPubKey': PUBLIC_KEY,
      'currency': currency,
      'payment_type': paymentType,
      'country': receivingCountry,
      'amount': amount,
      'email': email,
      'phonenumber': phone,
      'network': network,
      'firstname': firstName,
      'lastname': lastName,
      'txRef': "MC-" + DateTime.now().toString(),
      'orderRef': "MC-" + DateTime.now().toString(),
      'is_mobile_money_ug': "1",
      'device_fingerprint': deviceId,
      'redirect_url': VERIFICATION_API_BASE_URL
    };

    var requestBody = encryptJsonPayload(payload, ENCRYPTION_KEY, PUBLIC_KEY);

    var response = await postToEndpointWithBody(
        '$CHARGE_ENDPOINT?use_polling=1', //TODO; What is use_polling
        requestBody); //TODO: This request body is json encoded in the final documentation

    if (response == null) {
      _showToast(context, 'Payment processing failed. Please try again later.');
      _dismissMobileMoneyDialog(false);
    } else {
      print(response['data']['link']);
      Navigator.pushReplacementNamed(context, '/contributeWebView',
          arguments: response['data']['link']);
      // Navigator.push(
      //     context,
      //     new MaterialPageRoute(
      //         builder: (context) => new ContributeWebView(response['data']['link'])));
      // _continueProcessingAfterCharge(response, true);
    }
  }

  _showToast(BuildContext context, String textInput, {Color backgroundColor}) {
    if (mounted) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(textInput),
        duration: Duration(milliseconds: 1000),
        backgroundColor: backgroundColor ?? Colors.black87,
      ));
    }
  }

  Future<void> _showMobileMoneyProcessingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mobile Money'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'A push notification is being sent to your phone, please complete the transaction by entering your pin.'),
                SizedBox(
                  height: 8.0,
                ),
                SpinKitThreeBounce(
                  color: Colors.grey.shade900,
                  size: 20.0,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'CANCEL',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                _dismissMobileMoneyDialog(true);
              },
            ),
          ],
        );
      },
    );
  }

  void _dismissMobileMoneyDialog(bool dismissedByUser) {
    _userDismissedDialog = dismissedByUser;
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }
  }

  String _validatePhoneNumber(String phone) {
    String pattern = r'(^[0+](?:[0-9] ?){6,14}[0-9]$)';
    RegExp regExp = RegExp(pattern);
    if (phone.length == 0) {
      return "Enter mobile number";
    } else if (!regExp.hasMatch(phone.trim())) {
      return "Enter valid mobile number";
    }
    return null;
  }

  String _addCountryCodeSuffixToNumber(String countryCode, String phoneNumber) {
    if (phoneNumber[0] == '0') {
      return countryCode + phoneNumber.substring(1);
    }
    return phoneNumber;
  }

  void _continueProcessingAfterCharge(
      Map<String, dynamic> response, bool firstQuery) async {
    // var chargeResponse = ChargeResponse.fromJson(response, firstQuery);
    var chargeResponse = jsonDecode(jsonEncode(response));
    print(chargeResponse['data']);

    if (chargeResponse['data'] != null &&
        chargeResponse['data']['flwRef'] != null) {
      _requeryTx(chargeResponse['data']['flwRef']);
    } else {
      if (chargeResponse['status'] == 'success' &&
          chargeResponse['data']['link'] != null) {
        // _waitDuration = chargeResponse['data']['wait'];
        _requeryUrl = chargeResponse['data']['link'];
        Timer(Duration(milliseconds: _waitDuration), () {
          _chargeAgainAfterDuration(chargeResponse['data']['link']);
        });
      } else if (chargeResponse['status'] == 'success' &&
          chargeResponse['data']['status'] == 'pending') {
        Timer(Duration(milliseconds: _waitDuration), () {
          _chargeAgainAfterDuration(_requeryUrl);
        });
      } else if (chargeResponse['status'] == 'success' &&
          chargeResponse['data']['status'] == 'completed' &&
          chargeResponse['data']['flwRef'] != null) {
        _requeryTx(chargeResponse['data']['flwRef']);
      } else {
        _showToast(
            context, 'Payment processing failed. Please try again later.');
        _dismissMobileMoneyDialog(false);
      }
    }
  }

  void _requeryTx(String flwRef) async {
    if (!_userDismissedDialog && _reQueryTxCount < MAX_REQUERY_COUNT) {
      _reQueryTxCount++;
      final requeryRequestBody = {"PBFPubKey": PUBLIC_KEY, "flw_ref": flwRef};

      var response =
          await postToEndpointWithBody(REQUERY_ENDPOINT, requeryRequestBody);

      if (response == null) {
        _showToast(
            context, 'Payment processing failed. Please try again later.');
        _dismissMobileMoneyDialog(false);
      } else {
        // var requeryResponse = RequeryResponse.fromJson(response);
        var requeryResponse = response['data'];

        if (requeryResponse.data == null) {
          _showToast(
              context, 'Payment processing failed. Please try again later.');
          _dismissMobileMoneyDialog(false);
        } else if (requeryResponse.data.chargeResponseCode == '02' &&
            requeryResponse.data.status != 'failed') {
          _onPollingComplete(flwRef);
        } else if (requeryResponse.data.chargeResponseCode == '00') {
          _onPaymentSuccessful();
        } else {
          _showToast(
              context, 'Payment processing failed. Please try again later.');
          _dismissMobileMoneyDialog(false);
        }
      }
    } else if (_reQueryTxCount == MAX_REQUERY_COUNT) {
      _showToast(
          context, 'Payment processing timeout. Please try again later.');
      _dismissMobileMoneyDialog(false);
    }
  }

  void _chargeAgainAfterDuration(String url) async {
    print('requeryUrl: $url');
    if (!_userDismissedDialog) {
      _queryCount++;
      print('Charging Again after $_queryCount Charge calls');
      var response = await getResponseFromEndpoint(url);
      print('url response: $response');

      if (response == null) {
        _showToast(
            context, 'Payment processing failed. Please try again later.');
        _dismissMobileMoneyDialog(false);
      } else {
        _continueProcessingAfterCharge(response, false);
      }
    }
  }

  void _onPollingComplete(String flwRef) {
    Timer(Duration(milliseconds: 5000), () {
      _requeryTx(flwRef);
    });
  }

  void _onPaymentSuccessful() async {
    _showPaymentSuccessfulDialog();
  }

  void _showPaymentSuccessfulDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.done,
                  color: Colors.blue,
                  size: MediaQuery.of(context).size.width / 6,
                ),
              ),
              Text(
                'Payment completed!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                'You have successfully completed your payment!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                onTap: () {
                  //Proceed to the next action after successful payment
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: 32.0, right: 32.0, top: 8.0, bottom: 16.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'Proceed',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              )
            ],
          );
        });
  }
}
