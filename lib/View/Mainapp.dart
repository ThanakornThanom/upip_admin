import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:upip_admin/View/chart2.dart';

import 'chart.dart';

class Mainapp extends StatefulWidget {
  @override
  _MainappState createState() => _MainappState();
}

List<Widget> pageeee = [Firstpage(), Secondpage(), ThirdPage(), FourPage()];
const kPrimaryColor = Color(0xFFFFC200);
const kTextcolor = Color(0xFF241424);
const kDarkButton = Color(0xFF372930);
int _selectedIndex = 0;
var jobsssssArray = {};
var userArray = {};
var matchingArray = {};
var currentmatchingArray = {};
var currentjobsssssArray = {};
var currentuserArray = {};

List imageList(
  String _image1,
  String _image2,
  String _image3,
  String _image4,
  String _image5,
  String _image6,
) {
  List _imagelist = [];
  if (_image1 != null) {
    _imagelist.add(_image1);
  }
  if (_image2 != null) {
    _imagelist.add(_image2);
  }
  if (_image3 != null) {
    _imagelist.add(_image3);
  }
  if (_image4 != null) {
    _imagelist.add(_image4);
  }
  if (_image5 != null) {
    _imagelist.add(_image5);
  }
  if (_image6 != null) {
    _imagelist.add(_image6);
  }
  return _imagelist;
}

class _MainappState extends State<Mainapp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() async {
      setState(() {
        fetchJobData();
        fetchUserData();
        fetchMatchingData();
      });
    });
  }

  Future<void> fetchJobData() async {
    var jobsArrey = {};
    await FirebaseFirestore.instance.collection('Jobs').get().then((value) {
      value.docs.forEach((element) {
        jobsArrey[element.id] = element.data();
      });
    });
    setState(() {
      jobsssssArray = jobsArrey;
    });
  }

  Future<void> fetchUserData() async {
    var map = {};
    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        map[element.id] = element.data();
      });
    });
    setState(() {
      userArray = map;
    });
  }

  Future<void> fetchMatchingData() async {
    var map = {};
    await FirebaseFirestore.instance.collection('Matching').get().then((value) {
      value.docs.forEach((element) {
        map[element.id] = element.data();
      });
    });
    setState(() {
      matchingArray = map;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        NavigationRail(
          extended: true,
          backgroundColor: Colors.orange[900],
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          labelType: NavigationRailLabelType.none,
          leading: Container(
            width: 200,
            child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/logintest01-870ad.appspot.com/o/Assets%2FBAKS_Clothing_Company_Logo-removebg-preview.png?alt=media&token=f7e82224-432a-4759-81b2-bbb95c7ea124"),
          ),
          destinations: [
            NavigationRailDestination(
              icon: Icon(
                CupertinoIcons.chart_pie,
                color: Colors.white,
              ),
              selectedIcon: Icon(
                CupertinoIcons.chart_pie_fill,
                color: Colors.white,
              ),
              label: Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
            ),
            NavigationRailDestination(
              icon: Icon(
                CupertinoIcons.doc,
                color: Colors.white,
              ),
              selectedIcon: Icon(
                CupertinoIcons.doc_chart_fill,
                color: Colors.white,
              ),
              label: Text(
                'Jobs',
                style: TextStyle(color: Colors.white),
              ),
            ),
            NavigationRailDestination(
              icon: Icon(
                CupertinoIcons.person_circle,
                color: Colors.white,
              ),
              selectedIcon: Icon(
                CupertinoIcons.person_circle_fill,
                color: Colors.white,
              ),
              label: Text(
                'Users',
                style: TextStyle(color: Colors.white),
              ),
            ),
            NavigationRailDestination(
              icon: Icon(
                CupertinoIcons.money_dollar,
                color: Colors.white,
              ),
              selectedIcon: Icon(
                CupertinoIcons.money_dollar_circle_fill,
                color: Colors.white,
              ),
              label: Text(
                'Transaction',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        VerticalDivider(thickness: 1, width: 1),
        // This is the main content.
        Expanded(
          child: pageeee[_selectedIndex],
        )
      ],
    ));
  }
}

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Map screenDataMatching(DateTime time1, DateTime time2) {
    Map screeneddata = {};
    print(time1);
    print(time2);
    matchingArray.forEach((key, value) {
      Timestamp currenttimestamp = value["_timeLiked"];
      DateTime currenttime = DateTime.fromMicrosecondsSinceEpoch(
          currenttimestamp.microsecondsSinceEpoch);

      if (currenttime.isAfter(time1) & currenttime.isBefore(time2)) {
        screeneddata[key] = value;
      }
    });
    print(screeneddata.keys);
    return screeneddata;
  }

  Map screenDataUser(DateTime time1, DateTime time2) {
    Map screeneddata = {};

    userArray.forEach((key, value) {
      Timestamp currenttimestamp = value["Timestamp"];
      DateTime currenttime = DateTime.fromMicrosecondsSinceEpoch(
          currenttimestamp.microsecondsSinceEpoch);

      if (currenttime.isAfter(time1) & currenttime.isBefore(time2)) {
        screeneddata[key] = value;
      }
    });
    print(screeneddata.keys);
    return screeneddata;
  }

  Map screenDataJob(DateTime time1, DateTime time2) {
    Map screeneddata = {};

    jobsssssArray.forEach((key, value) {
      Timestamp currenttimestamp = value["_date"];
      DateTime currenttime = DateTime.fromMicrosecondsSinceEpoch(
          currenttimestamp.microsecondsSinceEpoch);

      if (currenttime.isAfter(time1) & currenttime.isBefore(time2)) {
        screeneddata[key] = value;
      }
    });
    print(screeneddata.keys);
    return screeneddata;
  }

  int paidCampaign() {
    int count = 0;
    currentjobsssssArray.forEach((key, value) {
      if (value["_status"] == "paid") {
        count += 1;
      }
    });
    return count;
  }

  int totalTransaction() {
    int count = 0;
    currentmatchingArray.forEach((key, value) {
      if (value["Liked"] == value["_isliked"]) {
        count += value["_wage"];
      }
    });
    return count;
  }

  final controller1 = TextEditingController();
  DateTime selectedDate1 = DateTime.now();
  _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate1)
      setState(() {
        selectedDate1 = picked;
        controller1.text = selectedDate1.day.toString() +
            "/" +
            selectedDate1.month.toString() +
            "/" +
            selectedDate1.year.toString();
      });
  }

  final controller2 = TextEditingController();
  DateTime selectedDate2 = DateTime.now();
  _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate1)
      setState(() {
        selectedDate2 = picked;
        controller2.text = selectedDate2.day.toString() +
            "/" +
            selectedDate2.month.toString() +
            "/" +
            selectedDate2.year.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(46),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -2),
                    blurRadius: 30,
                    color: Colors.black.withOpacity(0.16),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 5),
                  Text(
                    "Dashboard",
                    style: GoogleFonts.lobster(fontSize: 30),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("From"),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            _selectDate1(context);
                          },
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: controller1,
                            enabled: false,
                          ),
                        )),
                        Text("To"),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            _selectDate2(context);
                          },
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: controller2,
                            enabled: false,
                          ),
                        )),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentmatchingArray = screenDataMatching(
                                  selectedDate1, selectedDate2);
                              currentjobsssssArray =
                                  screenDataJob(selectedDate1, selectedDate2);
                              currentuserArray =
                                  screenDataUser(selectedDate1, selectedDate2);
                            });
                          },
                          child: Icon(Icons.search),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text(
                                  "Total Campaign in the systems",
                                ),
                                Center(
                                  child: Text(
                                    currentjobsssssArray.length.toString(),
                                    style: TextStyle(
                                      fontSize: 50,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text("Total User in the systems"),
                                Center(
                                  child: Text(
                                    currentuserArray.length.toString(),
                                    style: TextStyle(fontSize: 50),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text("To Influencer was hired"),
                                Center(
                                  child: Text(
                                    paidCampaign().toString(),
                                    style: TextStyle(fontSize: 50),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text("Total payment for campaign"),
                                Center(
                                  child: Text(
                                    totalTransaction().toString() + "฿",
                                    style: TextStyle(fontSize: 50),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Text("Total Fees We got"),
                          Center(
                            child: Text(
                              (totalTransaction() * 0.1)
                                      .roundToDouble()
                                      .toString() +
                                  "฿",
                              style: TextStyle(fontSize: 50),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Revenue Graph"),
                        Container(
                          height: 230,
                          child: SimpleTimeSeriesChart(
                            _createSampleData(),
                            // Disable animations for image tests.
                            animate: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Gender proportion Graph"),
                        Container(
                            height: 230,
                            child: SimpleDatumLegend(
                              _createSampleData2(),
                              // Disable animations for image tests.
                              animate: false,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static List<charts.Series<LinearSales, String>> _createSampleData2() {
    final data = [
      new LinearSales("", 100, Colors.white),
    ];
    void adddata() {
      data.clear();

      int countMale = 0;
      int countFemale = 0;
      int countOther = 0;
      currentuserArray.forEach((key, value) {
        if (value["_gender"] == "Others") {
          countOther += 1;
        } else if (value["_gender"] == "Male") {
          countMale += 1;
        } else {
          countFemale += 1;
        }
      });
      data.add(
        LinearSales("Male", countMale, Colors.blue),
      );
      data.add(
        LinearSales("Female", countFemale, Colors.pink),
      );
      data.add(
        LinearSales("Others", countOther, Colors.grey),
      );
    }

    adddata();
    return [
      new charts.Series<LinearSales, String>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.name,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          labelAccessorFn: (LinearSales row, _) =>
              '${row.name}: ${(row.sales / currentuserArray.length * 100).round()}%',
          colorFn: (LinearSales row, _) =>
              charts.ColorUtil.fromDartColor(row.color)),
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2020, 12, 31), 0),
    ];
    void adddata() {
      data.clear();
      currentmatchingArray.forEach((key, value) {
        Timestamp currentTimeStamp = value["_timeLiked"];
        DateTime currentDate = DateTime.fromMicrosecondsSinceEpoch(
            currentTimeStamp.microsecondsSinceEpoch);
        data.add(TimeSeriesSales(currentDate, value["_wage"]));
      });
    }

    adddata();
    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class Secondpage extends StatefulWidget {
  @override
  _SecondpageState createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  var selectedIndex;
  String numberselected = "";

  void showDetail(var index) {
    List list = currentjobsssssArray.values.toList()[index]["_images"];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${currentjobsssssArray.values.toList()[index]["_campaignname"]}",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        (currentjobsssssArray.values.toList()[index]
                                    ["_status"] ==
                                "paid")
                            ? Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.green,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Text(
                                  "${currentjobsssssArray.values.toList()[index]["_status"]}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Text(
                                  "${currentjobsssssArray.values.toList()[index]["_status"]}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      ],
                    ),
                    Text(
                        "${currentjobsssssArray.values.toList()[index]["_user"]}"),
                    Text(list.length.toString()),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> showTestAlert(var index) {
    List list = currentjobsssssArray.values.toList()[index]["_images"];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future<void> deleteCampaign(var selectedJobID) async {
            await FirebaseFirestore.instance
                .collection('Jobs')
                .doc(selectedJobID)
                .update({"_status": "deleted"});
            Navigator.of(context).pop();
          }

          return AlertDialog(
            title: Row(
              children: [
                Text(
                  "${currentjobsssssArray.values.toList()[index]["_campaignname"]}",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                (currentjobsssssArray.values.toList()[index]["_status"] ==
                        "paid")
                    ? Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(
                              color: Colors.green,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          "${currentjobsssssArray.values.toList()[index]["_status"]}",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : (currentjobsssssArray.values.toList()[index]["_status"] ==
                            "deleted")
                        ? Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                  color: Colors.red,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              "${currentjobsssssArray.values.toList()[index]["_status"]}",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              "${currentjobsssssArray.values.toList()[index]["_status"]}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 600,
                    height: 400,
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(list.length, (i) {
                        return Container(
                          width: 200,
                          height: 200,
                          child: Image.network(
                            currentjobsssssArray.values.toList()[index]
                                ["_images"][i],
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        deleteCampaign(
                            currentjobsssssArray.keys.toList()[index]);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.red,
                          border: Border.all(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        "Delete this campaign",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  List<bool> selected =
      List<bool>.generate(currentjobsssssArray.length, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(46),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                blurRadius: 30,
                color: Colors.black.withOpacity(0.16),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Jobs list",
                style: GoogleFonts.lobster(fontSize: 30),
              ),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(17),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      showCheckboxColumn: false,
                      horizontalMargin: 20,
                      columnSpacing: 30.0,
                      columns: [
                        DataColumn(label: Text('No.')),
                        DataColumn(label: Text('JobID')),
                        DataColumn(label: Text('JobName')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('User')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Budget')),
                        DataColumn(label: Text('No.Influencer')),
                        DataColumn(label: Text('No.interested')),
                        DataColumn(label: Text('Requirement')),
                      ],
                      rows: List<DataRow>.generate(
                          currentjobsssssArray.length,
                          (index) => DataRow(
                                  selected: selectedIndex == index + 1,
                                  onSelectChanged: (bool value) async {
                                    setState(() async {
                                      selectedIndex = index + 1;
                                      numberselected = selectedIndex.toString();
                                      await showTestAlert(index)
                                          .whenComplete(() {
                                        setState(() {});
                                      });
                                    });
                                  },
                                  cells: [
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(currentjobsssssArray.keys
                                        .toList()[index])),
                                    DataCell(Text(
                                        "${currentjobsssssArray.values.toList()[index]["_campaignname"]}")),
                                    DataCell(
                                      (currentjobsssssArray.values
                                                  .toList()[index]["_status"] ==
                                              "paid")
                                          ? Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  border: Border.all(
                                                    color: Colors.green,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Text(
                                                "${currentjobsssssArray.values.toList()[index]["_status"]}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : (currentjobsssssArray.values
                                                          .toList()[index]
                                                      ["_status"] ==
                                                  "deleted")
                                              ? Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      border: Border.all(
                                                        color: Colors.red,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Text(
                                                    "${currentjobsssssArray.values.toList()[index]["_status"]}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child: Text(
                                                    "${currentjobsssssArray.values.toList()[index]["_status"]}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                    ),
                                    DataCell(Text(
                                        "${currentjobsssssArray.values.toList()[index]["_user"]}")),
                                    DataCell(SingleChildScrollView(
                                      child: Text(
                                          "${DateTime.fromMicrosecondsSinceEpoch(currentjobsssssArray.values.toList()[index]["_date"].microsecondsSinceEpoch).toString()}"),
                                    )),
                                    DataCell(Text(
                                        "${currentjobsssssArray.values.toList()[index]["_budget"].toString()}")),
                                    DataCell(Text(
                                        "${currentjobsssssArray.values.toList()[index]["_numOfInfluencer"].toString()}")),
                                    DataCell(Text(
                                        "${currentjobsssssArray.values.toList()[index]["_interested"].toString()}")),
                                    DataCell(Container(
                                      width: 300,
                                      child: Text(
                                          "${currentjobsssssArray.values.toList()[index]["_requirement"]}"),
                                    )),
                                  ]))),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  var selectedIndex;
  String numberselected = "";
  void showTestAlert(var index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(currentuserArray.values.toList()[index]["_firstname"]),
            content: Column(
              children: [],
            ),
          );
        });
  }

  List<bool> selected =
      List<bool>.generate(currentuserArray.length, (index) => false);
  List userimageList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(46),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                blurRadius: 30,
                color: Colors.black.withOpacity(0.16),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Users list",
                style: GoogleFonts.lobster(fontSize: 30),
              ),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(17),
              children: [
                Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        showCheckboxColumn: false,
                        dataRowHeight: 60,
                        horizontalMargin: 20,
                        columns: [
                          DataColumn(label: Text('No.')),
                          DataColumn(label: Text('UserID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Gender')),
                          DataColumn(label: Text('DateofBirth')),
                          DataColumn(label: Text('Bio')),
                        ],
                        rows: List<DataRow>.generate(
                            currentuserArray.length,
                            (index) => DataRow(
                                    selected: selectedIndex == index,
                                    onSelectChanged: (bool value) {
                                      setState(() {
                                        setState(() {
                                          selectedIndex = index;
                                          numberselected =
                                              (selectedIndex + 1).toString();
                                          userimageList = imageList(
                                              currentuserArray.values
                                                      .toList()[selectedIndex]
                                                  ["_image1"],
                                              currentuserArray.values
                                                      .toList()[selectedIndex]
                                                  ["_image2"],
                                              currentuserArray.values
                                                      .toList()[selectedIndex]
                                                  ["_image3"],
                                              currentuserArray.values
                                                      .toList()[selectedIndex]
                                                  ["_image4"],
                                              currentuserArray.values
                                                      .toList()[selectedIndex]
                                                  ["_image5"],
                                              currentuserArray.values
                                                      .toList()[selectedIndex]
                                                  ["_image6"]);
                                          showTestAlert(index);
                                        });
                                      });
                                    },
                                    cells: [
                                      DataCell(Text((index + 1).toString())),
                                      DataCell(Text(currentuserArray.keys
                                          .toList()[index])),
                                      DataCell(Text(
                                          "${currentuserArray.values.toList()[index]["_firstname"]}")),
                                      DataCell(Text(
                                          "${currentuserArray.values.toList()[index]["_gender"]}")),
                                      DataCell(Text(
                                          "${currentuserArray.values.toList()[index]["_birthdate"].toString()}")),
                                      DataCell(Text(
                                          "${currentuserArray.values.toList()[index]["biostring"]}")),
                                    ]))),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class FourPage extends StatefulWidget {
  @override
  _FourPageState createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  var selectedIndex;
  String numberselected = "";
  List<bool> selected =
      List<bool>.generate(currentmatchingArray.length, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(46),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                blurRadius: 30,
                color: Colors.black.withOpacity(0.16),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Transaction list",
                style: GoogleFonts.lobster(fontSize: 30),
              ),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(17),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      showCheckboxColumn: false,
                      dataRowHeight: 60,
                      horizontalMargin: 20,
                      columns: [
                        DataColumn(label: Text('No.')),
                        DataColumn(label: Text('MatchingID')),
                        DataColumn(label: Text('UserID')),
                        DataColumn(label: Text('JobID')),
                        DataColumn(label: Text('MatchDate')),
                        DataColumn(label: Text('Wage(Baht)')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Evidentlink')),
                        DataColumn(label: Text('Bank')),
                        DataColumn(label: Text('Account ID')),
                        DataColumn(label: Text('Contact Email')),
                      ],
                      rows: List<DataRow>.generate(
                          currentmatchingArray.length,
                          (index) => DataRow(
                                  selected: selectedIndex == index + 1,
                                  onSelectChanged: (bool value) {
                                    setState(() {
                                      setState(() {
                                        selectedIndex = index + 1;
                                        numberselected =
                                            selectedIndex.toString();
                                      });
                                    });
                                  },
                                  cells: [
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(currentmatchingArray.keys
                                        .toList()[index])),
                                    DataCell(Text(
                                        "${currentmatchingArray.values.toList()[index]["_baseeUser"]}")),
                                    DataCell(Text(
                                        "${currentmatchingArray.values.toList()[index]["_targetUser"]}")),
                                    DataCell(Text(
                                        "${DateTime.fromMicrosecondsSinceEpoch(currentmatchingArray.values.toList()[index]["_timeLiked"].microsecondsSinceEpoch).toString()}")),
                                    DataCell(Text(
                                        "${currentmatchingArray.values.toList()[index]["_wage"].toString()}")),
                                    DataCell(Text(
                                        "${currentmatchingArray.values.toList()[index]["status"]}")),
                                    DataCell(Text(
                                        "${currentmatchingArray.values.toList()[index]["_evidentLink"]}")),
                                    (currentuserArray[currentmatchingArray
                                                            .values
                                                            .toList()[index]
                                                        ["_baseeUser"]]["Bank"]
                                                    ["Bank"] ==
                                                null ||
                                            currentuserArray[
                                                        currentmatchingArray
                                                                .values
                                                                .toList()[index]
                                                            ["_baseeUser"]]
                                                    ["Bank"]["Bank"] ==
                                                null)
                                        ? DataCell(Text("null"))
                                        : DataCell(
                                            Text("${currentuserArray[currentmatchingArray.values.toList()[index]["_baseeUser"]]["Bank"]["Bank"]}")),
                                    (currentuserArray[currentmatchingArray
                                                            .values
                                                            .toList()[index]
                                                        ["_baseeUser"]]["Bank"]
                                                    ["Bank"] ==
                                                null ||
                                            currentuserArray[
                                                        currentmatchingArray
                                                                .values
                                                                .toList()[index]
                                                            ["_baseeUser"]]
                                                    ["Bank"]["Bank"] ==
                                                null)
                                        ? DataCell(Text("null"))
                                        : DataCell(
                                            Text("${currentuserArray[currentmatchingArray.values.toList()[index]["_baseeUser"]]["Bank"]["BankID"]}")),
                                    (currentuserArray[currentmatchingArray
                                                        .values
                                                        .toList()[index]
                                                    ["_baseeUser"]]["Bank"]
                                                ["Bank"] ==
                                            null)
                                        ? DataCell(Text("null"))
                                        : DataCell(Text(
                                            "${currentuserArray[currentmatchingArray.values.toList()[index]["_baseeUser"]]["Email"]}")),
                                  ]))),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
