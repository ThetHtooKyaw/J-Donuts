// dart format width=80
// ignore_for_file: type=lint
part of 'drift_database.dart';

class $MemberTableTable extends MemberTable
    with TableInfo<$MemberTableTable, MemberTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemberTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsToNextTierMeta = const VerificationMeta(
    'pointsToNextTier',
  );
  @override
  late final GeneratedColumn<int> pointsToNextTier = GeneratedColumn<int>(
    'points_to_next_tier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationCountMeta = const VerificationMeta(
    'notificationCount',
  );
  @override
  late final GeneratedColumn<int> notificationCount = GeneratedColumn<int>(
    'notification_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    tier,
    pointsToNextTier,
    totalPoints,
    avatarUrl,
    notificationCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'member_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('points_to_next_tier')) {
      context.handle(
        _pointsToNextTierMeta,
        pointsToNextTier.isAcceptableOrUnknown(
          data['points_to_next_tier']!,
          _pointsToNextTierMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pointsToNextTierMeta);
    }
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPointsMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_avatarUrlMeta);
    }
    if (data.containsKey('notification_count')) {
      context.handle(
        _notificationCountMeta,
        notificationCount.isAcceptableOrUnknown(
          data['notification_count']!,
          _notificationCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemberTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      pointsToNextTier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_to_next_tier'],
      )!,
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      )!,
      notificationCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_count'],
      )!,
    );
  }

  @override
  $MemberTableTable createAlias(String alias) {
    return $MemberTableTable(attachedDatabase, alias);
  }
}

class MemberTableData extends DataClass implements Insertable<MemberTableData> {
  final String id;
  final String name;
  final String tier;
  final int pointsToNextTier;
  final int totalPoints;
  final String avatarUrl;
  final int notificationCount;
  const MemberTableData({
    required this.id,
    required this.name,
    required this.tier,
    required this.pointsToNextTier,
    required this.totalPoints,
    required this.avatarUrl,
    required this.notificationCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['tier'] = Variable<String>(tier);
    map['points_to_next_tier'] = Variable<int>(pointsToNextTier);
    map['total_points'] = Variable<int>(totalPoints);
    map['avatar_url'] = Variable<String>(avatarUrl);
    map['notification_count'] = Variable<int>(notificationCount);
    return map;
  }

  MemberTableCompanion toCompanion(bool nullToAbsent) {
    return MemberTableCompanion(
      id: Value(id),
      name: Value(name),
      tier: Value(tier),
      pointsToNextTier: Value(pointsToNextTier),
      totalPoints: Value(totalPoints),
      avatarUrl: Value(avatarUrl),
      notificationCount: Value(notificationCount),
    );
  }

  factory MemberTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      tier: serializer.fromJson<String>(json['tier']),
      pointsToNextTier: serializer.fromJson<int>(json['pointsToNextTier']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
      avatarUrl: serializer.fromJson<String>(json['avatarUrl']),
      notificationCount: serializer.fromJson<int>(json['notificationCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'tier': serializer.toJson<String>(tier),
      'pointsToNextTier': serializer.toJson<int>(pointsToNextTier),
      'totalPoints': serializer.toJson<int>(totalPoints),
      'avatarUrl': serializer.toJson<String>(avatarUrl),
      'notificationCount': serializer.toJson<int>(notificationCount),
    };
  }

  MemberTableData copyWith({
    String? id,
    String? name,
    String? tier,
    int? pointsToNextTier,
    int? totalPoints,
    String? avatarUrl,
    int? notificationCount,
  }) => MemberTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    tier: tier ?? this.tier,
    pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
    totalPoints: totalPoints ?? this.totalPoints,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    notificationCount: notificationCount ?? this.notificationCount,
  );
  MemberTableData copyWithCompanion(MemberTableCompanion data) {
    return MemberTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      tier: data.tier.present ? data.tier.value : this.tier,
      pointsToNextTier: data.pointsToNextTier.present
          ? data.pointsToNextTier.value
          : this.pointsToNextTier,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      notificationCount: data.notificationCount.present
          ? data.notificationCount.value
          : this.notificationCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tier: $tier, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('notificationCount: $notificationCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    tier,
    pointsToNextTier,
    totalPoints,
    avatarUrl,
    notificationCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.tier == this.tier &&
          other.pointsToNextTier == this.pointsToNextTier &&
          other.totalPoints == this.totalPoints &&
          other.avatarUrl == this.avatarUrl &&
          other.notificationCount == this.notificationCount);
}

class MemberTableCompanion extends UpdateCompanion<MemberTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> tier;
  final Value<int> pointsToNextTier;
  final Value<int> totalPoints;
  final Value<String> avatarUrl;
  final Value<int> notificationCount;
  final Value<int> rowid;
  const MemberTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.tier = const Value.absent(),
    this.pointsToNextTier = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.notificationCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MemberTableCompanion.insert({
    required String id,
    required String name,
    required String tier,
    required int pointsToNextTier,
    required int totalPoints,
    required String avatarUrl,
    required int notificationCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       tier = Value(tier),
       pointsToNextTier = Value(pointsToNextTier),
       totalPoints = Value(totalPoints),
       avatarUrl = Value(avatarUrl),
       notificationCount = Value(notificationCount);
  static Insertable<MemberTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? tier,
    Expression<int>? pointsToNextTier,
    Expression<int>? totalPoints,
    Expression<String>? avatarUrl,
    Expression<int>? notificationCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (tier != null) 'tier': tier,
      if (pointsToNextTier != null) 'points_to_next_tier': pointsToNextTier,
      if (totalPoints != null) 'total_points': totalPoints,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (notificationCount != null) 'notification_count': notificationCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MemberTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? tier,
    Value<int>? pointsToNextTier,
    Value<int>? totalPoints,
    Value<String>? avatarUrl,
    Value<int>? notificationCount,
    Value<int>? rowid,
  }) {
    return MemberTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      tier: tier ?? this.tier,
      pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
      totalPoints: totalPoints ?? this.totalPoints,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      notificationCount: notificationCount ?? this.notificationCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (pointsToNextTier.present) {
      map['points_to_next_tier'] = Variable<int>(pointsToNextTier.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (notificationCount.present) {
      map['notification_count'] = Variable<int>(notificationCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemberTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tier: $tier, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTableTable extends ProductsTable
    with TableInfo<$ProductsTableTable, ProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMmkMeta = const VerificationMeta(
    'priceMmk',
  );
  @override
  late final GeneratedColumn<int> priceMmk = GeneratedColumn<int>(
    'price_mmk',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<int> discountPercent = GeneratedColumn<int>(
    'discount_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageUrl,
    description,
    category,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_mmk')) {
      context.handle(
        _priceMmkMeta,
        priceMmk.isAcceptableOrUnknown(data['price_mmk']!, _priceMmkMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMmkMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    } else if (isInserting) {
      context.missing(_isNewMeta);
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
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
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceMmk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_mmk'],
      )!,
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_percent'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $ProductsTableTable createAlias(String alias) {
    return $ProductsTableTable(attachedDatabase, alias);
  }
}

class ProductsTableData extends DataClass
    implements Insertable<ProductsTableData> {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final String imageUrl;
  final String description;
  final String category;
  const ProductsTableData({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountPercent,
    required this.imageUrl,
    required this.description,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['price_mmk'] = Variable<int>(priceMmk);
    map['is_new'] = Variable<bool>(isNew);
    if (!nullToAbsent || discountPercent != null) {
      map['discount_percent'] = Variable<int>(discountPercent);
    }
    map['image_url'] = Variable<String>(imageUrl);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    return map;
  }

  ProductsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductsTableCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      priceMmk: Value(priceMmk),
      isNew: Value(isNew),
      discountPercent: discountPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPercent),
      imageUrl: Value(imageUrl),
      description: Value(description),
      category: Value(category),
    );
  }

  factory ProductsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsTableData(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      priceMmk: serializer.fromJson<int>(json['priceMmk']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      discountPercent: serializer.fromJson<int?>(json['discountPercent']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'priceMmk': serializer.toJson<int>(priceMmk),
      'isNew': serializer.toJson<bool>(isNew),
      'discountPercent': serializer.toJson<int?>(discountPercent),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
    };
  }

  ProductsTableData copyWith({
    String? id,
    String? code,
    String? name,
    int? priceMmk,
    bool? isNew,
    Value<int?> discountPercent = const Value.absent(),
    String? imageUrl,
    String? description,
    String? category,
  }) => ProductsTableData(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    priceMmk: priceMmk ?? this.priceMmk,
    isNew: isNew ?? this.isNew,
    discountPercent: discountPercent.present
        ? discountPercent.value
        : this.discountPercent,
    imageUrl: imageUrl ?? this.imageUrl,
    description: description ?? this.description,
    category: category ?? this.category,
  );
  ProductsTableData copyWithCompanion(ProductsTableCompanion data) {
    return ProductsTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      priceMmk: data.priceMmk.present ? data.priceMmk.value : this.priceMmk,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('description: $description, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageUrl,
    description,
    category,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.priceMmk == this.priceMmk &&
          other.isNew == this.isNew &&
          other.discountPercent == this.discountPercent &&
          other.imageUrl == this.imageUrl &&
          other.description == this.description &&
          other.category == this.category);
}

class ProductsTableCompanion extends UpdateCompanion<ProductsTableData> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> priceMmk;
  final Value<bool> isNew;
  final Value<int?> discountPercent;
  final Value<String> imageUrl;
  final Value<String> description;
  final Value<String> category;
  final Value<int> rowid;
  const ProductsTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.priceMmk = const Value.absent(),
    this.isNew = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsTableCompanion.insert({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    required bool isNew,
    this.discountPercent = const Value.absent(),
    required String imageUrl,
    required String description,
    required String category,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       name = Value(name),
       priceMmk = Value(priceMmk),
       isNew = Value(isNew),
       imageUrl = Value(imageUrl),
       description = Value(description),
       category = Value(category);
  static Insertable<ProductsTableData> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? priceMmk,
    Expression<bool>? isNew,
    Expression<int>? discountPercent,
    Expression<String>? imageUrl,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (priceMmk != null) 'price_mmk': priceMmk,
      if (isNew != null) 'is_new': isNew,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (imageUrl != null) 'image_url': imageUrl,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? name,
    Value<int>? priceMmk,
    Value<bool>? isNew,
    Value<int?>? discountPercent,
    Value<String>? imageUrl,
    Value<String>? description,
    Value<String>? category,
    Value<int>? rowid,
  }) {
    return ProductsTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      priceMmk: priceMmk ?? this.priceMmk,
      isNew: isNew ?? this.isNew,
      discountPercent: discountPercent ?? this.discountPercent,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceMmk.present) {
      map['price_mmk'] = Variable<int>(priceMmk.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<int>(discountPercent.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShopsTableTable extends ShopsTable
    with TableInfo<$ShopsTableTable, ShopsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, address, imageUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
    );
  }

  @override
  $ShopsTableTable createAlias(String alias) {
    return $ShopsTableTable(attachedDatabase, alias);
  }
}

class ShopsTableData extends DataClass implements Insertable<ShopsTableData> {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  const ShopsTableData({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  ShopsTableCompanion toCompanion(bool nullToAbsent) {
    return ShopsTableCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      imageUrl: Value(imageUrl),
    );
  }

  factory ShopsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  ShopsTableData copyWith({
    String? id,
    String? name,
    String? address,
    String? imageUrl,
  }) => ShopsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    imageUrl: imageUrl ?? this.imageUrl,
  );
  ShopsTableData copyWithCompanion(ShopsTableCompanion data) {
    return ShopsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.imageUrl == this.imageUrl);
}

class ShopsTableCompanion extends UpdateCompanion<ShopsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> address;
  final Value<String> imageUrl;
  final Value<int> rowid;
  const ShopsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopsTableCompanion.insert({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       address = Value(address),
       imageUrl = Value(imageUrl);
  static Insertable<ShopsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? imageUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (imageUrl != null) 'image_url': imageUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? address,
    Value<String>? imageUrl,
    Value<int>? rowid,
  }) {
    return ShopsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MemberTableTable memberTable = $MemberTableTable(this);
  late final $ProductsTableTable productsTable = $ProductsTableTable(this);
  late final $ShopsTableTable shopsTable = $ShopsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    memberTable,
    productsTable,
    shopsTable,
  ];
}

typedef $$MemberTableTableCreateCompanionBuilder =
    MemberTableCompanion Function({
      required String id,
      required String name,
      required String tier,
      required int pointsToNextTier,
      required int totalPoints,
      required String avatarUrl,
      required int notificationCount,
      Value<int> rowid,
    });
typedef $$MemberTableTableUpdateCompanionBuilder =
    MemberTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> tier,
      Value<int> pointsToNextTier,
      Value<int> totalPoints,
      Value<String> avatarUrl,
      Value<int> notificationCount,
      Value<int> rowid,
    });

class $$MemberTableTableFilterComposer
    extends Composer<_$AppDatabase, $MemberTableTable> {
  $$MemberTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MemberTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MemberTableTable> {
  $$MemberTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MemberTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemberTableTable> {
  $$MemberTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => column,
  );
}

class $$MemberTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemberTableTable,
          MemberTableData,
          $$MemberTableTableFilterComposer,
          $$MemberTableTableOrderingComposer,
          $$MemberTableTableAnnotationComposer,
          $$MemberTableTableCreateCompanionBuilder,
          $$MemberTableTableUpdateCompanionBuilder,
          (
            MemberTableData,
            BaseReferences<_$AppDatabase, $MemberTableTable, MemberTableData>,
          ),
          MemberTableData,
          PrefetchHooks Function()
        > {
  $$MemberTableTableTableManager(_$AppDatabase db, $MemberTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemberTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemberTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemberTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<int> pointsToNextTier = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<String> avatarUrl = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemberTableCompanion(
                id: id,
                name: name,
                tier: tier,
                pointsToNextTier: pointsToNextTier,
                totalPoints: totalPoints,
                avatarUrl: avatarUrl,
                notificationCount: notificationCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String tier,
                required int pointsToNextTier,
                required int totalPoints,
                required String avatarUrl,
                required int notificationCount,
                Value<int> rowid = const Value.absent(),
              }) => MemberTableCompanion.insert(
                id: id,
                name: name,
                tier: tier,
                pointsToNextTier: pointsToNextTier,
                totalPoints: totalPoints,
                avatarUrl: avatarUrl,
                notificationCount: notificationCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MemberTableTable, MemberTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MemberTableTable,
                    MemberTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MemberTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemberTableTable,
      MemberTableData,
      $$MemberTableTableFilterComposer,
      $$MemberTableTableOrderingComposer,
      $$MemberTableTableAnnotationComposer,
      $$MemberTableTableCreateCompanionBuilder,
      $$MemberTableTableUpdateCompanionBuilder,
      (
        MemberTableData,
        BaseReferences<_$AppDatabase, $MemberTableTable, MemberTableData>,
      ),
      MemberTableData,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableTableCreateCompanionBuilder =
    ProductsTableCompanion Function({
      required String id,
      required String code,
      required String name,
      required int priceMmk,
      required bool isNew,
      Value<int?> discountPercent,
      required String imageUrl,
      required String description,
      required String category,
      Value<int> rowid,
    });
typedef $$ProductsTableTableUpdateCompanionBuilder =
    ProductsTableCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> name,
      Value<int> priceMmk,
      Value<bool> isNew,
      Value<int?> discountPercent,
      Value<String> imageUrl,
      Value<String> description,
      Value<String> category,
      Value<int> rowid,
    });

class $$ProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceMmk =>
      $composableBuilder(column: $table.priceMmk, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$ProductsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTableTable,
          ProductsTableData,
          $$ProductsTableTableFilterComposer,
          $$ProductsTableTableOrderingComposer,
          $$ProductsTableTableAnnotationComposer,
          $$ProductsTableTableCreateCompanionBuilder,
          $$ProductsTableTableUpdateCompanionBuilder,
          (
            ProductsTableData,
            BaseReferences<
              _$AppDatabase,
              $ProductsTableTable,
              ProductsTableData
            >,
          ),
          ProductsTableData,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableTableManager(_$AppDatabase db, $ProductsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceMmk = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<int?> discountPercent = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsTableCompanion(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageUrl: imageUrl,
                description: description,
                category: category,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String name,
                required int priceMmk,
                required bool isNew,
                Value<int?> discountPercent = const Value.absent(),
                required String imageUrl,
                required String description,
                required String category,
                Value<int> rowid = const Value.absent(),
              }) => ProductsTableCompanion.insert(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageUrl: imageUrl,
                description: description,
                category: category,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTableTable, ProductsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ProductsTableTable,
                    ProductsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTableTable,
      ProductsTableData,
      $$ProductsTableTableFilterComposer,
      $$ProductsTableTableOrderingComposer,
      $$ProductsTableTableAnnotationComposer,
      $$ProductsTableTableCreateCompanionBuilder,
      $$ProductsTableTableUpdateCompanionBuilder,
      (
        ProductsTableData,
        BaseReferences<_$AppDatabase, $ProductsTableTable, ProductsTableData>,
      ),
      ProductsTableData,
      PrefetchHooks Function()
    >;
typedef $$ShopsTableTableCreateCompanionBuilder =
    ShopsTableCompanion Function({
      required String id,
      required String name,
      required String address,
      required String imageUrl,
      Value<int> rowid,
    });
typedef $$ShopsTableTableUpdateCompanionBuilder =
    ShopsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> address,
      Value<String> imageUrl,
      Value<int> rowid,
    });

class $$ShopsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$ShopsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopsTableTable,
          ShopsTableData,
          $$ShopsTableTableFilterComposer,
          $$ShopsTableTableOrderingComposer,
          $$ShopsTableTableAnnotationComposer,
          $$ShopsTableTableCreateCompanionBuilder,
          $$ShopsTableTableUpdateCompanionBuilder,
          (
            ShopsTableData,
            BaseReferences<_$AppDatabase, $ShopsTableTable, ShopsTableData>,
          ),
          ShopsTableData,
          PrefetchHooks Function()
        > {
  $$ShopsTableTableTableManager(_$AppDatabase db, $ShopsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsTableCompanion(
                id: id,
                name: name,
                address: address,
                imageUrl: imageUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String address,
                required String imageUrl,
                Value<int> rowid = const Value.absent(),
              }) => ShopsTableCompanion.insert(
                id: id,
                name: name,
                address: address,
                imageUrl: imageUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShopsTableTable, ShopsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ShopsTableTable,
                    ShopsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopsTableTable,
      ShopsTableData,
      $$ShopsTableTableFilterComposer,
      $$ShopsTableTableOrderingComposer,
      $$ShopsTableTableAnnotationComposer,
      $$ShopsTableTableCreateCompanionBuilder,
      $$ShopsTableTableUpdateCompanionBuilder,
      (
        ShopsTableData,
        BaseReferences<_$AppDatabase, $ShopsTableTable, ShopsTableData>,
      ),
      ShopsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MemberTableTableTableManager get memberTable =>
      $$MemberTableTableTableManager(_db, _db.memberTable);
  $$ProductsTableTableTableManager get productsTable =>
      $$ProductsTableTableTableManager(_db, _db.productsTable);
  $$ShopsTableTableTableManager get shopsTable =>
      $$ShopsTableTableTableManager(_db, _db.shopsTable);
}
