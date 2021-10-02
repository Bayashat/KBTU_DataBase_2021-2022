select dept_name, avg(salary), count(*)
from instructor
group by dept_name
order by avg(salary) asc;


select building, count(*)
from department,
     course
where department.dept_name = course.dept_name
group by building
having count(*) =
       (select max(course_count)
        from (
                 select count(*) as course_count
                 from department,
                      course
                 where department.dept_name = course.dept_name
                 group by building
             ) as t
       );


select department.dept_name, count(*)
from department,
     course
where department.dept_name = course.dept_name
group by department.dept_name
having count(*) =
       (select min(course_count)
        from (
                 select count(*) as course_count
                 from department,
                      course
                 where department.dept_name = course.dept_name
                 group by department.dept_name
             ) as t
       );


select student.name, takes.id, count(takes.course_id)
from course,
     takes,
     student
where takes.course_id = course.course_id
  and takes.id = student.id
  and course.dept_name = 'Comp. Sci.'
group by student.name, takes.id
having count(takes.course_id) > 3;

select *
from instructor
where dept_name = 'Biology'
   or dept_name = 'Philosophy'
   or dept_name = 'Music';

select instructor.id, instructor.name, instructor.dept_name
from instructor,
     teaches
where instructor.id = teaches.id
  and instructor.name not in (
    select instructor.name
    from instructor,
         teaches
    where instructor.id = teaches.id
      and teaches.year = 2017
);