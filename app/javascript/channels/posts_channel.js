import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', function () {
  const room_id = 'posts'

  consumer.subscriptions.create(
    {
      channel: 'PostsChannel',
      post_id: room_id,
    },
    {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log('Connected to room_channel [' + room_id + ']');
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
        console.log('Disconnected to room_channel [' + room_id + ']');
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log('received( ');
        console.log(data.post);
        console.log(' )');

        var tableRef = document.getElementById('posts').getElementsByTagName('tbody')[0];
        //insert Row
        tableRef.insertRow(0).innerHTML = data.post;
      },
    }
  );
});