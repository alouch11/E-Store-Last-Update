import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/domain/model/lines_model.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';


class MachineCardUI extends StatelessWidget {
  final Machines? machineModel;
  const MachineCardUI({super.key, this.machineModel});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: 20,
                    ),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey.shade100,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${getTranslated('name', context)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.15,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                         SizedBox( width: MediaQuery.of(context).size.width * 0.69,
                           child: Text(maxLines: 3,
                              machineModel!.name!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                         ),
                        ],
                      ),
                      /*SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),*/
                      Container(
                        width: MediaQuery.of(context).size.width * 0.07,
                        height: MediaQuery.of(context).size.width * 0.07,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurple.shade300,
                        ),
                        child: const Icon(
                         Icons.description,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),


                const SizedBox(
                  height: 10,
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [

                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            '${getTranslated('model', context)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1.15,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox( width: MediaQuery.of(context).size.width * 0.69,
                            child: Text(
                            machineModel!.model!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,

                            ),
                            ))
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.07,
                        height: MediaQuery.of(context).size.width * 0.07,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent.shade400,
                        ),
                        child: const Icon(
                          Icons.model_training,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                 Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                            '${getTranslated('serial_number', context)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.15,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            SizedBox( width: MediaQuery.of(context).size.width * 0.69,
                              child: Text(
                              machineModel!.code!,
                              style: const TextStyle(
                                color: Colors.grey,

                                fontSize: 12,
                              ),
                              ) ),
                          ],
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.width * 0.07,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.redAccent),
                          child: const Icon(
                            Icons.code,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),



                const SizedBox(
                  height: 10,
                ),

                Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              '${getTranslated('status', context)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.15,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            SizedBox( width: MediaQuery.of(context).size.width * 0.69,
                              child:  Text(maxLines: 3,
                              machineModel!.status!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              )),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          height: MediaQuery.of(context).size.width * 0.07,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.shade300,
                          ),
                          child: const Icon(
                            CupertinoIcons.lightbulb_slash_fill,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),


                const SizedBox(
                  height: 20,
                ),
                Divider(
                  indent: MediaQuery.of(context).size.width * 0.1,
                  endIndent: MediaQuery.of(context).size.width * 0.1,
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: 20,
                    ),
                    const Text(
                      'General Informations',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                      '${getTranslated('make', context)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1.15,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox( width: MediaQuery.of(context).size.width * 0.69,
                            child:  Text(
                            machineModel!.make !=null ? machineModel!.make!:'',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,

                            ),
                            ) )
                        ],
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.07,
                        height: MediaQuery.of(context).size.width * 0.07,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent.shade400,
                        ),
                        child: const Icon(
                          Icons.precision_manufacturing,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey.shade100,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${getTranslated('date', context)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.15,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox( width: MediaQuery.of(context).size.width * 0.69,
                            child:  Text(
                            machineModel!.yearOfConstraction !=null? machineModel!.yearOfConstraction!:'' ,
                            style: const TextStyle(
                              color: Colors.grey,

                              fontSize: 12,
                            ),
                            )),
                        ],
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.07,
                        height: MediaQuery.of(context).size.width * 0.07,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.redAccent),
                        child: const Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),



                const SizedBox(
                  height: 10,
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.fromLTRB(20, 3, 1, 3),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey.shade100,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${getTranslated('installation_date', context)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.15,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox( width: MediaQuery.of(context).size.width * 0.69,
                            child:  Text(
                            machineModel!.installationDate !=null ? machineModel!.installationDate!:'',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            )),
                        ],
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.07,
                        height: MediaQuery.of(context).size.width * 0.07,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurple.shade300,
                        ),
                        child: const Icon(
                          Icons.date_range,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),

























              ]
            ),
          ),
        ),

    );
  }
}
