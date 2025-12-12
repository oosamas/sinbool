// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChaptersTable extends Chapters with TableInfo<$ChaptersTable, Chapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _titleArabicMeta = const VerificationMeta(
    'titleArabic',
  );
  @override
  late final GeneratedColumn<String> titleArabic = GeneratedColumn<String>(
    'title_arabic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionArabicMeta = const VerificationMeta(
    'descriptionArabic',
  );
  @override
  late final GeneratedColumn<String> descriptionArabic =
      GeneratedColumn<String>(
        'description_arabic',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('menu_book'),
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#2E7D32'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lessonCountMeta = const VerificationMeta(
    'lessonCount',
  );
  @override
  late final GeneratedColumn<int> lessonCount = GeneratedColumn<int>(
    'lesson_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isPremiumMeta = const VerificationMeta(
    'isPremium',
  );
  @override
  late final GeneratedColumn<bool> isPremium = GeneratedColumn<bool>(
    'is_premium',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_premium" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDownloadedMeta = const VerificationMeta(
    'isDownloaded',
  );
  @override
  late final GeneratedColumn<bool> isDownloaded = GeneratedColumn<bool>(
    'is_downloaded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_downloaded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    title,
    titleArabic,
    description,
    descriptionArabic,
    iconName,
    colorHex,
    sortOrder,
    lessonCount,
    isPremium,
    isDownloaded,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Chapter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('title_arabic')) {
      context.handle(
        _titleArabicMeta,
        titleArabic.isAcceptableOrUnknown(
          data['title_arabic']!,
          _titleArabicMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('description_arabic')) {
      context.handle(
        _descriptionArabicMeta,
        descriptionArabic.isAcceptableOrUnknown(
          data['description_arabic']!,
          _descriptionArabicMeta,
        ),
      );
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('lesson_count')) {
      context.handle(
        _lessonCountMeta,
        lessonCount.isAcceptableOrUnknown(
          data['lesson_count']!,
          _lessonCountMeta,
        ),
      );
    }
    if (data.containsKey('is_premium')) {
      context.handle(
        _isPremiumMeta,
        isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta),
      );
    }
    if (data.containsKey('is_downloaded')) {
      context.handle(
        _isDownloadedMeta,
        isDownloaded.isAcceptableOrUnknown(
          data['is_downloaded']!,
          _isDownloadedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chapter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      titleArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_arabic'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      descriptionArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_arabic'],
      ),
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      lessonCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_count'],
      )!,
      isPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_premium'],
      )!,
      isDownloaded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_downloaded'],
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
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

class Chapter extends DataClass implements Insertable<Chapter> {
  final int id;
  final String serverId;
  final String title;
  final String? titleArabic;
  final String description;
  final String? descriptionArabic;
  final String iconName;
  final String colorHex;
  final int sortOrder;
  final int lessonCount;
  final bool isPremium;
  final bool isDownloaded;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Chapter({
    required this.id,
    required this.serverId,
    required this.title,
    this.titleArabic,
    required this.description,
    this.descriptionArabic,
    required this.iconName,
    required this.colorHex,
    required this.sortOrder,
    required this.lessonCount,
    required this.isPremium,
    required this.isDownloaded,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || titleArabic != null) {
      map['title_arabic'] = Variable<String>(titleArabic);
    }
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || descriptionArabic != null) {
      map['description_arabic'] = Variable<String>(descriptionArabic);
    }
    map['icon_name'] = Variable<String>(iconName);
    map['color_hex'] = Variable<String>(colorHex);
    map['sort_order'] = Variable<int>(sortOrder);
    map['lesson_count'] = Variable<int>(lessonCount);
    map['is_premium'] = Variable<bool>(isPremium);
    map['is_downloaded'] = Variable<bool>(isDownloaded);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      serverId: Value(serverId),
      title: Value(title),
      titleArabic: titleArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(titleArabic),
      description: Value(description),
      descriptionArabic: descriptionArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionArabic),
      iconName: Value(iconName),
      colorHex: Value(colorHex),
      sortOrder: Value(sortOrder),
      lessonCount: Value(lessonCount),
      isPremium: Value(isPremium),
      isDownloaded: Value(isDownloaded),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Chapter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chapter(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      title: serializer.fromJson<String>(json['title']),
      titleArabic: serializer.fromJson<String?>(json['titleArabic']),
      description: serializer.fromJson<String>(json['description']),
      descriptionArabic: serializer.fromJson<String?>(
        json['descriptionArabic'],
      ),
      iconName: serializer.fromJson<String>(json['iconName']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      lessonCount: serializer.fromJson<int>(json['lessonCount']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
      isDownloaded: serializer.fromJson<bool>(json['isDownloaded']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'title': serializer.toJson<String>(title),
      'titleArabic': serializer.toJson<String?>(titleArabic),
      'description': serializer.toJson<String>(description),
      'descriptionArabic': serializer.toJson<String?>(descriptionArabic),
      'iconName': serializer.toJson<String>(iconName),
      'colorHex': serializer.toJson<String>(colorHex),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'lessonCount': serializer.toJson<int>(lessonCount),
      'isPremium': serializer.toJson<bool>(isPremium),
      'isDownloaded': serializer.toJson<bool>(isDownloaded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Chapter copyWith({
    int? id,
    String? serverId,
    String? title,
    Value<String?> titleArabic = const Value.absent(),
    String? description,
    Value<String?> descriptionArabic = const Value.absent(),
    String? iconName,
    String? colorHex,
    int? sortOrder,
    int? lessonCount,
    bool? isPremium,
    bool? isDownloaded,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Chapter(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    title: title ?? this.title,
    titleArabic: titleArabic.present ? titleArabic.value : this.titleArabic,
    description: description ?? this.description,
    descriptionArabic: descriptionArabic.present
        ? descriptionArabic.value
        : this.descriptionArabic,
    iconName: iconName ?? this.iconName,
    colorHex: colorHex ?? this.colorHex,
    sortOrder: sortOrder ?? this.sortOrder,
    lessonCount: lessonCount ?? this.lessonCount,
    isPremium: isPremium ?? this.isPremium,
    isDownloaded: isDownloaded ?? this.isDownloaded,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Chapter copyWithCompanion(ChaptersCompanion data) {
    return Chapter(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      title: data.title.present ? data.title.value : this.title,
      titleArabic: data.titleArabic.present
          ? data.titleArabic.value
          : this.titleArabic,
      description: data.description.present
          ? data.description.value
          : this.description,
      descriptionArabic: data.descriptionArabic.present
          ? data.descriptionArabic.value
          : this.descriptionArabic,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      lessonCount: data.lessonCount.present
          ? data.lessonCount.value
          : this.lessonCount,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
      isDownloaded: data.isDownloaded.present
          ? data.isDownloaded.value
          : this.isDownloaded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chapter(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('title: $title, ')
          ..write('titleArabic: $titleArabic, ')
          ..write('description: $description, ')
          ..write('descriptionArabic: $descriptionArabic, ')
          ..write('iconName: $iconName, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('lessonCount: $lessonCount, ')
          ..write('isPremium: $isPremium, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    title,
    titleArabic,
    description,
    descriptionArabic,
    iconName,
    colorHex,
    sortOrder,
    lessonCount,
    isPremium,
    isDownloaded,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chapter &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.title == this.title &&
          other.titleArabic == this.titleArabic &&
          other.description == this.description &&
          other.descriptionArabic == this.descriptionArabic &&
          other.iconName == this.iconName &&
          other.colorHex == this.colorHex &&
          other.sortOrder == this.sortOrder &&
          other.lessonCount == this.lessonCount &&
          other.isPremium == this.isPremium &&
          other.isDownloaded == this.isDownloaded &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChaptersCompanion extends UpdateCompanion<Chapter> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<String> title;
  final Value<String?> titleArabic;
  final Value<String> description;
  final Value<String?> descriptionArabic;
  final Value<String> iconName;
  final Value<String> colorHex;
  final Value<int> sortOrder;
  final Value<int> lessonCount;
  final Value<bool> isPremium;
  final Value<bool> isDownloaded;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.title = const Value.absent(),
    this.titleArabic = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionArabic = const Value.absent(),
    this.iconName = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.lessonCount = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChaptersCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    required String title,
    this.titleArabic = const Value.absent(),
    required String description,
    this.descriptionArabic = const Value.absent(),
    this.iconName = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.lessonCount = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : serverId = Value(serverId),
       title = Value(title),
       description = Value(description);
  static Insertable<Chapter> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<String>? title,
    Expression<String>? titleArabic,
    Expression<String>? description,
    Expression<String>? descriptionArabic,
    Expression<String>? iconName,
    Expression<String>? colorHex,
    Expression<int>? sortOrder,
    Expression<int>? lessonCount,
    Expression<bool>? isPremium,
    Expression<bool>? isDownloaded,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (title != null) 'title': title,
      if (titleArabic != null) 'title_arabic': titleArabic,
      if (description != null) 'description': description,
      if (descriptionArabic != null) 'description_arabic': descriptionArabic,
      if (iconName != null) 'icon_name': iconName,
      if (colorHex != null) 'color_hex': colorHex,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (lessonCount != null) 'lesson_count': lessonCount,
      if (isPremium != null) 'is_premium': isPremium,
      if (isDownloaded != null) 'is_downloaded': isDownloaded,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChaptersCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<String>? title,
    Value<String?>? titleArabic,
    Value<String>? description,
    Value<String?>? descriptionArabic,
    Value<String>? iconName,
    Value<String>? colorHex,
    Value<int>? sortOrder,
    Value<int>? lessonCount,
    Value<bool>? isPremium,
    Value<bool>? isDownloaded,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ChaptersCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      title: title ?? this.title,
      titleArabic: titleArabic ?? this.titleArabic,
      description: description ?? this.description,
      descriptionArabic: descriptionArabic ?? this.descriptionArabic,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      sortOrder: sortOrder ?? this.sortOrder,
      lessonCount: lessonCount ?? this.lessonCount,
      isPremium: isPremium ?? this.isPremium,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleArabic.present) {
      map['title_arabic'] = Variable<String>(titleArabic.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (descriptionArabic.present) {
      map['description_arabic'] = Variable<String>(descriptionArabic.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (lessonCount.present) {
      map['lesson_count'] = Variable<int>(lessonCount.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    if (isDownloaded.present) {
      map['is_downloaded'] = Variable<bool>(isDownloaded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('title: $title, ')
          ..write('titleArabic: $titleArabic, ')
          ..write('description: $description, ')
          ..write('descriptionArabic: $descriptionArabic, ')
          ..write('iconName: $iconName, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('lessonCount: $lessonCount, ')
          ..write('isPremium: $isPremium, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LessonsTable extends Lessons with TableInfo<$LessonsTable, Lesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id)',
    ),
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
  static const VerificationMeta _titleArabicMeta = const VerificationMeta(
    'titleArabic',
  );
  @override
  late final GeneratedColumn<String> titleArabic = GeneratedColumn<String>(
    'title_arabic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtitleArabicMeta = const VerificationMeta(
    'subtitleArabic',
  );
  @override
  late final GeneratedColumn<String> subtitleArabic = GeneratedColumn<String>(
    'subtitle_arabic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _hasAudioMeta = const VerificationMeta(
    'hasAudio',
  );
  @override
  late final GeneratedColumn<bool> hasAudio = GeneratedColumn<bool>(
    'has_audio',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_audio" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hasQuizMeta = const VerificationMeta(
    'hasQuiz',
  );
  @override
  late final GeneratedColumn<bool> hasQuiz = GeneratedColumn<bool>(
    'has_quiz',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_quiz" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _thumbnailUrlMeta = const VerificationMeta(
    'thumbnailUrl',
  );
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
    'thumbnail_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPremiumMeta = const VerificationMeta(
    'isPremium',
  );
  @override
  late final GeneratedColumn<bool> isPremium = GeneratedColumn<bool>(
    'is_premium',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_premium" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDownloadedMeta = const VerificationMeta(
    'isDownloaded',
  );
  @override
  late final GeneratedColumn<bool> isDownloaded = GeneratedColumn<bool>(
    'is_downloaded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_downloaded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    chapterId,
    title,
    titleArabic,
    subtitle,
    subtitleArabic,
    sortOrder,
    durationMinutes,
    hasAudio,
    hasQuiz,
    thumbnailUrl,
    audioUrl,
    isPremium,
    isDownloaded,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lessons';
  @override
  VerificationContext validateIntegrity(
    Insertable<Lesson> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('title_arabic')) {
      context.handle(
        _titleArabicMeta,
        titleArabic.isAcceptableOrUnknown(
          data['title_arabic']!,
          _titleArabicMeta,
        ),
      );
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    }
    if (data.containsKey('subtitle_arabic')) {
      context.handle(
        _subtitleArabicMeta,
        subtitleArabic.isAcceptableOrUnknown(
          data['subtitle_arabic']!,
          _subtitleArabicMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('has_audio')) {
      context.handle(
        _hasAudioMeta,
        hasAudio.isAcceptableOrUnknown(data['has_audio']!, _hasAudioMeta),
      );
    }
    if (data.containsKey('has_quiz')) {
      context.handle(
        _hasQuizMeta,
        hasQuiz.isAcceptableOrUnknown(data['has_quiz']!, _hasQuizMeta),
      );
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
        _thumbnailUrlMeta,
        thumbnailUrl.isAcceptableOrUnknown(
          data['thumbnail_url']!,
          _thumbnailUrlMeta,
        ),
      );
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    }
    if (data.containsKey('is_premium')) {
      context.handle(
        _isPremiumMeta,
        isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta),
      );
    }
    if (data.containsKey('is_downloaded')) {
      context.handle(
        _isDownloadedMeta,
        isDownloaded.isAcceptableOrUnknown(
          data['is_downloaded']!,
          _isDownloadedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lesson(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      titleArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_arabic'],
      ),
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      ),
      subtitleArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle_arabic'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      hasAudio: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_audio'],
      )!,
      hasQuiz: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_quiz'],
      )!,
      thumbnailUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_url'],
      ),
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
      ),
      isPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_premium'],
      )!,
      isDownloaded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_downloaded'],
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
  $LessonsTable createAlias(String alias) {
    return $LessonsTable(attachedDatabase, alias);
  }
}

class Lesson extends DataClass implements Insertable<Lesson> {
  final int id;
  final String serverId;
  final int chapterId;
  final String title;
  final String? titleArabic;
  final String? subtitle;
  final String? subtitleArabic;
  final int sortOrder;
  final int durationMinutes;
  final bool hasAudio;
  final bool hasQuiz;
  final String? thumbnailUrl;
  final String? audioUrl;
  final bool isPremium;
  final bool isDownloaded;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Lesson({
    required this.id,
    required this.serverId,
    required this.chapterId,
    required this.title,
    this.titleArabic,
    this.subtitle,
    this.subtitleArabic,
    required this.sortOrder,
    required this.durationMinutes,
    required this.hasAudio,
    required this.hasQuiz,
    this.thumbnailUrl,
    this.audioUrl,
    required this.isPremium,
    required this.isDownloaded,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<String>(serverId);
    map['chapter_id'] = Variable<int>(chapterId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || titleArabic != null) {
      map['title_arabic'] = Variable<String>(titleArabic);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || subtitleArabic != null) {
      map['subtitle_arabic'] = Variable<String>(subtitleArabic);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['has_audio'] = Variable<bool>(hasAudio);
    map['has_quiz'] = Variable<bool>(hasQuiz);
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    }
    if (!nullToAbsent || audioUrl != null) {
      map['audio_url'] = Variable<String>(audioUrl);
    }
    map['is_premium'] = Variable<bool>(isPremium);
    map['is_downloaded'] = Variable<bool>(isDownloaded);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      serverId: Value(serverId),
      chapterId: Value(chapterId),
      title: Value(title),
      titleArabic: titleArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(titleArabic),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      subtitleArabic: subtitleArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitleArabic),
      sortOrder: Value(sortOrder),
      durationMinutes: Value(durationMinutes),
      hasAudio: Value(hasAudio),
      hasQuiz: Value(hasQuiz),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      audioUrl: audioUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioUrl),
      isPremium: Value(isPremium),
      isDownloaded: Value(isDownloaded),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Lesson.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lesson(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String>(json['serverId']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      title: serializer.fromJson<String>(json['title']),
      titleArabic: serializer.fromJson<String?>(json['titleArabic']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      subtitleArabic: serializer.fromJson<String?>(json['subtitleArabic']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      hasAudio: serializer.fromJson<bool>(json['hasAudio']),
      hasQuiz: serializer.fromJson<bool>(json['hasQuiz']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      audioUrl: serializer.fromJson<String?>(json['audioUrl']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
      isDownloaded: serializer.fromJson<bool>(json['isDownloaded']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String>(serverId),
      'chapterId': serializer.toJson<int>(chapterId),
      'title': serializer.toJson<String>(title),
      'titleArabic': serializer.toJson<String?>(titleArabic),
      'subtitle': serializer.toJson<String?>(subtitle),
      'subtitleArabic': serializer.toJson<String?>(subtitleArabic),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'hasAudio': serializer.toJson<bool>(hasAudio),
      'hasQuiz': serializer.toJson<bool>(hasQuiz),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'audioUrl': serializer.toJson<String?>(audioUrl),
      'isPremium': serializer.toJson<bool>(isPremium),
      'isDownloaded': serializer.toJson<bool>(isDownloaded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Lesson copyWith({
    int? id,
    String? serverId,
    int? chapterId,
    String? title,
    Value<String?> titleArabic = const Value.absent(),
    Value<String?> subtitle = const Value.absent(),
    Value<String?> subtitleArabic = const Value.absent(),
    int? sortOrder,
    int? durationMinutes,
    bool? hasAudio,
    bool? hasQuiz,
    Value<String?> thumbnailUrl = const Value.absent(),
    Value<String?> audioUrl = const Value.absent(),
    bool? isPremium,
    bool? isDownloaded,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Lesson(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    chapterId: chapterId ?? this.chapterId,
    title: title ?? this.title,
    titleArabic: titleArabic.present ? titleArabic.value : this.titleArabic,
    subtitle: subtitle.present ? subtitle.value : this.subtitle,
    subtitleArabic: subtitleArabic.present
        ? subtitleArabic.value
        : this.subtitleArabic,
    sortOrder: sortOrder ?? this.sortOrder,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    hasAudio: hasAudio ?? this.hasAudio,
    hasQuiz: hasQuiz ?? this.hasQuiz,
    thumbnailUrl: thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
    audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,
    isPremium: isPremium ?? this.isPremium,
    isDownloaded: isDownloaded ?? this.isDownloaded,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Lesson copyWithCompanion(LessonsCompanion data) {
    return Lesson(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      title: data.title.present ? data.title.value : this.title,
      titleArabic: data.titleArabic.present
          ? data.titleArabic.value
          : this.titleArabic,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      subtitleArabic: data.subtitleArabic.present
          ? data.subtitleArabic.value
          : this.subtitleArabic,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      hasAudio: data.hasAudio.present ? data.hasAudio.value : this.hasAudio,
      hasQuiz: data.hasQuiz.present ? data.hasQuiz.value : this.hasQuiz,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
      isDownloaded: data.isDownloaded.present
          ? data.isDownloaded.value
          : this.isDownloaded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lesson(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('chapterId: $chapterId, ')
          ..write('title: $title, ')
          ..write('titleArabic: $titleArabic, ')
          ..write('subtitle: $subtitle, ')
          ..write('subtitleArabic: $subtitleArabic, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('hasAudio: $hasAudio, ')
          ..write('hasQuiz: $hasQuiz, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('isPremium: $isPremium, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    chapterId,
    title,
    titleArabic,
    subtitle,
    subtitleArabic,
    sortOrder,
    durationMinutes,
    hasAudio,
    hasQuiz,
    thumbnailUrl,
    audioUrl,
    isPremium,
    isDownloaded,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lesson &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.chapterId == this.chapterId &&
          other.title == this.title &&
          other.titleArabic == this.titleArabic &&
          other.subtitle == this.subtitle &&
          other.subtitleArabic == this.subtitleArabic &&
          other.sortOrder == this.sortOrder &&
          other.durationMinutes == this.durationMinutes &&
          other.hasAudio == this.hasAudio &&
          other.hasQuiz == this.hasQuiz &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.audioUrl == this.audioUrl &&
          other.isPremium == this.isPremium &&
          other.isDownloaded == this.isDownloaded &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LessonsCompanion extends UpdateCompanion<Lesson> {
  final Value<int> id;
  final Value<String> serverId;
  final Value<int> chapterId;
  final Value<String> title;
  final Value<String?> titleArabic;
  final Value<String?> subtitle;
  final Value<String?> subtitleArabic;
  final Value<int> sortOrder;
  final Value<int> durationMinutes;
  final Value<bool> hasAudio;
  final Value<bool> hasQuiz;
  final Value<String?> thumbnailUrl;
  final Value<String?> audioUrl;
  final Value<bool> isPremium;
  final Value<bool> isDownloaded;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.title = const Value.absent(),
    this.titleArabic = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.subtitleArabic = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.hasAudio = const Value.absent(),
    this.hasQuiz = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LessonsCompanion.insert({
    this.id = const Value.absent(),
    required String serverId,
    required int chapterId,
    required String title,
    this.titleArabic = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.subtitleArabic = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.hasAudio = const Value.absent(),
    this.hasQuiz = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : serverId = Value(serverId),
       chapterId = Value(chapterId),
       title = Value(title);
  static Insertable<Lesson> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<int>? chapterId,
    Expression<String>? title,
    Expression<String>? titleArabic,
    Expression<String>? subtitle,
    Expression<String>? subtitleArabic,
    Expression<int>? sortOrder,
    Expression<int>? durationMinutes,
    Expression<bool>? hasAudio,
    Expression<bool>? hasQuiz,
    Expression<String>? thumbnailUrl,
    Expression<String>? audioUrl,
    Expression<bool>? isPremium,
    Expression<bool>? isDownloaded,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (title != null) 'title': title,
      if (titleArabic != null) 'title_arabic': titleArabic,
      if (subtitle != null) 'subtitle': subtitle,
      if (subtitleArabic != null) 'subtitle_arabic': subtitleArabic,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (hasAudio != null) 'has_audio': hasAudio,
      if (hasQuiz != null) 'has_quiz': hasQuiz,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (isPremium != null) 'is_premium': isPremium,
      if (isDownloaded != null) 'is_downloaded': isDownloaded,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LessonsCompanion copyWith({
    Value<int>? id,
    Value<String>? serverId,
    Value<int>? chapterId,
    Value<String>? title,
    Value<String?>? titleArabic,
    Value<String?>? subtitle,
    Value<String?>? subtitleArabic,
    Value<int>? sortOrder,
    Value<int>? durationMinutes,
    Value<bool>? hasAudio,
    Value<bool>? hasQuiz,
    Value<String?>? thumbnailUrl,
    Value<String?>? audioUrl,
    Value<bool>? isPremium,
    Value<bool>? isDownloaded,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LessonsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      chapterId: chapterId ?? this.chapterId,
      title: title ?? this.title,
      titleArabic: titleArabic ?? this.titleArabic,
      subtitle: subtitle ?? this.subtitle,
      subtitleArabic: subtitleArabic ?? this.subtitleArabic,
      sortOrder: sortOrder ?? this.sortOrder,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      hasAudio: hasAudio ?? this.hasAudio,
      hasQuiz: hasQuiz ?? this.hasQuiz,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      isPremium: isPremium ?? this.isPremium,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleArabic.present) {
      map['title_arabic'] = Variable<String>(titleArabic.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (subtitleArabic.present) {
      map['subtitle_arabic'] = Variable<String>(subtitleArabic.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (hasAudio.present) {
      map['has_audio'] = Variable<bool>(hasAudio.value);
    }
    if (hasQuiz.present) {
      map['has_quiz'] = Variable<bool>(hasQuiz.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    if (isDownloaded.present) {
      map['is_downloaded'] = Variable<bool>(isDownloaded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('chapterId: $chapterId, ')
          ..write('title: $title, ')
          ..write('titleArabic: $titleArabic, ')
          ..write('subtitle: $subtitle, ')
          ..write('subtitleArabic: $subtitleArabic, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('hasAudio: $hasAudio, ')
          ..write('hasQuiz: $hasQuiz, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('isPremium: $isPremium, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LessonContentTable extends LessonContent
    with TableInfo<$LessonContentTable, LessonContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lessons (id)',
    ),
  );
  static const VerificationMeta _pageNumberMeta = const VerificationMeta(
    'pageNumber',
  );
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
    'page_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTextMeta = const VerificationMeta(
    'contentText',
  );
  @override
  late final GeneratedColumn<String> contentText = GeneratedColumn<String>(
    'content_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTextArabicMeta = const VerificationMeta(
    'contentTextArabic',
  );
  @override
  late final GeneratedColumn<String> contentTextArabic =
      GeneratedColumn<String>(
        'content_text_arabic',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageDescriptionMeta = const VerificationMeta(
    'imageDescription',
  );
  @override
  late final GeneratedColumn<String> imageDescription = GeneratedColumn<String>(
    'image_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioTimestampMeta = const VerificationMeta(
    'audioTimestamp',
  );
  @override
  late final GeneratedColumn<String> audioTimestamp = GeneratedColumn<String>(
    'audio_timestamp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lessonId,
    pageNumber,
    contentText,
    contentTextArabic,
    translation,
    imageUrl,
    imageDescription,
    audioTimestamp,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_content';
  @override
  VerificationContext validateIntegrity(
    Insertable<LessonContentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('page_number')) {
      context.handle(
        _pageNumberMeta,
        pageNumber.isAcceptableOrUnknown(data['page_number']!, _pageNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_pageNumberMeta);
    }
    if (data.containsKey('content_text')) {
      context.handle(
        _contentTextMeta,
        contentText.isAcceptableOrUnknown(
          data['content_text']!,
          _contentTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTextMeta);
    }
    if (data.containsKey('content_text_arabic')) {
      context.handle(
        _contentTextArabicMeta,
        contentTextArabic.isAcceptableOrUnknown(
          data['content_text_arabic']!,
          _contentTextArabicMeta,
        ),
      );
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_description')) {
      context.handle(
        _imageDescriptionMeta,
        imageDescription.isAcceptableOrUnknown(
          data['image_description']!,
          _imageDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('audio_timestamp')) {
      context.handle(
        _audioTimestampMeta,
        audioTimestamp.isAcceptableOrUnknown(
          data['audio_timestamp']!,
          _audioTimestampMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LessonContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonContentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_id'],
      )!,
      pageNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_number'],
      )!,
      contentText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_text'],
      )!,
      contentTextArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_text_arabic'],
      ),
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      imageDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_description'],
      ),
      audioTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_timestamp'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LessonContentTable createAlias(String alias) {
    return $LessonContentTable(attachedDatabase, alias);
  }
}

class LessonContentData extends DataClass
    implements Insertable<LessonContentData> {
  final int id;
  final int lessonId;
  final int pageNumber;
  final String contentText;
  final String? contentTextArabic;
  final String? translation;
  final String? imageUrl;
  final String? imageDescription;
  final String? audioTimestamp;
  final DateTime createdAt;
  const LessonContentData({
    required this.id,
    required this.lessonId,
    required this.pageNumber,
    required this.contentText,
    this.contentTextArabic,
    this.translation,
    this.imageUrl,
    this.imageDescription,
    this.audioTimestamp,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
    map['page_number'] = Variable<int>(pageNumber);
    map['content_text'] = Variable<String>(contentText);
    if (!nullToAbsent || contentTextArabic != null) {
      map['content_text_arabic'] = Variable<String>(contentTextArabic);
    }
    if (!nullToAbsent || translation != null) {
      map['translation'] = Variable<String>(translation);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || imageDescription != null) {
      map['image_description'] = Variable<String>(imageDescription);
    }
    if (!nullToAbsent || audioTimestamp != null) {
      map['audio_timestamp'] = Variable<String>(audioTimestamp);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LessonContentCompanion toCompanion(bool nullToAbsent) {
    return LessonContentCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      pageNumber: Value(pageNumber),
      contentText: Value(contentText),
      contentTextArabic: contentTextArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(contentTextArabic),
      translation: translation == null && nullToAbsent
          ? const Value.absent()
          : Value(translation),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      imageDescription: imageDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(imageDescription),
      audioTimestamp: audioTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(audioTimestamp),
      createdAt: Value(createdAt),
    );
  }

  factory LessonContentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonContentData(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int>(json['lessonId']),
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      contentText: serializer.fromJson<String>(json['contentText']),
      contentTextArabic: serializer.fromJson<String?>(
        json['contentTextArabic'],
      ),
      translation: serializer.fromJson<String?>(json['translation']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      imageDescription: serializer.fromJson<String?>(json['imageDescription']),
      audioTimestamp: serializer.fromJson<String?>(json['audioTimestamp']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int>(lessonId),
      'pageNumber': serializer.toJson<int>(pageNumber),
      'contentText': serializer.toJson<String>(contentText),
      'contentTextArabic': serializer.toJson<String?>(contentTextArabic),
      'translation': serializer.toJson<String?>(translation),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'imageDescription': serializer.toJson<String?>(imageDescription),
      'audioTimestamp': serializer.toJson<String?>(audioTimestamp),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LessonContentData copyWith({
    int? id,
    int? lessonId,
    int? pageNumber,
    String? contentText,
    Value<String?> contentTextArabic = const Value.absent(),
    Value<String?> translation = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> imageDescription = const Value.absent(),
    Value<String?> audioTimestamp = const Value.absent(),
    DateTime? createdAt,
  }) => LessonContentData(
    id: id ?? this.id,
    lessonId: lessonId ?? this.lessonId,
    pageNumber: pageNumber ?? this.pageNumber,
    contentText: contentText ?? this.contentText,
    contentTextArabic: contentTextArabic.present
        ? contentTextArabic.value
        : this.contentTextArabic,
    translation: translation.present ? translation.value : this.translation,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    imageDescription: imageDescription.present
        ? imageDescription.value
        : this.imageDescription,
    audioTimestamp: audioTimestamp.present
        ? audioTimestamp.value
        : this.audioTimestamp,
    createdAt: createdAt ?? this.createdAt,
  );
  LessonContentData copyWithCompanion(LessonContentCompanion data) {
    return LessonContentData(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      pageNumber: data.pageNumber.present
          ? data.pageNumber.value
          : this.pageNumber,
      contentText: data.contentText.present
          ? data.contentText.value
          : this.contentText,
      contentTextArabic: data.contentTextArabic.present
          ? data.contentTextArabic.value
          : this.contentTextArabic,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageDescription: data.imageDescription.present
          ? data.imageDescription.value
          : this.imageDescription,
      audioTimestamp: data.audioTimestamp.present
          ? data.audioTimestamp.value
          : this.audioTimestamp,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonContentData(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('contentText: $contentText, ')
          ..write('contentTextArabic: $contentTextArabic, ')
          ..write('translation: $translation, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageDescription: $imageDescription, ')
          ..write('audioTimestamp: $audioTimestamp, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lessonId,
    pageNumber,
    contentText,
    contentTextArabic,
    translation,
    imageUrl,
    imageDescription,
    audioTimestamp,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonContentData &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.pageNumber == this.pageNumber &&
          other.contentText == this.contentText &&
          other.contentTextArabic == this.contentTextArabic &&
          other.translation == this.translation &&
          other.imageUrl == this.imageUrl &&
          other.imageDescription == this.imageDescription &&
          other.audioTimestamp == this.audioTimestamp &&
          other.createdAt == this.createdAt);
}

class LessonContentCompanion extends UpdateCompanion<LessonContentData> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<int> pageNumber;
  final Value<String> contentText;
  final Value<String?> contentTextArabic;
  final Value<String?> translation;
  final Value<String?> imageUrl;
  final Value<String?> imageDescription;
  final Value<String?> audioTimestamp;
  final Value<DateTime> createdAt;
  const LessonContentCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.pageNumber = const Value.absent(),
    this.contentText = const Value.absent(),
    this.contentTextArabic = const Value.absent(),
    this.translation = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageDescription = const Value.absent(),
    this.audioTimestamp = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LessonContentCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    required int pageNumber,
    required String contentText,
    this.contentTextArabic = const Value.absent(),
    this.translation = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageDescription = const Value.absent(),
    this.audioTimestamp = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : lessonId = Value(lessonId),
       pageNumber = Value(pageNumber),
       contentText = Value(contentText);
  static Insertable<LessonContentData> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<int>? pageNumber,
    Expression<String>? contentText,
    Expression<String>? contentTextArabic,
    Expression<String>? translation,
    Expression<String>? imageUrl,
    Expression<String>? imageDescription,
    Expression<String>? audioTimestamp,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (pageNumber != null) 'page_number': pageNumber,
      if (contentText != null) 'content_text': contentText,
      if (contentTextArabic != null) 'content_text_arabic': contentTextArabic,
      if (translation != null) 'translation': translation,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageDescription != null) 'image_description': imageDescription,
      if (audioTimestamp != null) 'audio_timestamp': audioTimestamp,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LessonContentCompanion copyWith({
    Value<int>? id,
    Value<int>? lessonId,
    Value<int>? pageNumber,
    Value<String>? contentText,
    Value<String?>? contentTextArabic,
    Value<String?>? translation,
    Value<String?>? imageUrl,
    Value<String?>? imageDescription,
    Value<String?>? audioTimestamp,
    Value<DateTime>? createdAt,
  }) {
    return LessonContentCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      pageNumber: pageNumber ?? this.pageNumber,
      contentText: contentText ?? this.contentText,
      contentTextArabic: contentTextArabic ?? this.contentTextArabic,
      translation: translation ?? this.translation,
      imageUrl: imageUrl ?? this.imageUrl,
      imageDescription: imageDescription ?? this.imageDescription,
      audioTimestamp: audioTimestamp ?? this.audioTimestamp,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (contentText.present) {
      map['content_text'] = Variable<String>(contentText.value);
    }
    if (contentTextArabic.present) {
      map['content_text_arabic'] = Variable<String>(contentTextArabic.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageDescription.present) {
      map['image_description'] = Variable<String>(imageDescription.value);
    }
    if (audioTimestamp.present) {
      map['audio_timestamp'] = Variable<String>(audioTimestamp.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonContentCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('pageNumber: $pageNumber, ')
          ..write('contentText: $contentText, ')
          ..write('contentTextArabic: $contentTextArabic, ')
          ..write('translation: $translation, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageDescription: $imageDescription, ')
          ..write('audioTimestamp: $audioTimestamp, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $QuizQuestionsTable extends QuizQuestions
    with TableInfo<$QuizQuestionsTable, QuizQuestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizQuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lessons (id)',
    ),
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionArabicMeta = const VerificationMeta(
    'questionArabic',
  );
  @override
  late final GeneratedColumn<String> questionArabic = GeneratedColumn<String>(
    'question_arabic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _optionsMeta = const VerificationMeta(
    'options',
  );
  @override
  late final GeneratedColumn<String> options = GeneratedColumn<String>(
    'options',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionsArabicMeta = const VerificationMeta(
    'optionsArabic',
  );
  @override
  late final GeneratedColumn<String> optionsArabic = GeneratedColumn<String>(
    'options_arabic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _correctIndexMeta = const VerificationMeta(
    'correctIndex',
  );
  @override
  late final GeneratedColumn<int> correctIndex = GeneratedColumn<int>(
    'correct_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _explanationArabicMeta = const VerificationMeta(
    'explanationArabic',
  );
  @override
  late final GeneratedColumn<String> explanationArabic =
      GeneratedColumn<String>(
        'explanation_arabic',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lessonId,
    question,
    questionArabic,
    options,
    optionsArabic,
    correctIndex,
    explanation,
    explanationArabic,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_questions';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuizQuestion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('question_arabic')) {
      context.handle(
        _questionArabicMeta,
        questionArabic.isAcceptableOrUnknown(
          data['question_arabic']!,
          _questionArabicMeta,
        ),
      );
    }
    if (data.containsKey('options')) {
      context.handle(
        _optionsMeta,
        options.isAcceptableOrUnknown(data['options']!, _optionsMeta),
      );
    } else if (isInserting) {
      context.missing(_optionsMeta);
    }
    if (data.containsKey('options_arabic')) {
      context.handle(
        _optionsArabicMeta,
        optionsArabic.isAcceptableOrUnknown(
          data['options_arabic']!,
          _optionsArabicMeta,
        ),
      );
    }
    if (data.containsKey('correct_index')) {
      context.handle(
        _correctIndexMeta,
        correctIndex.isAcceptableOrUnknown(
          data['correct_index']!,
          _correctIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctIndexMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    }
    if (data.containsKey('explanation_arabic')) {
      context.handle(
        _explanationArabicMeta,
        explanationArabic.isAcceptableOrUnknown(
          data['explanation_arabic']!,
          _explanationArabicMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizQuestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizQuestion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_id'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      questionArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_arabic'],
      ),
      options: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options'],
      )!,
      optionsArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options_arabic'],
      ),
      correctIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_index'],
      )!,
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      ),
      explanationArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation_arabic'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QuizQuestionsTable createAlias(String alias) {
    return $QuizQuestionsTable(attachedDatabase, alias);
  }
}

class QuizQuestion extends DataClass implements Insertable<QuizQuestion> {
  final int id;
  final int lessonId;
  final String question;
  final String? questionArabic;
  final String options;
  final String? optionsArabic;
  final int correctIndex;
  final String? explanation;
  final String? explanationArabic;
  final int sortOrder;
  final DateTime createdAt;
  const QuizQuestion({
    required this.id,
    required this.lessonId,
    required this.question,
    this.questionArabic,
    required this.options,
    this.optionsArabic,
    required this.correctIndex,
    this.explanation,
    this.explanationArabic,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
    map['question'] = Variable<String>(question);
    if (!nullToAbsent || questionArabic != null) {
      map['question_arabic'] = Variable<String>(questionArabic);
    }
    map['options'] = Variable<String>(options);
    if (!nullToAbsent || optionsArabic != null) {
      map['options_arabic'] = Variable<String>(optionsArabic);
    }
    map['correct_index'] = Variable<int>(correctIndex);
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    if (!nullToAbsent || explanationArabic != null) {
      map['explanation_arabic'] = Variable<String>(explanationArabic);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuizQuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuizQuestionsCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      question: Value(question),
      questionArabic: questionArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(questionArabic),
      options: Value(options),
      optionsArabic: optionsArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(optionsArabic),
      correctIndex: Value(correctIndex),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      explanationArabic: explanationArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(explanationArabic),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory QuizQuestion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizQuestion(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int>(json['lessonId']),
      question: serializer.fromJson<String>(json['question']),
      questionArabic: serializer.fromJson<String?>(json['questionArabic']),
      options: serializer.fromJson<String>(json['options']),
      optionsArabic: serializer.fromJson<String?>(json['optionsArabic']),
      correctIndex: serializer.fromJson<int>(json['correctIndex']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      explanationArabic: serializer.fromJson<String?>(
        json['explanationArabic'],
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int>(lessonId),
      'question': serializer.toJson<String>(question),
      'questionArabic': serializer.toJson<String?>(questionArabic),
      'options': serializer.toJson<String>(options),
      'optionsArabic': serializer.toJson<String?>(optionsArabic),
      'correctIndex': serializer.toJson<int>(correctIndex),
      'explanation': serializer.toJson<String?>(explanation),
      'explanationArabic': serializer.toJson<String?>(explanationArabic),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  QuizQuestion copyWith({
    int? id,
    int? lessonId,
    String? question,
    Value<String?> questionArabic = const Value.absent(),
    String? options,
    Value<String?> optionsArabic = const Value.absent(),
    int? correctIndex,
    Value<String?> explanation = const Value.absent(),
    Value<String?> explanationArabic = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => QuizQuestion(
    id: id ?? this.id,
    lessonId: lessonId ?? this.lessonId,
    question: question ?? this.question,
    questionArabic: questionArabic.present
        ? questionArabic.value
        : this.questionArabic,
    options: options ?? this.options,
    optionsArabic: optionsArabic.present
        ? optionsArabic.value
        : this.optionsArabic,
    correctIndex: correctIndex ?? this.correctIndex,
    explanation: explanation.present ? explanation.value : this.explanation,
    explanationArabic: explanationArabic.present
        ? explanationArabic.value
        : this.explanationArabic,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  QuizQuestion copyWithCompanion(QuizQuestionsCompanion data) {
    return QuizQuestion(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      question: data.question.present ? data.question.value : this.question,
      questionArabic: data.questionArabic.present
          ? data.questionArabic.value
          : this.questionArabic,
      options: data.options.present ? data.options.value : this.options,
      optionsArabic: data.optionsArabic.present
          ? data.optionsArabic.value
          : this.optionsArabic,
      correctIndex: data.correctIndex.present
          ? data.correctIndex.value
          : this.correctIndex,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      explanationArabic: data.explanationArabic.present
          ? data.explanationArabic.value
          : this.explanationArabic,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizQuestion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('question: $question, ')
          ..write('questionArabic: $questionArabic, ')
          ..write('options: $options, ')
          ..write('optionsArabic: $optionsArabic, ')
          ..write('correctIndex: $correctIndex, ')
          ..write('explanation: $explanation, ')
          ..write('explanationArabic: $explanationArabic, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lessonId,
    question,
    questionArabic,
    options,
    optionsArabic,
    correctIndex,
    explanation,
    explanationArabic,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizQuestion &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.question == this.question &&
          other.questionArabic == this.questionArabic &&
          other.options == this.options &&
          other.optionsArabic == this.optionsArabic &&
          other.correctIndex == this.correctIndex &&
          other.explanation == this.explanation &&
          other.explanationArabic == this.explanationArabic &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class QuizQuestionsCompanion extends UpdateCompanion<QuizQuestion> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<String> question;
  final Value<String?> questionArabic;
  final Value<String> options;
  final Value<String?> optionsArabic;
  final Value<int> correctIndex;
  final Value<String?> explanation;
  final Value<String?> explanationArabic;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const QuizQuestionsCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.question = const Value.absent(),
    this.questionArabic = const Value.absent(),
    this.options = const Value.absent(),
    this.optionsArabic = const Value.absent(),
    this.correctIndex = const Value.absent(),
    this.explanation = const Value.absent(),
    this.explanationArabic = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  QuizQuestionsCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    required String question,
    this.questionArabic = const Value.absent(),
    required String options,
    this.optionsArabic = const Value.absent(),
    required int correctIndex,
    this.explanation = const Value.absent(),
    this.explanationArabic = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : lessonId = Value(lessonId),
       question = Value(question),
       options = Value(options),
       correctIndex = Value(correctIndex);
  static Insertable<QuizQuestion> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<String>? question,
    Expression<String>? questionArabic,
    Expression<String>? options,
    Expression<String>? optionsArabic,
    Expression<int>? correctIndex,
    Expression<String>? explanation,
    Expression<String>? explanationArabic,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (question != null) 'question': question,
      if (questionArabic != null) 'question_arabic': questionArabic,
      if (options != null) 'options': options,
      if (optionsArabic != null) 'options_arabic': optionsArabic,
      if (correctIndex != null) 'correct_index': correctIndex,
      if (explanation != null) 'explanation': explanation,
      if (explanationArabic != null) 'explanation_arabic': explanationArabic,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  QuizQuestionsCompanion copyWith({
    Value<int>? id,
    Value<int>? lessonId,
    Value<String>? question,
    Value<String?>? questionArabic,
    Value<String>? options,
    Value<String?>? optionsArabic,
    Value<int>? correctIndex,
    Value<String?>? explanation,
    Value<String?>? explanationArabic,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return QuizQuestionsCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      question: question ?? this.question,
      questionArabic: questionArabic ?? this.questionArabic,
      options: options ?? this.options,
      optionsArabic: optionsArabic ?? this.optionsArabic,
      correctIndex: correctIndex ?? this.correctIndex,
      explanation: explanation ?? this.explanation,
      explanationArabic: explanationArabic ?? this.explanationArabic,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (questionArabic.present) {
      map['question_arabic'] = Variable<String>(questionArabic.value);
    }
    if (options.present) {
      map['options'] = Variable<String>(options.value);
    }
    if (optionsArabic.present) {
      map['options_arabic'] = Variable<String>(optionsArabic.value);
    }
    if (correctIndex.present) {
      map['correct_index'] = Variable<int>(correctIndex.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (explanationArabic.present) {
      map['explanation_arabic'] = Variable<String>(explanationArabic.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizQuestionsCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('question: $question, ')
          ..write('questionArabic: $questionArabic, ')
          ..write('options: $options, ')
          ..write('optionsArabic: $optionsArabic, ')
          ..write('correctIndex: $correctIndex, ')
          ..write('explanation: $explanation, ')
          ..write('explanationArabic: $explanationArabic, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lessons (id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, lessonId, note, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {lessonId},
  ];
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final int lessonId;
  final String? note;
  final DateTime createdAt;
  const Bookmark({
    required this.id,
    required this.lessonId,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int>(json['lessonId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int>(lessonId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bookmark copyWith({
    int? id,
    int? lessonId,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => Bookmark(
    id: id ?? this.id,
    lessonId: lessonId ?? this.lessonId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonId, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : lessonId = Value(lessonId);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<int>? lessonId,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserProgressTable extends UserProgress
    with TableInfo<$UserProgressTable, UserProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _totalLessonsCompletedMeta =
      const VerificationMeta('totalLessonsCompleted');
  @override
  late final GeneratedColumn<int> totalLessonsCompleted = GeneratedColumn<int>(
    'total_lessons_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalQuizzesPassedMeta =
      const VerificationMeta('totalQuizzesPassed');
  @override
  late final GeneratedColumn<int> totalQuizzesPassed = GeneratedColumn<int>(
    'total_quizzes_passed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalTimeMinutesMeta = const VerificationMeta(
    'totalTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> totalTimeMinutes = GeneratedColumn<int>(
    'total_time_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastActivityDateMeta = const VerificationMeta(
    'lastActivityDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastActivityDate =
      GeneratedColumn<DateTime>(
        'last_activity_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    totalLessonsCompleted,
    totalQuizzesPassed,
    currentStreak,
    longestStreak,
    totalTimeMinutes,
    lastActivityDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_lessons_completed')) {
      context.handle(
        _totalLessonsCompletedMeta,
        totalLessonsCompleted.isAcceptableOrUnknown(
          data['total_lessons_completed']!,
          _totalLessonsCompletedMeta,
        ),
      );
    }
    if (data.containsKey('total_quizzes_passed')) {
      context.handle(
        _totalQuizzesPassedMeta,
        totalQuizzesPassed.isAcceptableOrUnknown(
          data['total_quizzes_passed']!,
          _totalQuizzesPassedMeta,
        ),
      );
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    if (data.containsKey('total_time_minutes')) {
      context.handle(
        _totalTimeMinutesMeta,
        totalTimeMinutes.isAcceptableOrUnknown(
          data['total_time_minutes']!,
          _totalTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('last_activity_date')) {
      context.handle(
        _lastActivityDateMeta,
        lastActivityDate.isAcceptableOrUnknown(
          data['last_activity_date']!,
          _lastActivityDateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      totalLessonsCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_lessons_completed'],
      )!,
      totalQuizzesPassed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_quizzes_passed'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      longestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_streak'],
      )!,
      totalTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_time_minutes'],
      )!,
      lastActivityDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_activity_date'],
      ),
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
  $UserProgressTable createAlias(String alias) {
    return $UserProgressTable(attachedDatabase, alias);
  }
}

class UserProgressData extends DataClass
    implements Insertable<UserProgressData> {
  final int id;
  final int totalLessonsCompleted;
  final int totalQuizzesPassed;
  final int currentStreak;
  final int longestStreak;
  final int totalTimeMinutes;
  final DateTime? lastActivityDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProgressData({
    required this.id,
    required this.totalLessonsCompleted,
    required this.totalQuizzesPassed,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalTimeMinutes,
    this.lastActivityDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_lessons_completed'] = Variable<int>(totalLessonsCompleted);
    map['total_quizzes_passed'] = Variable<int>(totalQuizzesPassed);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    map['total_time_minutes'] = Variable<int>(totalTimeMinutes);
    if (!nullToAbsent || lastActivityDate != null) {
      map['last_activity_date'] = Variable<DateTime>(lastActivityDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProgressCompanion toCompanion(bool nullToAbsent) {
    return UserProgressCompanion(
      id: Value(id),
      totalLessonsCompleted: Value(totalLessonsCompleted),
      totalQuizzesPassed: Value(totalQuizzesPassed),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      totalTimeMinutes: Value(totalTimeMinutes),
      lastActivityDate: lastActivityDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActivityDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgressData(
      id: serializer.fromJson<int>(json['id']),
      totalLessonsCompleted: serializer.fromJson<int>(
        json['totalLessonsCompleted'],
      ),
      totalQuizzesPassed: serializer.fromJson<int>(json['totalQuizzesPassed']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      totalTimeMinutes: serializer.fromJson<int>(json['totalTimeMinutes']),
      lastActivityDate: serializer.fromJson<DateTime?>(
        json['lastActivityDate'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalLessonsCompleted': serializer.toJson<int>(totalLessonsCompleted),
      'totalQuizzesPassed': serializer.toJson<int>(totalQuizzesPassed),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'totalTimeMinutes': serializer.toJson<int>(totalTimeMinutes),
      'lastActivityDate': serializer.toJson<DateTime?>(lastActivityDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProgressData copyWith({
    int? id,
    int? totalLessonsCompleted,
    int? totalQuizzesPassed,
    int? currentStreak,
    int? longestStreak,
    int? totalTimeMinutes,
    Value<DateTime?> lastActivityDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserProgressData(
    id: id ?? this.id,
    totalLessonsCompleted: totalLessonsCompleted ?? this.totalLessonsCompleted,
    totalQuizzesPassed: totalQuizzesPassed ?? this.totalQuizzesPassed,
    currentStreak: currentStreak ?? this.currentStreak,
    longestStreak: longestStreak ?? this.longestStreak,
    totalTimeMinutes: totalTimeMinutes ?? this.totalTimeMinutes,
    lastActivityDate: lastActivityDate.present
        ? lastActivityDate.value
        : this.lastActivityDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProgressData copyWithCompanion(UserProgressCompanion data) {
    return UserProgressData(
      id: data.id.present ? data.id.value : this.id,
      totalLessonsCompleted: data.totalLessonsCompleted.present
          ? data.totalLessonsCompleted.value
          : this.totalLessonsCompleted,
      totalQuizzesPassed: data.totalQuizzesPassed.present
          ? data.totalQuizzesPassed.value
          : this.totalQuizzesPassed,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      totalTimeMinutes: data.totalTimeMinutes.present
          ? data.totalTimeMinutes.value
          : this.totalTimeMinutes,
      lastActivityDate: data.lastActivityDate.present
          ? data.lastActivityDate.value
          : this.lastActivityDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressData(')
          ..write('id: $id, ')
          ..write('totalLessonsCompleted: $totalLessonsCompleted, ')
          ..write('totalQuizzesPassed: $totalQuizzesPassed, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('totalTimeMinutes: $totalTimeMinutes, ')
          ..write('lastActivityDate: $lastActivityDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    totalLessonsCompleted,
    totalQuizzesPassed,
    currentStreak,
    longestStreak,
    totalTimeMinutes,
    lastActivityDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgressData &&
          other.id == this.id &&
          other.totalLessonsCompleted == this.totalLessonsCompleted &&
          other.totalQuizzesPassed == this.totalQuizzesPassed &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.totalTimeMinutes == this.totalTimeMinutes &&
          other.lastActivityDate == this.lastActivityDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProgressCompanion extends UpdateCompanion<UserProgressData> {
  final Value<int> id;
  final Value<int> totalLessonsCompleted;
  final Value<int> totalQuizzesPassed;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<int> totalTimeMinutes;
  final Value<DateTime?> lastActivityDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserProgressCompanion({
    this.id = const Value.absent(),
    this.totalLessonsCompleted = const Value.absent(),
    this.totalQuizzesPassed = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.totalTimeMinutes = const Value.absent(),
    this.lastActivityDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProgressCompanion.insert({
    this.id = const Value.absent(),
    this.totalLessonsCompleted = const Value.absent(),
    this.totalQuizzesPassed = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.totalTimeMinutes = const Value.absent(),
    this.lastActivityDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserProgressData> custom({
    Expression<int>? id,
    Expression<int>? totalLessonsCompleted,
    Expression<int>? totalQuizzesPassed,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<int>? totalTimeMinutes,
    Expression<DateTime>? lastActivityDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalLessonsCompleted != null)
        'total_lessons_completed': totalLessonsCompleted,
      if (totalQuizzesPassed != null)
        'total_quizzes_passed': totalQuizzesPassed,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (totalTimeMinutes != null) 'total_time_minutes': totalTimeMinutes,
      if (lastActivityDate != null) 'last_activity_date': lastActivityDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProgressCompanion copyWith({
    Value<int>? id,
    Value<int>? totalLessonsCompleted,
    Value<int>? totalQuizzesPassed,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<int>? totalTimeMinutes,
    Value<DateTime?>? lastActivityDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserProgressCompanion(
      id: id ?? this.id,
      totalLessonsCompleted:
          totalLessonsCompleted ?? this.totalLessonsCompleted,
      totalQuizzesPassed: totalQuizzesPassed ?? this.totalQuizzesPassed,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalTimeMinutes: totalTimeMinutes ?? this.totalTimeMinutes,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalLessonsCompleted.present) {
      map['total_lessons_completed'] = Variable<int>(
        totalLessonsCompleted.value,
      );
    }
    if (totalQuizzesPassed.present) {
      map['total_quizzes_passed'] = Variable<int>(totalQuizzesPassed.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (totalTimeMinutes.present) {
      map['total_time_minutes'] = Variable<int>(totalTimeMinutes.value);
    }
    if (lastActivityDate.present) {
      map['last_activity_date'] = Variable<DateTime>(lastActivityDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressCompanion(')
          ..write('id: $id, ')
          ..write('totalLessonsCompleted: $totalLessonsCompleted, ')
          ..write('totalQuizzesPassed: $totalQuizzesPassed, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('totalTimeMinutes: $totalTimeMinutes, ')
          ..write('lastActivityDate: $lastActivityDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LessonProgressTable extends LessonProgress
    with TableInfo<$LessonProgressTable, LessonProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<int> lessonId = GeneratedColumn<int>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lessons (id)',
    ),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastPageViewedMeta = const VerificationMeta(
    'lastPageViewed',
  );
  @override
  late final GeneratedColumn<int> lastPageViewed = GeneratedColumn<int>(
    'last_page_viewed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _quizScoreMeta = const VerificationMeta(
    'quizScore',
  );
  @override
  late final GeneratedColumn<int> quizScore = GeneratedColumn<int>(
    'quiz_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quizAttemptsMeta = const VerificationMeta(
    'quizAttempts',
  );
  @override
  late final GeneratedColumn<int> quizAttempts = GeneratedColumn<int>(
    'quiz_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _timeSpentMinutesMeta = const VerificationMeta(
    'timeSpentMinutes',
  );
  @override
  late final GeneratedColumn<int> timeSpentMinutes = GeneratedColumn<int>(
    'time_spent_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lessonId,
    isCompleted,
    lastPageViewed,
    quizScore,
    quizAttempts,
    timeSpentMinutes,
    startedAt,
    completedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<LessonProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('last_page_viewed')) {
      context.handle(
        _lastPageViewedMeta,
        lastPageViewed.isAcceptableOrUnknown(
          data['last_page_viewed']!,
          _lastPageViewedMeta,
        ),
      );
    }
    if (data.containsKey('quiz_score')) {
      context.handle(
        _quizScoreMeta,
        quizScore.isAcceptableOrUnknown(data['quiz_score']!, _quizScoreMeta),
      );
    }
    if (data.containsKey('quiz_attempts')) {
      context.handle(
        _quizAttemptsMeta,
        quizAttempts.isAcceptableOrUnknown(
          data['quiz_attempts']!,
          _quizAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('time_spent_minutes')) {
      context.handle(
        _timeSpentMinutesMeta,
        timeSpentMinutes.isAcceptableOrUnknown(
          data['time_spent_minutes']!,
          _timeSpentMinutesMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {lessonId},
  ];
  @override
  LessonProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_id'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      lastPageViewed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_page_viewed'],
      )!,
      quizScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quiz_score'],
      ),
      quizAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quiz_attempts'],
      )!,
      timeSpentMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_spent_minutes'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LessonProgressTable createAlias(String alias) {
    return $LessonProgressTable(attachedDatabase, alias);
  }
}

class LessonProgressData extends DataClass
    implements Insertable<LessonProgressData> {
  final int id;
  final int lessonId;
  final bool isCompleted;
  final int lastPageViewed;
  final int? quizScore;
  final int quizAttempts;
  final int timeSpentMinutes;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime updatedAt;
  const LessonProgressData({
    required this.id,
    required this.lessonId,
    required this.isCompleted,
    required this.lastPageViewed,
    this.quizScore,
    required this.quizAttempts,
    required this.timeSpentMinutes,
    this.startedAt,
    this.completedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<int>(lessonId);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['last_page_viewed'] = Variable<int>(lastPageViewed);
    if (!nullToAbsent || quizScore != null) {
      map['quiz_score'] = Variable<int>(quizScore);
    }
    map['quiz_attempts'] = Variable<int>(quizAttempts);
    map['time_spent_minutes'] = Variable<int>(timeSpentMinutes);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LessonProgressCompanion toCompanion(bool nullToAbsent) {
    return LessonProgressCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      isCompleted: Value(isCompleted),
      lastPageViewed: Value(lastPageViewed),
      quizScore: quizScore == null && nullToAbsent
          ? const Value.absent()
          : Value(quizScore),
      quizAttempts: Value(quizAttempts),
      timeSpentMinutes: Value(timeSpentMinutes),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LessonProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonProgressData(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<int>(json['lessonId']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      lastPageViewed: serializer.fromJson<int>(json['lastPageViewed']),
      quizScore: serializer.fromJson<int?>(json['quizScore']),
      quizAttempts: serializer.fromJson<int>(json['quizAttempts']),
      timeSpentMinutes: serializer.fromJson<int>(json['timeSpentMinutes']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<int>(lessonId),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'lastPageViewed': serializer.toJson<int>(lastPageViewed),
      'quizScore': serializer.toJson<int?>(quizScore),
      'quizAttempts': serializer.toJson<int>(quizAttempts),
      'timeSpentMinutes': serializer.toJson<int>(timeSpentMinutes),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LessonProgressData copyWith({
    int? id,
    int? lessonId,
    bool? isCompleted,
    int? lastPageViewed,
    Value<int?> quizScore = const Value.absent(),
    int? quizAttempts,
    int? timeSpentMinutes,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => LessonProgressData(
    id: id ?? this.id,
    lessonId: lessonId ?? this.lessonId,
    isCompleted: isCompleted ?? this.isCompleted,
    lastPageViewed: lastPageViewed ?? this.lastPageViewed,
    quizScore: quizScore.present ? quizScore.value : this.quizScore,
    quizAttempts: quizAttempts ?? this.quizAttempts,
    timeSpentMinutes: timeSpentMinutes ?? this.timeSpentMinutes,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LessonProgressData copyWithCompanion(LessonProgressCompanion data) {
    return LessonProgressData(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      lastPageViewed: data.lastPageViewed.present
          ? data.lastPageViewed.value
          : this.lastPageViewed,
      quizScore: data.quizScore.present ? data.quizScore.value : this.quizScore,
      quizAttempts: data.quizAttempts.present
          ? data.quizAttempts.value
          : this.quizAttempts,
      timeSpentMinutes: data.timeSpentMinutes.present
          ? data.timeSpentMinutes.value
          : this.timeSpentMinutes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressData(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('lastPageViewed: $lastPageViewed, ')
          ..write('quizScore: $quizScore, ')
          ..write('quizAttempts: $quizAttempts, ')
          ..write('timeSpentMinutes: $timeSpentMinutes, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lessonId,
    isCompleted,
    lastPageViewed,
    quizScore,
    quizAttempts,
    timeSpentMinutes,
    startedAt,
    completedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonProgressData &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.isCompleted == this.isCompleted &&
          other.lastPageViewed == this.lastPageViewed &&
          other.quizScore == this.quizScore &&
          other.quizAttempts == this.quizAttempts &&
          other.timeSpentMinutes == this.timeSpentMinutes &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt);
}

class LessonProgressCompanion extends UpdateCompanion<LessonProgressData> {
  final Value<int> id;
  final Value<int> lessonId;
  final Value<bool> isCompleted;
  final Value<int> lastPageViewed;
  final Value<int?> quizScore;
  final Value<int> quizAttempts;
  final Value<int> timeSpentMinutes;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> updatedAt;
  const LessonProgressCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.lastPageViewed = const Value.absent(),
    this.quizScore = const Value.absent(),
    this.quizAttempts = const Value.absent(),
    this.timeSpentMinutes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LessonProgressCompanion.insert({
    this.id = const Value.absent(),
    required int lessonId,
    this.isCompleted = const Value.absent(),
    this.lastPageViewed = const Value.absent(),
    this.quizScore = const Value.absent(),
    this.quizAttempts = const Value.absent(),
    this.timeSpentMinutes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : lessonId = Value(lessonId);
  static Insertable<LessonProgressData> custom({
    Expression<int>? id,
    Expression<int>? lessonId,
    Expression<bool>? isCompleted,
    Expression<int>? lastPageViewed,
    Expression<int>? quizScore,
    Expression<int>? quizAttempts,
    Expression<int>? timeSpentMinutes,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (lastPageViewed != null) 'last_page_viewed': lastPageViewed,
      if (quizScore != null) 'quiz_score': quizScore,
      if (quizAttempts != null) 'quiz_attempts': quizAttempts,
      if (timeSpentMinutes != null) 'time_spent_minutes': timeSpentMinutes,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LessonProgressCompanion copyWith({
    Value<int>? id,
    Value<int>? lessonId,
    Value<bool>? isCompleted,
    Value<int>? lastPageViewed,
    Value<int?>? quizScore,
    Value<int>? quizAttempts,
    Value<int>? timeSpentMinutes,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime>? updatedAt,
  }) {
    return LessonProgressCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      isCompleted: isCompleted ?? this.isCompleted,
      lastPageViewed: lastPageViewed ?? this.lastPageViewed,
      quizScore: quizScore ?? this.quizScore,
      quizAttempts: quizAttempts ?? this.quizAttempts,
      timeSpentMinutes: timeSpentMinutes ?? this.timeSpentMinutes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<int>(lessonId.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (lastPageViewed.present) {
      map['last_page_viewed'] = Variable<int>(lastPageViewed.value);
    }
    if (quizScore.present) {
      map['quiz_score'] = Variable<int>(quizScore.value);
    }
    if (quizAttempts.present) {
      map['quiz_attempts'] = Variable<int>(quizAttempts.value);
    }
    if (timeSpentMinutes.present) {
      map['time_spent_minutes'] = Variable<int>(timeSpentMinutes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('lastPageViewed: $lastPageViewed, ')
          ..write('quizScore: $quizScore, ')
          ..write('quizAttempts: $quizAttempts, ')
          ..write('timeSpentMinutes: $timeSpentMinutes, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSetting({
    required this.id,
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({
    int? id,
    String? key,
    String? value,
    DateTime? updatedAt,
  }) => AppSetting(
    id: id ?? this.id,
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $LessonContentTable lessonContent = $LessonContentTable(this);
  late final $QuizQuestionsTable quizQuestions = $QuizQuestionsTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $UserProgressTable userProgress = $UserProgressTable(this);
  late final $LessonProgressTable lessonProgress = $LessonProgressTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    chapters,
    lessons,
    lessonContent,
    quizQuestions,
    bookmarks,
    userProgress,
    lessonProgress,
    appSettings,
  ];
}

typedef $$ChaptersTableCreateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      required String serverId,
      required String title,
      Value<String?> titleArabic,
      required String description,
      Value<String?> descriptionArabic,
      Value<String> iconName,
      Value<String> colorHex,
      Value<int> sortOrder,
      Value<int> lessonCount,
      Value<bool> isPremium,
      Value<bool> isDownloaded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ChaptersTableUpdateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<String> title,
      Value<String?> titleArabic,
      Value<String> description,
      Value<String?> descriptionArabic,
      Value<String> iconName,
      Value<String> colorHex,
      Value<int> sortOrder,
      Value<int> lessonCount,
      Value<bool> isPremium,
      Value<bool> isDownloaded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ChaptersTableReferences
    extends BaseReferences<_$AppDatabase, $ChaptersTable, Chapter> {
  $$ChaptersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LessonsTable, List<Lesson>> _lessonsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.lessons,
    aliasName: $_aliasNameGenerator(db.chapters.id, db.lessons.chapterId),
  );

  $$LessonsTableProcessedTableManager get lessonsRefs {
    final manager = $$LessonsTableTableManager(
      $_db,
      $_db.lessons,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lessonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionArabic => $composableBuilder(
    column: $table.descriptionArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lessonCount => $composableBuilder(
    column: $table.lessonCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
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

  Expression<bool> lessonsRefs(
    Expression<bool> Function($$LessonsTableFilterComposer f) f,
  ) {
    final $$LessonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableFilterComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionArabic => $composableBuilder(
    column: $table.descriptionArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lessonCount => $composableBuilder(
    column: $table.lessonCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
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

class $$ChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionArabic => $composableBuilder(
    column: $table.descriptionArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get lessonCount => $composableBuilder(
    column: $table.lessonCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);

  GeneratedColumn<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> lessonsRefs<T extends Object>(
    Expression<T> Function($$LessonsTableAnnotationComposer a) f,
  ) {
    final $$LessonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableAnnotationComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          Chapter,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (Chapter, $$ChaptersTableReferences),
          Chapter,
          PrefetchHooks Function({bool lessonsRefs})
        > {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> titleArabic = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> descriptionArabic = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> lessonCount = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<bool> isDownloaded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                serverId: serverId,
                title: title,
                titleArabic: titleArabic,
                description: description,
                descriptionArabic: descriptionArabic,
                iconName: iconName,
                colorHex: colorHex,
                sortOrder: sortOrder,
                lessonCount: lessonCount,
                isPremium: isPremium,
                isDownloaded: isDownloaded,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                required String title,
                Value<String?> titleArabic = const Value.absent(),
                required String description,
                Value<String?> descriptionArabic = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> lessonCount = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<bool> isDownloaded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ChaptersCompanion.insert(
                id: id,
                serverId: serverId,
                title: title,
                titleArabic: titleArabic,
                description: description,
                descriptionArabic: descriptionArabic,
                iconName: iconName,
                colorHex: colorHex,
                sortOrder: sortOrder,
                lessonCount: lessonCount,
                isPremium: isPremium,
                isDownloaded: isDownloaded,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChaptersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lessonsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (lessonsRefs) db.lessons],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (lessonsRefs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable, Lesson>(
                      currentTable: table,
                      referencedTable: $$ChaptersTableReferences
                          ._lessonsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ChaptersTableReferences(db, table, p0).lessonsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.chapterId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChaptersTable,
      Chapter,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (Chapter, $$ChaptersTableReferences),
      Chapter,
      PrefetchHooks Function({bool lessonsRefs})
    >;
typedef $$LessonsTableCreateCompanionBuilder =
    LessonsCompanion Function({
      Value<int> id,
      required String serverId,
      required int chapterId,
      required String title,
      Value<String?> titleArabic,
      Value<String?> subtitle,
      Value<String?> subtitleArabic,
      Value<int> sortOrder,
      Value<int> durationMinutes,
      Value<bool> hasAudio,
      Value<bool> hasQuiz,
      Value<String?> thumbnailUrl,
      Value<String?> audioUrl,
      Value<bool> isPremium,
      Value<bool> isDownloaded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$LessonsTableUpdateCompanionBuilder =
    LessonsCompanion Function({
      Value<int> id,
      Value<String> serverId,
      Value<int> chapterId,
      Value<String> title,
      Value<String?> titleArabic,
      Value<String?> subtitle,
      Value<String?> subtitleArabic,
      Value<int> sortOrder,
      Value<int> durationMinutes,
      Value<bool> hasAudio,
      Value<bool> hasQuiz,
      Value<String?> thumbnailUrl,
      Value<String?> audioUrl,
      Value<bool> isPremium,
      Value<bool> isDownloaded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$LessonsTableReferences
    extends BaseReferences<_$AppDatabase, $LessonsTable, Lesson> {
  $$LessonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) => db.chapters
      .createAlias($_aliasNameGenerator(db.lessons.chapterId, db.chapters.id));

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<int>('chapter_id')!;

    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LessonContentTable, List<LessonContentData>>
  _lessonContentRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lessonContent,
    aliasName: $_aliasNameGenerator(db.lessons.id, db.lessonContent.lessonId),
  );

  $$LessonContentTableProcessedTableManager get lessonContentRefs {
    final manager = $$LessonContentTableTableManager(
      $_db,
      $_db.lessonContent,
    ).filter((f) => f.lessonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lessonContentRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuizQuestionsTable, List<QuizQuestion>>
  _quizQuestionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quizQuestions,
    aliasName: $_aliasNameGenerator(db.lessons.id, db.quizQuestions.lessonId),
  );

  $$QuizQuestionsTableProcessedTableManager get quizQuestionsRefs {
    final manager = $$QuizQuestionsTableTableManager(
      $_db,
      $_db.quizQuestions,
    ).filter((f) => f.lessonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_quizQuestionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BookmarksTable, List<Bookmark>>
  _bookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookmarks,
    aliasName: $_aliasNameGenerator(db.lessons.id, db.bookmarks.lessonId),
  );

  $$BookmarksTableProcessedTableManager get bookmarksRefs {
    final manager = $$BookmarksTableTableManager(
      $_db,
      $_db.bookmarks,
    ).filter((f) => f.lessonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookmarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LessonProgressTable, List<LessonProgressData>>
  _lessonProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lessonProgress,
    aliasName: $_aliasNameGenerator(db.lessons.id, db.lessonProgress.lessonId),
  );

  $$LessonProgressTableProcessedTableManager get lessonProgressRefs {
    final manager = $$LessonProgressTableTableManager(
      $_db,
      $_db.lessonProgress,
    ).filter((f) => f.lessonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lessonProgressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LessonsTableFilterComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitleArabic => $composableBuilder(
    column: $table.subtitleArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasAudio => $composableBuilder(
    column: $table.hasAudio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasQuiz => $composableBuilder(
    column: $table.hasQuiz,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
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

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> lessonContentRefs(
    Expression<bool> Function($$LessonContentTableFilterComposer f) f,
  ) {
    final $$LessonContentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessonContent,
      getReferencedColumn: (t) => t.lessonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonContentTableFilterComposer(
            $db: $db,
            $table: $db.lessonContent,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> quizQuestionsRefs(
    Expression<bool> Function($$QuizQuestionsTableFilterComposer f) f,
  ) {
    final $$QuizQuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizQuestions,
      getReferencedColumn: (t) => t.lessonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizQuestionsTableFilterComposer(
            $db: $db,
            $table: $db.quizQuestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bookmarksRefs(
    Expression<bool> Function($$BookmarksTableFilterComposer f) f,
  ) {
    final $$BookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.lessonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableFilterComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> lessonProgressRefs(
    Expression<bool> Function($$LessonProgressTableFilterComposer f) f,
  ) {
    final $$LessonProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessonProgress,
      getReferencedColumn: (t) => t.lessonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonProgressTableFilterComposer(
            $db: $db,
            $table: $db.lessonProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LessonsTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitleArabic => $composableBuilder(
    column: $table.subtitleArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasAudio => $composableBuilder(
    column: $table.hasAudio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasQuiz => $composableBuilder(
    column: $table.hasQuiz,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
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

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get titleArabic => $composableBuilder(
    column: $table.titleArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get subtitleArabic => $composableBuilder(
    column: $table.subtitleArabic,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasAudio =>
      $composableBuilder(column: $table.hasAudio, builder: (column) => column);

  GeneratedColumn<bool> get hasQuiz =>
      $composableBuilder(column: $table.hasQuiz, builder: (column) => column);

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);

  GeneratedColumn<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> lessonContentRefs<T extends Object>(
    Expression<T> Function($$LessonContentTableAnnotationComposer a) f,
  ) {
    final $$LessonContentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessonContent,
      getReferencedColumn: (t) => t.lessonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonContentTableAnnotationComposer(
            $db: $db,
            $table: $db.lessonContent,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> quizQuestionsRefs<T extends Object>(
    Expression<T> Function($$QuizQuestionsTableAnnotationComposer a) f,
  ) {
    final $$QuizQuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizQuestions,
      getReferencedColumn: (t) => t.lessonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizQuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.quizQuestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bookmarksRefs<T extends Object>(
    Expression<T> Function($$BookmarksTableAnnotationComposer a) f,
  ) {
    final $$BookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.lessonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> lessonProgressRefs<T extends Object>(
    Expression<T> Function($$LessonProgressTableAnnotationComposer a) f,
  ) {
    final $$LessonProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessonProgress,
      getReferencedColumn: (t) => t.lessonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.lessonProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LessonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LessonsTable,
          Lesson,
          $$LessonsTableFilterComposer,
          $$LessonsTableOrderingComposer,
          $$LessonsTableAnnotationComposer,
          $$LessonsTableCreateCompanionBuilder,
          $$LessonsTableUpdateCompanionBuilder,
          (Lesson, $$LessonsTableReferences),
          Lesson,
          PrefetchHooks Function({
            bool chapterId,
            bool lessonContentRefs,
            bool quizQuestionsRefs,
            bool bookmarksRefs,
            bool lessonProgressRefs,
          })
        > {
  $$LessonsTableTableManager(_$AppDatabase db, $LessonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> serverId = const Value.absent(),
                Value<int> chapterId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> titleArabic = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String?> subtitleArabic = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<bool> hasAudio = const Value.absent(),
                Value<bool> hasQuiz = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<String?> audioUrl = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<bool> isDownloaded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LessonsCompanion(
                id: id,
                serverId: serverId,
                chapterId: chapterId,
                title: title,
                titleArabic: titleArabic,
                subtitle: subtitle,
                subtitleArabic: subtitleArabic,
                sortOrder: sortOrder,
                durationMinutes: durationMinutes,
                hasAudio: hasAudio,
                hasQuiz: hasQuiz,
                thumbnailUrl: thumbnailUrl,
                audioUrl: audioUrl,
                isPremium: isPremium,
                isDownloaded: isDownloaded,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String serverId,
                required int chapterId,
                required String title,
                Value<String?> titleArabic = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String?> subtitleArabic = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<bool> hasAudio = const Value.absent(),
                Value<bool> hasQuiz = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<String?> audioUrl = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<bool> isDownloaded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LessonsCompanion.insert(
                id: id,
                serverId: serverId,
                chapterId: chapterId,
                title: title,
                titleArabic: titleArabic,
                subtitle: subtitle,
                subtitleArabic: subtitleArabic,
                sortOrder: sortOrder,
                durationMinutes: durationMinutes,
                hasAudio: hasAudio,
                hasQuiz: hasQuiz,
                thumbnailUrl: thumbnailUrl,
                audioUrl: audioUrl,
                isPremium: isPremium,
                isDownloaded: isDownloaded,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LessonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                chapterId = false,
                lessonContentRefs = false,
                quizQuestionsRefs = false,
                bookmarksRefs = false,
                lessonProgressRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (lessonContentRefs) db.lessonContent,
                    if (quizQuestionsRefs) db.quizQuestions,
                    if (bookmarksRefs) db.bookmarks,
                    if (lessonProgressRefs) db.lessonProgress,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (chapterId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.chapterId,
                                    referencedTable: $$LessonsTableReferences
                                        ._chapterIdTable(db),
                                    referencedColumn: $$LessonsTableReferences
                                        ._chapterIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (lessonContentRefs)
                        await $_getPrefetchedData<
                          Lesson,
                          $LessonsTable,
                          LessonContentData
                        >(
                          currentTable: table,
                          referencedTable: $$LessonsTableReferences
                              ._lessonContentRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LessonsTableReferences(
                                db,
                                table,
                                p0,
                              ).lessonContentRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lessonId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (quizQuestionsRefs)
                        await $_getPrefetchedData<
                          Lesson,
                          $LessonsTable,
                          QuizQuestion
                        >(
                          currentTable: table,
                          referencedTable: $$LessonsTableReferences
                              ._quizQuestionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LessonsTableReferences(
                                db,
                                table,
                                p0,
                              ).quizQuestionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lessonId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bookmarksRefs)
                        await $_getPrefetchedData<
                          Lesson,
                          $LessonsTable,
                          Bookmark
                        >(
                          currentTable: table,
                          referencedTable: $$LessonsTableReferences
                              ._bookmarksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LessonsTableReferences(
                                db,
                                table,
                                p0,
                              ).bookmarksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lessonId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (lessonProgressRefs)
                        await $_getPrefetchedData<
                          Lesson,
                          $LessonsTable,
                          LessonProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$LessonsTableReferences
                              ._lessonProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LessonsTableReferences(
                                db,
                                table,
                                p0,
                              ).lessonProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lessonId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LessonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LessonsTable,
      Lesson,
      $$LessonsTableFilterComposer,
      $$LessonsTableOrderingComposer,
      $$LessonsTableAnnotationComposer,
      $$LessonsTableCreateCompanionBuilder,
      $$LessonsTableUpdateCompanionBuilder,
      (Lesson, $$LessonsTableReferences),
      Lesson,
      PrefetchHooks Function({
        bool chapterId,
        bool lessonContentRefs,
        bool quizQuestionsRefs,
        bool bookmarksRefs,
        bool lessonProgressRefs,
      })
    >;
typedef $$LessonContentTableCreateCompanionBuilder =
    LessonContentCompanion Function({
      Value<int> id,
      required int lessonId,
      required int pageNumber,
      required String contentText,
      Value<String?> contentTextArabic,
      Value<String?> translation,
      Value<String?> imageUrl,
      Value<String?> imageDescription,
      Value<String?> audioTimestamp,
      Value<DateTime> createdAt,
    });
typedef $$LessonContentTableUpdateCompanionBuilder =
    LessonContentCompanion Function({
      Value<int> id,
      Value<int> lessonId,
      Value<int> pageNumber,
      Value<String> contentText,
      Value<String?> contentTextArabic,
      Value<String?> translation,
      Value<String?> imageUrl,
      Value<String?> imageDescription,
      Value<String?> audioTimestamp,
      Value<DateTime> createdAt,
    });

final class $$LessonContentTableReferences
    extends
        BaseReferences<_$AppDatabase, $LessonContentTable, LessonContentData> {
  $$LessonContentTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LessonsTable _lessonIdTable(_$AppDatabase db) =>
      db.lessons.createAlias(
        $_aliasNameGenerator(db.lessonContent.lessonId, db.lessons.id),
      );

  $$LessonsTableProcessedTableManager get lessonId {
    final $_column = $_itemColumn<int>('lesson_id')!;

    final manager = $$LessonsTableTableManager(
      $_db,
      $_db.lessons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lessonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LessonContentTableFilterComposer
    extends Composer<_$AppDatabase, $LessonContentTable> {
  $$LessonContentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentText => $composableBuilder(
    column: $table.contentText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentTextArabic => $composableBuilder(
    column: $table.contentTextArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageDescription => $composableBuilder(
    column: $table.imageDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioTimestamp => $composableBuilder(
    column: $table.audioTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LessonsTableFilterComposer get lessonId {
    final $$LessonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableFilterComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonContentTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonContentTable> {
  $$LessonContentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentText => $composableBuilder(
    column: $table.contentText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentTextArabic => $composableBuilder(
    column: $table.contentTextArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageDescription => $composableBuilder(
    column: $table.imageDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioTimestamp => $composableBuilder(
    column: $table.audioTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LessonsTableOrderingComposer get lessonId {
    final $$LessonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableOrderingComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonContentTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonContentTable> {
  $$LessonContentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageNumber => $composableBuilder(
    column: $table.pageNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentText => $composableBuilder(
    column: $table.contentText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentTextArabic => $composableBuilder(
    column: $table.contentTextArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageDescription => $composableBuilder(
    column: $table.imageDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioTimestamp => $composableBuilder(
    column: $table.audioTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LessonsTableAnnotationComposer get lessonId {
    final $$LessonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableAnnotationComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonContentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LessonContentTable,
          LessonContentData,
          $$LessonContentTableFilterComposer,
          $$LessonContentTableOrderingComposer,
          $$LessonContentTableAnnotationComposer,
          $$LessonContentTableCreateCompanionBuilder,
          $$LessonContentTableUpdateCompanionBuilder,
          (LessonContentData, $$LessonContentTableReferences),
          LessonContentData,
          PrefetchHooks Function({bool lessonId})
        > {
  $$LessonContentTableTableManager(_$AppDatabase db, $LessonContentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonContentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonContentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonContentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lessonId = const Value.absent(),
                Value<int> pageNumber = const Value.absent(),
                Value<String> contentText = const Value.absent(),
                Value<String?> contentTextArabic = const Value.absent(),
                Value<String?> translation = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageDescription = const Value.absent(),
                Value<String?> audioTimestamp = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LessonContentCompanion(
                id: id,
                lessonId: lessonId,
                pageNumber: pageNumber,
                contentText: contentText,
                contentTextArabic: contentTextArabic,
                translation: translation,
                imageUrl: imageUrl,
                imageDescription: imageDescription,
                audioTimestamp: audioTimestamp,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int lessonId,
                required int pageNumber,
                required String contentText,
                Value<String?> contentTextArabic = const Value.absent(),
                Value<String?> translation = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageDescription = const Value.absent(),
                Value<String?> audioTimestamp = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LessonContentCompanion.insert(
                id: id,
                lessonId: lessonId,
                pageNumber: pageNumber,
                contentText: contentText,
                contentTextArabic: contentTextArabic,
                translation: translation,
                imageUrl: imageUrl,
                imageDescription: imageDescription,
                audioTimestamp: audioTimestamp,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LessonContentTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lessonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lessonId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lessonId,
                                referencedTable: $$LessonContentTableReferences
                                    ._lessonIdTable(db),
                                referencedColumn: $$LessonContentTableReferences
                                    ._lessonIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LessonContentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LessonContentTable,
      LessonContentData,
      $$LessonContentTableFilterComposer,
      $$LessonContentTableOrderingComposer,
      $$LessonContentTableAnnotationComposer,
      $$LessonContentTableCreateCompanionBuilder,
      $$LessonContentTableUpdateCompanionBuilder,
      (LessonContentData, $$LessonContentTableReferences),
      LessonContentData,
      PrefetchHooks Function({bool lessonId})
    >;
typedef $$QuizQuestionsTableCreateCompanionBuilder =
    QuizQuestionsCompanion Function({
      Value<int> id,
      required int lessonId,
      required String question,
      Value<String?> questionArabic,
      required String options,
      Value<String?> optionsArabic,
      required int correctIndex,
      Value<String?> explanation,
      Value<String?> explanationArabic,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$QuizQuestionsTableUpdateCompanionBuilder =
    QuizQuestionsCompanion Function({
      Value<int> id,
      Value<int> lessonId,
      Value<String> question,
      Value<String?> questionArabic,
      Value<String> options,
      Value<String?> optionsArabic,
      Value<int> correctIndex,
      Value<String?> explanation,
      Value<String?> explanationArabic,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

final class $$QuizQuestionsTableReferences
    extends BaseReferences<_$AppDatabase, $QuizQuestionsTable, QuizQuestion> {
  $$QuizQuestionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LessonsTable _lessonIdTable(_$AppDatabase db) =>
      db.lessons.createAlias(
        $_aliasNameGenerator(db.quizQuestions.lessonId, db.lessons.id),
      );

  $$LessonsTableProcessedTableManager get lessonId {
    final $_column = $_itemColumn<int>('lesson_id')!;

    final manager = $$LessonsTableTableManager(
      $_db,
      $_db.lessons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lessonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuizQuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionArabic => $composableBuilder(
    column: $table.questionArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get options => $composableBuilder(
    column: $table.options,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionsArabic => $composableBuilder(
    column: $table.optionsArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctIndex => $composableBuilder(
    column: $table.correctIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanationArabic => $composableBuilder(
    column: $table.explanationArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LessonsTableFilterComposer get lessonId {
    final $$LessonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableFilterComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizQuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionArabic => $composableBuilder(
    column: $table.questionArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get options => $composableBuilder(
    column: $table.options,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionsArabic => $composableBuilder(
    column: $table.optionsArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctIndex => $composableBuilder(
    column: $table.correctIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanationArabic => $composableBuilder(
    column: $table.explanationArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LessonsTableOrderingComposer get lessonId {
    final $$LessonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableOrderingComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizQuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get questionArabic => $composableBuilder(
    column: $table.questionArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get options =>
      $composableBuilder(column: $table.options, builder: (column) => column);

  GeneratedColumn<String> get optionsArabic => $composableBuilder(
    column: $table.optionsArabic,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctIndex => $composableBuilder(
    column: $table.correctIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get explanationArabic => $composableBuilder(
    column: $table.explanationArabic,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LessonsTableAnnotationComposer get lessonId {
    final $$LessonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableAnnotationComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizQuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizQuestionsTable,
          QuizQuestion,
          $$QuizQuestionsTableFilterComposer,
          $$QuizQuestionsTableOrderingComposer,
          $$QuizQuestionsTableAnnotationComposer,
          $$QuizQuestionsTableCreateCompanionBuilder,
          $$QuizQuestionsTableUpdateCompanionBuilder,
          (QuizQuestion, $$QuizQuestionsTableReferences),
          QuizQuestion,
          PrefetchHooks Function({bool lessonId})
        > {
  $$QuizQuestionsTableTableManager(_$AppDatabase db, $QuizQuestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizQuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizQuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizQuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lessonId = const Value.absent(),
                Value<String> question = const Value.absent(),
                Value<String?> questionArabic = const Value.absent(),
                Value<String> options = const Value.absent(),
                Value<String?> optionsArabic = const Value.absent(),
                Value<int> correctIndex = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<String?> explanationArabic = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QuizQuestionsCompanion(
                id: id,
                lessonId: lessonId,
                question: question,
                questionArabic: questionArabic,
                options: options,
                optionsArabic: optionsArabic,
                correctIndex: correctIndex,
                explanation: explanation,
                explanationArabic: explanationArabic,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int lessonId,
                required String question,
                Value<String?> questionArabic = const Value.absent(),
                required String options,
                Value<String?> optionsArabic = const Value.absent(),
                required int correctIndex,
                Value<String?> explanation = const Value.absent(),
                Value<String?> explanationArabic = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QuizQuestionsCompanion.insert(
                id: id,
                lessonId: lessonId,
                question: question,
                questionArabic: questionArabic,
                options: options,
                optionsArabic: optionsArabic,
                correctIndex: correctIndex,
                explanation: explanation,
                explanationArabic: explanationArabic,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuizQuestionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lessonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lessonId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lessonId,
                                referencedTable: $$QuizQuestionsTableReferences
                                    ._lessonIdTable(db),
                                referencedColumn: $$QuizQuestionsTableReferences
                                    ._lessonIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuizQuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizQuestionsTable,
      QuizQuestion,
      $$QuizQuestionsTableFilterComposer,
      $$QuizQuestionsTableOrderingComposer,
      $$QuizQuestionsTableAnnotationComposer,
      $$QuizQuestionsTableCreateCompanionBuilder,
      $$QuizQuestionsTableUpdateCompanionBuilder,
      (QuizQuestion, $$QuizQuestionsTableReferences),
      QuizQuestion,
      PrefetchHooks Function({bool lessonId})
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      required int lessonId,
      Value<String?> note,
      Value<DateTime> createdAt,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      Value<int> lessonId,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

final class $$BookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark> {
  $$BookmarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LessonsTable _lessonIdTable(_$AppDatabase db) => db.lessons
      .createAlias($_aliasNameGenerator(db.bookmarks.lessonId, db.lessons.id));

  $$LessonsTableProcessedTableManager get lessonId {
    final $_column = $_itemColumn<int>('lesson_id')!;

    final manager = $$LessonsTableTableManager(
      $_db,
      $_db.lessons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lessonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LessonsTableFilterComposer get lessonId {
    final $$LessonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableFilterComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LessonsTableOrderingComposer get lessonId {
    final $$LessonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableOrderingComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LessonsTableAnnotationComposer get lessonId {
    final $$LessonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableAnnotationComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, $$BookmarksTableReferences),
          Bookmark,
          PrefetchHooks Function({bool lessonId})
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lessonId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                lessonId: lessonId,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int lessonId,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion.insert(
                id: id,
                lessonId: lessonId,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookmarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lessonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lessonId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lessonId,
                                referencedTable: $$BookmarksTableReferences
                                    ._lessonIdTable(db),
                                referencedColumn: $$BookmarksTableReferences
                                    ._lessonIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, $$BookmarksTableReferences),
      Bookmark,
      PrefetchHooks Function({bool lessonId})
    >;
typedef $$UserProgressTableCreateCompanionBuilder =
    UserProgressCompanion Function({
      Value<int> id,
      Value<int> totalLessonsCompleted,
      Value<int> totalQuizzesPassed,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<int> totalTimeMinutes,
      Value<DateTime?> lastActivityDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserProgressTableUpdateCompanionBuilder =
    UserProgressCompanion Function({
      Value<int> id,
      Value<int> totalLessonsCompleted,
      Value<int> totalQuizzesPassed,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<int> totalTimeMinutes,
      Value<DateTime?> lastActivityDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UserProgressTableFilterComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLessonsCompleted => $composableBuilder(
    column: $table.totalLessonsCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuizzesPassed => $composableBuilder(
    column: $table.totalQuizzesPassed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTimeMinutes => $composableBuilder(
    column: $table.totalTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActivityDate => $composableBuilder(
    column: $table.lastActivityDate,
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

class $$UserProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLessonsCompleted => $composableBuilder(
    column: $table.totalLessonsCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuizzesPassed => $composableBuilder(
    column: $table.totalQuizzesPassed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTimeMinutes => $composableBuilder(
    column: $table.totalTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActivityDate => $composableBuilder(
    column: $table.lastActivityDate,
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

class $$UserProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalLessonsCompleted => $composableBuilder(
    column: $table.totalLessonsCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuizzesPassed => $composableBuilder(
    column: $table.totalQuizzesPassed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalTimeMinutes => $composableBuilder(
    column: $table.totalTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActivityDate => $composableBuilder(
    column: $table.lastActivityDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProgressTable,
          UserProgressData,
          $$UserProgressTableFilterComposer,
          $$UserProgressTableOrderingComposer,
          $$UserProgressTableAnnotationComposer,
          $$UserProgressTableCreateCompanionBuilder,
          $$UserProgressTableUpdateCompanionBuilder,
          (
            UserProgressData,
            BaseReferences<_$AppDatabase, $UserProgressTable, UserProgressData>,
          ),
          UserProgressData,
          PrefetchHooks Function()
        > {
  $$UserProgressTableTableManager(_$AppDatabase db, $UserProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalLessonsCompleted = const Value.absent(),
                Value<int> totalQuizzesPassed = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> totalTimeMinutes = const Value.absent(),
                Value<DateTime?> lastActivityDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProgressCompanion(
                id: id,
                totalLessonsCompleted: totalLessonsCompleted,
                totalQuizzesPassed: totalQuizzesPassed,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                totalTimeMinutes: totalTimeMinutes,
                lastActivityDate: lastActivityDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalLessonsCompleted = const Value.absent(),
                Value<int> totalQuizzesPassed = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> totalTimeMinutes = const Value.absent(),
                Value<DateTime?> lastActivityDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProgressCompanion.insert(
                id: id,
                totalLessonsCompleted: totalLessonsCompleted,
                totalQuizzesPassed: totalQuizzesPassed,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                totalTimeMinutes: totalTimeMinutes,
                lastActivityDate: lastActivityDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProgressTable,
      UserProgressData,
      $$UserProgressTableFilterComposer,
      $$UserProgressTableOrderingComposer,
      $$UserProgressTableAnnotationComposer,
      $$UserProgressTableCreateCompanionBuilder,
      $$UserProgressTableUpdateCompanionBuilder,
      (
        UserProgressData,
        BaseReferences<_$AppDatabase, $UserProgressTable, UserProgressData>,
      ),
      UserProgressData,
      PrefetchHooks Function()
    >;
typedef $$LessonProgressTableCreateCompanionBuilder =
    LessonProgressCompanion Function({
      Value<int> id,
      required int lessonId,
      Value<bool> isCompleted,
      Value<int> lastPageViewed,
      Value<int?> quizScore,
      Value<int> quizAttempts,
      Value<int> timeSpentMinutes,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> updatedAt,
    });
typedef $$LessonProgressTableUpdateCompanionBuilder =
    LessonProgressCompanion Function({
      Value<int> id,
      Value<int> lessonId,
      Value<bool> isCompleted,
      Value<int> lastPageViewed,
      Value<int?> quizScore,
      Value<int> quizAttempts,
      Value<int> timeSpentMinutes,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> updatedAt,
    });

final class $$LessonProgressTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LessonProgressTable,
          LessonProgressData
        > {
  $$LessonProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LessonsTable _lessonIdTable(_$AppDatabase db) =>
      db.lessons.createAlias(
        $_aliasNameGenerator(db.lessonProgress.lessonId, db.lessons.id),
      );

  $$LessonsTableProcessedTableManager get lessonId {
    final $_column = $_itemColumn<int>('lesson_id')!;

    final manager = $$LessonsTableTableManager(
      $_db,
      $_db.lessons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lessonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LessonProgressTableFilterComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastPageViewed => $composableBuilder(
    column: $table.lastPageViewed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quizScore => $composableBuilder(
    column: $table.quizScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quizAttempts => $composableBuilder(
    column: $table.quizAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeSpentMinutes => $composableBuilder(
    column: $table.timeSpentMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LessonsTableFilterComposer get lessonId {
    final $$LessonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableFilterComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastPageViewed => $composableBuilder(
    column: $table.lastPageViewed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quizScore => $composableBuilder(
    column: $table.quizScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quizAttempts => $composableBuilder(
    column: $table.quizAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeSpentMinutes => $composableBuilder(
    column: $table.timeSpentMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LessonsTableOrderingComposer get lessonId {
    final $$LessonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableOrderingComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastPageViewed => $composableBuilder(
    column: $table.lastPageViewed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quizScore =>
      $composableBuilder(column: $table.quizScore, builder: (column) => column);

  GeneratedColumn<int> get quizAttempts => $composableBuilder(
    column: $table.quizAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timeSpentMinutes => $composableBuilder(
    column: $table.timeSpentMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LessonsTableAnnotationComposer get lessonId {
    final $$LessonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lessonId,
      referencedTable: $db.lessons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonsTableAnnotationComposer(
            $db: $db,
            $table: $db.lessons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LessonProgressTable,
          LessonProgressData,
          $$LessonProgressTableFilterComposer,
          $$LessonProgressTableOrderingComposer,
          $$LessonProgressTableAnnotationComposer,
          $$LessonProgressTableCreateCompanionBuilder,
          $$LessonProgressTableUpdateCompanionBuilder,
          (LessonProgressData, $$LessonProgressTableReferences),
          LessonProgressData,
          PrefetchHooks Function({bool lessonId})
        > {
  $$LessonProgressTableTableManager(
    _$AppDatabase db,
    $LessonProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lessonId = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> lastPageViewed = const Value.absent(),
                Value<int?> quizScore = const Value.absent(),
                Value<int> quizAttempts = const Value.absent(),
                Value<int> timeSpentMinutes = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LessonProgressCompanion(
                id: id,
                lessonId: lessonId,
                isCompleted: isCompleted,
                lastPageViewed: lastPageViewed,
                quizScore: quizScore,
                quizAttempts: quizAttempts,
                timeSpentMinutes: timeSpentMinutes,
                startedAt: startedAt,
                completedAt: completedAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int lessonId,
                Value<bool> isCompleted = const Value.absent(),
                Value<int> lastPageViewed = const Value.absent(),
                Value<int?> quizScore = const Value.absent(),
                Value<int> quizAttempts = const Value.absent(),
                Value<int> timeSpentMinutes = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LessonProgressCompanion.insert(
                id: id,
                lessonId: lessonId,
                isCompleted: isCompleted,
                lastPageViewed: lastPageViewed,
                quizScore: quizScore,
                quizAttempts: quizAttempts,
                timeSpentMinutes: timeSpentMinutes,
                startedAt: startedAt,
                completedAt: completedAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LessonProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lessonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lessonId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lessonId,
                                referencedTable: $$LessonProgressTableReferences
                                    ._lessonIdTable(db),
                                referencedColumn:
                                    $$LessonProgressTableReferences
                                        ._lessonIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LessonProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LessonProgressTable,
      LessonProgressData,
      $$LessonProgressTableFilterComposer,
      $$LessonProgressTableOrderingComposer,
      $$LessonProgressTableAnnotationComposer,
      $$LessonProgressTableCreateCompanionBuilder,
      $$LessonProgressTableUpdateCompanionBuilder,
      (LessonProgressData, $$LessonProgressTableReferences),
      LessonProgressData,
      PrefetchHooks Function({bool lessonId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      required String key,
      required String value,
      Value<DateTime> updatedAt,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                key: key,
                value: value,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String value,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                key: key,
                value: value,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChaptersTableTableManager get chapters =>
      $$ChaptersTableTableManager(_db, _db.chapters);
  $$LessonsTableTableManager get lessons =>
      $$LessonsTableTableManager(_db, _db.lessons);
  $$LessonContentTableTableManager get lessonContent =>
      $$LessonContentTableTableManager(_db, _db.lessonContent);
  $$QuizQuestionsTableTableManager get quizQuestions =>
      $$QuizQuestionsTableTableManager(_db, _db.quizQuestions);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$UserProgressTableTableManager get userProgress =>
      $$UserProgressTableTableManager(_db, _db.userProgress);
  $$LessonProgressTableTableManager get lessonProgress =>
      $$LessonProgressTableTableManager(_db, _db.lessonProgress);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
