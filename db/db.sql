CREATE TABLE users
(
    id UUID NOT NULL DEFAULT uuid_generate_v4(),
    name TEXT ,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    createdAt timestamp(3) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pkey_tbl PRIMARY KEY (id)
);


CREATE TABLE notes
(
    id UUID NOT NULL DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    tag TEXT NOT NULL,
    createdAt timestamp(3) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT pkey_notes PRIMARY KEY (id)
);
-- INSERT INTO notes(title,description,tag,user_id) VALUES
select id from users where username='';
insert into notes(title,description,tag,user_id) values('THIS is new INDIA','Indian Desc','IN','d4f70e77-a08a-422c-88a4-9ed28925ff0e');