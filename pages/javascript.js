1. do not do it like this
function abc(){
  function abcd(){

  }

  function abce(){

  }
}
because this is hard to read the function while the functions getting more and more.
we should do it like this

var ModuleName = {};
ModuleName.MethodA = function(){}
ModuleName.MethodB = function(){}