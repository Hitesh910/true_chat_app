import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_chat_app/screen/home/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title:  const Text("TrueChat App"),
      // ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Home.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.grey.withOpacity(0.4),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                  const Text(
                    "True Chat",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person),
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    controller.profileList.length,
                    (index) {
                      return Container(
                        height: 90,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.primaries[index],
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          height: 90,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "${controller.profileList[index]}",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  // color: Colors.white,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width - 350,
                          child: const Divider(
                            thickness: 5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const ListTile(
                              title: Text("Name"),
                              leading: SizedBox(
                                height: 120,
                                width: 50,
                                child: CircleAvatar(),
                              ),
                              subtitle: Text("How are you?"),
                              trailing: Text(
                                "2 min ago",
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton:
      FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          Navigator.pushNamed(context, '/user');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
