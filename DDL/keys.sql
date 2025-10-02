-- primary key
-- unique
-- not null
-- auto index

drop table users;

create table users (
    id serial primary key
);

-- foreign key
-- perhaps null
-- link to other table

create table product (
    id serial primary key,
    name varchar(100),
    description text
);

create table orders (
    id serial primary key,
    user_id int references users(id),
    product_id int references product(id)
);

-- composite key

create table student_grades (
    student_id int,
    course_id int,
    grade varchar(2),
    primary key (student_id, course_id)
);