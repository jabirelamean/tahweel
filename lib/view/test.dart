import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mira/view/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class CallNum extends StatefulWidget {
  @override
  _CallNumState createState() => new _CallNumState();
}

class _CallNumState extends State<CallNum> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _mtnClientNumber = TextEditingController();
  TextEditingController _mtnAmount = TextEditingController();
  TextEditingController _mtnConfirmClientNumber = TextEditingController();

  TextEditingController _zainclientNumber = TextEditingController();
  TextEditingController _zainAmount = TextEditingController();
  TextEditingController _zainConfirmClientNumber = TextEditingController();
  TextEditingController _code = TextEditingController();

  TextEditingController _sdClientNumber = TextEditingController();
  TextEditingController _sdAmount = TextEditingController();
  TextEditingController _sdConfirmClientNumber = TextEditingController();


  //sudani   *303*amount*number*0000#
  //mtn      *121*000*amount*number#   u have to add 00 to the amount
  //zain     *200*code*amount*number*number#

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final double height = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Balance Transfering'),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10)),
                    child: TabBar(
                      indicator: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8)),
                      tabs: [
                        Tab(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/mtn_icon.jpg',
                                height: 30,
                                width: 20,
                              )),
                              Expanded(child: Text('MTN'))
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/zain_logo.jpg',
                                width: 20,
                                height: 30,
                              )),
                              Expanded(child: Text('Zain'))
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                'assets/images/sudani.png',
                                height: 40,
                              )),
                              Expanded(child: Text('Sudni'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 500,
                    child: Form(
                      key: _formKey,
                      child: TabBarView(
                        children: [
                          // SizedBox(height: 20,),
                          //MTN
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  child: Image.asset('assets/images/mtn.jpg'),
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                  maxLength: 10,
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return 'Please enter phone number';
                                    } else if(value.length <10){
                                      return 'Wrong number';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.number,
                                  label: 'Phone Number',
                                  controller: _mtnClientNumber,
                                ),
                                SizedBox(height: 16),
                                //confirm number
                                CustomTextField(
                                    validate: (value){
                                      if(value!.isEmpty || value != _mtnClientNumber.text || value.length <9){
                                        return 'Please confirm phone number';
                                      }
                                      else if(value == _mtnClientNumber.text){
                                        return null;
                                      }
                                    //  return null;
                                    },
                                  maxLength: 10,
                                    type: TextInputType.number,
                                    label: 'Confirm Number',
                                    controller: _mtnConfirmClientNumber),
                                SizedBox(height: 16),
                                CustomTextField(
                                    validate: (value){
                                      if(value!.isEmpty){
                                        return 'Please enter the amount';
                                      }
                                      return null;
                                    },
                                    type: TextInputType.number,
                                    label: 'Amount', controller: _mtnAmount),
                                SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (_mtnClientNumber.text ==
                                            _mtnConfirmClientNumber.text) {
                                          _makePhoneCall('*123*' +
                                              '000*' +
                                              _mtnAmount.text +
                                              '00*' +
                                              _mtnClientNumber.text +
                                              '#');

                                          _mtnClientNumber.clear();
                                          _mtnConfirmClientNumber.clear();
                                          _mtnAmount.clear();
                                        } else {
                                          Dialog(
                                            child: Text('Wrong Phone Number'),
                                          );
                                        }
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   const SnackBar(content: Text('Validation done')),
                                        // );
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Transfer",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.add_to_home_screen)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //ZAIN
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  child: Image.asset('assets/images/zain.jpg'),
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return 'Please enter phone number';
                                    } else if(value.length <10){
                                      return 'Wrong number';
                                    }
                                    return null;
                                  },
                                  maxLength: 10,
                                  type: TextInputType.number,
                                  label: 'Phone Number',
                                  controller: _zainclientNumber,
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                    validate: (value){
                                      if(value!.isEmpty || value != _zainclientNumber.text){
                                        return 'Please confirm phone number';
                                      }
                                      else if(value == _zainclientNumber.text){
                                        return null;
                                      }
                                      //  return null;
                                    },
                                    maxLength: 10,
                                    type: TextInputType.number,
                                    label: 'Confirm Number',
                                    controller: _zainConfirmClientNumber,
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return 'Please enter the amount';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.number,
                                    label: 'Code', controller: _code),
                                SizedBox(height: 16),
                                CustomTextField(
                                    validate: (value){
                                      if(value!.isEmpty){
                                        return 'Please enter the amount';
                                      }
                                      return null;
                                    },
                                  type: TextInputType.number,
                                    label: 'Amount', controller: _zainAmount),
                                SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {  //*200*code*amount*number*number#
                                        if (_formKey.currentState!.validate()) {
                                          if (_zainclientNumber.text ==
                                              _zainConfirmClientNumber.text) {
                                            _makePhoneCall('*200*' + _code.text + '*' +
                                                _zainAmount.text +
                                                '*' +
                                                _zainclientNumber.text + '*' + _zainclientNumber.text+
                                                '#');

                                            _zainclientNumber.clear();
                                            _zainConfirmClientNumber.clear();
                                            _zainAmount.clear();
                                            _code.clear();
                                          } else {
                                            Dialog(
                                              child: Text('Wrong Phone Number'),
                                            );
                                          }
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   const SnackBar(content: Text('Validation done')),
                                          // );
                                        };
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Transfer",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.add_to_home_screen)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //SUDANI
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  child: Image.asset('assets/images/sudani.png'),
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return 'Please enter phone number';
                                    } else if(value.length <10){
                                      return 'Wrong number';
                                    }
                                    return null;
                                  },
                                  maxLength: 10,
                                  type: TextInputType.number,
                                  label: 'Phone Number',
                                  controller: _sdClientNumber,
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                    validate: (value){
                                      if(value!.isEmpty || value != _sdClientNumber.text){
                                        return 'Please confirm phone number';
                                      }
                                      else if(value == _sdClientNumber.text){
                                        return null;
                                      }
                                      //  return null;
                                    },
                                    maxLength: 10,
                                    type: TextInputType.number,
                                    label: 'Confirm Number',
                                    controller: _sdConfirmClientNumber,
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                    validate: (value){
                                      if(value!.isEmpty){
                                        return 'Please enter the amount';
                                      }
                                      return null;
                                    },
                                    type: TextInputType.number,
                                    label: 'Amount', controller: _sdAmount),
                                SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    //*303*amount*number*0000#
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                          if (_sdClientNumber.text ==
                                              _sdConfirmClientNumber.text) {
                                            _makePhoneCall('*303*' +
                                                _sdAmount.text +
                                                '*' +
                                                _sdClientNumber.text + '*' + '0000' +
                                                '#');
                                            _sdClientNumber.clear();
                                            _sdConfirmClientNumber.clear();
                                            _sdAmount.clear();
                                          } else {
                                            Dialog(
                                              child: Text('Wrong Phone Number'),
                                            );
                                          }
                                      }
                                    },
                                    // onPressed: () {
                                    //   if (_sdClientNumber.text ==
                                    //       _sdConfirmClientNumber.text) {
                                    //     _makePhoneCall('*303*' +
                                    //         _sdAmount.text +
                                    //         '*' +
                                    //         _sdClientNumber.text + '*' + '0000' +
                                    //         '#');
                                    //     _sdClientNumber.clear();
                                    //     _sdConfirmClientNumber.clear();
                                    //     _sdAmount.clear();
                                    //   } else {
                                    //     Dialog(
                                    //       child: Text('Wrong Phone Number'),
                                    //     );
                                    //   }
                                    // },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Transfer",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.add_to_home_screen)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

// Future<void> _launchNumber() async {
//   if(!await launchUrl(Uri.parse("tel://*166#"))){
//     throw 'Could not launch';
//   }
// }
}
