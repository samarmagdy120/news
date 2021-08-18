import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/WebViewScreen.dart';
import 'package:news_app/shared/cubit/states.dart';

Widget BuildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage("${article['urlToImage']}"),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${article['title']}",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list, context,{isSearch = false}) => Container(
      child: list.length > 0
          ? ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  BuildArticleItem(list[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: list.length)
          : (isSearch = true) ? Container() : Center(child: CircularProgressIndicator()),
    );

/***************************/

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        ValueChanged? onSubmit,
        ValueChanged? onChange,
        required FormFieldValidator validate,
        required String label,
        IconData? suffix,
        required IconData prefix,
        VoidCallback? suffixPressed,
        ispassword = false}) =>
    TextFormField(
      // 3lshan a7'd ali gwah
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: suffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );

/***************************************/

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
