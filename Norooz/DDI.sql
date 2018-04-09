CREATE TABLE customer(c_id char(4) PRIMARY KEY,
	c_name varchar(20),
	c_city varchar(20),
	c_street varchar(20));

CREATE TABLE branch(b_id char(4) PRIMARY key,
	b_name varchar(20),
	b_city varchar(20));

CREATE TABLE deposit(c_id char(4),
	b_id char(4),
	a_id char(4) PRIMARY KEY,
	balance numeric(7,0),
	time_st date,
	FOREIGN key(c_id) REFERENCES customer(c_id),
	FOREIGN key(b_id) REFERENCES branch(b_id));

CREATE TABLE transfer(dest_id char(4),
	source_id char(4),
	amount numeric(7,0),
	time_st date,
	PRIMARY KEY(source_id, time_st),
	FOREIGN KEY(dest_id) REFERENCES deposit(a_id),
	FOREIGN KEY(source_id) REFERENCES deposit(a_id));

CREATE TABLE transactions(a_id char(4),
	type char(1),
	amount numeric(7,0),
	time_st date,
	PRIMARY KEY(a_id, time_st),
	FOREIGN KEY(a_id) REFERENCES deposit(a_id));

CREATE TABLE borrow(c_id char(4),
	b_id char(4),
	l_id char(4)PRIMARY KEY,
	amount numeric(7,0),
	FOREIGN KEY(c_id) REFERENCES customer(c_id),
	FOREIGN KEY(b_id) REFERENCES branch(b_id));
