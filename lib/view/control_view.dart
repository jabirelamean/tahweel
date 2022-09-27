import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira/view/archive_view.dart';
import 'package:mira/view/done_view.dart';
import 'package:mira/view/new_view.dart';
import 'package:mira/view_model/control_view_model.dart';
import 'package:mira/view_model/home_view_model.dart';
import 'package:intl/intl.dart';

class ControlVeiw extends StatelessWidget {
  ControlVeiw({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  final controlViewModel = Get.put(ControlViewModel());
  final homeViewModel = Get.put(HomeViewModel());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: const Color(0xffE80F88),
              title:
              Text(controlViewModel.titles[homeViewModel.currentIndex.value]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Color(0xffE80F88),
              onPressed: () {
                Get.bottomSheet(
                  BottomSheet(
                      onClosing: () => Get.back(),
                      enableDrag: false,
                      builder: (_) {
                        return Container(
                          height: 300,
                          padding: EdgeInsets.only(
                              top: 20, right: 10, left: 10),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Title',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                          )),
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: noteController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'note must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Note',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                          )),
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.text,
                                  onTap: () async {
                                    await showDatePicker(context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-10-25'),
                                    ).then((value) {
                                      dateController.text = DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Date',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                          )),
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.text,
                                  onTap: () async {
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Time',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                          )),
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
            ),
            body: controlViewModel.screens[homeViewModel.currentIndex.value],
            bottomNavigationBar: Obx(
                  () =>
                  BottomNavigationBar(
                    currentIndex: homeViewModel.currentIndex.value,
                    selectedItemColor: Color(0xffE80F88),
                    onTap: (value) {
                      homeViewModel.currentIndex.value = value;
                    },
                    items: [
                      BottomNavigationBarItem(
                        label: 'New',
                        icon: Icon(Icons.notes_sharp),
                      ),
                      BottomNavigationBarItem(
                        label: 'Done',
                        icon: Icon(Icons.done),
                      ),
                      BottomNavigationBarItem(
                        label: 'Archive',
                        icon: Icon(Icons.archive),
                      ),
                    ],
                  ),
            ),
          ),
    );
  }
}
