"# sui-move-gas-optimization" 

Instructions to run the Sui packages in this GitHub repository

1. Install Sui. 
https://docs.sui.io/guides/developer/getting-started/sui-install

2. Connect to Sui Testnet network.
https://docs.sui.io/guides/developer/getting-started/connect#configure-sui-client

3. Install Sui Wallet and get a Sui address.
https://docs.sui.io/guides/developer/getting-started/get-address
Important note: Store your passphrase. You will need that later. 

4. Get Sui tokens on Testnet. Make sure you use Testnet all the time. 
https://docs.sui.io/guides/developer/getting-started/get-coins

A few options to get Sui tokens are given below. 

4.a. The easiest way to get Sui Tokens is running the following command on your terminal. It will transfer 1 SUI to your account in a few seconds. You can run this command several times and get many tokens. Check your Sui wallet that you have received the tokens. Note that you need to successfully complete the above steps 1 and 2 to be able to run this command. If you don’t want to use this command to get Sui tokens, steps 1 and 2 are not required. 

    $ sui client faucet

4.b. You can also directly request tokens in your Sui wallet. In the Sui Wallet extension, go to the settings and click on “Request Testnet SUI Tokens.” This method has a cooldown of a few seconds. Note: This may not work all the time. 

![Fig. 1. Request SUI Tokens at Sui wallet](images/4b%20-%20fig1.png)
    
    
4.c. In the Sui Discord server (https://discord.gg/sui), go to the '#testnet-faucet' channel and type “!faucet” followed by your wallet address. This method has a cooldown of 2 hours. This may not work all the time. You may get a message that the faucet is over capacity. 

![Fig 2. Request Sui tokens on Discord](images/4c%20-%20fig2.png)


5. Optional: Install VSCode and its Move extension to develop Sui packages. 
https://docs.sui.io/guides/developer/advanced/move-2024-migration#update-ide-support

6. Use Move Studio to develop, compile, and deploy Sui packages. 

First test:
6.a. Go to Move Studio: https://www.movestudio.dev/build
6.b. Link to Sui Wallet on the top-right corner.
6.c. Create a new project. Name it “todo_list”. 
6.d. On the left “Files” menu, observe that the project has a “Move.toml” file and a “sources” folder.  
6.d.1. In the “Move.toml” file, make sure that the name in [package] and [addresses] match the project name, which is todo_list. Also, make sure that version = "0.0.1", edition="2024.beta" and rev = "testnet". 

[package]
name = "todo_list"
version = "0.0.1"
edition="2024.beta"

[dependencies]
Sui = { git = "https://github.com/MystenLabs/sui.git", subdir = "crates/sui-framework/packages/sui-framework", rev = "testnet" }

[addresses]
todo_list = "0x0"

Code 1: Move.toml

6.d.2. in the “sources” folder, create a file, name it “todo_list.move”, and paste the following code to that. This code has been taken from this link with some changes. 

module todo_list::todo_list {
   use std::string::String;

   public struct TodoList has key, store {
      id: UID,
      items: vector<String>
   }

   /// Create a new todo list and transfer
   fun init(ctx: &mut TxContext) {
      transfer::transfer(TodoList {
         id: object::new(ctx),
         items: vector[]
      }, ctx.sender());
   }

   /// Create a new todo list.
   public fun new(ctx: &mut TxContext): TodoList {
      let list = TodoList {
      id: object::new(ctx),
      items: vector[]
      };

       (list)
   }

   /// Add a new todo item to the list.
   entry fun add(list: &mut TodoList, item: String) {
      list.items.push_back(item);
   }

   /// Remove a todo item from the list by index.
   entry fun remove(list: &mut TodoList, index: u64): String {
      list.items.remove(index)
   }

   /// Delete the list and the capability to manage it.
   entry fun delete(list: TodoList) {
      let TodoList { id, items: _ } = list;
      id.delete();
   }

   /// Get the number of items in the list.
   entry fun length(list: &TodoList): u64 {
      list.items.length()
   }

}

Code 2: sources/todo_list.move
 
6.e. On Move Studio, use the Tools menu on the left, and compile the package. Then deploy it to Testnet. Check to see if the list object was created when deploying. It will return a package id. Store the package id in your report file. Then test it. Call the “add”, “remove”, “delete”, and “length” functions are entry functions, so that they could be directly called. 

   ![Fig. 3. After the package deployment, check the created object for todo_list package on your Sui wallet.](images/6e%20-%20fig3.png)
  

7. You can access your package in your wallet as well. Open Sui Wallet. Click “Activity” tab, and click the transaction you recently executed to deploy the package. Check the package id. Click “view on explorer” button. It will it on either Suivision (https://testnet.suivision.xyz/) or Suiscan (https://suiscan.xyz/testnet/home). Both these websites are Sui explorers. We prefer to use Suivision, but in case that doesn’t work, Suiscan is an alternative. 

8. You can also directly open these websites and search your package id, transaction id, or account, and get a report of your transactions. When you open these explorers, by default it is on Mainnet. Make sure to change it to Testnet at the settings on the top right corner. In Suivision, enter the package id in the search bar and press enter. It lists the package. Click the package. On the package page, click “Code” tab, as shown in Fig. 4. It will open an “Execute” window on the right. Observe that the package entry functions show up on the right. You can directly call them here. 

Call the “add” function 3 times and add 3 elements to the list: “apple”, “orange”, “peach”. Anytime you execute a function, the Sui wallet will open pop-up and asks you to approve it. 
You can check the contents of the vector at Suivision. For that, enter the vector's ObjectID into the search bar. On the object’s page is where you will see its fields as shown in Fig. 5. Then call the “remove” function on item number 1, which is “orange”. It will delete that from the vector. Then call the “delete” function. It will delete the vector. Call the “length” function. You will not see the returned value of entry functions on Suivision. 

  ![Fig. 4. A deployed package on Suivision.](images/8%20-%20fig4.png)
  
Package id: 0x98183f91cc3d29a2dd248a094d18dc2e06eb930b916c187b85a55c3f2adedc72      https://testnet.suivision.xyz/package/0x98183f91cc3d29a2dd248a094d18dc2e06eb930b916c187b85a55c3f2adedc72 

  ![Fig. 5. An object’s page on Suivision. (TodoList object)](images/8%20-%20fig5.png)

Object id: 0x47f3a0b658dcfa7ea15ed044c3c19819ae9f3b7d19708779305514363cfd8cae https://testnet.suivision.xyz/object/0x47f3a0b658dcfa7ea15ed044c3c19819ae9f3b7d19708779305514363cfd8cae
 
This repository provides the smart contract modules in .move files. The easiest way to run them is to create a project on Move Studio, enter replace the Move.toml file with Code1 given above, and create a .move file with the contents of files given in this repository. Then compile and publish it. Now you can use your Sui cryptowallet and call the functions in the package.   

Reference to learn more about Move language:  https://move-book.com/

