import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/models/participant_model.dart';
import 'package:beanmind_flutter/models/procession_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const CourseListHistoryScreen(),
    );
  }
}

class CourseListHistoryScreen extends GetView<ProfileController> {
  static const headerStyle = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
  static const contentStyleHeader = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.normal);

  const CourseListHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "LỊCH SỬ HỌC TẬP",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Search bar
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm nội dung bạn đã học",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.courseDetailData.isEmpty) {
                  return const Center(child: Text('Không có khóa học nào.'));
                }
                return ListView.builder(
                  itemCount: controller.courseDetailData.length,
                  itemBuilder: (context, index) {
                    final courseDetail = controller.courseDetailData[index];
                    return ExpansionTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courseDetail.title ?? 'Không có tên',
                            style: const TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          const SizedBox(height: 10),
                          buildProgressItem(
                            context,
                            'Thông tin khóa học',
                            courseDetail.totalSlot != null && courseDetail.totalSlot! > 0
                                ? controller.participantModelItemList
                                .where((a) => a.enrollment!.courseId == courseDetail.id)
                                .length /
                                courseDetail.totalSlot!
                                : 0.0,
                            '${controller.participantModelItemList.where((a) => a.enrollment!.courseId == courseDetail.id).length}',
                            'N/A',
                          ),
                        ],
                      ),
                      children: <Widget>[
                        MyNestedExpansionTile(course: courseDetail),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyNestedExpansionTile extends GetView<ProfileController> {
  final CourseDetailData course;

  const MyNestedExpansionTile({required this.course, super.key});

  @override
  Widget build(context) {
    return Obx(() {
      final enrollment = controller.enrollmentModelList.firstWhere((e) => e.courseId == course.id);
      final parcitipant = controller.participantModelItemList.where((p) => p.enrollment!.id == enrollment.id).toList();

      final chapters = controller.chapterList.where((chapter) => chapter.courseId == course.id).toList();
      final worksheetAttempts = controller.worksheetAttempt.where((attempt) => attempt.enrollment?.courseId == course.id).toList();

      if (controller.participantModelItemList.isEmpty && controller.processionModelItemList.isEmpty) {
        return const Center(child: ShimmerCourseHistoryItem());
      }

      if (enrollment == null) {
        return const Center(child: Text('Chưa có chương nào được tải.'));
      }

      return Column(
        children: parcitipant.map((parcitipant) {
          return ExpansionTile(
            title: buildParticipantInfoItem(
              context,
              parcitipant,
            ),
            children: <Widget>[
              Column(
                children: controller.processionModelItemList
                    .where((p) => p.participantId == parcitipant.id)
                    .map((ProcessionModelItem procession) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_box,
                      color: Colors.green,
                    ),
                    title: Text(
                      procession.topic!.title!,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    tileColor: Colors.white,
                    onTap: () => {},
                  );
                }).toList(),
              ),
            ],
          );
        }).toList(),
      );
    });
  }
}

Widget buildProgressItem(BuildContext context, String title, double progress, String slots, String time) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(progress >= 1 ? Colors.green : Colors.blue),
        ),
        const SizedBox(height: 5),
        Text(
          'Đã học: $slots slot',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        Text(
          'Thời gian đã học: $time',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget buildParticipantInfoItem(BuildContext context, ParticipantModelItem participant) {
  final isPresent = participant.isPresent!;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          participant.session!.date != null
              ? DateFormat('dd-MM-yyyy').format(participant.session!.date!.toLocal())
              : 'N/A',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          '${participant.session!.teachingSlot!.startTime} → ${participant.session!.teachingSlot!.endTime}',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(
          'Giáo viên giảng dạy: ${participant.session?.applicationUser?.firstName ?? 'Null'} ${participant.session?.applicationUser?.lastName ?? 'Null'}',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              isPresent ? Icons.check_circle : Icons.cancel,
              color: isPresent ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 5),
            Text(
              isPresent ? 'Đã điểm danh' : 'Vắng mặt',
              style: TextStyle(fontSize: 16, color: isPresent ? Colors.green : Colors.red),
            ),
          ],
        ),
      ],
    ),
  );
}

class ShimmerCourseHistoryItem extends StatelessWidget {
  const ShimmerCourseHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
