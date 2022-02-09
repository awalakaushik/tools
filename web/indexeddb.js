// Using: https://github.com/jakearchibald/idb
// Docs: https://npm.runkit.com/idb

var databaseName = 'clinical_questions';

let db;

const createDB = async (dbName, storeList, sendResponse) => {
  
  console.info(`Creating ${dbName}...`);

  try {
    db = await idb.openDB(dbName, 1, {
      upgrade(db, oldVersion, newVersion, transaction) {
  
        switch(oldVersion) {
          case 0:
          case 1:
            // create a db store of objects (for each item in the store list)

            storeList.forEach(store => {
              db.createObjectStore(store.name, {autoincrement: true, keyPath: store.keyPath});
            });
  
            // TODO: add db indexes as necessary
        }
      }
    });
  
    console.log("Database created and opened...");
    sendResponse({success: true});
  }
  catch(e) {
    sendResponse({success: false, message: `Error while creating DB: ${e.message}`});
  }
};

const deleteDB = async (dbName, sendResponse) => {

  if (!dbName) {
    sendResponse({success: false, message: `Database name is required...`});
  }

  console.info(`Deleting ${dbName}...`);

  await idb.deleteDB(dbName);
  sendResponse({success: true});
};

const getData = async (storeName, key, sendResponse) => {
  if (db == undefined) {
    sendResponse({success: false, message: `Database is closed...`});
  }

  try {
    console.info(`Fetching from store: ${storeName}, key: ${key}...`);

    const tx = await db.transaction(storeName, 'readonly')
    const store = tx.objectStore(storeName);
    const value = await store.get(key);
    sendResponse({success: true, data: value});
  }
  catch(e) {
    sendResponse({success: false, message: `Error while fetching from DB: ${e.message}`});
  }

};

const getAllData = async (storeName, sendResponse) => {
  if (db == undefined) {
    sendResponse({success: false, message: `Database is closed...`});
  }

  try {
    const tx = await db.transaction(storeName, 'readonly')
    const store = tx.objectStore(storeName);
    const value = await store.getAll();
    console.info(`Fetching from store: ${storeName}, data: `, value);
    sendResponse({success: true, data: value});
  }
  catch(e) {
    sendResponse({success: false, message: `Error while fetching from DB: ${e.message}`});
  }

};

const addData = async(storeName, value, sendResponse) => {
  if (db == undefined) {
    sendResponse({success: false, message: `Database is closed...`});
  }

  try {
    console.info(`Adding to store: ${storeName}, value: ...`, value);

    const tx = db.transaction(storeName, 'readwrite');
    const store = await tx.objectStore(storeName);
    await Promise.all(value.map((v) => store.add(v)));
    await tx.done;

    sendResponse({success: true});
  }
  catch(e) {
    sendResponse({success: false, message: `Error while adding to DB: ${e.message}`});
  }
  
}

const updateData = async(storeName, value, sendResponse) => {
  
  if (db == undefined) {
    sendResponse({success: false, message: `Database is closed...`});
  }

  try {
    console.info(`Updating store: ${storeName}, value: ${value}...`);

    const tx = db.transaction(storeName, 'readwrite');
    const store = await tx.objectStore(storeName);
    await Promise.all(value.map((v) => store.add(v)));
    await tx.done;

    sendResponse({success: true});
  }
  catch(e) {
    sendResponse({success: false, message: `Error while updating to DB: ${e.message}`});
  }
}

const deleteData = async(storeName, key, sendResponse) => {
  
  if (db == undefined) {
    sendResponse({success: false, message: `Database is closed...`});
  }

  try {
    console.info(`Deleting from store: ${storeName}, key: ${key}...`);

    const tx = db.transaction(storeName, 'readwrite');
    const store = await tx.objectStore(storeName);
    await store.delete(key);
    await tx.done;

    sendResponse({success: true});
  }
  catch(e) {
    sendResponse({success: false, message: `Error while deleting from DB: ${e.message}`});
  }
}

const handleRequest = (request, sender, sendResponse) => {
  console.info("Request received...");

  if (!('indexedDB' in window)) {
    console.warn('IndexedDB not supported')
    sendResponse({success: false, message: "IndexedDB not supported on this browser!"});
  }

  if (request) {

    if(request.action == "create") {
      createDB(request.dbName, request.storeList, sendResponse);
    }
    else if(request.action == "clear") {
      deleteDB(request.dbName, sendResponse);
    }
    else if (request.action == "get") {
      getData(request.storeName, request.key, sendResponse);
    }
    else if (request.action == "getall") {
      getAllData(request.storeName, sendResponse);
    }
    else if (request.action == "add") {
      addData(request.storeName, request.data, sendResponse);
    }
    else if (request.action == "update") {
      updateData(request.storeName, request.data, sendResponse);
    }
    else if (request.action == "delete") {
      deleteData(request.storeName, request.key, sendResponse);
    }
    
    // return true to send the response asynchronously
    return true;
  }
}

chrome.runtime.onMessage.addListener(handleRequest);
