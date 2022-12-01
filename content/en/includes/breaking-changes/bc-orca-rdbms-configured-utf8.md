### Orca requires RDBMS configured with UTF-8 encoding

This release includes a change from MySQL JDBC drivers to AWS drivers. We have seen this cause issues when the database is NOT in a utf8mb4 format.
