import "package:cloud_firestore/cloud_firestore.dart";
import "package:get/get.dart";
import "package:tiktok_clone/constants.dart";
import "package:tiktok_clone/models/user_Model.dart" as model;

class SearchController extends GetxController {
  final Rx<List<model.User>> _searchedUsers = Rx<List<model.User>>([]);

  List<model.User> get searchedUser => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.value.clear();
    if (typedUser.isNotEmpty) {
      _searchedUsers.bindStream(firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map((QuerySnapshot query) {
        List<model.User> retVal = [];
        for (var elem in query.docs) {
          retVal.add(model.User.fromSnap(elem));
        }
        return retVal;
      }));
    } else {
      _searchedUsers.value.clear();
    }
  }
}
