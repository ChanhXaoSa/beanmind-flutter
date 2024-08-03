import 'package:beanmind_flutter/controllers/common/app_bar_controller.dart';
import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/screens/course/course_leaning_screen_2.dart';
import 'package:beanmind_flutter/screens/game/game_leaderboard_screen.dart';
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
            })),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
        GetPage(
            page: () => const ProfileScreen(),
            name: ProfileScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(ProfileController());
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
            page: () => const QuizeScreen(),
            name: QuizeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<QuizController>(QuizController());
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
            page: () => const CourseLearningScreen(),
            name: CourseLearningScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(MyDrawerController());
              Get.put(CourseController());
            })),
        GetPage(
          name: CourseDetailScreen.routeName,
          page: () => const CourseDetailScreen(),
          binding: BindingsBuilder(() {
            Get.put(CourseDetailController());
          }),
        ),
    GetPage(
      name: CourseLeaningScreen2.routeName,
      page: () => const CourseLeaningScreen2(),
      binding: BindingsBuilder(() {
        Get.put(CourseLearningController());
      }),
    ),
      ];
}
