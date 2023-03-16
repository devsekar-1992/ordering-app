import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordering_app/models/uom/uom_list_model.dart';
import 'package:ordering_app/screens/uom/pages/uom_form.dart';
import 'package:ordering_app/services/uom/uom.dart';
import 'package:ordering_app/widgets/g_icon_button.dart';
import 'package:ordering_app/widgets/g_setting_list_card.dart';

class UomLIst extends StatefulWidget {
  UomLIst({Key? key}) : super(key: key);

  @override
  State<UomLIst> createState() => _UomLIstState();
}

class _UomLIstState extends State<UomLIst> {
  List<UomListData> uomListItems = [];
  Future<List<UomListData>?> getUomListData() async {
    try {
      final response = await UomRequest().getUomList();
      uomListItems = response.uomListData;
      setState(() {});
      return uomListItems;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Delete Item
  deleteItem(index) {
    if (kDebugMode) {
      print(index);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUomListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: const Text('Unit Of Measurements'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UomForm(
                        uomId: null,
                      ))).then((value) => getUomListData());
        },
        child: const Icon(Icons.add, size: 25),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: uomListItems.length,
                itemBuilder: (context, index) {
                  return SettingListCard(listItems: [
                    Text(
                      uomListItems[index].uomName.toString(),
                      style: const TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      uomListItems[index].uomDescription.toString(),
                      style: const TextStyle(fontSize: 12.0),
                    )
                  ], actionItems: [
                    IButton(
                        onClick: () async {
                          final uomId = uomListItems[index].uomId;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UomForm(
                                        uomId: uomId,
                                      ))).then((value) => getUomListData());
                        },
                        icon: const Icon(Icons.edit)),
                    IButton(
                        onClick: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel')),
                                      ElevatedButton(
                                          onPressed: () async {
                                            final uomId =
                                                uomListItems[index].uomId;
                                            final response = await UomRequest()
                                                .deleteUomData(
                                                    {'uom_id': uomId});
                                            if (response.isSuccess!) {
                                              uomListItems.removeWhere(
                                                  (element) =>
                                                      element.uomId ==
                                                      uomListItems[index]
                                                          .uomId);
                                              setState(() {});
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text('Sure'))
                                    ],
                                    content: const Text(
                                        'Are you sure want to delete?'));
                              });
                        },
                        icon: const Icon(Icons.delete))
                  ]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
