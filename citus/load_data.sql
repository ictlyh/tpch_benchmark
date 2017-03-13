\timing on

TRUNCATE TABLE part;
TRUNCATE TABLE region;
TRUNCATE TABLE nation;
TRUNCATE TABLE supplier;
TRUNCATE TABLE customer;
TRUNCATE TABLE partsupp;
TRUNCATE TABLE orders;
TRUNCATE TABLE lineitem;

COPY part FROM '/tmp/dss-data/part.csv' WITH (FORMAT csv, DELIMITER '|');
COPY region FROM '/tmp/dss-data/region.csv' WITH (FORMAT csv, DELIMITER '|');
COPY nation FROM '/tmp/dss-data/nation.csv' WITH (FORMAT csv, DELIMITER '|');
COPY supplier FROM '/tmp/dss-data/supplier.csv' WITH (FORMAT csv, DELIMITER '|');
COPY customer FROM '/tmp/dss-data/customer.csv' WITH (FORMAT csv, DELIMITER '|');
COPY partsupp FROM '/tmp/dss-data/partsupp.csv' WITH (FORMAT csv, DELIMITER '|');
COPY orders FROM '/tmp/dss-data/orders.csv' WITH (FORMAT csv, DELIMITER '|');
COPY lineitem FROM '/tmp/dss-data/lineitem.csv' WITH (FORMAT csv, DELIMITER '|');
