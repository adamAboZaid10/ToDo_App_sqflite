import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cubit/cubit.dart';
import '../controller/cubit/states.dart';
import '../shared/component.dart';

class AddTaskScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
        if (state is InertIntoToDoDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add your Tasks'.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      child: customTextFormField(
                        controller: titleController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please add your title'.tr();
                          }
                        },
                        keyBoardType: TextInputType.text,
                        label: 'title',
                        hintText: 'add your title',
                        prefixIcon: Icons.title,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: customTextFormField(
                          controller: timeController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please add your time'.tr();
                            }
                          },
                          keyBoardType: TextInputType.datetime,
                          label: 'time',
                          hintText: 'add your time',
                          prefixIcon: Icons.timer,
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((TimeOfDay? value) {
                              timeController.text = value!.format(context);
                            }).catchError((error) {
                              timeController.clear();
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: customTextFormField(
                          controller: dateController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please add your date'.tr();
                            }
                          },
                          keyBoardType: TextInputType.datetime,
                          label: 'date',
                          hintText: 'add your date',
                          prefixIcon: Icons.date_range,
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2040-12-30'))
                                .then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value!);
                            }).catchError((error) {
                              dateController.clear();
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: customTextFormField(
                        controller: descController,
                        lines: 8,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please add your description'.tr();
                          }
                        },
                        keyBoardType: TextInputType.text,
                        label: 'description',
                        hintText: 'add your description',
                        prefixIcon: Icons.title,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minWidth: double.infinity,
                      color: Colors.deepOrange,
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          cubit.insertInToDataBase(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text,
                            description: descController.text,
                          );
                        }
                      },
                      child: Text(
                        'add tasks'.tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
