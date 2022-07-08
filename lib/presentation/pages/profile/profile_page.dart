import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_app/domain/entities/account.dart';
import 'package:training_app/presentation/components/components.dart';
import 'package:training_app/presentation/pages/profile/profile_controller.dart';
import 'package:training_app/presentation/pages/profile/views/index.dart';
import 'package:training_app/presentation/pages/profile/widgets/profile_header.dart';
import 'package:training_app/presentation/pages/profile_edit/views/index.dart';

import 'package:training_app/presentation/theme/theme.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguageCode = ref.watch(languageController);
    const tabbar = ProfileTab.values;
    final header = ProfileHeader(
      account: ref.watch(accountController).value?.object ?? Account(),
      currentLanguage: currentLanguageCode,
      onTapSetting: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const ProfileSetting()));
      },
    );

    
    // ref.listen(accountController, (previous, next) {});
    const footer = PreviewFooter();
    return DefaultTabController(
      length: tabbar.length,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Consumer(builder: (context, ref, child) {
            // can be switch only main section but not save offset of list
            return IndexedStack(
              index: ref.watch(tabController),
              children: tabbar
                  .map(
                    (tab) => ListView(
                      children: [
                        /////////// header
                        header,
                        //////////// end header
                        const SizedBox(height: 30),
                        //main section
                        mapTabView(tab),
                        //end main
                        const SizedBox(height: 90),
                        ////////////////// footer
                        footer
                        ////////////////// end footer
                      ],
                    ),
                  )
                  .toList(),
            );
          }),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
          padding: const EdgeInsets.only(top: 5),
          height: 75,
          width: double.maxFinite,
          decoration: ShapeDecoration(
            shadows: [
              BoxShadow(blurRadius: 5, color: AppColors.black.withOpacity(0.25))
            ],
            color: AppColors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Center(child: Consumer(builder: (context, ref, _) {
            return TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelStyle: TextStyles.smallBold,
              labelColor: AppColors.customizeFG,
              unselectedLabelColor: AppColors.customizeFG.withOpacity(0.5),
              tabs: tabbar
                  .map((tab) => Tab(
                        text: tab.tabName,
                        iconMargin: const EdgeInsets.only(bottom: 5),
                        // icon: Icon(Icons.abc),
                        icon: SvgPicture.asset(
                          tab.tabIcon,
                          height: 24,
                          color: tabbar[ref.watch(tabController)] == tab
                              ? AppColors.customizeFG
                              : AppColors.customizeFG.withOpacity(0.5),
                        ),
                      ))
                  .toList(),
              onTap: (index) {
                ref.read(tabController.state).state = index;
              },
            );
          })),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget mapTabView(ProfileTab tab) {
    switch (tab) {
      case ProfileTab.home:
        return const ProfileHome();
      case ProfileTab.spot:
        return const ProfileSpot();
      case ProfileTab.skill:
        return const ProfileSkill();
      case ProfileTab.activity:
        return const ProfileActivity();
      case ProfileTab.photo:
        return const ProfilePhoto();
    }
  }
}
