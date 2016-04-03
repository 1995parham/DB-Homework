/*
 * In The Name Of God
 * ========================================
 * [] File Name : p.mysql
 *
 * [] Creation Date : 04-01-2016
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
/*
 * Copyright (c) 2016 Parham Alvani.
*/
create database company;
connect company;

create table Customer
(
	CustomerNumber int PRIMARY KEY,
	SocialSecurityNumber int,
	FirstName char(20),
	Surname char(20),
	Salutation char(5),
	PhoneNumber char(20)
);

create table StateLookup
(
	StateID int PRIMARY KEY,
	CountryID int,
	Name char(40),
	FOREIGN KEY (CountryID) REFERENCES CountryLookup(CountryID)
);

create table CountryLookup
(
	CountryID int PRIMARY KEY,
	Name char(40)
);

create table Address
(
	AddressID int PRIMARY KEY,
	Street char(40),
	City char(20),
	StateID int,
	CountryID int,
	ZipCode char(20),
	FOREIGN KEY (CountryID) REFERENCES CountryLookup(CountryID), FOREIGN KEY (StateID) REFERENCES StateLookup(StateID)
);

create table AddressUsageLookup
(
	AddressUsageCode int PRIMARY KEY,
	AddressUsageDescription char(40)
);

create table CustomerHasAddress
(
	CustomerNumber int,
	AddressID int,
	FOREIGN KEY (CustomerNumber) REFERENCES Customer(CustomerNumber),
	FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
	FOREIGN KEY (AddressUsageCode) REFERENCES AddressUsageLookup(AddressUsageCode),
	PRIMARY KEY (CustomerNumber, AddressID)
);

insert into Customer
(
	CustomerNumber , SocialSecurityNumber, FirstName,
	Surname,
	Salutation, PhoneNumber
)
values
(
	3 ,'0017784646', 'Parham', 'Alvani', '?', '+989390909540'
);
