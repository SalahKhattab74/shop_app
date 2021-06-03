import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/moduels/shop_app/favourites/favourite_screen.dart';
import 'package:shop_app/moduels/shop_app/search/cubit/search_cubit.dart';
import 'package:shop_app/moduels/shop_app/search/cubit/search_states.dart';
import 'package:shop_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Enter Text To Search';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        }),
                    SizedBox(height: 10.0),
                    if (state is SearchLoadingStates) LinearProgressIndicator(),
                    if (state is SearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildFavItem(
                                SearchCubit.get(context)
                                    .searchModel
                                    .data
                                    .data[index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: SearchCubit.get(context)
                                .searchModel
                                .data
                                .data
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
