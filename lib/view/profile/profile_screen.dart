import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/cache/cache_helper.dart';
import 'package:e_commerce_app/cache/hive.dart';
import 'package:e_commerce_app/controller/theme/theme_cubit.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/reusable_widgets/show_dialog.dart';
import 'package:e_commerce_app/view/authantications/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../controller/auth/auth_cubit.dart';
import '../../controller/auth/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
          child: ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text("Dark Theme"),
            trailing: Switch(
              value: context.read<ThemeCubit>().state == ThemeMode.dark,
              onChanged: (val) {
                context.read<ThemeCubit>().toggle();
              },
            ),
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is FailedGetUserDataState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is SuccessGetUserDataState) {
            final data = state.model;
            List<dynamic> listTileTitle = [
              data.firstName + data.lastName,
              data.email,
              data.phone,
              data.address.city,
              data.birthDate,
              data.age.toString(),
              "Log Out",
            ];
            List<Widget> icons = [
              Icon(Icons.person, size: 25.sp),
              Icon(Icons.email, size: 25.sp),
              Icon(Icons.phone, size: 25.sp),
              Icon(Icons.location_city, size: 25.sp),
              Icon(Icons.date_range, size: 25.sp),
              Icon(Icons.person, size: 25.sp),
              Icon(Icons.logout, size: 25.sp, color: Colors.red),
            ];
            return ListView(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    height: 25.h,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://img.freepik.com/premium-vector/avatar-profile-icon-'
                          'flat-style-female-user-profile-vector-illustration-isolated'
                          '-background-women-profile-sign-business-concept_157943-'
                          '38866.jpg?semt=ais_user_personalization&w=740&q=80',
                      height: 20.h,
                      imageBuilder: (context, imageProvider) {
                        return CircleAvatar(
                          maxRadius: 40.sp,
                          backgroundImage: imageProvider,
                        );
                      },
                      placeholder: (context, url) {
                        return Center(child: CircularProgressIndicator());
                      },
                      errorWidget: (context, error, val) {
                        return Icon(Icons.person, size: 50.sp);
                      },
                    ),
                  ),
                ),
                ...List.generate(listTileTitle.length, (e) {
                  return ListTile(
                    visualDensity: const VisualDensity(vertical: -2),
                    onTap: () {
                      if (listTileTitle[e] == "Log Out") {
                        ShowDialogWidget.removingItemDialog(
                          context: context,
                          onPressed: () {
                            // CacheHelper().removeData(key: ApiKey.accessToken);
                            HiveCache.users?.delete(ApiKey.accessToken);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false,
                            );
                          },
                          content: "Are You Sure You Want Log Out",
                          title: "Log Out",
                          cancel: "Cancel",
                          ok: "Yes",
                        );
                      } else {}
                    },
                    title: Text(
                      listTileTitle[e],
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    leading: icons[e],
                    subtitle: listTileTitle[e] == data.address.city
                        ? Text(data.address.address)
                        : null,
                  );
                }),
              ],
            );
          }
          if (state is FailedGetUserDataState) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: Text("No user data found"));
        },
      ),
    );
  }
}
