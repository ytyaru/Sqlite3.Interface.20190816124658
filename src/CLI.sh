SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"
# インメモリ
sqlite3 :memory: "create table T(A text);" "insert into T values('AAA');" "select * from T;"
# ファイル
sqlite3 ./lite.db "create table if not exists T(A text);" "insert into T values('AAA');" "select * from T;"
# 対話コマンド
sqlite3 :memory: ".headers on" ".mode column" "create table T(A text);" "insert into T values('AAA');" "select * from T;"
# 外部ファイル
sqlite3 :memory: < a.sql

