import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spareparts_store/features/chat/domain/model/media_file_model.dart';
import 'package:flutter_spareparts_store/features/chat/domain/model/message_body.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/chat/domain/model/chat_model.dart';
import 'package:flutter_spareparts_store/features/chat/domain/model/message_model.dart';
import 'package:flutter_spareparts_store/features/chat/domain/repo/chat_repo.dart';
import 'package:flutter_spareparts_store/features/profile/domain/model/user_info_model.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/helper/image_size_checker.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
//import 'package:get_thumbnail_video/index.dart';
//import 'package:get_thumbnail_video/video_thumbnail.dart';

enum SenderType {
  customer,
  seller,
  admin,
  deliveryMan,
  user,
  unknown
}

class ChatProvider extends ChangeNotifier {
  final ChatRepo? chatRepo;
  ChatProvider({required this.chatRepo});


  bool _isSendButtonActive = false;
  bool get isSendButtonActive => _isSendButtonActive;
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  File? _imageFile;
  File? get imageFile => _imageFile;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isMessageSend = false;
  bool get isMessageSend => _isMessageSend;

  int _userTypeIndex = 0;
  int get userTypeIndex =>  _userTypeIndex;
  ChatModel? chatModel;



  bool sellerChatCall= false;
  bool deliveryChatCall= false;





  Future<void> getChatList(BuildContext context, int offset, {bool reload = true}) async {
    chatModel = null;
    if(reload){
      notifyListeners();
    }

    ApiResponse apiResponse = await chatRepo!.getChatList(_userTypeIndex == 0? 'user' : 'user', offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        chatModel = null;
        chatModel = ChatModel.fromJson(apiResponse.response!.data);
      }else{
        chatModel?.chat?.addAll(ChatModel.fromJson(apiResponse.response!.data).chat!);
        chatModel?.offset  = (ChatModel.fromJson(apiResponse.response!.data).offset!);
        chatModel?.totalSize  = (ChatModel.fromJson(apiResponse.response!.data).totalSize!);
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  Future<void> searchChat(BuildContext context, String search) async {
    _isLoading = true;
    chatModel = null;
    notifyListeners();
    ApiResponse apiResponse = await chatRepo!.searchChat(_userTypeIndex == 0? 'user' : 'user', search);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      chatModel = null;
      chatModel = ChatModel(totalSize: 1, limit: '10', offset: '1', chat: []);
      apiResponse.response!.data.forEach((chat) => chatModel!.chat!.add(Chat.fromJson(chat)));
      chatModel?.chat = chatModel!.chat;

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }



  UserModel? userModel;
  Future<void> getUserList(BuildContext context, int offset, {bool reload = true}) async {
    userModel = null;
    if(reload){
      notifyListeners();
    }

    ApiResponse apiResponse = await chatRepo!.getUserList( offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        userModel = null;
        userModel = UserModel.fromJson(apiResponse.response!.data);
      }else{
        userModel?.user?.addAll(UserModel.fromJson(apiResponse.response!.data).user!);
        userModel?.offset  = (UserModel.fromJson(apiResponse.response!.data).offset!);
        userModel?.totalSize  = (UserModel.fromJson(apiResponse.response!.data).totalSize!);
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  Future<void> searchUser(BuildContext context, String search) async {
    _isLoading = true;
    userModel = null;
    notifyListeners();
    ApiResponse apiResponse = await chatRepo!.searchUser(search);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      userModel = null;
      userModel = UserModel.fromJson(apiResponse.response!.data);

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }


  List<String> dateList = [];
  List<dynamic> messageList=[];
  List<Message> allMessageList=[];
  MessageModel? messageModel;

  Future<void> getMessageList(BuildContext context, int? id, int offset, {bool reload = true}) async {
    if(reload){
      messageModel = null;
      dateList = [];
      messageList = [];
      allMessageList = [];
    }
    _isLoading = true;
    ApiResponse apiResponse = await chatRepo!.getMessageList(_userTypeIndex == 0? 'user' : 'user', id, offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {


      messageModel = null;
      dateList = [];
      messageList = [];
      allMessageList = [];
        messageModel = MessageModel.fromJson(apiResponse.response!.data);
        for (var data in messageModel!.message!) {
          if(!dateList.contains(DateConverter.dateStringMonthYear(DateTime.tryParse(data.createdAt!)))) {
            dateList.add(DateConverter.dateStringMonthYear(DateTime.tryParse(data.createdAt!)));
          }
          allMessageList.add(data);
        }


      for(int i=0;i< dateList.length;i++){
        messageList.add([]);
        for (var element in allMessageList) {
          if(dateList[i]== DateConverter.dateStringMonthYear(DateTime.tryParse(element.createdAt!))){
            messageList[i].add(element);
          }
        }
      }


    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }



  Future<http.StreamedResponse> sendMessage(MessageBody messageBody,{int? userType}) async {
    _isMessageSend = true;
    notifyListeners();

    http.StreamedResponse response = await chatRepo!.sendMessage(messageBody, 'user' ,
        getXFileFromMediaFileModel(pickedMediaStored ?? []) ?? [], pickedFiles ?? []);
        //pickedImageFileStored  ?? [], pickedFiles ?? []);

    if (response.statusCode == 200) {
      getMessageList(Get.context!, messageBody.id, 1, reload: false);
      _pickedImageFiles = [];
      pickedMediaStored = [];
      pickedImageFileStored = [];
    }

    _pickedImageFiles = [];
    pickedMediaStored = [];
    pickedFiles = [];
    pickedImageFileStored = [];
    _isMessageSend = false;

    notifyListeners();
    return response;
  }






  Future<ApiResponse> seenMessage(BuildContext context, int? sellerId, int? deliveryId) async {
    ApiResponse apiResponse = await chatRepo!.seenMessage(_userTypeIndex == 0 ? sellerId! : deliveryId!, _userTypeIndex == 0 ? 'user' : 'user');
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getChatList(Get.context!, 1);
    } else {
      ApiChecker.checkApi( apiResponse);
    }

    notifyListeners();
    return apiResponse;
  }




  void toggleSendButtonActivity() {
    _isSendButtonActive = !_isSendButtonActive;
    notifyListeners();
  }

  void setImage(File image) {
    _imageFile = image;
    _isSendButtonActive = true;
    notifyListeners();
  }

  void removeImage(String text) {
    _imageFile = null;
    text.isEmpty ? _isSendButtonActive = false : _isSendButtonActive = true;
    notifyListeners();
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    notifyListeners();
  }
  void setUserTypeIndex(BuildContext context, int index) {
    _userTypeIndex = index;
    getChatList(context, 1);
    notifyListeners();
  }


  String _onImageOrFileTimeShowID = '';
  String get onImageOrFileTimeShowID => _onImageOrFileTimeShowID;

  bool _isClickedOnImageOrFile = false;
  bool get isClickedOnImageOrFile => _isClickedOnImageOrFile;

  bool _isClickedOnMessage = false;
  bool get isClickedOnMessage => _isClickedOnMessage;

  String _onMessageTimeShowID = '';
  String get onMessageTimeShowID => _onMessageTimeShowID;


  void toggleOnClickMessage ({required String onMessageTimeShowID}) {
    _onImageOrFileTimeShowID = '';
    _isClickedOnImageOrFile = false;
    if(_isClickedOnMessage && _onMessageTimeShowID != onMessageTimeShowID){
      _onMessageTimeShowID = onMessageTimeShowID;
    }else if(_isClickedOnMessage && _onMessageTimeShowID == onMessageTimeShowID){
      _isClickedOnMessage = false;
      _onMessageTimeShowID = '';
    }else{
      _isClickedOnMessage = true;
      _onMessageTimeShowID = onMessageTimeShowID;
    }
    notifyListeners();
  }


  String? getOnPressChatTime(Message currentConversation){
    if(currentConversation.id.toString() == _onMessageTimeShowID || currentConversation.id.toString() == _onImageOrFileTimeShowID){
      DateTime currentDate = DateTime.now();
      DateTime todayConversationDateTime = DateConverter.isoStringToLocalDate(
          currentConversation.createdAt ?? ""
      );

      if(currentDate.weekday != todayConversationDateTime.weekday
          && DateConverter.countDays(todayConversationDateTime) <= 7){
        return DateConverter.convertStringTimeToDateChatting(todayConversationDateTime);
      }else if(currentDate.weekday == todayConversationDateTime.weekday
          && DateConverter.countDays(todayConversationDateTime) <= 7){
        return  DateConverter.convert24HourTimeTo12HourTime(todayConversationDateTime);
      }else{
        return DateConverter.isoStringToLocalDateAndTime(currentConversation.createdAt!);
      }
    }else{
      return null;
    }
  }


  bool _pickedFIleCrossMaxLimit = false;
  bool get pickedFIleCrossMaxLimit => _pickedFIleCrossMaxLimit;

  bool _pickedFIleCrossMaxLength = false;
  bool get pickedFIleCrossMaxLength => _pickedFIleCrossMaxLength;

  bool _singleFIleCrossMaxLimit = false;
  bool get singleFIleCrossMaxLimit => _singleFIleCrossMaxLimit;

  List<PlatformFile>? pickedFiles;

  Future<void> pickOtherFile(bool isRemove, {int? index}) async {
    _pickedFIleCrossMaxLimit = false;
    _pickedFIleCrossMaxLength = false;
    _singleFIleCrossMaxLimit = false;

    List<String> allowedFileExtensions = [
      'doc', 'docx', 'txt', 'csv', 'xls', 'xlsx', 'rar', 'tar', 'targz', 'zip', 'pdf',
    ];

    if(isRemove){
      if(pickedFiles!=null){
        pickedFiles!.removeAt(index!);
      }
    }else{
      List<PlatformFile>? platformFile = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedFileExtensions,
        allowMultiple: true,
        withReadStream: true,
      ))?.files ;

      pickedFiles = [];

      pickedFiles = platformFile;


    }

    _pickedFIleCrossMaxLimit = _isCrossedMaxFileLimit(pickedFiles);
    _pickedFIleCrossMaxLength = _isCrossedMaxFileLen(pickedFiles);
    notifyListeners();
  }

  bool _isCrossedMaxFileLimit(List<PlatformFile>? platformFile) =>
      pickedFiles?.length == AppConstants.maxLimitOfTotalFileSent
          && platformFile != null
          && ImageSize.getMultipleFileSizeFromPlatformFiles(platformFile) > AppConstants.maxLimitOfFileSentINConversation;

  bool _isCrossedMaxFileLen(List<PlatformFile>? platformFile) => platformFile!.length > AppConstants.maxLimitOfTotalFileSent ;


  List <XFile> _pickedImageFiles1 =[];
  List <XFile>? get pickedImageFile1 => _pickedImageFiles1;



  List <PlatformFile> _pickedMediaFiles =[];
  List <PlatformFile>? get pickedMediaFiles => _pickedMediaFiles;



List <XFile>?  pickedImageFileStored = [];


 void pickMultipleImage(bool isRemove,{int? index}) async {
    if(isRemove) {
      if(index != null){
        pickedImageFileStored?.removeAt(index);
      }
    }else {
      _pickedImageFiles1 = await ImagePicker().pickMultiImage(imageQuality: 40);
      pickedImageFileStored?.addAll(_pickedImageFiles1);
    }
    notifyListeners();
  }


  List <PlatformFile> _pickedImageFiles =[];
  List <PlatformFile>? get pickedImageFile => _pickedImageFiles;
  List <MediaFileModel>?  pickedMediaStored = [];

  void pickMultipleMedia(bool isRemove,{int? index, bool openCamera = false}) async {
    _pickedFIleCrossMaxLimit = false;
    _pickedFIleCrossMaxLength = false;

    if(isRemove) {
      if(index != null){
        pickedMediaStored?.removeAt(index);
      }
    } else if(openCamera){
      final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 400);

      if(pickedImage != null) {
        pickedMediaStored?.add(MediaFileModel(file: pickedImage, thumbnailPath: pickedImage.path, isVideo: false));

      }
    } else {

      FilePickerResult? filePickerResult =  await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowCompression: true,
        allowedExtensions: [
          ...AppConstants.imageExtensions,
          ...AppConstants.videoExtensions,
        ],
        compressionQuality: 40,
      );

      _pickedImageFiles = filePickerResult?.files ?? [];


      for (PlatformFile file in _pickedImageFiles) {
        if (isVideoExtension(file.path ?? '')) {
          final thumbnailPath = await generateThumbnail(file.path ?? '');
          if (thumbnailPath != null) {

            pickedMediaStored?.add(MediaFileModel(file: file.xFile, thumbnailPath: thumbnailPath, isVideo: true));
          }
        } else {
          pickedMediaStored?.add(MediaFileModel(
            file: file.xFile,
            thumbnailPath: file.path,
            isVideo: false,
            isSvg: file.extension == 'svg',
          ));
        }
      }


    }

    _pickedFIleCrossMaxLength = _isMediaCrossMaxLen();
    _pickedFIleCrossMaxLimit =  await _isCrossMediaMaxLimit();

    notifyListeners();
  }



  Future<bool> _isCrossMediaMaxLimit() async =>
      _pickedImageFiles.length == AppConstants.maxLimitOfTotalFileSent
          && await ImageSize.getMultipleImageSizeFromXFile(getXFileFromMediaFileModel(pickedMediaStored ?? []) ?? []) > AppConstants.maxLimitOfFileSentINConversation;

  bool _isMediaCrossMaxLen() => pickedMediaStored!.length > AppConstants.maxLimitOfTotalFileSent;


  List<XFile>? getXFileFromMediaFileModel(List<MediaFileModel> mediaFileModel) {
    return mediaFileModel
        .map((model) => model.file)
        .whereType<XFile>() // Filters out any null values
        .toList();
  }


  bool isVideoExtension(String path) {
    final fileExtension = path.split('.').last.toLowerCase();

    const videoExtensions = [
      'mp4', 'mkv', 'avi', 'mov', 'flv', 'wmv', 'webm', 'mpeg', 'mpg', '3gp', 'ogv'
    ];
    return videoExtensions.contains(fileExtension);
  }


  Future<String?> generateThumbnail(String filePath) async {
    final directory = await getTemporaryDirectory();

/*    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: filePath, // Replace with your video URL
      thumbnailPath: directory.path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 100,
      maxWidth: 200,
      quality: 1,
    );

    return thumbnailPath.path;*/
  }



  String getChatTime (String todayChatTimeInUtc , String? nextChatTimeInUtc) {
    String chatTime = '';
    DateTime todayConversationDateTime = DateConverter.isoUtcStringToLocalTimeOnly(todayChatTimeInUtc);
    DateTime nextConversationDateTime;
    DateTime currentDate = DateTime.now();

    if(nextChatTimeInUtc == null){
      String chatTime = DateConverter.isoStringToLocalDateAndTime(todayChatTimeInUtc);
      return chatTime;
    }else{
      nextConversationDateTime = DateConverter.isoUtcStringToLocalTimeOnly(nextChatTimeInUtc);


      if(todayConversationDateTime.difference(nextConversationDateTime) < const Duration(minutes: 30) &&
          todayConversationDateTime.weekday == nextConversationDateTime.weekday){
        chatTime = '';
      }else if(currentDate.weekday != todayConversationDateTime.weekday
          && DateConverter.countDays(todayConversationDateTime) < 6){

        if( (currentDate.weekday -1 == 0 ? 7 : currentDate.weekday -1) == todayConversationDateTime.weekday){
          chatTime = DateConverter.convert24HourTimeTo12HourTimeWithDay(todayConversationDateTime, false);
        }else{
          chatTime = DateConverter.convertStringTimeToDate(todayConversationDateTime);
        }

      }else if(currentDate.weekday == todayConversationDateTime.weekday
          && DateConverter.countDays(todayConversationDateTime) < 6){
        chatTime = DateConverter.convert24HourTimeTo12HourTimeWithDay(todayConversationDateTime, true);
      }else{
        chatTime = DateConverter.isoStringToLocalDateAndTimeConversation(todayChatTimeInUtc);
      }
    }
    return chatTime;
  }




  SenderType getSenderType(Message? senderData) {
    if (senderData?.sentByCustomer == true) {
      return SenderType.customer;
    } else if (senderData?.sentBySeller == true) {
      return SenderType.seller;
    } else if (senderData?.sentByAdmin == true) {
      return SenderType.admin;
    }/* else if (senderData?.sentByDeliveryman == true) {
      return SenderType.deliveryMan;
    } else if (senderData?.sentByUser == true) {
      return SenderType.deliveryMan;
    }*/else {
      return SenderType.unknown;
    }
  }


  bool isSameUserWithPreviousMessage(Message? previousConversation, Message currentConversation){
    if(getSenderType(previousConversation) == getSenderType(currentConversation) && previousConversation?.message != null && currentConversation.message !=null){
      return true;
    }
    return false;
  }
  bool isSameUserWithNextMessage( Message currentConversation, Message? nextConversation){
    if(getSenderType(currentConversation) == getSenderType(nextConversation) && nextConversation?.message != null && currentConversation.message !=null){
      return true;
    }
    return false;
  }


  String getChatTimeWithPrevious (Message currentChat, Message? previousChat) {
    DateTime todayConversationDateTime = DateConverter
        .isoUtcStringToLocalTimeOnly(currentChat.createdAt ?? "");

    DateTime previousConversationDateTime;

    if (previousChat?.createdAt == null) {
      return 'Not-Same';
    } else {
      previousConversationDateTime =
          DateConverter.isoUtcStringToLocalTimeOnly(previousChat!.createdAt!);
      if (kDebugMode) {
        print("The Difference is ${previousConversationDateTime.difference(todayConversationDateTime) < const Duration(minutes: 30)}");
      }
      if (previousConversationDateTime.difference(todayConversationDateTime) <
          const Duration(minutes: 30) &&
          todayConversationDateTime.weekday ==
              previousConversationDateTime.weekday && isSameUserWithPreviousMessage(currentChat, previousChat)) {
        return '';
      } else {
        return 'Not-Same';
      }
    }

  }

  void downloadFile(String url, String dir, String openFileUrl, String fileName) async {

    var snackBar = const SnackBar(content: Text('Downloading....'),backgroundColor: Colors.black54, duration: Duration(seconds: 1),);
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

    final task  = await FlutterDownloader.enqueue(
      url: url,
      savedDir: dir,
      fileName: fileName,
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
    );

    if (kDebugMode) {
      print('-----task-----${task != null} || $openFileUrl');
    }

    /*if(task !=null){
      await OpenFile.open(openFileUrl);
    }*/
  }




}
