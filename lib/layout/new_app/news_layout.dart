// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
//
// class NewsLayout extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<NewsCubit,NewsStates>(
//     listener: (context,state){},
//       builder: ( context,  state) {
//       var cubit = NewsCubit.get(context);
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('News App'),
//           actions: [
//             IconButton(onPressed: (){
//               navigateTo(context,SearchScreen());
//             }, icon: Icon(Icons.search)),
//             IconButton(onPressed: (){
//               AppCubit.get(context).changeAppMode();
//             }, icon: Icon(Icons.brightness_4_outlined ))
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: cubit.bottomItems,
//           currentIndex: cubit.currentIndex,
//           onTap: (index){
//             cubit.changeBottomNavBar(index);
//           },
//         ),
//         body: cubit.screens[cubit.currentIndex],
//       );
//       },
//     );
//   }
// }
