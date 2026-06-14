String fireStoreChatServiceTemplate(String projectName) => '''
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

final fireStoreChatService = FireStoreChatService();

class FireStoreChatService {
  final _fireStore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _chats =>
      _firestore.collection('chats');

  DocumentReference<Map<String, dynamic>> _chat(String id) =>
      _chats.doc(id);

  CollectionReference<Map<String, dynamic>> _messages(String chatId) =>
      _chat(chatId).collection('messages');

  Future<Chat?> getChat(String id) async {
    final snapshot = await _chat(id).get();
    if (!snapshot.exists) return null;
    return Chat.fromJson(snapshot.data()!);
  }

  Stream<Chat?> streamChat(String id) {
    return _chat(id).snapshots().map(
      (snapshot) => snapshot.exists
          ? Chat.fromJson(snapshot.data()!)
          : null,
    );
  }

  Future<List<Chat>> getChatsForUser(String userId) async {
    final snapshot = await _chats
        .where('users', arrayContains: {'id': userId})
        .get();
    return snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList();
  }

  Stream<List<Chat>> streamChatsForUser(String userId) {
    return _chats
        .where('users', arrayContains: {'id': userId})
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList());
  }

  Future<String> createChat(CreateChatDto dto) async {
    final doc = await _chats.add(dto.toJson());
    return doc.id;
  }

  Future<void> updateChat(String id, UpdateChatDto dto) async {
    await _chat(id).update(dto.toJson());
  }

  Future<void> deleteChat(String id) async {
    await _chat(id).delete();
  }

  Stream<List<Message>> streamMessages(String chatId) {
    return _messages(chatId)
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList());
  }

  Future<List<Message>> getMessages(String chatId) async {
    final snapshot = await _messages(chatId)
        .orderBy('dateCreated', descending: true)
        .get();
    return snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
  }

  Future<String> createMessage(String chatId, CreateMessageDto dto) async {
    final doc = await _messages(chatId).add(dto.toJson());
    return doc.id;
  }

  Future<void> updateMessage(
    String chatId,
    String messageId,
    UpdateMessageDto dto,
  ) async {
    await _messages(chatId).doc(messageId).update(dto.toJson());
  }

  Future<void> deleteMessage(String chatId, String messageId) async {
    await _messages(chatId).doc(messageId).delete();
  }
}
''';
