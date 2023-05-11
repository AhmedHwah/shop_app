import 'package:flutter/material.dart';


class articleBuilder extends StatelessWidget {
  var myList = [];
  int index = 0;
  articleBuilder({
    Key? key,
    required int index,
    required var list,
  }) {
    myList = list;
    this.index = index;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
        },
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Image.network(
                myList[index]['urlToImage'] != null
                    ? '${myList[index]['urlToImage']}'
                    : 'https://guide-images.cdn.ifixit.com/igi/o4OjCNmNeOhvsS1P.standard',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                height: 120,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${myList[index]['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1
                      ),
                    ),
                    Text(
                      '${myList[index]['publishedAt']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
