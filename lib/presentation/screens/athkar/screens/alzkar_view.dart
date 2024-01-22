import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/lists.dart';
import '../../../../core/widgets/widgets.dart';
import '../models/all_azkar.dart';
import '/core/utils/constants/extensions.dart';
import 'azkar_fav.dart';
import 'azkar_item.dart';

class AzkarView extends StatefulWidget {
  const AzkarView({Key? key}) : super(key: key);

  @override
  State<AzkarView> createState() => _AzkarViewState();
}

class _AzkarViewState extends State<AzkarView> {
  var controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Random rnd = Random();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Get.theme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: Get.theme.colorScheme.background,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(
                color: Get.theme.colorScheme.background,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  width: 2,
                  color: Get.theme.colorScheme.surface,
                )),
            child: DefaultTabController(
              length: 2,
              child: context.definePlatform(
                  context.customOrientation(
                      Column(
                        children: [
                          zekrWidget(context),
                          Expanded(child: tabBar(context)),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: zekrWidget(context),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width /
                                  1 /
                                  2 *
                                  .90,
                              child: tabBar(context),
                            ),
                          ),
                        ],
                      )),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: zekrWidget(context),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1 / 2,
                          child: tabBar(context),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget tabBar(BuildContext context) {
    return Column(
      children: [
        TabBar(
          unselectedLabelColor: Colors.grey,
          indicatorColor: Get.theme.primaryColorLight,
          tabs: [
            Semantics(
              button: true,
              enabled: true,
              excludeSemantics: true,
              label: 'azkar'.tr,
              child: Tab(
                child: Text(
                  'azkar'.tr,
                  style: TextStyle(
                    color: Get.theme.colorScheme.surface,
                    fontFamily: 'kufi',
                  ),
                ),
              ),
            ),
            Semantics(
              button: true,
              enabled: true,
              excludeSemantics: true,
              label: 'azkarfav'.tr,
              child: Tab(
                child: Text(
                  'azkarfav'.tr,
                  style: TextStyle(
                      color: Get.theme.colorScheme.surface,
                      fontFamily: 'kufi',
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: <Widget>[
              Stack(
                children: [
                  AnimationLimiter(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: azkarDataList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 450),
                            child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                    child: _buildListItem(context, index))));
                      },
                    ),
                  ),
                ],
              ),
              const AzkarFav(),
            ],
          ),
        ),
      ],
    );
  }

  Widget zekrWidget(BuildContext context) {
    var element = zikr[rnd.nextInt(zikr.length)];
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: .05,
          child: SvgPicture.asset(
            'assets/svg/athkar.svg',
            height: context.customOrientation(220.0, 250.0),
            width: context.customOrientation(220.0, 250.0),
          ),
        ),
        Container(
          height: 190.0,
          width: context.customOrientation(
              MediaQuery.sizeOf(context).width,
              context.definePlatform(
                  MediaQuery.sizeOf(context).width / 1 / 2 * .65,
                  MediaQuery.sizeOf(context).width / 1 / 2 * .8)),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          margin: context.customOrientation(
              const EdgeInsets.symmetric(horizontal: 16.0),
              const EdgeInsets.only(left: 32.0, right: 32.0)),
          decoration: BoxDecoration(
              color: Get.theme.colorScheme.surface.withOpacity(.5),
              border: Border.symmetric(
                  vertical: BorderSide(
                      color: Get.theme.colorScheme.surface, width: 2))),
          child: Text(
            element,
            style: TextStyle(
                color:
                    Get.isDarkMode ? Colors.white : Get.theme.primaryColorDark,
                fontSize: context.definePlatform(
                    context.customOrientation(22.0, 18.0), 18.0),
                height: 1.7,
                fontFamily: 'naskh',
                fontWeight: FontWeight.w100),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: index == 0
              ? const Radius.circular(20.0)
              : const Radius.circular(5.0),
          topRight: index == 0
              ? const Radius.circular(20.0)
              : const Radius.circular(5.0),
          bottomLeft: index == azkarDataList.length - 1
              ? const Radius.circular(20.0)
              : const Radius.circular(5.0),
          bottomRight: index == azkarDataList.length - 1
              ? const Radius.circular(20.0)
              : const Radius.circular(5.0),
        ),
        color: (index % 2 == 0
            ? Get.theme.colorScheme.surface.withOpacity(.2)
            : Get.theme.colorScheme.background),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(animatRoute(
            AzkarItem(
              azkar: azkarDataList[index].toString().trim(),
            ),
          ));
        },
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  azkarDataList[index].toString(),
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? Get.theme.canvasColor
                        : Get.theme.primaryColorDark,
                    fontSize: 20,
                    fontFamily: 'kufi',
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
