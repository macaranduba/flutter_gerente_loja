import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {

  final _usersController = BehaviorSubject();

  Map<String, Map<String, dynamic>> _users = {}; // or Map();

  Firestore _firestore = Firestore.instance;

  UserBloc() {
    _addUsersListener();
  }

  @override
  void dispose() {
    _usersController.close();
    super.dispose();
  }

  void _addUsersListener() {
    _firestore.collection('users').snapshots().listen( (snapshot) {
      snapshot.documentChanges.forEach( (change) {
        String uid = change.document.documentID;
        switch(change.type) {
          case DocumentChangeType.added:
            _users[uid] = change.document.data;

            break;
          case DocumentChangeType.modified:
            // because data hold changes only, we use Map.addAll and not Map[key] = value
            _users[uid].addAll(change.document.data);
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            break;
        }
      });
    });
  }
}
