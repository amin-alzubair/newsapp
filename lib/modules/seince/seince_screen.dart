import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/shared/components/components.dart';

class SeincesScreen extends StatelessWidget {
  const SeincesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context,state){
          var list = NewsCubit.get(context).science;
          return articleBuilder(list,context);
        }
    );
  }
}
