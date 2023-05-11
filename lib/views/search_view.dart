import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/cubit/news_cubit.dart';
import 'package:shopapp/shared/compoments.dart';

class SearchView extends StatelessWidget {
   SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).search;
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state) {

      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height ,
            child: Column(
              children: [
               TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
                SizedBox(height: 30,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 300,
                      child: ConditionalBuilder(
                        condition: state is! NewsSearchLoadingState,
                        builder: (context) =>ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context,index) => articleBuilder(index: index, list: list),),
                        fallback: (context) => Center(child: CircularProgressIndicator(),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
