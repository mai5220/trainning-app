import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_app/presentation/components/components.dart';
import 'package:training_app/presentation/theme/theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    Size size = MediaQuery.of(context).size;
    const String avt =
        'https://s3-alpha-sig.figma.com/img/9991/cef5/aaed996b4b1aeec0bd3f612bc276f858?Expires=1657497600&Signature=D~I9pookPfjgdM4xt5PDfVUwTz~EToXUyB-Zk1QyRNUaxd9trxyygaJyu-luBGIeE6IIzp53hP5rh0jNdN5ClXTMlo6dqHguBKo~L7CJwA9mPQFUCsL0M~c-uS4F0ESrQJFpMGKAuWkLcAPk8fzJiGdWo4OPYbbpni73I~zkKc5sY~pplU8m6GHjwo5MuqQkOkDn4W3lwuszf9hkiLoplwBIKkYJ9380W6gPULztecfVKeJ4IJroKVLcvNjMgg0vCIZFtzuZocqO7~p3o1moVtORq2eUT~Ef4lx7oR-HC0R8LCD1JuVCJcJoXSKty~TBbEpW0Igk-tl6DEEFWHuxkw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA';

    const String cover =
        'https://s3-alpha-sig.figma.com/img/089f/a4c7/8b3c7a6da07b05c7c3020cc539ff0037?Expires=1657497600&Signature=g-Tz9EV~lncFq9QKg9prRMNSItxS1IAJ9M2DUpdJFPLrcpRtX831VuUCXSxEYCQmQhcqzFOcgZ11G5-mTzbKldUTol5WQV7GtOU988I4-lgXXYVPdbLW3yqdWMgZKcN24l2FbEZ8vOOgs7n67wc-0aiSbZRPoKeQVasRK~IsTw3UFXzB2Acy14RC~4fdCnz3kE48Ie5W3nww5ioE8vnvE8QllTBIehLhOfJPTJ~QOlbW1djDlUYN0FtG8vJCxogF8ETu9nYznpPHc3aJcGdk3zuxGNP2OPyra74ivmfhWDA6uIDeuyaKTkIMvnlFtsuBiMjM4VKpyIWzTfk2zwAhtg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA';
    
    return Stack(children: [
      Positioned.fill(
        child: CustomPaint(
          // size: Size.square(size.width),
          painter: ShapeBackgroundPainter(color: AppColors.lightBlue),
        ),
      ),
      Column(
        children: [
          Container(
            height: 64,
            // color: AppColors.lightBlue,
            padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.horizontalMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SvgPicture.asset(AppAssets.markColor),
                SizedBox(
                  height: 34,
                  child: Image.asset(AppAssets.mark),
                ),
                InkWell(
                  onTap: () => globalKey.currentState?.openEndDrawer(),
                  child: SizedBox(
                    height: 18,
                    child: SvgPicture.asset(AppAssets.menu),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            indent: 24,
            endIndent: 24,
            height: 1,
            thickness: 1,
          ),
          Align(
            // toggle button
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.only(right: AppStyles.horizontalMargin),
              child: Container(
                height: 28,
                width: 71 * 2,
                color: AppColors.white,
              ),
            ),
          ),
          Stack(
            fit: StackFit.loose,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 31,
                  left: AppStyles.horizontalMargin,
                  right: AppStyles.horizontalMargin,
                ),
                child: NetImage(
                  width: double.maxFinite,
                  height: 154,
                  imageUrl: cover,
                  placeHolder: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.greyBackground,
                        boxShadow: [
                          BoxShadow(blurRadius: 3, color: AppColors.greyBorder)
                        ]),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.image,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                  left: AppStyles.horizontalMargin - 3,
                  bottom: 0,
                  child: BorderAvatar(
                    size: 90,
                    imageUrl: avt,
                  )),
              Positioned(
                  bottom: 0,
                  right: AppStyles.horizontalMargin + 10,
                  child: SizedBox(
                    height: 20,
                    child: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        // color: AppColors.white,
                        child: Row(children: [
                          const Icon(
                            Icons.settings,
                            size: 16,
                            color: AppColors.black1,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'プロフィール編集',
                            style: TextStyles.smallRegular.copyWith(
                                // backgroundColor: AppColors.primaryColor,
                                height: 1),
                          )
                        ]),
                        onPressed: () {}),
                  ))
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.horizontalMargin),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '旅行 花子',
                        style: TextStyles.extraLargeBold,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Ryoko Hanako',
                        style: TextStyles.smallRegular
                            .copyWith(color: AppColors.black.withOpacity(0.8)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '沖縄ネイチャーガイド',
                        style: TextStyles.mediumBold,
                      )
                    ],
                  ),
                ),
                CustomButton(
                  icon: SvgPicture.asset(AppAssets.phoneOutlined),
                ),
                const SizedBox(width: 16),
                CustomButton(
                  icon: SvgPicture.asset(AppAssets.emailOutlined),
                )
              ],
            ),
          ),
          const SizedBox(height: 43)
        ],
      ),
    ]);
  }
}
