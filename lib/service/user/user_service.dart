import 'package:flutter_prj/model/user_model.dart';
import 'package:flutter_prj/service/user/user_service_interface.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

class UserService implements IUserService {
  final Rethinkdb _db;
  final Connection _connection;

  UserService(this._db, this._connection);

  @override
  Future<User> connect(User user) async {
    var data = user.toJson();
    if (user.id != null) data['id'] = user.id;
    final result = await _db.table('users').insert(data, {
      'conflict': 'update',
      'return_changes': true,
    }).run(_connection);
    return User.fromJson(result['changes'].first['new_val']);
  }

  @override
  Future<void> disconnect(User user) async {
    await _db.table('user').update({'id':user.id, 'active':false, 'last_seen':DateTime.now()}).run(_connection);
    _connection.close();
  }

  @override
  Future<List<User>> online() async {
    Cursor cursor = await _db.table('users').filter({'active':true}).run(_connection);
    final users = await cursor.toList();
    return users.map((u)=>User.fromJson(u)).toList();
  }
}