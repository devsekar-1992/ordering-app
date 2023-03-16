import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordering_app/models/uom/uom_common_model.dart';
import 'package:ordering_app/models/uom/uom_list_model.dart';
import 'package:ordering_app/services/uom/uom.dart';

class UomForm extends StatefulWidget {
  int? uomId = null;
  UomForm({Key? key, required this.uomId}) : super(key: key);

  @override
  State<UomForm> createState() => _UomFormState();
}

class _UomFormState extends State<UomForm> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formState = GlobalKey<FormState>();
  final _unitName = TextEditingController();
  final _unitDesc = TextEditingController();
  String? responseMessage = '';
  bool? isSuccess = false;
  bool _isFormChanged = false;
  //Load Form Data
  void showFormInfo() async {
    try {
      if (widget.uomId != null) {
        final response =
            await UomRequest().getUnitById({'uom_id': widget.uomId});
        _unitName.text = response.uomListData[0].uomName.toString();
        _unitDesc.text = response.uomListData[0].uomDescription.toString();
      }
    } on DioError catch (e) {}
  }

  /// Save Data
  Future<void> saveData() async {
    UomCommonModel response = await UomRequest().saveUomData({
      'uom_name': _unitName.text,
      'uom_description': _unitDesc.text,
      'uom_id': widget.uomId
    });
    setState(() {
      responseMessage = response.msg.toString();
      isSuccess = response.isSuccess;
    });
  }

  @override
  void initState() {
    super.initState();
    showFormInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 0,
        title: const Text(
          'Units',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text(
                      "Are you sure you want to abandon the form? Any changes will be lost."),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    ElevatedButton(
                      child: const Text("Abandon"),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                );
              });
          return shouldPop!;
        },
        child: Form(
            onChanged: () {
              if (_isFormChanged) return;
              setState(() {
                _isFormChanged = true;
              });
            },
            key: _formState,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _unitName,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Please fill Unit name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          labelText: 'Unit Name',
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                    )),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _unitDesc,
                    validator: (value) {
                      if (value == '') {
                        return 'Please add Unit description';
                      }
                      return null;
                    },
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        labelText: 'Unit Description'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formState.currentState!.validate()) {
                        if (kDebugMode) {}
                        await saveData();
                        if (!mounted) return;
                        showSnackBar(context, responseMessage.toString());
                        if (isSuccess!) {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pop(context, true);
                          });
                        }
                      }
                    },
                    child: const Text('Save'))
              ],
            )),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
