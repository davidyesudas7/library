import 'package:library_server/src/generated/protocol.dart' as app;
import 'package:serverpod/serverpod.dart';

class DownloadDataEndpoint extends Endpoint {
  Future<void> saveDownloadRequest(
    Session session,
    app.DownloadedBook downloadedBook,
  ) async {
    try {
      await app.DownloadedBook.db.insertRow(session, downloadedBook);
    } catch (e) {
      session.log('Failed to save download request: $e');
    }
  }
  Future<int> getTotalDownloadCount(Session session) async {
    return await app.DownloadedBook.db.count(session);
  }

  Future<int> getBookDownloadCount(Session session, int bookId) async {
    return await app.DownloadedBook.db.count(
      session,
      where: (t) => t.bookId.equals(bookId),
    );
  }
}
