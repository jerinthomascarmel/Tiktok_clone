import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/search_controller.dart' as controller;
import 'package:tiktok_clone/models/user_Model.dart';
import 'package:tiktok_clone/views/screen/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  controller.SearchController searchController =
      Get.put(controller.SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(141, 255, 86, 34),
          title: TextFormField(
            onFieldSubmitted: (value) => searchController.searchUser(value),
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        body: searchController.searchedUser.isEmpty
            ? const Center(
                child: Text(
                'Search for users!',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ))
            : ListView.builder(
                itemCount: searchController.searchedUser.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUser[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileScreen(uid: user.uid),
                    )),
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePhoto)),
                      title: Text(
                        user.name,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
