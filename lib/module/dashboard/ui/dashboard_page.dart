import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/search_box.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<DashboardProvider>(context, listen: false).initConfig(context);
    return Scaffold(
      backgroundColor: ColorUtils.lightGray,
      body: Consumer<DashboardProvider>(
          builder: (context, dashboardController, child) {
        return Container(
          width: displayWeight(context),
          child: dashboardController.screens[dashboardController.currentPage]);
      }),
      bottomNavigationBar: Consumer<DashboardProvider>(
          builder: (context, dashboardController, child) {
        return BottomAppBar(
          elevation: 0,
          padding: EdgeInsets.zero,
          color: ColorUtils.white,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
            child: Container(
              height: 55,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        dashboardController.changePage(0);
                      },
                      child: _buildBottomBarItem(
                          context: context,
                          title: 'Home',
                          selectedIcon: ImageUtils.SelectedHome,
                          icon: ImageUtils.HomeIcon,
                          isSelected: dashboardController.currentPage == 0)),
                  InkWell(
                      onTap: () {
                        dashboardController.changePage(1);
                      },
                      child: _buildBottomBarItem(
                          context: context,
                          title: 'Applies',
                          selectedIcon: ImageUtils.SelectedApplies,
                          icon: ImageUtils.Applied,
                          isSelected: dashboardController.currentPage == 1)),
                  InkWell(
                    onTap: () {
                      dashboardController.changePage(2);
                    },
                    child: _buildBottomBarItem(
                        context: context,
                        title: 'Profile',
                        selectedIcon: ImageUtils.SelectedProfile,
                        icon: ImageUtils.Profile,
                        isSelected: dashboardController.currentPage == 2),
                  ),
                  InkWell(
                      onTap: () {
                        dashboardController.changePage(3);
                      },
                      child: _buildBottomBarItem(
                          context: context,
                          title: 'Alerts',
                          selectedIcon: ImageUtils.SelectedAdd,
                          icon: ImageUtils.AddIcon,
                          isSelected: dashboardController.currentPage == 3))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _buildBottomBarItem(
      {required BuildContext context,
      required String title,
      required String icon,
      required String selectedIcon,
      required bool isSelected}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageUtils.getImage(
            image: isSelected ? selectedIcon : icon, height: 20, width: 20),
        const SizedBox(
          height: 5,
        ),
        headingH12(
            text: title,
            context: context,
            color: isSelected ? ColorUtils.blackColor : ColorUtils.lightGrey)
      ],
    );
  }
}
