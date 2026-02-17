import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FailedLoadProductScreen extends StatelessWidget {
  const FailedLoadProductScreen({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  final Icon icon;
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/no internet.jpg', height: 50.h),
                  Text(
                    text,
                    style: TextStyle(fontSize: 20.sp, color: Colors.black54),
                  ),
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(Icons.refresh, size: 30.sp),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
