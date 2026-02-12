import 'package:e_commerce_app/view/reusable_widgets/reusable_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
        child: Column(
          children: [
            Text(
              "Favorites",
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 9 / 14,
                  crossAxisSpacing: 1.w,
                  mainAxisSpacing: 1.h,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20.sp),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          width: 30.w,
                          fit: BoxFit.contain,
                          'https://cdn.dummyjson.com/product-images/beauty/red-lipstick/thumbnail.webp',
                        ),
                        ListTile(
                          title: Text("Data"),
                          subtitle: Text("\$32"),
                          trailing: Icon(Icons.favorite, color: Colors.red),
                        ),
                        ReusableButton(
                          onTap: () {},
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.h,
                          ),
                          containerColor: Colors.orange,
                          alignment: Alignment.center,
                          text: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag_rounded,
                                size: 18.sp,
                                color: Colors.white,
                              ),
                              Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
