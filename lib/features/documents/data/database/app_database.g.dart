// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DocumentsTableTable extends DocumentsTable
    with TableInfo<$DocumentsTableTable, DocumentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstPagePreviewPathMeta =
      const VerificationMeta('firstPagePreviewPath');
  @override
  late final GeneratedColumn<String> firstPagePreviewPath =
      GeneratedColumn<String>(
        'first_page_preview_path',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastPagePreviewPathMeta =
      const VerificationMeta('lastPagePreviewPath');
  @override
  late final GeneratedColumn<String> lastPagePreviewPath =
      GeneratedColumn<String>(
        'last_page_preview_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _pageCountMeta = const VerificationMeta(
    'pageCount',
  );
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
    'page_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    filePath,
    firstPagePreviewPath,
    lastPagePreviewPath,
    pageCount,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('first_page_preview_path')) {
      context.handle(
        _firstPagePreviewPathMeta,
        firstPagePreviewPath.isAcceptableOrUnknown(
          data['first_page_preview_path']!,
          _firstPagePreviewPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstPagePreviewPathMeta);
    }
    if (data.containsKey('last_page_preview_path')) {
      context.handle(
        _lastPagePreviewPathMeta,
        lastPagePreviewPath.isAcceptableOrUnknown(
          data['last_page_preview_path']!,
          _lastPagePreviewPathMeta,
        ),
      );
    }
    if (data.containsKey('page_count')) {
      context.handle(
        _pageCountMeta,
        pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta),
      );
    } else if (isInserting) {
      context.missing(_pageCountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      firstPagePreviewPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_page_preview_path'],
      )!,
      lastPagePreviewPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_page_preview_path'],
      ),
      pageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_count'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DocumentsTableTable createAlias(String alias) {
    return $DocumentsTableTable(attachedDatabase, alias);
  }
}

class DocumentsTableData extends DataClass
    implements Insertable<DocumentsTableData> {
  final String id;
  final String title;
  final String filePath;
  final String firstPagePreviewPath;
  final String? lastPagePreviewPath;
  final int pageCount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DocumentsTableData({
    required this.id,
    required this.title,
    required this.filePath,
    required this.firstPagePreviewPath,
    this.lastPagePreviewPath,
    required this.pageCount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['file_path'] = Variable<String>(filePath);
    map['first_page_preview_path'] = Variable<String>(firstPagePreviewPath);
    if (!nullToAbsent || lastPagePreviewPath != null) {
      map['last_page_preview_path'] = Variable<String>(lastPagePreviewPath);
    }
    map['page_count'] = Variable<int>(pageCount);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentsTableCompanion toCompanion(bool nullToAbsent) {
    return DocumentsTableCompanion(
      id: Value(id),
      title: Value(title),
      filePath: Value(filePath),
      firstPagePreviewPath: Value(firstPagePreviewPath),
      lastPagePreviewPath: lastPagePreviewPath == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPagePreviewPath),
      pageCount: Value(pageCount),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DocumentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentsTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      filePath: serializer.fromJson<String>(json['filePath']),
      firstPagePreviewPath: serializer.fromJson<String>(
        json['firstPagePreviewPath'],
      ),
      lastPagePreviewPath: serializer.fromJson<String?>(
        json['lastPagePreviewPath'],
      ),
      pageCount: serializer.fromJson<int>(json['pageCount']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'filePath': serializer.toJson<String>(filePath),
      'firstPagePreviewPath': serializer.toJson<String>(firstPagePreviewPath),
      'lastPagePreviewPath': serializer.toJson<String?>(lastPagePreviewPath),
      'pageCount': serializer.toJson<int>(pageCount),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DocumentsTableData copyWith({
    String? id,
    String? title,
    String? filePath,
    String? firstPagePreviewPath,
    Value<String?> lastPagePreviewPath = const Value.absent(),
    int? pageCount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DocumentsTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    filePath: filePath ?? this.filePath,
    firstPagePreviewPath: firstPagePreviewPath ?? this.firstPagePreviewPath,
    lastPagePreviewPath: lastPagePreviewPath.present
        ? lastPagePreviewPath.value
        : this.lastPagePreviewPath,
    pageCount: pageCount ?? this.pageCount,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DocumentsTableData copyWithCompanion(DocumentsTableCompanion data) {
    return DocumentsTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      firstPagePreviewPath: data.firstPagePreviewPath.present
          ? data.firstPagePreviewPath.value
          : this.firstPagePreviewPath,
      lastPagePreviewPath: data.lastPagePreviewPath.present
          ? data.lastPagePreviewPath.value
          : this.lastPagePreviewPath,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('firstPagePreviewPath: $firstPagePreviewPath, ')
          ..write('lastPagePreviewPath: $lastPagePreviewPath, ')
          ..write('pageCount: $pageCount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    filePath,
    firstPagePreviewPath,
    lastPagePreviewPath,
    pageCount,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.filePath == this.filePath &&
          other.firstPagePreviewPath == this.firstPagePreviewPath &&
          other.lastPagePreviewPath == this.lastPagePreviewPath &&
          other.pageCount == this.pageCount &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DocumentsTableCompanion extends UpdateCompanion<DocumentsTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> filePath;
  final Value<String> firstPagePreviewPath;
  final Value<String?> lastPagePreviewPath;
  final Value<int> pageCount;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DocumentsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.filePath = const Value.absent(),
    this.firstPagePreviewPath = const Value.absent(),
    this.lastPagePreviewPath = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsTableCompanion.insert({
    required String id,
    required String title,
    required String filePath,
    required String firstPagePreviewPath,
    this.lastPagePreviewPath = const Value.absent(),
    required int pageCount,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       filePath = Value(filePath),
       firstPagePreviewPath = Value(firstPagePreviewPath),
       pageCount = Value(pageCount),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DocumentsTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? filePath,
    Expression<String>? firstPagePreviewPath,
    Expression<String>? lastPagePreviewPath,
    Expression<int>? pageCount,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (filePath != null) 'file_path': filePath,
      if (firstPagePreviewPath != null)
        'first_page_preview_path': firstPagePreviewPath,
      if (lastPagePreviewPath != null)
        'last_page_preview_path': lastPagePreviewPath,
      if (pageCount != null) 'page_count': pageCount,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? filePath,
    Value<String>? firstPagePreviewPath,
    Value<String?>? lastPagePreviewPath,
    Value<int>? pageCount,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DocumentsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      firstPagePreviewPath: firstPagePreviewPath ?? this.firstPagePreviewPath,
      lastPagePreviewPath: lastPagePreviewPath ?? this.lastPagePreviewPath,
      pageCount: pageCount ?? this.pageCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (firstPagePreviewPath.present) {
      map['first_page_preview_path'] = Variable<String>(
        firstPagePreviewPath.value,
      );
    }
    if (lastPagePreviewPath.present) {
      map['last_page_preview_path'] = Variable<String>(
        lastPagePreviewPath.value,
      );
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('firstPagePreviewPath: $firstPagePreviewPath, ')
          ..write('lastPagePreviewPath: $lastPagePreviewPath, ')
          ..write('pageCount: $pageCount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DocumentsTableTable documentsTable = $DocumentsTableTable(this);
  late final DocumentDao documentDao = DocumentDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [documentsTable];
}

typedef $$DocumentsTableTableCreateCompanionBuilder =
    DocumentsTableCompanion Function({
      required String id,
      required String title,
      required String filePath,
      required String firstPagePreviewPath,
      Value<String?> lastPagePreviewPath,
      required int pageCount,
      required String status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DocumentsTableTableUpdateCompanionBuilder =
    DocumentsTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> filePath,
      Value<String> firstPagePreviewPath,
      Value<String?> lastPagePreviewPath,
      Value<int> pageCount,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DocumentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstPagePreviewPath => $composableBuilder(
    column: $table.firstPagePreviewPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastPagePreviewPath => $composableBuilder(
    column: $table.lastPagePreviewPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstPagePreviewPath => $composableBuilder(
    column: $table.firstPagePreviewPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastPagePreviewPath => $composableBuilder(
    column: $table.lastPagePreviewPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get firstPagePreviewPath => $composableBuilder(
    column: $table.firstPagePreviewPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastPagePreviewPath => $composableBuilder(
    column: $table.lastPagePreviewPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DocumentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTableTable,
          DocumentsTableData,
          $$DocumentsTableTableFilterComposer,
          $$DocumentsTableTableOrderingComposer,
          $$DocumentsTableTableAnnotationComposer,
          $$DocumentsTableTableCreateCompanionBuilder,
          $$DocumentsTableTableUpdateCompanionBuilder,
          (
            DocumentsTableData,
            BaseReferences<
              _$AppDatabase,
              $DocumentsTableTable,
              DocumentsTableData
            >,
          ),
          DocumentsTableData,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableTableManager(
    _$AppDatabase db,
    $DocumentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> firstPagePreviewPath = const Value.absent(),
                Value<String?> lastPagePreviewPath = const Value.absent(),
                Value<int> pageCount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsTableCompanion(
                id: id,
                title: title,
                filePath: filePath,
                firstPagePreviewPath: firstPagePreviewPath,
                lastPagePreviewPath: lastPagePreviewPath,
                pageCount: pageCount,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String filePath,
                required String firstPagePreviewPath,
                Value<String?> lastPagePreviewPath = const Value.absent(),
                required int pageCount,
                required String status,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DocumentsTableCompanion.insert(
                id: id,
                title: title,
                filePath: filePath,
                firstPagePreviewPath: firstPagePreviewPath,
                lastPagePreviewPath: lastPagePreviewPath,
                pageCount: pageCount,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTableTable,
      DocumentsTableData,
      $$DocumentsTableTableFilterComposer,
      $$DocumentsTableTableOrderingComposer,
      $$DocumentsTableTableAnnotationComposer,
      $$DocumentsTableTableCreateCompanionBuilder,
      $$DocumentsTableTableUpdateCompanionBuilder,
      (
        DocumentsTableData,
        BaseReferences<_$AppDatabase, $DocumentsTableTable, DocumentsTableData>,
      ),
      DocumentsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DocumentsTableTableTableManager get documentsTable =>
      $$DocumentsTableTableTableManager(_db, _db.documentsTable);
}
