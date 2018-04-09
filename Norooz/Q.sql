-- P11
select * from customer where (select count(c_id) from borrow,branch where borrow.c_id = customer.c_id and amount > 1000 and branch.b_id = borrow.b_id and branch.b_name = "amirkabir") = 3;
