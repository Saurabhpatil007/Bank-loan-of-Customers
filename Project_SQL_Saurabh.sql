SET SQL_SAFE_UPDATES =0;

CREATE DATABASE Project_Saurabh;

SELECT * FROM project_saurabh.finance1;
SELECT * FROM project_saurabh.finance_2csv;

SELECT YEAR, SUM(loan_amnt) FROM finance1 by YEAR order by YEAR;

/* KPI_1 :- Year wise loan amount Stats*/

select YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) as year, sum(loan_amnt) as Total_Loan_amnt 
from finance1 
group by YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y'));

/* KPI_2 :- Grade and sub grade wise revol_bal */

select grade, sub_grade,sum(revol_bal) as Total_revol_bal
from finance1 inner join finance_2csv
on(finance1.id = finance_2csv.id) 
group by grade,sub_grade
order by grade;

/* KPI_3 :- Total Payment for Verified Status Vs Total Payment for Non Verified Status */

select verification_status, round(sum(total_pymnt),2) as Total_payment
from finance1 inner join finance_2csv 
on(finance1.id = finance_2csv.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;

/* KPI_4 :- State wise and last_credit_pull_d wise loan status - Final */

select addr_state as States, MAX(DATE_FORMAT(STR_TO_DATE(last_credit_pull_d, '%b-%y'),'%Y-%m')) ,loan_status
from finance1 inner join finance_2csv 
on(finance1.id = finance_2csv.id) 
group by addr_state, DATE_FORMAT(STR_TO_DATE(last_credit_pull_d, '%b-%y'),'%Y')
order by addr_state;

/* KPI_5 :- Home ownership Vs last payment date stats */

select home_ownership
,MAX(DATE_FORMAT(STR_TO_DATE(last_pymnt_d, '%b-%y'),'%Y-%m'))
from finance1 inner join finance_2csv 
on(finance1.id = finance_2csv.id) 
group by home_ownership #, DATE_FORMAT(STR_TO_DATE(last_pymnt_d, '%b-%y'),'%Y')
order by home_ownership;
