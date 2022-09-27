import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira/view/archive_view.dart';
import 'package:mira/view/done_view.dart';
import 'package:mira/view/new_view.dart';

class ControlViewModel extends GetxController{

  final List<Widget> screens = [
    NewView(),
    DoneView(),
    ArchiveView(),
  ];

  final List<String> titles= [
    'Mira Notes',
    'Done Notes',
    'Archive Notes',
  ];

}