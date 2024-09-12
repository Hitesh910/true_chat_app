import 'package:flutter/material.dart';
class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                      "Calls",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.call),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
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
                              title: Text("Name",style: TextStyle(color: Colors.black),),
                              leading: SizedBox(
                                height: 120,
                                width: 50,
                                child: CircleAvatar(),
                              ),
                              trailing: Icon(Icons.call,color: Colors.black),subtitle: Row(children: [
                                Icon(Icons.call,size: 14,color: Colors.black,),Text("Today 9:30",style: TextStyle(color: Colors.black),)
                            ],),
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
    );
  }
}
