# dbank

Dapp university tutorial

Be careful: 
1. Please use command 

   $npm install -g truffle 

rather than 

   $npm install --global truffle@5.1.39

(suggested in tutorial video) to install your truffle environment, otherwise you will disable the compiling for token.sol.

2. Please add:

   await window.ethereum.enable()
   
 or manually update the network connection between Metamask and localhost:300(URL assigned by App.js) before your access to
 all the data of your ganache accounts tested and smart contract in App.js, otherwise console.log() will fail to access the 
 all the data from your test accounts.
