import 'dart:async';
import 'dart:convert';

import 'package:base_project/models/http/http_setting.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../constant/theme/global_data.dart';
import '../websocketdata/ws_ack_send_message_data.dart';
import '../websocketdata/ws_send_message_data.dart';

enum SocketStatus {
  SocketStatusConnected,
  SocketStatusFailed,
  SocketStatusClose,
}

class WebSocketUtil {
  /// 單例
  static WebSocketUtil? _webSocketUtil;

  /// 內部構造方法，避免外部暴露
  WebSocketUtil._();

  /// 獲取單例内部方法
  factory WebSocketUtil() {
    // 只能有一个實例
    return _webSocketUtil ??= WebSocketUtil._();
  }

  late IOWebSocketChannel _channel; // WebSocket
  StreamController streamController = StreamController.broadcast(); // 流控制器，多頁面才能監聽同一流
  SocketStatus _socketStatus = SocketStatus.SocketStatusClose; // 連線狀態
  late Timer _heartBeat; // 心跳
  final int _heartTimes = 6000; // 心跳間隔(毫秒)
  final int _reconnectCount = 20; // 最大重連次數
  late int _reconnectTimes = 0; // 重連次數紀錄
  late Timer _reconnectTimer; // 重連定時
  late Function onError; // Socket Error
  late Function onOpen; // Socket Open
  late Function onMessage; // Get Message
  late StreamSubscription streamSubscription;
  bool bStillWaitingACK = false; // 由伺服器端斷線的情況下作為自動重連
  String _SOCKET_URL = HttpSetting.socketUrl;

  void initWebSocket({required Function onOpen, required Function onMessage, required Function onError}) {
    this.onOpen = onOpen;
    this.onMessage = onMessage;
    this.onError = onError;
    openSocket();
  }

  void openSocket() {
    if (_socketStatus == SocketStatus.SocketStatusConnected) {
      GlobalData.printLog('WebSocket已是連線狀態');
      try {
        // 防尚未init
        _reconnectTimer.cancel();
      } catch (_) {
        return;
      }
      return;
    }

    Map<String, dynamic> header = {};
    header['Authorization'] = GlobalData.userToken;
    _channel = IOWebSocketChannel.connect(_SOCKET_URL, headers: header);
    GlobalData.printLog('WebSocket連線成功: $_SOCKET_URL');
    // 連線成功，將channel放進stream，由streamController來做監聽
    streamController.addStream(_channel.stream);
    _socketStatus = SocketStatus.SocketStatusConnected;
    bStillWaitingACK = false;

    // 連線成功，重置計數器
    _reconnectTimes = 0;

    // 由MainScreen啟動心跳
    onOpen();

    // 接收消息
    socketListener();
  }

  void socketListener() {
    streamSubscription = streamController.stream
        .listen((data) => webSocketOnMessage(data), onError: webSocketOnError, onDone: webSocketOnDone);
  }

  /// Init心跳
  void initHeartBeat() {
    _heartBeat = Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
      sentHeart();
    });
  }

  /// 心跳
  void sentHeart() {
    if (bStillWaitingACK) {
      // 被伺服器端斷線了
      GlobalData.printLog('被伺服器斷線 開始進行重連');
      closeSocket();
      // SocketStatus.SocketStatusClosed;
      _reconnect();
      return;
    }
    bStillWaitingACK = true;
    Map<String, dynamic> heartBeat = {};
    heartBeat['topic'] = 'HB';
    var jsonStr = json.encode(heartBeat);
    var utf8Data = utf8.encode(jsonStr);
    _sendMessage(utf8Data);
  }

  /// WebSocket收到消息
  webSocketOnMessage(data) {
    onMessage(data);
  }

  /// WebSocket關閉連線
  webSocketOnDone() {
    GlobalData.printLog('WebSocketOnDone 關閉連線');
    closeSocket();
    // SocketStatus.SocketStatusClosed;
    _reconnect();
  }

  /// WebSocket連線錯誤
  webSocketOnError(e) {
    GlobalData.printLog('WebSocket連線錯誤');
    WebSocketChannelException ex = e;
    _socketStatus = SocketStatus.SocketStatusFailed;
    onError(ex.message);
    closeSocket();
  }

  void closeSocket() {
    GlobalData.printLog('WebSocket關閉');
    _channel.sink.close();
    streamSubscription.cancel();
    destroyHeartBeat();
    _socketStatus = SocketStatus.SocketStatusClose;
  }

  void destroyHeartBeat() {
    _heartBeat.cancel();
  }

  /// 心跳重連機制
  void _reconnect() {
    if (GlobalData.userToken.isNotEmpty) {
      if (_reconnectTimes < _reconnectCount) {
        _reconnectTimes++;
        _reconnectTimer = Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
          openSocket();
        });
      } else {
        GlobalData.printLog('重連次數已達上限');
        _reconnectTimer.cancel();
        return;
      }
    }
  }
///////////////////////////////
////////////////////////////////

  void _sendMessage(message) {
    switch (_socketStatus) {
      case SocketStatus.SocketStatusConnected:
        GlobalData.printLog('訊息發送中');
        _channel.sink.add(message);
        break;
      case SocketStatus.SocketStatusClose:
        GlobalData.printLog('已斷線');
        break;
      case SocketStatus.SocketStatusFailed:
        GlobalData.printLog('發訊息失敗');
        break;
      default:
        break;
    }
  }

  /// WebSocket 發送Data轉binary (utf8)
  sendMessage(WsSendMessageData data) {
    var jsonStr = json.encode(data);
    var utf8Data = utf8.encode(jsonStr);
    _sendMessage(utf8Data);
    GlobalData.printLog('發出去的jsonStr: $jsonStr');
  }

  /// WebSocket ACK資料轉Data
  WsAckSendMessageData getACKData(ackMessage) {
    bStillWaitingACK = false;
    var messageString = utf8.decode(ackMessage);
    var jsonStr = messageString; // Dio已自動轉成json
    GlobalData.printLog('ACK訊息：$jsonStr');
    WsAckSendMessageData data = wsAckSendMessageDataFromJson(jsonStr);
    return data;
  }
}
