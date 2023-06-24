import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/machine.dart';
import '../../../networkhandler.dart';
import '../../widgets/widgets.dart';

class ServiceProviderProfile extends StatefulWidget {
  static const String routeName = '/serviceProvider_profile';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ServiceProviderProfile(),
    );
  }

  ServiceProviderProfile({
    Key? key,
    this.showFollowBottomInProfile = false,
  }) : super(key: key);
  final bool showFollowBottomInProfile;

  @override
  State<ServiceProviderProfile> createState() => _ServiceProviderProfileState();
}

class _ServiceProviderProfileState extends State<ServiceProviderProfile> {
  NetworkHandler networkHandler = NetworkHandler();
  List<MachineM> machine = [];
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/api/machinery/");

    setState(() {
      machine = (json.decode(response.body) as List)
          .map((data) => MachineM.fromJson(data))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget.showFollowBottomInProfile == false
                ? InkWell(
                    onTap: () {},
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mode_edit_outline_outlined,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),
                    // ),
                  )
                : const SizedBox(),
          ),
          // child: IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.share,
          //     color: Colors.black,
          //   ),
          // ),
        ],
        leading: widget.showFollowBottomInProfile == true
            ? Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black45,
                    )),
              )
            : const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/tracter1.png"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Alfoz Plc.",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "32",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Recipes",
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "789",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Following",
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        Column(
                          children: [
                            Text("1.200",
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Followers",
                                style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                      ],
                    ),
                    widget.showFollowBottomInProfile == true
                        ? CustomButton(onTap: () {}, text: "Follow")
                        : const SizedBox(
                            height: 20,
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomBinaryOption(
                    textLeft: "All",
                    textRight: "Booked",
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1.3,
                    children: List.generate(machine.length,
                        // (index) => CustomProductItemWidget(),
                        (index) {
                      final machines = machine[index];

                      return CustomProductItemWidget(machines);
                    }
                        // 5,
                        // (index) => CustomProductItemWidget(
                        //   showUser: false,
                        // ),
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
