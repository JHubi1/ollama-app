import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

export 'package:drift/drift.dart';

part 'chat_database.g.dart';

late final ChatDatabase chatDb;

class Chats extends Table {
  TextColumn get id => text().unique()();
  TextColumn get json => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Assets extends Table {
  TextColumn get id => text().unique()();
  TextColumn get chatId =>
      text().references(Chats, #id, onDelete: KeyAction.cascade)();
  BlobColumn get data => blob()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(tables: [Chats, Assets])
class ChatDatabase extends _$ChatDatabase {
  ChatDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: "chatDatabase",
      native: const DriftNativeOptions(),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse("sqlite3.wasm"),
        driftWorker: Uri.parse("drift_worker.js"),
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement("PRAGMA foreign_keys = ON");
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // if (from < 2) {}
      },
    );
  }
}
