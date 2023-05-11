import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/cubit/news_cubit.dart';
import 'package:shopapp/shared/compoments.dart';

class ScienceView extends StatelessWidget {
  const ScienceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.scienceList;

          return ConditionalBuilder(
            condition: list.length > 0,
            builder: (context) => ListView.builder(
                itemCount: 8,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: articleBuilder(
                        index: index,
                        list: NewsCubit.scienceList,
                      ),
                    )),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
