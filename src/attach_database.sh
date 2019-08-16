SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"
# users.db
sqlite3 ./users.db \
"create table users(id integer primary key, name text, items, text);" \
"insert into users(name, items) values('Yamada', '[1,2]');" \
"insert into users(name, items) values('Suzuki', '[1]');"
# items.db
sqlite3 ./items.db \
"create table items(id integer primary key, name text);" \
"insert into items(name) values('AAA');" \
"insert into items(name) values('BBB');"
# 異なるDBを結合
sqlite3 :memory: \
"attach database 'file:./users.db' as U;" \
"attach database 'file:./items.db' as I;" \
"select name from (select value from json_each((select items from U.users where name='Yamada'))) as yamada_item_ids left join I.items on yamada_item_ids.value=I.items.id;"

