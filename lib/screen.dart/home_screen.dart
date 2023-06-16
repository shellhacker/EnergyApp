import 'package:demo/auth/screen/loginscreen.dart';
import 'package:demo/const/space_helper.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:demo/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authController =
          Provider.of<HomeController>(context, listen: false);
      authController.fecthData(
        context,
      );
    });
    return Scaffold(
        drawer: SizedBox(),
        appBar: AppBar(
          actions: [Icon(Icons.settings)],
          centerTitle: true,
          title: Text("Reports"),
        ),
        body: Consumer<HomeController>(
            builder: (context, homeController, widget) {
          return SingleChildScrollView(
              child: homeController.result.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: homeController.result.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.purple, Colors.blue],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                    ),
                                    // color: Colors.amber,
                                    // height: 60,
                                    width: size.width / 1.2,
                                    child: Column(
                                      children: [
                                        vSpaceMin,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                vSpaceMin,
                                                Text(
                                                  "\$ " +
                                                      (homeController
                                                          .result[index]
                                                              ['NOK_per_kWh']
                                                          .toString()),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                vSpaceMin,
                                                Text("NOK_per_kWh"),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                vSpaceMin,
                                                Text(
                                                  "\$ " +
                                                      (homeController
                                                          .result[index]
                                                              ['EUR_per_kWh']
                                                          .toString()),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                vSpaceMin,
                                                Text("EUR_per_kWh"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        vSpaceMin,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "time_start : ${homeController.result[index]['time_start'].toString()}"),
                                            Text(
                                                "time_end : ${homeController.result[index]['time_end'].toString()}")
                                          ],
                                        ),
                                        vSpaceMin,
                                        Text(
                                            "EXR :${homeController.result[index]['EXR'].toString()} ")
                                      ],
                                    ),
                                  ),
                                  hSpaceMin,
                                  vSpaceMedium,
                                ]),
                              );
                            },
                          ),
                        ),
                      ],
                    ));
        }));
  }
}
