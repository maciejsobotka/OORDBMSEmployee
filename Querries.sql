def x = 3;
select a.city, count(a.person) from address a where DEREF(a.person) is of type(employee_typ) group by a.city having count(a.person) >= &x;

def x = 2400;
def y = 6000;
select avg(e.salary), e.address.city from employee e group by e.address.city having avg(e.salary) >= &x and avg(e.salary) <= &y;

def x = 10;
-- Select projects longer than x
--select sum(months_between(DEREF(pp.COLUMN_VALUE).enddate,DEREF(pp.COLUMN_VALUE).startdate)), count(DEREF(pp.COLUMN_VALUE)), p.project_id from project p, table(p.tasks) pp group by p.project_id
--having sum(months_between(DEREF(pp.COLUMN_VALUE).enddate,DEREF(pp.COLUMN_VALUE).startdate)) > &x;
select count(DEREF(e.COLUMN_VALUE)) as count, avg(DEREF(e.COLUMN_VALUE).salary) as avg_salary, p.project_id
from project p, table(p.employees) e
where p.project_id in (
select p.project_id from project p, table(p.tasks) pp group by p.project_id
having sum(months_between(DEREF(pp.COLUMN_VALUE).enddate,DEREF(pp.COLUMN_VALUE).startdate)) > &x)
group by p.project_id;
