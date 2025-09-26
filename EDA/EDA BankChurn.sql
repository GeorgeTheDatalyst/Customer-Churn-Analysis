select*
from bank_churn
where customer_id is null;

select distinct country
from bank_churn;

select distinct gender
from bank_churn;

Select DISTINCT gender
from bank_churn
WHERE tenure is null;

select*
from bank_churn
where tenure is null;

select *
from bank_churn
where balance is null;

select*
from bank_churn
where product_number is null;

select*
from bank_churn
where credit_card is null;

select*
from bank_churn
where active_member is null;

select*
from bank_churn
where estimated_salary is null;

select*
from bank_churn
where churn is null;

---------------------------
-- > Age exploration
---------------------------
select max(age) as highest_age,min(age) as min_age,MAX(age) - MIN(age )as age_range
from bank_churn;

SELECT DISTINCT product_number
FROM bank_churn
ORDER BY 1;

select MAX(balance), MIN(balance)
from bank_churn;