-- 1
SELECT DISTINCT c_name 
FROM customer , deposit
WHERE customer.c_id = deposit.c_id;
		
-- 2
SELECT DISTINCT c_name 
FROM customer , borrow 
WHERE customer.c_id NOT IN(SELECT c_id
                              FROM borrow); 

-- 3
SELECT DISTINCT c_name 
FROM customer, deposit
WHERE customer.c_id = deposit.c_id AND balance > 1000 AND 
					deposit.b_id = (SELECT b_id 
                           FROM branch 
                           WHERE b_name = 'valiasr');	

-- 4
SELECT DISTINCT c_name
FROM customer,deposit
WHERE customer.c_id = deposit.c_id 
					AND b_id = (SELECT b_id
                                FROM branch
                                WHERE b_name = 'valiasr')
                    AND customer.c_id NOT IN (SELECT c_id
                                     FROM borrow);            

-- 5
SELECT DISTINCT c_street 
FROM customer,(SELECT c_id AS c1, SUM(balance) AS sum_balance
              FROM deposit GROUP BY c_id) AS sum_deposit
WHERE c_id = c1 
	  AND sum_balance < 10 
	  AND c_id IN(SELECT c_id
                  FROM borrow);

-- 6
SELECT c_name 
FROM customer 
WHERE c_city = (SELECT c_city
                FROM customer 
                WHERE c_id = '0003')
      AND c_street = (SELECT c_street
                FROM customer 
                WHERE c_id = '0003');

-- 7
SELECT l_id
FROM borrow
WHERE c_id = (SELECT c_id
              FROM customer 
              WHERE c_city = 'tehran' AND customer.c_id = borrow.c_id);

-- 8
SELECT COUNT(l_id)
FROM borrow
WHERE b_id = (SELECT b_id
              FROM branch
              WHERE b_city = 'shiraz' AND branch.b_id = borrow.b_id);

-- 9
SELECT DISTINCT c_city
FROM customer 
WHERE c_id IN (SELECT c_id
               FROM borrow
               WHERE b_id = (SELECT b_id
                             FROM branch 
                             WHERE branch.b_id = borrow.b_id
                             	   AND branch.b_name = 'hafez'))
      AND EXISTS (SELECT *
                  FROM deposit 
                  WHERE deposit.c_id = customer.c_id 
                 		AND b_id = (SELECT b_id
                                    FROM branch 
                                    WHERE branch.b_id = deposit.b_id
                                   		  AND branch.b_name = 'valiasr'	)); 

-- 10
SELECT sum_balance1 
FROM(SELECT b_id AS b_id1 , SUM(balance) AS sum_balance1
	 FROM deposit GROUP BY b_id) AS sum_deposit1
WHERE b_id1 = (SELECT b_id
                           FROM branch
                           WHERE b_name = 'valiasr');     

-- 11
SELECT * FROM customer WHERE
	(SELECT COUNT(c_id) FROM borrow,branch WHERE customer.c_id = borrow.c_id AND borrow.b_id = branch.b_id AND branch.b_name = "amirkabir" AND borrow.amount > 100000) = 3 AND
	(SELECT sum(balance) FROM branch, deposit WHERE customer.c_id = deposit.c_id AND deposit.b_id = branch.b_id AND branch.b_name = "amirkabir") BETWEEN 1000 AND 20000;

-- 12
SELECT amount
FROM borrow
WHERE c_id IN(SELECT c_id
			  FROM deposit AS d1,branch
			  WHERE d1.b_id = branch.b_id AND branch.b_name = 'hafez')
      AND c_id IN (SELECT c_id
			       FROM deposit AS d2,branch
			       WHERE d2.b_id = branch.b_id
                   AND branch.b_name = 'amirkabir');

-- 13
select customer.c_name, sum(transactions.amount) from customer, transactions where
    exists (select amount from transfer, deposit where dest_id = deposit.a_id and deposit.c_id = customer.c_id and source_id in (select a_id from deposit where deposit.c_id = '0004') and amount > 1000)
    and transactions.a_id in (select deposit.a_id from deposit where deposit.c_id = customer.c_id)
    group by customer.c_name;

-- 14
select customer.c_name from customer where
    (select count(distinct branch.b_name) from branch, deposit where deposit.c_id = '0004' and branch.b_id = deposit.b_id and branch.b_name in ('amirkabir', 'hafez', 'valiasr')) = 3 and
    (select avg(balance) from deposit where deposit.c_id = customer.c_id) < (select avg(balance) from deposit where deposit.c_id = '0003') and
    (select sum(amount) from borrow, branch where borrow.c_id = customer.c_name and branch.b_id = borrow.b_id and branch.b_name = 'valiasr') < (select sum(amount) from borrow, branch where borrow.c_id = '0002' and branch.b_id = borrow.b_id and branch.b_name = 'jordan');



-- 15
select branch.b_id, branch.b_name, customer.c_id, customer.c_name, (select count(deposit.c_id) from deposit where deposit.c_id = customer.c_id and deposit.b_id = branch.b_id group by deposit.c_id) from customer, branch, deposit where
    customer.c_id = deposit.c_id and
    branch.b_id = deposit.b_id and
    3 < (select count(deposit.c_id) from deposit where deposit.c_id = customer.c_id and deposit.b_id = branch.b_id group by deposit.c_id);

-- 16

-- 17

-- 18
SELECT a_id, type, amount, time_st
FROM transactions
WHERE transactions.a_id IN (SELECT dest_id
 							FROM transfer, deposit, customer
							WHERE source_id = deposit.a_id AND 									deposit.c_id = customer.c_id AND
                            c_name = 'sina') AND 
                            transactions.type = '1';

-- 19
select c_id from deposit group by deposit.c_id order by sum(balance) limit 10;

-- 20
SELECT SUM(amount)
FROM transfer
WHERE month(time_st) = 3;


-- 21
SELECT max(amount)
FROM transactions, deposit, branch
WHERE year(transactions.time_st) = 1376 
AND month(transactions.time_st) = 5 
AND day(transactions.time_st) = 5 
AND transactions.a_id = deposit.a_id 
AND deposit.b_id  = branch.b_id 
AND branch.b_city = 'karaj';


-- 22*
SELECT c_id
FROM transfer, deposit AS d1, deposit AS d2
WHERE d1.a_id = transfer.source_id 
AND transfer.amount = (SELECT max(amount)
					   FROM transfer as t, deposit AS d4								   WHERE t.dest_id =d4.a_id 
                       AND d4.a_id =(SELECT a_id
              						 FROM deposit AS d3, customer AS c4
             						 WHERE d3.c_id = c3.c_id 
                   					 AND c4.c_name = 'karim benzema')
AND transfer.dest_id =d2.a_id 
AND d2.a_id =(SELECT a_id
              FROM deposit AS d3, customer AS c3
              WHERE d3.c_id = c3.c_id 
                    AND c3.c_name = 'karim benzema');
////23*
SELECT c_name
FROM deposit, customer
WHERE datediff('13961215','00000000') >= datediff(time_st, '00000000')
AND customer.c_id = deposit.c_id
;


////24*
SELECT c_id
FROM transactions as t3, deposit, transactions as t4
WHERE t3.a_id = t4.a_id = deposit.a_id
 			AND datediff(t3.time_st, t4.time_st) 
            = (SELECT max(datediff(t1.time_st, t2.time_st)
               FROM transactions AS t1, transactions AS t2
               WHERE t2.a_id = t1.a_id);
				
////25*
SELECT b_city, sum_dep, sum_pick
FROM branch, deposit,(SELECT a_id, SUM(amount)AS sum_dep
                      FROM transactions GROUP by a_id
                      WHERE transactions.type = '1') AS t1
                      ,(SELECT a_id, SUM(amount)AS sum_pick
                     	FROM transactions GROUP by a_id
                        WHERE transactions.type = '0') AS t2
WHERE branch.b_id = deposit.b_id 
	  AND deposit.a_id = t1.a_id = t2.a_id;

////26*
SELECT c_name
FROM customer, deposit
WHERE customer.c_id = deposit.c_id 
	  AND balance > (SELECT MAX(balance1)
                     FROM (SELECT balance AS balance1
                           FROM deposit
                           except(balance = max(balance)
                           ) AS dep
                     )
     AND balance < MAX(deposit.balance);
///27

////28*
SELECT b_name
FROM branch, deposit AS dep
WHERE branch.b_id = dep.b_id
	  AND ((SELECT SUM(balance)
      		FROM deposit GROUP BY b_id
     	    WHERE dep.b_id = deposit.b_id) > 
           (SELECT AVG(balance)
      		FROM deposit)); 
                             
		





