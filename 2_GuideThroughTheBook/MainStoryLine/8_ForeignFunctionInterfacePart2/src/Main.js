"use strict";

function addAwesome(someStr){
  return someStr + " is awesome!";
}

function fakeAwesome(someStr){
  if(someStr.toLowerCase() == "gulab jamoon"){
    return someStr + " is awesome!";
  }else{
    return {name: "Sleepy", age:23};
  }
}

function someCalc(num){
  if(num == 1){
    return num + 10;
  }else{
    return {name: "Sleepy", age:23};
  }
}

function logIt (logStr){
  console.log(logStr);
}

function badFunction(){
  console.log("all evil stuff here")
}

exports.addAwesome = addAwesome;
exports.fakeAwesome = fakeAwesome;
exports.someCalc = someCalc;
exports.logIt = logIt;
exports.logTest = badFunction();
exports.getName = getName;
exports.getPlace =getPlace;
exports.jsCalc =jsCalc;
exports.processAccount = processAccount;

function jsCalc (a){
  return {name:"Prasanna", place:"Bangalore"};
}

function getName (a){
  return a.name;
}

function getPlace (a){
  return a.place;
}

function processAccount(account){
  console.log("Account Number : " + account.value0);
  return true;
}
