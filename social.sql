DROP TABLE "Comment";
DROP TABLE InfractionRules;
DROP TABLE Admin;
DROP TABLE ListOfBlockedUser;
DROP TABLE ListOfFriends;
DROP TABLE Message;
DROP TABLE PostInGroup;
DROP TABLE Publication;
DROP TABLE Rules;
DROP TABLE GroupMember;
DROP TABLE "Group";
DROP TABLE UserInterests;
DROP TABLE Interests;
DROP TABLE "User";

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
-- tables
-- Table: Admin
CREATE TABLE Admin (
    IdAdmin integer  NOT NULL,
    FirstName varchar2(20)  NOT NULL,
    LastName varchar2(20)  NULL,
    DateOfEmployment date  NOT NULL,
    CONSTRAINT Admin_pk PRIMARY KEY (IdAdmin)
) ;

-- Table: Comment
CREATE TABLE "Comment" (
    IdUser integer  NOT NULL,
    IdPublication integer  NOT NULL,
    "Comment" varchar2(3000)  NOT NULL,
    Rating number(1,0)  NOT NULL,
    CONSTRAINT Comment_pk PRIMARY KEY (IdUser,IdPublication)
) ;

-- Table: Group
CREATE TABLE "Group" (
    IdGroup integer  NOT NULL,
    GroupName varchar2(20)  NOT NULL,
    IdCreator integer  NOT NULL,
    CONSTRAINT Group_pk PRIMARY KEY (IdGroup)
) ;

-- Table: GroupMember
CREATE TABLE GroupMember (
    IdGroupMember integer  NOT NULL,
    IdUser integer  NOT NULL,
    Status varchar2(20)  NOT NULL,
    IdGroup integer  NOT NULL,
    CONSTRAINT GroupMember_pk PRIMARY KEY (IdGroupMember)
) ;

-- Table: InfractionRules
CREATE TABLE InfractionRules (
    IdInfractionRules integer  NOT NULL,
    notes varchar2(100)  NULL,
    IdRules integer  NOT NULL,
    IdUser integer  NOT NULL,
    IdAdmin integer  NOT NULL,
    CONSTRAINT InfractionRules_pk PRIMARY KEY (IdInfractionRules)
) ;

-- Table: Interests
CREATE TABLE Interests (
    IdInterests integer  NOT NULL,
    title varchar2(20)  NOT NULL,
    CONSTRAINT Interests_pk PRIMARY KEY (IdInterests)
) ;

-- Table: ListOfBlockedUser
CREATE TABLE ListOfBlockedUser (
    idUser integer  NOT NULL,
    IdBlockedUser integer  NOT NULL,
    CONSTRAINT ListOfBlockedUser_pk PRIMARY KEY (idUser,IdBlockedUser)
) ;

-- Table: ListOfFriends
CREATE TABLE ListOfFriends (
    IdUser integer  NOT NULL,
    IdFriend integer  NOT NULL,
    CONSTRAINT ListOfFriends_pk PRIMARY KEY (IdUser,IdFriend)
) ;

-- Table: Message
CREATE TABLE Message (
    IdMessage integer  NOT NULL,
    Text varchar2(1000)  NOT NULL,
    FromUser integer  NOT NULL,
    ToUser integer  NOT NULL,
    "date" date  NOT NULL,
    CONSTRAINT Message_pk PRIMARY KEY (IdMessage)
) ;

-- Table: PostInGroup
CREATE TABLE PostInGroup (
    IdPostInGroup integer  NOT NULL,
    Title varchar2(20)  NOT NULL,
    Text varchar2(2500)  NOT NULL,
    IdGroupMember integer  NOT NULL,
    IdGroup integer  NOT NULL,
    CONSTRAINT PostInGroup_pk PRIMARY KEY (IdPostInGroup)
) ;

-- Table: Publication
CREATE TABLE Publication (
    IdPublication integer  NOT NULL,
    Title varchar2(100)  NOT NULL,
    Text varchar2(3000)  NOT NULL,
    IdUser integer  NOT NULL,
    CONSTRAINT Publication_pk PRIMARY KEY (IdPublication)
) ;

-- Table: Rules
CREATE TABLE Rules (
    IdRules integer  NOT NULL,
    Text varchar2(100)  NOT NULL,
    CONSTRAINT Rules_pk PRIMARY KEY (IdRules)
) ;

-- Table: User
CREATE TABLE "User" (
    IdUser integer  NOT NULL,
    FirstName varchar2(20)  NOT NULL,
    LastName varchar2(20)  NULL,
    Gender varchar2(20)  NULL,
    DateOfBirth date  NOT NULL,
    Phone integer  NULL,
    Email varchar2(20)  NULL,
    CONSTRAINT User_pk PRIMARY KEY (IdUser)
) ;

-- Table: UserInterests
CREATE TABLE UserInterests (
    IdInterests integer  NOT NULL,
    IdUser integer  NOT NULL,
    CONSTRAINT UserInterests_pk PRIMARY KEY (IdUser,IdInterests)
) ;

-- foreign keys
-- Reference: Comment_Publication (table: Comment)
ALTER TABLE "Comment" ADD CONSTRAINT Comment_Publication
    FOREIGN KEY (IdPublication)
    REFERENCES Publication (IdPublication);

-- Reference: Comment_User (table: Comment)
ALTER TABLE "Comment" ADD CONSTRAINT Comment_User
    FOREIGN KEY (IdUser)
    REFERENCES "User" (IdUser);

-- Reference: FromUser (table: Message)
ALTER TABLE Message ADD CONSTRAINT FromUser
    FOREIGN KEY (FromUser)
    REFERENCES "User" (IdUser);

-- Reference: GroupMember_Group (table: GroupMember)
ALTER TABLE GroupMember ADD CONSTRAINT GroupMember_Group
    FOREIGN KEY (IdGroup)
    REFERENCES "Group" (IdGroup);

-- Reference: GroupMember_User (table: GroupMember)
ALTER TABLE GroupMember ADD CONSTRAINT GroupMember_User
    FOREIGN KEY (IdUser)
    REFERENCES "User" (IdUser);

-- Reference: IdCreator (table: Group)
ALTER TABLE "Group" ADD CONSTRAINT IdCreator
    FOREIGN KEY (IdCreator)
    REFERENCES "User" (IdUser);

-- Reference: InfractionRules_Admin (table: InfractionRules)
ALTER TABLE InfractionRules ADD CONSTRAINT InfractionRules_Admin
    FOREIGN KEY (IdAdmin)
    REFERENCES Admin (IdAdmin);

-- Reference: InfractionRules_Rules (table: InfractionRules)
ALTER TABLE InfractionRules ADD CONSTRAINT InfractionRules_Rules
    FOREIGN KEY (IdRules)
    REFERENCES Rules (IdRules);

-- Reference: InfractionRules_User (table: InfractionRules)
ALTER TABLE InfractionRules ADD CONSTRAINT InfractionRules_User
    FOREIGN KEY (IdUser)
    REFERENCES "User" (IdUser);

-- Reference: ListOfBlockedUser_IdBlock (table: ListOfBlockedUser)
ALTER TABLE ListOfBlockedUser ADD CONSTRAINT ListOfBlockedUser_IdBlock
    FOREIGN KEY (IdBlockedUser)
    REFERENCES "User" (IdUser);

-- Reference: ListOfBlockedUser_IdUser (table: ListOfBlockedUser)
ALTER TABLE ListOfBlockedUser ADD CONSTRAINT ListOfBlockedUser_IdUser
    FOREIGN KEY (idUser)
    REFERENCES "User" (IdUser);

-- Reference: ListOfFriends_IdUser (table: ListOfFriends)
ALTER TABLE ListOfFriends ADD CONSTRAINT ListOfFriends_IdUser
    FOREIGN KEY (IdUser)
    REFERENCES "User" (IdUser);

-- Reference: ListOfFriends_User (table: ListOfFriends)
ALTER TABLE ListOfFriends ADD CONSTRAINT ListOfFriends_User
    FOREIGN KEY (IdFriend)
    REFERENCES "User" (IdUser);

-- Reference: PostsInGroup_Group (table: PostInGroup)
ALTER TABLE PostInGroup ADD CONSTRAINT PostsInGroup_Group
    FOREIGN KEY (IdGroup)
    REFERENCES "Group" (IdGroup);

-- Reference: PostsInGroup_GroupMember (table: PostInGroup)
ALTER TABLE PostInGroup ADD CONSTRAINT PostsInGroup_GroupMember
    FOREIGN KEY (IdGroupMember)
    REFERENCES GroupMember (IdGroupMember);

-- Reference: Publication_User (table: Publication)
ALTER TABLE Publication ADD CONSTRAINT Publication_User
    FOREIGN KEY (IdUser)
    REFERENCES "User" (IdUser);

-- Reference: ToUser (table: Message)
ALTER TABLE Message ADD CONSTRAINT ToUser
    FOREIGN KEY (ToUser)
    REFERENCES "User" (IdUser);

-- Reference: UserInterests_Interests (table: UserInterests)
ALTER TABLE UserInterests ADD CONSTRAINT UserInterests_Interests
    FOREIGN KEY (IdInterests)
    REFERENCES Interests (IdInterests);

-- Reference: UserInterests_User (table: UserInterests)
ALTER TABLE UserInterests ADD CONSTRAINT UserInterests_User
    FOREIGN KEY (IdUser)
    REFERENCES "User" (IdUser);

-- End of file.

INSERT INTO "User" (IdUser, FirstName, LastName, Gender, DateOfBirth, Phone, Email) VALUES (1, 'Liam', 'Smith', 'Male', '1998-03-12', '3642198913', 'rbd1@gmail.com');
INSERT INTO "User" (IdUser, FirstName, LastName, Gender, DateOfBirth, Phone, Email) VALUES (2, 'Noah', 'Johnson', null, '1998-03-11', '2461147442', 'rbd2@gmail.com');
INSERT INTO "User" (IdUser, FirstName, LastName, Gender, DateOfBirth, Phone, Email) VALUES (3, 'Oliver', 'Williams', 'Male', '1983-01-21', '3512638337', 'rbd3@gmail.com');
INSERT INTO "User" (IdUser, FirstName, LastName, Gender, DateOfBirth, Phone, Email) VALUES (4, 'Elijah', 'Brown', 'Female', '2001-11-11', null, null);
INSERT INTO "User" (IdUser, FirstName, LastName, Gender, DateOfBirth, Phone, Email) VALUES (5, 'James', 'Jones', null, '1990-09-10', null, null);
INSERT INTO "User" (IdUser, FirstName, LastName, Gender, DateOfBirth, Phone, Email) VALUES (6, 'William', 'Garcia', 'Male', '2005-05-15', null, null);
INSERT INTO "User" (IdUser, FirstName, LastName, Gender, DateOfBirth, Phone, Email) VALUES (7, 'Benjamin', 'Miller', 'Male', '2007-07-27', null, null);

INSERT INTO ListOfFriends (IdUser, IdFriend) VALUES (1, 3);
INSERT INTO ListOfFriends (IdUser, IdFriend) VALUES (3, 1);
INSERT INTO ListOfFriends (IdUser, IdFriend) VALUES (4, 5);
INSERT INTO ListOfFriends (IdUser, IdFriend) VALUES (4, 2);
INSERT INTO ListOfFriends (IdUser, IdFriend) VALUES (2, 4);

INSERT INTO ListOfBlockedUser (IdUser, IdBlockedUser) VALUES (1, 4);
INSERT INTO ListOfBlockedUser (IdUser, IdBlockedUser) VALUES (4, 1);
INSERT INTO ListOfBlockedUser (IdUser, IdBlockedUser) VALUES (5, 2);

INSERT INTO Interests (IdInterests, title) VALUES (1, 'IT');
INSERT INTO Interests (IdInterests, title) VALUES (2, 'Basketball');
INSERT INTO Interests (IdInterests, title) VALUES (3, 'Volleyball');
INSERT INTO Interests (IdInterests, title) VALUES (4, 'Regby');
INSERT INTO Interests (IdInterests, title) VALUES (5, 'Films');

INSERT INTO UserInterests (IdUser, IdInterests) VALUES (1, 2);
INSERT INTO UserInterests (IdUser, IdInterests) VALUES (2, 2);
INSERT INTO UserInterests (IdUser, IdInterests) VALUES (4, 5);
INSERT INTO UserInterests (IdUser, IdInterests) VALUES (3, 4);
INSERT INTO UserInterests (IdUser, IdInterests) VALUES (5, 4);

INSERT INTO Admin (IdAdmin, FirstName, LastName, DateOfEmployment) VALUES (3, 'Alexander', 'Davis', '2021-01-21');
INSERT INTO Admin (IdAdmin, FirstName, LastName, DateOfEmployment) VALUES (1, 'Jackson', null, '2020-02-20');
INSERT INTO Admin (IdAdmin, FirstName, LastName, DateOfEmployment) VALUES (2, 'Mateo', 'Rodriguez', '2019-09-19');
INSERT INTO Admin (IdAdmin, FirstName, LastName, DateOfEmployment) VALUES (4, 'Sebastian', null, '2018-08-18');
INSERT INTO Admin (IdAdmin, FirstName, LastName, DateOfEmployment) VALUES (5, 'Ethan', null, '2005-05-25');

INSERT INTO Rules (IdRules, Text) VALUES (1, 'Do not spam!');
INSERT INTO Rules (IdRules, Text) VALUES (2, 'Do not share such content!');
INSERT INTO Rules (IdRules, Text) VALUES (3, 'Do not offend other users!');

INSERT INTO InfractionRules (IdInfractionRules, IdUser, IdAdmin, IdRules, notes) VALUES (1, 5, 3, 1, null);
INSERT INTO InfractionRules (IdInfractionRules, IdUser, IdAdmin, IdRules, notes) VALUES (2, 4, 2, 2, null);
INSERT INTO InfractionRules (IdInfractionRules, IdUser, IdAdmin, IdRules, notes) VALUES (3, 3, 1, 2, null);
INSERT INTO InfractionRules (IdInfractionRules, IdUser, IdAdmin, IdRules, notes) VALUES (4, 2, 4, 3, null);
INSERT INTO InfractionRules (IdInfractionRules, IdUser, IdAdmin, IdRules, notes) VALUES (5, 2, 4, 3, 'Ban for 2 weeks(Second Infraction)');

INSERT INTO Publication (IdPublication, IdUser, Title, Text) VALUES (1, 3, 'The Hunger Games: Catching Fire!', 'Unbelievable!');
INSERT INTO Publication (IdPublication, IdUser, Title, Text) VALUES (2, 5, 'Faraway!', 'This movie was not worth my time!');
INSERT INTO Publication (IdPublication, IdUser, Title, Text) VALUES (3, 1, 'Cats', 'This kitty is so beautiful');
INSERT INTO Publication (IdPublication, IdUser, Title, Text) VALUES (4, 4, 'Basketball', 'Lakers will destroy this guys in 1 half');
INSERT INTO Publication (IdPublication, IdUser, Title, Text) VALUES (5, 2, 'UFC', 'Ricardo Abreu will win');

INSERT INTO "Comment" (IdPublication, IdUser, "Comment", Rating) VALUES (2, 2, 'Cute!', 6);
INSERT INTO "Comment" (IdPublication, IdUser, "Comment", Rating) VALUES (2, 1, 'This picture is astounding. ', 7);
INSERT INTO "Comment" (IdPublication, IdUser, "Comment", Rating) VALUES (1, 4, 'I am running out of comments to share on your pictures.', 9);
INSERT INTO "Comment" (IdPublication, IdUser, "Comment", Rating) VALUES (5, 4, 'Please stop publishing such content!', 1);
INSERT INTO "Comment" (IdPublication, IdUser, "Comment", Rating) VALUES (1, 2, 'You are a loser!', 2);

INSERT INTO Message (IdMessage, FromUser, ToUser, Text, "date") VALUES (1, 1, 3, 'Hi, you look delicious, do you want to catch up?', TO_DATE('2023-03-25 17:18:19', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Message (IdMessage, FromUser, ToUser, Text, "date") VALUES (5, 4, 5, 'I am glad to hear this',TO_DATE('2020-02-20 18:59:59', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Message (IdMessage, FromUser, ToUser, Text, "date") VALUES (2, 3, 1, 'How was your additional class?', TO_DATE('2019-04-24 21:30:01', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Message (IdMessage, FromUser, ToUser, Text, "date") VALUES (3, 4, 1, 'Bye Bye', TO_DATE('2018-12-15 23:05:59', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Message (IdMessage, FromUser, ToUser, Text, "date") VALUES (4, 5, 3, 'It is over',TO_DATE('2017-07-14 06:01:01', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO "Group" (IdGroup, GroupName, IdCreator) VALUES (1, '24.04 Avatar 3', 3);
INSERT INTO "Group" (IdGroup, GroupName, IdCreator) VALUES (2, 'Family!!!', 1);
INSERT INTO "Group" (IdGroup, GroupName, IdCreator) VALUES (3, 'Music!', 2);

INSERT INTO GroupMember (IdGroupMember, IdUser, IdGroup, Status) VALUES (1, 5, 1, 'Member');
INSERT INTO GroupMember (IdGroupMember, IdUser, IdGroup, Status) VALUES (2, 4, 1, 'Creator');
INSERT INTO GroupMember (IdGroupMember, IdUser, IdGroup, Status) VALUES (3, 3, 2, 'Member');
INSERT INTO GroupMember (IdGroupMember, IdUser, IdGroup, Status) VALUES (5, 1, 2, 'Creator');
INSERT INTO GroupMember (IdGroupMember, IdUser, IdGroup, Status) VALUES (4, 2, 3, 'Creator');

INSERT INTO PostInGroup (IdPostInGroup, IdGroupMember, IdGroup, Title, Text) VALUES (1, 5, 1, 'Film', 'Lets take a look at the new Avatar');
INSERT INTO PostInGroup (IdPostInGroup, IdGroupMember, IdGroup, Title, Text) VALUES (2, 4, 1, 'Film', 'Lets take a look XXX');
INSERT INTO PostInGroup (IdPostInGroup, IdGroupMember, IdGroup, Title, Text) VALUES (3, 3, 2, 'Family', 'Dinner will be ready in 30 minutes');
INSERT INTO PostInGroup (IdPostInGroup, IdGroupMember, IdGroup, Title, Text) VALUES (4, 2, 2, 'Family', 'Сlean the room we have guests today');
INSERT INTO PostInGroup (IdPostInGroup, IdGroupMember, IdGroup, Title, Text) VALUES (5, 1, 3, 'Music', 'MusicXXX');

-- 2 SELECT statements that include at least two tables and contain a WHERE clause

--1
SELECT "User".FirstName, "User".LastName, "Group".GroupName
FROM "User"
JOIN GroupMember ON "User".IdUser = GroupMember.IdUser
JOIN "Group" ON GroupMember.IdGroup = "Group".IdGroup
WHERE "User".Gender = 'Female';
--2
SELECT Publication.Title, Publication.Text, "User".FirstName, "User".LastName
FROM Publication
JOIN "User" ON Publication.IdUser = "User".IdUser
JOIN ListOfBlockedUser ON Publication.IdUser = ListOfBlockedUser.IdUser
WHERE ListOfBlockedUser.IdBlockedUser = 1;

--2 SELECT statements with aggregate functions 

--1 
SELECT IdPublication, AVG(Rating) as AvgRating
FROM "Comment"
GROUP BY IdPublication;
--2 
SELECT i.Title, COUNT(*) as NumUsers
FROM Interests i
JOIN UserInterests ui ON i.IdInterests = ui.IdInterests
GROUP BY i.Title;

--2 SELECT statements with subquery

--1 
SELECT
    "User".FirstName,
    "User".LastName,
    (SELECT COUNT(*) FROM Publication WHERE Publication.IdUser = "User".IdUser) AS PublicationCount
FROM
    "User";
--2 
SELECT
    "User".FirstName,
    "User".LastName,
    (SELECT AVG("Comment".Rating) FROM "Comment" WHERE "Comment".IdUser = "User".IdUser) AS AvgRating
FROM
    "User";

-- 1 SELECT statement with correlated subquery
SELECT a.FirstName, a.LastName, a.DateOfEmployment
FROM Admin a
WHERE NOT EXISTS (
    SELECT 1
    FROM "Group" g
    WHERE g.IdCreator = a.IdAdmin
);

--DML Instructions:

-- 1 UPDATE with correlated subquery
select*from GroupMember;

UPDATE GroupMember
SET Status = 'Member'
WHERE IdUser IN (
    SELECT IdUser
    FROM "User"
    WHERE IdUser NOT IN (
        SELECT IdCreator
        FROM "Group"
    )
);

-- 1 DELETE with subquery 
DELETE FROM "Comment"
WHERE IdUser IN (
    SELECT IdUser FROM "User"
    WHERE FirstName = 'Noah' AND LastName = 'Johnson'
);


---------------------------------------------------------------------------------------------------------
select * from "Comment";
INSERT INTO "Comment" (IdPublication, IdUser, "Comment", Rating) VALUES (1, 2, 'You are a loser!', 2);
INSERT INTO "Comment" (IdPublication, IdUser, "Comment", Rating) VALUES (2, 2, 'Cute!', 6);

UPDATE "Comment"
SET "Comment" = 'You are not a loser!', Rating = 5
WHERE IdPublication = 1 AND IdUser = 2;
