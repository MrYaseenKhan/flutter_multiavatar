import 'package:custom_multiavatar/api_services/db_services.dart';
import 'package:custom_multiavatar/providers/multi_avatar_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  ValueNotifier<String> avatarNotifier = ValueNotifier("Default User");
  late MultiAvatarProvider multiAvatarProvider;

  @override
  void initState() {
    multiAvatarProvider =
        Provider.of<MultiAvatarProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multiavatar",  style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30,),
              const Text(
                "12 Billion Unique Multicultural Avatars",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Names-based avatars (identicons) in vector SVG and raster PNG formats for your website, community, or an app",
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30,),
              Consumer<MultiAvatarProvider>(
                builder: (context, userName, child) => SizedBox(
                  height: 100,
                  width: 100,
                  child: FutureBuilder(
                    future: DBServices.fetchCustomAvatar(
                        name: userName.geNameAvatar),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CupertinoActivityIndicator();
                      }
                      if (snapshot.hasData) {
                        return Image.memory(snapshot.data!);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (value) {
                  if(value.isNotEmpty){
                    multiAvatarProvider.setNameAvatar = value;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Write your name",
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Add rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: const Icon(Icons.person),
                ),
                controller: controller,
              ),
              const SizedBox(height: 10),
              const Text(
                "Get a unique avatar by entering your name!",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
