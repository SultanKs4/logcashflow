PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE android_metadata (locale TEXT);
INSERT INTO android_metadata VALUES('en_US');
CREATE TABLE users(
        id INTEGER PRIMARY KEY NOT NULL,
        username VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
INSERT INTO users VALUES(1,'user','b14361404c078ffd549c03db443c3fede2f3e534d73f78f77301ed97d4a436a9fd9db05ee8b325c0ad36438b43fec8510c204fc1c1edb21d0941c00e9e2c1ce2','2022-07-30T03:30:04.000');
CREATE TABLE cashflow(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        users_id INTEGER NOT NULL,
        type INTEGER NOT NULL,
        date DATE NOT NULL,
        value INTEGER NOT NULL,
        description TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
COMMIT;
