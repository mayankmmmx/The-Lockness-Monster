var UI = require('ui');

var method = 'POST';
// Construct URL
var url = "https://agent.electricimp.com/B_odmEQnlMF2?LockState=";

// Create the request
var request = new XMLHttpRequest();

var main = new UI.Card({
  	title: 'Bike Lock',
  	subtitle: 'Control your bike lock remotely!',
  	body: 'Press Select Button to Start.',
  	subtitleColor: 'indigo', // Named colors
  	bodyColor: '#9a0036' // Hex colors
});

main.show();

main.on('click', 'select', function(e) {
	var menu = new UI.Menu({
   	sections: [{
     		items: [{
        		title: 'Lock',
        		subtitle: 'Click here to lock your bike'
      	}, {
        		title: 'Unlock',
        		subtitle: 'Click here to unlock your bike'
      	}]
    	}]
  	});
  	menu.on('select', function(e) {
		var urlNew = url + e.itemIndex;
		console.log(urlNew);
		request.open(method, urlNew);
		request.send();
	});
  	menu.show();
});