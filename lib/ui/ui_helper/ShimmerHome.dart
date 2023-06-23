
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHome extends StatelessWidget {
  const ShimmerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade200,
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index){
                return Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Icon(Icons.add),
                      ),),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 15,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: SizedBox(
                                    width: 60,
                                    height: 15,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),

                          Flexible(
                            child: SizedBox(
                              width: 100,
                              height: 40,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 15,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: SizedBox(
                                      width: 60,
                                      height: 15,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    )

                  ],
                );
              })),
    );
  }
}
