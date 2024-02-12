import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/bookmarks_controller.dart';
import '../../../controllers/general_controller.dart';
import '../widgets/audio/audio_widget.dart';
import '../widgets/left_page.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/right_page.dart';
import '/core/widgets/tab_bar_widget.dart';
import '/presentation/controllers/audio_controller.dart';
import '/presentation/controllers/quran_controller.dart';
import '/presentation/screens/quran_page/widgets/pages_widget.dart';

class MPages extends StatelessWidget {
  MPages({Key? key}) : super(key: key);
  final audioCtrl = sl<AudioController>();
  final generalCtrl = sl<GeneralController>();
  final quranCtrl = sl<QuranController>();
  final bookmarkCtrl = sl<BookmarksController>();

  @override
  Widget build(BuildContext context) {
    bookmarkCtrl.getBookmarks();
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          GetBuilder<GeneralController>(
            builder: (generalCtrl) => PageView.builder(
                controller: generalCtrl.pageController(),
                itemCount: 604,
                physics: const ClampingScrollPhysics(),
                onPageChanged: generalCtrl.pageChanged,
                itemBuilder: (_, index) {
                  return (index % 2 == 0
                      ? Semantics(
                          image: true,
                          label: 'Quran Page',
                          child: RightPage(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PagesWidget(pageIndex: index),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (bookmarkCtrl
                                                .isPageBookmarked(index + 1)) {
                                              bookmarkCtrl.deleteBookmarks(
                                                  index + 1, context);
                                            } else {
                                              bookmarkCtrl
                                                  .addAyahBookmark(
                                                      index + 1,
                                                      quranCtrl
                                                          .getSurahNameFromPage(
                                                              index + 1),
                                                      generalCtrl
                                                          .timeNow.lastRead)
                                                  .then((value) =>
                                                      customErrorSnackBar(
                                                          'addBookmark'.tr));
                                              print('addBookmark');
                                              print(
                                                  '${generalCtrl.timeNow.lastRead}');
                                              // bookmarkCtrl
                                              //     .savelastBookmark(index + 1);
                                            }
                                          },
                                          child:
                                              bookmarkIcon(context, 30.0, 30.0),
                                        ),
                                        const Gap(16),
                                        Text(
                                          '${'juz'.tr}: ${generalCtrl.convertNumbers(quranCtrl.pages[index + 1].first.juz.toString())}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: 'naskh',
                                              color: Color(0xff77554B)),
                                        ),
                                        const Spacer(),
                                        Text(
                                          quranCtrl.getSurahNameFromPage(index),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: 'naskh',
                                              color: Color(0xff77554B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    '${generalCtrl.convertNumbers('${index + 1}')}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: 'naskh',
                                        color: Color(0xff77554B)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Semantics(
                          image: true,
                          label: 'Quran Page',
                          child: LeftPage(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PagesWidget(pageIndex: index),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          quranCtrl.getSurahNameFromPage(index),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: 'naskh',
                                              color: Color(0xff77554B)),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${'juz'.tr}: ${generalCtrl.convertNumbers(quranCtrl.pages[index].first.juz.toString())}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: 'naskh',
                                              color: Color(0xff77554B)),
                                        ),
                                        const Gap(16),
                                        GestureDetector(
                                          onTap: () {
                                            if (bookmarkCtrl
                                                .isPageBookmarked(index + 1)) {
                                              bookmarkCtrl.deleteBookmarks(
                                                  index + 1, context);
                                            } else {
                                              bookmarkCtrl
                                                  .addAyahBookmark(
                                                      index + 1,
                                                      quranCtrl
                                                          .getSurahNameFromPage(
                                                              index + 1),
                                                      generalCtrl
                                                          .timeNow.lastRead)
                                                  .then((value) =>
                                                      customErrorSnackBar(
                                                          'addBookmark'.tr));
                                              print('addBookmark');
                                              print(
                                                  '${generalCtrl.timeNow.lastRead}');
                                              // bookmarkCtrl
                                              //     .savelastBookmark(index + 1);
                                            }
                                          },
                                          child:
                                              bookmarkIcon(context, 30.0, 30.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    '${generalCtrl.convertNumbers('${index + 1}')}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: 'naskh',
                                        color: Color(0xff77554B)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                }),
          ),
          Obx(() => generalCtrl.isShowControl.value
              ? const TabBarWidget(
                  isChild: true,
                  isIndicator: true,
                )
              : const SizedBox.shrink()),
          Obx(() =>
              audioCtrl.isStartPlaying.value || generalCtrl.isShowControl.value
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: AudioWidget(),
                    )
                  : const SizedBox.shrink()),
          Obx(() => generalCtrl.isShowControl.value
              ? const Align(
                  alignment: Alignment.bottomCenter,
                  child: NavBarWidget(),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
