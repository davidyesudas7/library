import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class CategoryEndpoint extends Endpoint {
  Future<List<Category>> getAll(Session session) async {
    return await Category.db.find(session);
  }

  Future<Category> create(Session session, Category category) async {
    return await Category.db.insertRow(session, category);
  }

  Future<Category> update(Session session, Category category) async {
    return await Category.db.updateRow(session, category);
  }

  Future<Category> delete(Session session, Category category) async {
    return await Category.db.deleteRow(session, category);
  }
}
