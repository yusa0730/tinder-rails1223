import consumer from "./consumer"

const appChatRoom = consumer.subscriptions.create("ChatRoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // document.getElementById('chat-messages');でid="chat-messages"の要素のオブジェクトを返します。
    const chatMessages = document.getElementById('chat-messages');
    // insertAdjacentHTML で第2引数のdata['chat_message']を挿入します。
    // 挿入位置は、'beforeend'なので、element 内部の、最後の子要素の後に挿入します。
    chatMessages.insertAdjacentHTML('beforeend', data['chat_message']);
  },

  // chat_messageとchat_room_idをchat_room_channel.rb の speak アクションに送っています。
  speak: function(chat_message, chat_room_id) {
    return this.perform('speak', { chat_message: chat_message, chat_room_id: chat_room_id});
  }
});

if(/chat_rooms/.test(location.pathname)) {
  $(document).on("keydown", ".chat-room__message-form_textarea", function(e) {
    if (e.key === "Enter") {
      const chat_room_id = $('textarea').data('chat_room_id');
      // appChatRoomのspeakアクションにchat_room_idを引数として渡しています。
      appChatRoom.speak(e.target.value, chat_room_id);
      e.target.value = '';
      e.preventDefault();
    }
  })
}