import 'dart:ui';

import 'package:armada/models/machine.dart';
import 'package:armada/utils/helper_widget.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class CustomProductItemWidget extends StatefulWidget {
  MachineM machine;

  CustomProductItemWidget(MachineM this.machine,
      {Key? key, this.showUser = true})
      : super(key: key);
  final bool showUser;

  @override
  State<CustomProductItemWidget> createState() =>
      _CustomProductItemWidgetState();
}

class _CustomProductItemWidgetState extends State<CustomProductItemWidget> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and profail picture
          widget.showUser == true
              ? InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, '/itemPage',
                    //     arguments: widget.machine);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) =>
                              ItemPage(machine: widget.machine)),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            "assets/images/farmer1.png",
                            height: 32,
                            width: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.machine.manufacturer,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),

          // product image and favorite botton
          Stack(
            children: [
              // Product image
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, '/itemPage',
                      //     arguments: widget.machine);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                ItemPage(machine: widget.machine)),
                          ));
                    },
                    child: Image.network(
                        "https://armada-server.glitch.me/api/machinery/image/${widget.machine.imageFile}"),
                    // child: Image.asset(
                    //   "assets/images/tracter1.png",
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
              // Favorite botton
              Positioned(
                top: 20,
                right: 20,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          favorite = !favorite;
                        });
                      },
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black.withOpacity(0.10),
                              ),
                              child: Center(
                                child: favorite == false
                                    ? const Icon(
                                        Icons.heart_broken,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.favorite,
                                        color: Colors.greenAccent,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // producte name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.machine.type,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(" ${widget.machine.year}",
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              addHorizontalSpace(25),
              // Container(

              Container(
                padding: EdgeInsets.all(1),
                height: 18,
                width: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.green,
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.machine.status,
                    style: TextStyle(fontSize: 15.0, color: Colors.green),
                  ),
                ),
              ),
              // Text(widget.machine.status),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
