import 'package:chewie/chewie.dart';
import 'package:course_view/pages/course_view/challenges_tab.dart';
import 'package:course_view/pages/course_view/comments_tab.dart';
import 'package:course_view/pages/course_view/lectures_tab.dart';
import 'package:course_view/utils/download.dart';
import 'package:course_view/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../home/model.dart';
import 'model.dart';
import 'notes_tab.dart';
import 'provider.dart';

class CourseViewPage extends ConsumerStatefulWidget {
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
    final download = Download();
    await download.initialize();

    if (completed) return;

    final file = await download.getVideo(module.url, module.id, 'mp4');

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
          initializePlayer(data.lessons.first.modules.first);
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
                    : Container(
                        color: Colors.grey.withOpacity(.3),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.course.title,
                              style: Theme.of(context).textTheme.titleMedium,
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
                      const SizedBox(height: 4.0),
                      MaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        padding:
                            const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox.square(
                              dimension: 48.0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Icon(
                                  Icons.folder,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 4.0),
                      Expanded(
                        child: DefaultTabController(
                          length: 4,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                isScrollable: true,
                                labelColor: Colors.blueGrey,
                                unselectedLabelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                indicatorColor: Theme.of(context).primaryColor,
                                tabs: const <Widget>[
                                  Tab(text: 'Lectures', height: 40),
                                  Tab(text: 'Notes', height: 40),
                                  Tab(text: 'Comments', height: 40),
                                  Tab(text: 'Challenges', height: 40),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: TabBarView(
                                    children: <Widget>[
                                      LecturesTab(data: data),
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
                ),
              ),
              // ...[
              //   const SizedBox(height: 30.0),
              //   _titleText('Course Description'),
              //   _bodyText(widget.course.description),
              //   const SizedBox(height: 30.0),
              //   _smallText('Curriculum'),
              //   _titleText('Learn-by doing with our Exclusion Videos'),
              //   _bodyText(
              //     'Our Course is setup to make you learn Advanced Audit and '
              //     'Assurance(Revision) by step with a practical detailed note/'
              //     'video that focuses 100% on learn-by-doing',
              //   ),
              //   const SizedBox(height: 30.0),
              //   _smallText('On Course Completion'),
              //   _titleText('Course Requirements'),
              //   _bodyText('On successful completion of this cour'),
              //   _smallText('Wooah! Fully Loaded'),
              //   _titleText('This course includes'),
              //   Row(
              //     children: <Widget>[
              //       const Icon(CupertinoIcons.checkmark_seal),
              //       _bodyText('195 Lessons & Details otes')
              //     ],
              //   ),
              //   _titleText('Instructor'),
              //   Row(
              //     children: <Widget>[
              //       SizedBox.square(
              //         dimension: 45,
              //         child: DecoratedBox(
              //           decoration: BoxDecoration(
              //             color: Colors.blueGrey.shade900,
              //             borderRadius: BorderRadius.circular(4.0),
              //           ),
              //           child: const Center(
              //             child: Text(
              //               'A',
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white,
              //                 fontSize: 18,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(width: 5.0),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           _titleText('Ahmed Suluka ACA, ASSA'),
              //           _bodyText('ead of scool ExcelAcadey'),
              //         ],
              //       )
              //     ],
              //   ),
              //   _smallText('COURSE PRICING'),
              //   _titleText('Simple, transparent pricing'),
              //   _bodyText(
              //     'We keep track of the pricing of the '
              //     'course from onset without computing',
              //   ),
              //   const SizedBox(height: 30),
              //   Container(
              //     padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8.0),
              //       border: Border.all(
              //         color: Theme.of(context).primaryColor.withOpacity(.3),
              //       ),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: <Widget>[
              //             _bodyText('Pay today'),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: SizedBox.square(
              //                 dimension: 5.0,
              //                 child: DecoratedBox(
              //                   decoration: BoxDecoration(
              //                     color: Colors.grey.shade400,
              //                     shape: BoxShape.circle,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             _bodyText('save NGN 6,200.00'),
              //           ],
              //         ),
              //         const SizedBox(height: 20),
              //         const SizedBox(height: 5.0),
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Icon(
              //               Icons.warning_amber_rounded,
              //               color: Colors.blueGrey.shade400,
              //             ),
              //             const SizedBox(width: 5.0),
              //             Flexible(
              //               child: Text(
              //                 'This package is exclusive to '
              //                 'this particular course only',
              //                 style: TextStyle(
              //                   fontSize: 12,
              //                   color: Colors.blueGrey.shade800,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 10.0),
              //         // Text(
              //         //   'NGN 24,000.00',
              //         //   style: TextStyle(
              //         //     fontSize: 17,
              //         //     fontWeight: FontWeight.bold,
              //         //     color: Colors.black87,
              //         //     decoration: TextDecoration.lineThrough,
              //         //   ),
              //         // ),
              //         const Text(
              //           'NGN 20,000.00',
              //           style: TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black87,
              //           ),
              //         ),
              //         const SizedBox(height: 15.0),
              //         ElevatedButton(
              //           onPressed: () {},
              //           style: ButtonStyle(
              //             backgroundColor: MaterialStatePropertyAll(
              //               Theme.of(context).primaryColor,
              //             ),
              //             foregroundColor: const MaterialStatePropertyAll(
              //               Colors.white,
              //             ),
              //             shape: MaterialStatePropertyAll(
              //               RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(8.0),
              //               ),
              //             ),
              //             minimumSize: const MaterialStatePropertyAll(
              //               Size(double.infinity, 48),
              //             ),
              //           ),
              //           child: const Text('Enroll now'),
              //         ),
              //       ],
              //     ),
              //   ),
              //   const SizedBox(height: 30),
              //   _titleText('Got few questions for us?'),
              //   _bodyText(
              //     'We keep track of the pricing of the '
              //     'course from onset without compromising',
              //   ),
              //   QuestionListTile(
              //     onPressed: () {},
              //     question: 'How do we have access to the course?',
              //   ),
              //   QuestionListTile(
              //     onPressed: () {},
              //     question: 'How do we have access to the course?',
              //   ),
              //   QuestionListTile(
              //     onPressed: () {},
              //     question: 'How do we have access to the course?',
              //   ),
              //   const SizedBox(height: 30),
              //   _titleText('Still not conceived with Q&A'),
              //   _bodyText(
              //     'We keep track of the pricing of the '
              //     'course from onset without compromising',
              //   ),
              //   const SizedBox(height: 15.0),
              //   OutlinedButton(
              //     onPressed: () {},
              //     style: ButtonStyle(
              //       foregroundColor: MaterialStatePropertyAll(
              //         Theme.of(context).primaryColor,
              //       ),
              //       side: MaterialStatePropertyAll(
              //         BorderSide(
              //           color: Theme.of(context).primaryColor,
              //         ),
              //       ),
              //       shape: MaterialStatePropertyAll(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8.0),
              //         ),
              //       ),
              //       minimumSize: const MaterialStatePropertyAll(
              //         Size(double.infinity, 48),
              //       ),
              //     ),
              //     child: const Text('Send us a message'),
              //   ),
              //   const SizedBox(height: 30.0),
              //   Row(
              //     children: <Widget>[
              //       const Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           // Text(
              //           //   'NGN 24,000.00',
              //           //   style: TextStyle(
              //           //     fontSize: 17,
              //           //     fontWeight: FontWeight.bold,
              //           //     color: Colors.black87,
              //           //     decoration: TextDecoration.lineThrough,
              //           //   ),
              //           // ),
              //           Text(
              //             'NGN 20,000.00',
              //             style: TextStyle(
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black87,
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(width: 15.0),
              //       Expanded(
              //         child: ElevatedButton(
              //           onPressed: () {},
              //           style: ButtonStyle(
              //             backgroundColor: MaterialStatePropertyAll(
              //               Theme.of(context).primaryColor,
              //             ),
              //             foregroundColor: const MaterialStatePropertyAll(
              //               Colors.white,
              //             ),
              //             shape: MaterialStatePropertyAll(
              //               RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(8.0),
              //               ),
              //             ),
              //             minimumSize: const MaterialStatePropertyAll(
              //               Size(0, 48),
              //             ),
              //           ),
              //           child: const Text('Enroll now'),
              //         ),
              //       ),
              //     ],
              //   ),
              //   const SizedBox(height: 30),
              // ]
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
}
