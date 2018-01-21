(function (){
  "use strict";
  var x;
  function init(){
    var heading = document.querySelector("h1").innerText;
    x = parseInt(heading)
    //alert popup with the current value of the number.
    var alrt = document.getElementById('alert');
    alrt.addEventListener("click", popup);
    //increments the number.
    var inc = document.getElementById('increment');
    inc.addEventListener("click", increment);
    //appends a new paragraph containing the number to the bottom of the page.
    var appnd = document.getElementById('append');
    appnd.addEventListener("click", append);

  };
  function popup(){
    alert(x)
  };
  function increment(){
    x += 1;
    var heading = document.querySelector("h1");
    heading.innerText = x;
  };
  function append(){
    var body = document.children[0].children[1];
    var newp = document.createElement("p");
    newp.innerText = x;
    body.appendChild(newp)
  };
  window.addEventListener("load", init, false);

})();
