import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'photo_record.g.dart';

abstract class PhotoRecord implements Built<PhotoRecord, PhotoRecordBuilder> {
  static Serializer<PhotoRecord> get serializer => _$photoRecordSerializer;

  @nullable
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  String get photos;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PhotoRecordBuilder builder) =>
      builder..photos = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('photo');

  static Stream<PhotoRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<PhotoRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PhotoRecord._();
  factory PhotoRecord([void Function(PhotoRecordBuilder) updates]) =
      _$PhotoRecord;

  static PhotoRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPhotoRecordData({
  DocumentReference user,
  DateTime createdAt,
  String photos,
}) =>
    serializers.toFirestore(
        PhotoRecord.serializer,
        PhotoRecord((p) => p
          ..user = user
          ..createdAt = createdAt
          ..photos = photos));
