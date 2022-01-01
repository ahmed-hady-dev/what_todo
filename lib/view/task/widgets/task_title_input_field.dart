// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:what_todo/view/home/controller/home_cubit.dart';
// import 'package:what_todo/view/task/model/task_model.dart';
//
// class TaskTitleInputField extends StatelessWidget {
//   const TaskTitleInputField({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: BlocConsumer<HomeCubit, HomeState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           final cubit = HomeCubit.get(context);
//           return TextField(
//             controller: cubit.titleController,
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.go,
//             onSubmitted: (value) {
//               if (value.isNotEmpty) {
//                 cubit
//                     .insertTask(
//                         task:
//                             Task(title: value, description: 'task description'))
//                     .then((value) => cubit.getTasks);
//               }
//             },
//             style: Theme.of(context)
//                 .textTheme
//                 .headline6!
//                 .copyWith(fontWeight: FontWeight.bold),
//             decoration: InputDecoration(
//               hintText: 'Enter Task Title',
//               hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
//                   color: Theme.of(context)
//                       .textTheme
//                       .headline1!
//                       .color!
//                       .withOpacity(0.6)),
//               border: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               errorBorder: InputBorder.none,
//               enabledBorder: InputBorder.none,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
