import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:course_view/core/constants/images.dart';
import 'package:course_view/core/extensions/string.dart';
import 'package:course_view/pages/course_view/challenges_tab.dart';
import 'package:course_view/pages/course_view/comments_tab.dart';
import 'package:course_view/pages/course_view/lectures_tab.dart';
import 'package:course_view/pages/support/page.dart';
import 'package:course_view/router/route.dart';
import 'package:course_view/utils/download.dart';
import 'package:course_view/widgets/button.dart';
import 'package:course_view/widgets/list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/place_holders.dart';
import '../home/model.dart';
import 'model.dart';
import 'notes_tab.dart';
import 'provider.dart';
import 'controller.dart';

class CourseViewPage extends ConsumerStatefulWidget
    with CourseViewPageController {
  const CourseViewPage({
    Key? key,
    required this.course,
  }) : super(key: key);
  final CoursesModel course;

  @override
  ConsumerState<CourseViewPage> createState() => _CourseViewPageState();
}

class _CourseViewPageState extends ConsumerState<CourseViewPage> {
  late VideoPlayerController _videoController1;
  late VideoPlayerController _videoController2;
  ChewieController? _chewieController;
  int? bufferDelay;
  bool completed = false;
  final _download = Download();

  final _items = <String>[
    '195 Lessons well-tutored',
    'Full Lifetime access',
    '85 Exclusive Lessons & Details Notes',
    'Past Questions Tread',
    '50+ Exam-standard Q&A detailed explanation',
    'Play the leaderboard game with others',
    'Solved past question on each topic',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (completed) {
      _videoController1.dispose();
      _videoController2.dispose();
      _chewieController?.dispose();
    }
    super.dispose();
  }

  Future<void> initializePlayer(Module module) async {
    if (!_download.isInitialized) {
      await _download.initialize();
    }
    log(completed.toString());
    // if (completed) return;
    ref.read(canPlayVideoProvider.notifier).update((state) => false);

    if (completed) {
      await _videoController1.pause();
    }

    final file = await _download.getVideo(module.url, module.id, 'mp4');

    if (file != null) {
      _videoController1 = VideoPlayerController.file(file);
      _videoController2 = VideoPlayerController.file(file);

      await Future.wait([
        _videoController1.initialize(),
        _videoController2.initialize(),
      ]);

      _createChewieController();
      completed = true;
      ref.read(canPlayVideoProvider.notifier).update((state) => true);
    }
  }

  Future<void> downloadAllVideos(List<Lessons> lessons) async {
    List<Module> modules = [];
    List<ValueNotifier<bool>> valueNotifiers = [];

    for (var lesson in lessons) {
      for (var module in lesson.modules) {
        modules.add(module);
        valueNotifiers.add(ValueNotifier<bool>(false));
      }
    }

    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return DownloadDialog(
          modules: modules,
          valueNotifiers: valueNotifiers,
        );
      },
    );
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoController1,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
    );
  }

  void _onDoubleTap(TapDownDetails details) {
    if (ref.watch(doubleTapHandledProvider)) {
      // ref.read(doubleTapHandledProvider.notifier).update((state) => false);
      return;
    }

    ref.read(doubleTapHandledProvider.notifier).update((state) => true);
    // Get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;

    // Get the tap position within the screen
    double tapPosition = details.globalPosition.dx;

    // Calculate the region sizes
    double leftRegion = screenWidth / 3;
    double rightRegion = 2 * leftRegion;

    // Get the current position of the video
    final currentDuration =
        _chewieController!.videoPlayerController.value.position;

    // Define the seek duration for forward/backward (e.g., 10 seconds)
    const seekDuration = Duration(seconds: 10);

    // Check the tap position and perform the appropriate action
    if (tapPosition < leftRegion) {
      // Double-tap on the left: Seek backward
      if (currentDuration - seekDuration > Duration.zero) {
        _chewieController!.seekTo(currentDuration - seekDuration);
        ref.read(isBackwardingProvider.notifier).update((state) => true);
      } else {
        _chewieController!.seekTo(Duration.zero);
        ref.read(isForwardingProvider.notifier).update((state) => true);
      }
    } else if (tapPosition > rightRegion) {
      // Double-tap on the right: Seek forward
      if (currentDuration + seekDuration <
          _chewieController!.videoPlayerController.value.duration) {
        _chewieController!.seekTo(currentDuration + seekDuration);
      } else {
        _chewieController!
            .seekTo(_chewieController!.videoPlayerController.value.duration);
      }
    } else {
      // Double-tap in the center: Play/Pause
      if (_chewieController!.videoPlayerController.value.isPlaying) {
        _chewieController!.pause();
      } else {
        _chewieController!.play();
      }
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      ref.read(doubleTapHandledProvider.notifier).update((state) => false);
      ref.read(isForwardingProvider.notifier).update((state) => false);
      ref.read(isBackwardingProvider.notifier).update((state) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final course = ref.watch(courseProvider(widget.course.id));
    final canPlayVideo = ref.watch(canPlayVideoProvider);
    final isForwarding = ref.watch(isForwardingProvider);
    final isBackwarding = ref.watch(isBackwardingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Course View'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.lock_outline_rounded,
              color: Colors.blueGrey.shade600,
            ),
          ),
        ],
      ),
      body: course.when(
        data: (data) {
          return Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: canPlayVideo
                    ? GestureDetector(
                        onDoubleTapDown: _onDoubleTap,
                        child: IgnorePointer(
                          ignoring: ref.watch(doubleTapHandledProvider),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Chewie(controller: _chewieController!),
                              if (isForwarding)
                                Positioned(
                                  left: 10,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.refresh,
                                          color: Colors.grey.shade200,
                                          size: 40,
                                        ),
                                      ),
                                      const Text(
                                        '10',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              if (isBackwarding)
                                Positioned(
                                  right: 10,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.refresh,
                                          color: Colors.grey.shade200,
                                          size: 40,
                                        ),
                                      ),
                                      const Text(
                                        '10',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    : Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          ImageLoader(
                            imageUrl: widget.course.thumbnail,
                            fit: BoxFit.cover,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.zero),
                          ),
                          Container(
                            color: Colors.grey.withOpacity(.3),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.course.title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              ActionButton(
                                onPressed: () {},
                                iconData: CupertinoIcons.link,
                                text: 'Share',
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Wooah! Fully Loaded',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            'This course includes',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8.0),
                          ..._items.map((item) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    CupertinoIcons.checkmark_seal,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    item,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 12.0),
                          Text(
                            'Instructor',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              SizedBox.square(
                                dimension: 45,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade900,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'A',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Ahmed Suluka ACA, ASSA',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  Text('Head of school ExcelAcademy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          MaterialButton(
                            onPressed: () => downloadAllVideos(data.lessons),
                            elevation: 0,
                            padding: const EdgeInsets.fromLTRB(
                                5.0, 10.0, 10.0, 10.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox.square(
                                  dimension: 48.0,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: AssetImages.folder2,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Course Material Available',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      Text(
                                        'Download the course files before '
                                        'proceeding to watch the course',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                const Icon(
                                  Icons.file_download_outlined,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: DefaultTabController(
                              length: 4,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TabBar(
                                    isScrollable: true,
                                    labelColor: Colors.blueGrey,
                                    unselectedLabelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    indicatorColor:
                                        Theme.of(context).primaryColor,
                                    tabs: const <Widget>[
                                      Tab(text: 'Lectures', height: 40),
                                      Tab(text: 'Notes', height: 40),
                                      Tab(text: 'Comments', height: 40),
                                      Tab(text: 'Challenges', height: 40),
                                    ],
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 200,
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: TabBarView(
                                        children: <Widget>[
                                          LecturesTab(
                                            data: data,
                                            onPressed: (module) async {
                                              await initializePlayer(module);
                                            },
                                          ),
                                          const NotesTab(),
                                          const CommentsTab(),
                                          const ChallengesTab(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(),
                      const SizedBox(height: 5),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Pay today',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox.square(
                                    dimension: 5.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'save NGN 6,200.00',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 5.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.blueGrey.shade400,
                                ),
                                const SizedBox(width: 5.0),
                                Flexible(
                                  child: Text(
                                    'This package is exclusive to '
                                    'this particular course only',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blueGrey.shade800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            // Text(
                            //   'NGN 24,000.00',
                            //   style: TextStyle(
                            //     fontSize: 17,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.black87,
                            //     decoration: TextDecoration.lineThrough,
                            //   ),
                            // ),
                            Text(
                              'NGN ${data.price.toString().formatToPrice}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            ElevatedButton(
                              onPressed: () =>
                                  widget.onEnrollNow(context, data),
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColor,
                                ),
                                foregroundColor: const MaterialStatePropertyAll(
                                  Colors.white,
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                minimumSize: const MaterialStatePropertyAll(
                                  Size(double.infinity, 48),
                                ),
                              ),
                              child: const Text('Enroll now'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // SizedBox(),
                      // ...[
                      // const SizedBox(height: 30.0),
                      // _titleText('Course Description'),
                      // _bodyText(widget.course.description),
                      // const SizedBox(height: 30.0),
                      // _smallText('Curriculum'),
                      // _titleText('Learn-by doing with our Exclusion Videos'),
                      // _bodyText(
                      //   'Our Course is setup to make you learn Advanced Audit and '
                      //   'Assurance(Revision) by step with a practical detailed note/'
                      //   'video that focuses 100% on learn-by-doing',
                      // ),
                      // const SizedBox(height: 30.0),
                      // _smallText('On Course Completion'),
                      // _titleText('Course Requirements'),
                      // _bodyText('On successful completion of this cour'),
                      // _smallText('COURSE PRICING'),
                      // _titleText('Simple, transparent pricing'),
                      // _bodyText(
                      //   'We keep track of the pricing of the '
                      //   'course from onset without computing',
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _titleText('Got few questions for us?'),
                          _bodyText(
                            'We keep track of the pricing of the '
                            'course from onset without compromising',
                          ),
                          QuestionListTile(
                            onPressed: () {},
                            question: 'How do we have access to the course?',
                          ),
                          QuestionListTile(
                            onPressed: () {},
                            question: 'How do we have access to the course?',
                          ),
                          QuestionListTile(
                            onPressed: () {},
                            question: 'How do we have access to the course?',
                          ),
                          const SizedBox(height: 10),
                          _titleText('Still not conceived with Q&A?'),
                          _bodyText(
                            'We keep track of the pricing of the '
                            'course from onset without compromising',
                          ),
                          const SizedBox(height: 15.0),
                          OutlinedButton(
                            onPressed: () =>
                                pushTo(context, const SupportPage()),
                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor,
                              ),
                              side: MaterialStatePropertyAll(
                                BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              minimumSize: const MaterialStatePropertyAll(
                                Size(double.infinity, 48),
                              ),
                            ),
                            child: const Text('Send us a message'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'NGN ${(data.price + 1000).toString().formatToPrice}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          'NGN ${data.price.toString().formatToPrice}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => widget.onEnrollNow(context, data),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor,
                          ),
                          foregroundColor: const MaterialStatePropertyAll(
                            Colors.white,
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          minimumSize: const MaterialStatePropertyAll(
                            Size(0, 48),
                          ),
                        ),
                        child: const Text('Enroll now'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (_, __) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('An error as occurred, please try again'),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () =>
                      ref.refresh(courseProvider(widget.course.id)),
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _titleText(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _smallText(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}

class DownloadDialog extends StatelessWidget {
  DownloadDialog({
    Key? key,
    required this.modules,
    required this.valueNotifiers,
  }) : super(key: key);
  final List<Module> modules;
  final List<ValueNotifier<bool>> valueNotifiers;

  final isStartedNotifier = ValueNotifier<bool>(false);

  Future<void> _startDownload(context) async {
    final download = Download();

    if (!download.isInitialized) {
      await download.initialize();
    }

    isStartedNotifier.value = true;
    int index = 0;
    for (var module in modules) {
      if (valueNotifiers.elementAt(index).value) {
        log(module.url);
        await download.getVideo(module.url, module.id, 'mp4');
      }
      index++;
    }
    _popDialog(context);
  }

  void _popDialog(BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: ValueListenableBuilder(
        valueListenable: isStartedNotifier,
        builder: (context, isStarted, _) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (isStarted) const LinearProgressIndicator(),
                const SizedBox(height: 10.0),
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Text(
                    'Select files to download',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  child: Text(
                    'Select the course you want to download, '
                    'you may download others later as you watch.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...modules.asMap().entries.map(
                              (e) => ListTile(
                                onTap: () =>
                                    valueNotifiers.elementAt(e.key).value =
                                        !valueNotifiers.elementAt(e.key).value,
                                leading: Text('${e.key + 1}.'),
                                minLeadingWidth: 0,
                                title: Text(e.value.name),
                                trailing: isStarted
                                    ? const SizedBox.square(
                                        dimension: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : ValueListenableBuilder<bool>(
                                        valueListenable:
                                            valueNotifiers.elementAt(e.key),
                                        builder: (context, isSelected, _) {
                                          return IgnorePointer(
                                            child: Checkbox(
                                              value: isSelected,
                                              onChanged: (value) {},
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              side: BorderSide(
                                                width: 1.6,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          );
                                        }),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                dense: true,
                                visualDensity: const VisualDensity(
                                  vertical: -4,
                                  horizontal: -4,
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                CustomElevatedButton(
                  onPressed: () => _startDownload(context),
                  text: 'Download selected',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
