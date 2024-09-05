/* Find a list of order IDs where either gloss_qty or poster_qty is greater than 4000. 
Only include the id field in the resulting table. */

select id
from orders 
where gloss_qty > 4000 or poster_qty > 4000;


/* Write a query that returns a list of orders where the standard_qty is zero 
and either the gloss_qty or poster_qty is over 1000. */

select id, 
	standard_qty, 
	gloss_qty, 
	poster_qty
from orders
where standard_qty = 0 and gloss_qty > 1000 or poster_qty> 1000;


/* Find all the company names that start with a 'C' or 'W', 
and where the primary contact contains 'ana' or 'Ana', but does not contain 'eana'. */

select name, 
	primary_poc
from accounts
where (name LIKE 'C%' OR name LIKE 'W%')
	and primary_poc ILIKE '%ana%'
	and primary_poc NOT ILIKE '%eana%';

/* Provide a table that shows the region for each sales rep along
with their associated accounts. Your final table should include three columns: 
the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) by account name. */

select distinct r.name 
	region_name, 
	s.name sale_rep_name, 
	a.name account_name
from region r
inner join sales_reps s
	on r.id = s.region_id
inner join accounts a
	on s.id = a.sales_rep_id
order by account_name;
