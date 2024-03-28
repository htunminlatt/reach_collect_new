import 'package:flutter/material.dart';
import 'package:reach_collect/data/model/anc_model';
import 'package:reach_collect/network/presistance/database_provider.dart';
import 'package:reach_collect/screens/edit_userInfo.dart';
import 'package:reach_collect/utils/app_styles.dart';

import '../data/model/reach_model.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({super.key, required this.reachData, required this.reloadView});

  final List<ANCVo> reachData;
  final Function reloadView;

  @override
  Widget build(BuildContext context) {
    List<String> titleArray = [
      'Sr.',
      'Date',
      'Name',
      'Age',
      'Disability',
      'IDP',
      'Gestational',
      'Gravida'
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 150),
                  color: AppTheme.secondaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: titleArray
                        .map((e) => SizedBox(
                              width: e == titleArray[0] ? 30 : 90,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: reachData
                .asMap()
                .entries
                .map((e) => ContactView(
                      data: e.value,
                      index: e.key, reload: reloadView,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ContactView extends StatefulWidget {
  const ContactView({super.key, required this.data, required this.index, required this.reload});

  final ANCVo data;
  final int index;
  final Function reload;

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  List<String> titleArray = [
    '100',
    '12.3.2024',
    'Sai Sai Khen',
    '20',
    'Disability',
    'IDP',
    'Gestational',
    'Gravida'
  ];

  @override
  void initState() {
    super.initState();

    titleArray = [
      '${widget.index + 1}',
      widget.data.date ?? '',
      widget.data.name ?? '',
      widget.data.age ?? '',
      widget.data.disability ?? '',
      widget.data.idp ?? '',
      widget.data.gestational ?? '',
      widget.data.gravida ?? ''
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 3.0, spreadRadius: 2.0, color: Colors.black12)
      ]),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: titleArray
                  .map((e) => SizedBox(
                      width: e == titleArray[0] ? 30 : 90,
                      child: Text(
                        e,
                        style:
                            const TextStyle(overflow: TextOverflow.ellipsis),
                      )))
                  .toList(),
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          InkWell(
            onTap: () {
              try {
                //DatabaseProvider.db.deleteFromDB(widget.data.id ?? 0);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Center(
                  child: Text('Delete data successfully!'),
                )));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Center(
                  child: Text('Delete Fail!!'),
                )));
              }
              widget.reload();
            },
            child: Container(
              height: 30,
              width: 30,
              color: Colors.red,
              child: const Center(
                child: Icon(
                  Icons.delete,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>  EditUserInfo(reachCollectVo: widget.data)));
            },
            child: Container(
              height: 30,
              width: 30,
              color: AppTheme.thirdColor,
              child: const Center(
                child: Icon(
                  Icons.remove_red_eye,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 40,
          )
        ],
      ),
    );
  }
}
