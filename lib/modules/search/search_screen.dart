import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        var list =NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.text,
                  validator: (String? s){
                    if(s!.isEmpty){
                      return 'Please inter text search';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'serach',
                    prefix: Icon(Icons.search),
                    border: OutlineInputBorder()
                  ),
                  onChanged: (String value){
                       NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context))
            ],
          ),
        );
      },
    );
  }
}
