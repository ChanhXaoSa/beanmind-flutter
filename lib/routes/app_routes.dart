import 'package:beanmind_flutter/controllers/common/app_bar_controller.dart';
import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
import 'package:beanmind_flutter/screens/course/course_list_screen.dart';
import 'package:beanmind_flutter/screens/course/course_play_game_screen.dart';
import 'package:beanmind_flutter/screens/game/game_leaderboard_screen.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_attempt_screen.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/screens/screens.dart';

class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const SplashScreen(),
          name: SplashScreen.routeName,
        ),
        GetPage(
          page: () => const AppIntroductionScreen(),
          name: AppIntroductionScreen.routeName,
        ),
        GetPage(
            page: () => const HomeScreen(),
            name: HomeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(HomeController());
              Get.put(AppBarController());
              Get.put(CourseController());
              Get.put(GameController());
            })),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
        GetPage(
            page: () => const ProfileScreen(),
            name: ProfileScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(ProfileController());
              Get.put(AppBarController());
            })),
        GetPage(
            page: () => LeaderBoardScreen(),
            name: LeaderBoardScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(LeaderBoardController());
            })),
        GetPage(
            page: () => GameLeaderboardScreen(),
            name: GameLeaderboardScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(GameLeaderBoardController());
            })),
        GetPage(
            page: () => const AnswersCheckScreen(),
            name: AnswersCheckScreen.routeName),
        GetPage(
            page: () => const QuizOverviewScreen(),
            name: QuizOverviewScreen.routeName),
        GetPage(page: () => const Resultcreen(), name: Resultcreen.routeName),
        GetPage(
            name: GameListScreen.routeName,
            page: () => const GameListScreen(),
            binding: BindingsBuilder(() {
              Get.put(GameController());
            })),
        GetPage(
            name: VideoLearningScreen.routeName,
            page: () => const VideoLearningScreen()),
        GetPage(
          name: CourseDetailScreen.routeName,
          page: () => const CourseDetailScreen(),
          binding: BindingsBuilder(() {
            Get.put(CourseDetailController());
            Get.put(AppBarController());
          }),
        ),
        GetPage(
          name: CourseLearningScreen.routeName,
          page: () => const CourseLearningScreen(),
          binding: BindingsBuilder(() {
            Get.put(CourseLearningController());
            Get.put(AppBarController());
          }),
        ),
      GetPage(
        name: CoursePlayGameScreen.routeName,
        page: () => const CoursePlayGameScreen(),
        binding: BindingsBuilder(() {
          Get.put(GameController());
        }),
      ),
        GetPage(
          name: QuizAttemptScreen.routeName,
          page: () => const QuizAttemptScreen(),
          binding: BindingsBuilder(() {
            Get.put<QuizController>(QuizController());
          }),
        ),
    GetPage(
      name: CourseListScreen.routeName,
      page: () => const CourseListScreen(),
      binding: BindingsBuilder(() {
        Get.put(CourseController());
        Get.put(HomeController());
        Get.put(AppBarController());
      }),
    ),
      ];
}
