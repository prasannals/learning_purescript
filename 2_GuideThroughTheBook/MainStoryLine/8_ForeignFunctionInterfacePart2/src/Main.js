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


exports.addAwesome = addAwesome;
exports.fakeAwesome = fakeAwesome;
exports.someCalc = someCalc;
exports.logIt = logIt;
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



function createNewContacts(){
  return {};
}

function addToContacts(contacts){
  return function(name){
    return function(number){
      contacts[name] = number;
      return Object.assign({}, contacts); //returning a new copy
    }
  }
}

function removeFromContacts(contacts){
  return function(name){
    delete contacts[name];
    return Object.assign({}, contacts);
  }
}

function updateContacts(contacts){
  return function(name){
    return function(number){
      contacts[name] = number;
      return Object.assign({}, contacts);
    }
  }
}


function contactsStr(contacts){
  return JSON.stringify(contacts);
}



exports.createNewContacts = createNewContacts;
exports.addToContacts = addToContacts;
exports.removeFromContacts = removeFromContacts;
exports.updateContacts = updateContacts;
exports.contactsStr = contactsStr;
