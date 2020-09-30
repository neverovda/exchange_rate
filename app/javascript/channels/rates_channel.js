import consumer from "./consumer"

consumer.subscriptions.create("RatesChannel", {
  connected() {
    console.log('connected!');
    this.perform('follow');
  },  

  received(data) {
    console.log('received!');
    var element = document.getElementById('target');
    element.textContent = data;    
  } 
});
