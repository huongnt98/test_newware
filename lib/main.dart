import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_newware/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Movies'),
      ),
      body: GetBuilder<DataController>(
          init: DataController(),
          builder: (controller) {
            print('item-----------------${controller.items}');
            if (controller.items == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular list',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff999999),
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: GridView.builder(
                          itemCount: controller.items!.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        'https://www.themoviedb.org/t/p/w220_and_h330_face' +
                                            controller.items![index]
                                            ['poster_path'],
                                        fit: BoxFit.cover,
                                      )),
                                  Positioned(
                                      right: 20,
                                      top: 15,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffeb6b31),
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment(0.8, 1),
                                            colors: <Color>[
                                              Color(0xffFF6633),
                                              Color(0xffFF0099),
                                            ],
                                            tileMode: TileMode.repeated,
                                          ),
                                        ),
                                        child: Center(
                                            child: RichText(
                                              text: TextSpan(
                                                style: DefaultTextStyle.of(context)
                                                    .style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: controller.items![index]
                                                      ['vote_average']
                                                          .toString()
                                                          .split('.')
                                                          .first,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 20)),
                                                  TextSpan(
                                                    text: '.' +
                                                        controller.items![index]
                                                        ['vote_average']
                                                            .toString()
                                                            .split('.')
                                                            .last,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      )),
                                  Positioned(
                                      left: 10,
                                      bottom: 15,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              controller.items![index]
                                              ['release_date']
                                                  .toString()
                                                  .split('-')
                                                  .first,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          Text(
                                            '${controller.items![index]['original_title']}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2,
                              margin: const EdgeInsets.all(5),
                            );
                          }))
                ],
              ),
            );
          }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
