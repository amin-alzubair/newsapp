
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticles(article, context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              )
          ),
        ),
        SizedBox(
          width: 20.0,
        ),

        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

Widget myDivide()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color:Colors.grey[300],
  ),
);

Widget articleBuilder(list,context)=>ConditionalBuilder(
  condition: list.length > 0,
  builder: (context)=>ListView.separated(
    itemBuilder: (context, index)=>buildArticles(list[index],context),
    separatorBuilder: (context,index)=>myDivide(),
    itemCount: list.length,
  ),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);

void navigator(context, widget)=>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>widget)
);