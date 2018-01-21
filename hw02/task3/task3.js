(function (){
  function init(){
    document.getElementById('loremLink').addEventListener("click", function(){
      showLorem('loremText');
    });
    document.getElementById('99BottlesLink').addEventListener("click", function(){
      showLorem('bottlesText');
    });
    document.getElementById('LastThingLink').addEventListener("click", function(){
      showLorem('LastThingText');
    });
  }
  function showLorem(id){
    var otherDivs = document.querySelectorAll('.text');
    otherDivs.forEach(function(d){
      d.style.display = "none";
  });
  document.getElementById(id).style.display = "block";
}
  window.addEventListener("load", init, false);
})();
