import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtodoapp/view/update_screen.dart';

import '../controller/cubit/cubit.dart';
import '../controller/cubit/states.dart';
import 'add_task_screen.dart';
import 'drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.deepOrange,
            title: Text(
              'My Tasks'.tr(),
            ),
          ),
          drawer: const Drawer(
            child: DrawerScreen(),
          ),
          body: ConditionalBuilder(
              condition: state is! LoadingGetDataFromToDoDatabaseState,
              fallback: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
              builder: (BuildContext context) {
                return (cubit.tasks.isNotEmpty)
                    ? ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return UpdateTaskScreen(
                                    id: cubit.tasks[index]['id']);
                              }));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            cubit.tasks[index]['title'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            cubit.tasks[index]['time'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            onPressed: () {
                                              cubit.deleteDataFromDataBase(
                                                  id: cubit.tasks[index]['id']);
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      cubit.tasks[index]['description'],
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: cubit.tasks.length,
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.hourglass_empty),
                            Text(
                              'there is not tasks here'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.deepOrange),
                            ),
                          ],
                        ),
                      );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTaskScreen()));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
