import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {

  final _usersController = BehaviorSubject<List>();
  Stream<List> get outUsers => _usersController.stream;

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
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            // because data hold changes only, we use Map.addAll and not Map[key] = value
            _users[uid].addAll(change.document.data);
            _usersController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            _unsubscribeToOrders(uid);
            _usersController.add(_users.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToOrders(String uid)  {
    _users[uid]['subscription'] = _firestore.collection('users').document(uid)
      .collection('orders').snapshots().listen( (orders) async {

        int numOrders = orders.documents.length;
        double money = .0;
        for(DocumentSnapshot doc in orders.documents) {
          DocumentSnapshot order = await _firestore.collection('orders')
            .document(doc.documentID).get();
          if(order.data == null) continue; // what if, for some reason, order details does not exist any more?
          money += order.data['totalPrice'];
        }

        _users[uid].addAll( {
          'money': money,
          'numOrders': numOrders
        });

        _usersController.add(_users.values.toList());
    });
  }

  void _unsubscribeToOrders(String uid) { // make sure we cancel user data listener subscription after user has been deleted
    _users[uid]['subscription'].cancel();
  }
}
