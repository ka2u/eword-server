create database eword;
use eword;

create table user (
       id int unsigned not null auto_increment primary key,
       mail varchar(255) not null
);

create table word (
       id int unsigned not null auto_increment primary key,
       user_id int unsigned not null,
       word varchar(255) not null,
       definition text not null,
       priority int unsigned
);
       
