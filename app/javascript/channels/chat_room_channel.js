import consumer from "./consumer"

const appChatRoom = consumer.subscriptions.create("ChatRoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // chat_room_channel.rbから送られてきたdataを受け取り、アラートを表示します。
  received(data) {
    // Called when there's incoming data on the websocket for this channel
    return alert(data['chat']);
  },

  // chat_room_channel.rbのspeakアクションにchat_messageを送っています。
  speak: function() {
    return this.perform('speak', {chat_message: chat_message});
  }
});

// チャットルームページかどうかを確かめています。チャットルームページだけで上記の処理をしたいためです。
// location.pathname で現在のページURLのパスを参照します。
// test() メソッドは、正規表現と指定された文字列の一致を調べるための検索を実行します。 true または false を返します。
if(/chat_rooms/.test(location.pathname)) {
  // フォーム内でEnterキーを押したときに処理を実行します。
  $(document).on("keydown", ".chat-room__message-form_textarea", function(e) {
    if (e.key === "Enter") {
      // speakアクションを発火させています。
      appChatRoom.speak(e.target.value);
      e.target.value="";
      e.preventDefault();
    }
  }) 
}
