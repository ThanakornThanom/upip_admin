import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  Job(this.id, this.campaignname, this.date, this.requirement, this.status,
      this.user, this.budget, this.interested, this.images, this.numberInflu);
  final String id;
  final String campaignname;
  final DateTime date;
  final String requirement;
  final String status;
  final String user;
  final int budget;
  final int interested;
  final List images;
  final int numberInflu;
}

Future<void> fetchJobs() async {
  List list;
  await FirebaseFirestore.instance.collection('Jobs').get().then((value) {
    value.docs.forEach((element) {
      list.add(Job(
          element.id,
          element.data()["_campaignname"],
          element.data()["_date"],
          element.data()["_requirement"],
          element.data()["_status"],
          element.data()["_user"],
          element.data()["_budget"],
          element.data()["_interrested"],
          element.data()["_images"],
          element.data()["_numOfInfluencer"]));
    });
  });
  print(list);
}
