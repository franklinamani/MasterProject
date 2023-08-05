# CMPT 310 Laboratory 8

The purpose of this lab is to gain experience with advanced SQL queries, procedures and functions. Your task is to re-implement your solutions from labs 3 & 6 completely on the database, i.e. no PHP programming or data manipulation. In addition, you will implement one new web page 'Author Summary'.

## Cloning

Start your lab by cloning this repository:

```
$> git clone https://submit.cs.kingsu.ca/PATH/TO/YOUR/REPO.git
```

**Note**: The URL for your repo can be found at https://submit.cs.kingsu.ca.

## Starting

Before running the lab in `docker`, change the MySQL password in the **docker-compose.yml** file as shown below.

```
# YOU NEED TO SET THIS PASSWORD (you can use pwgen)
- MYSQL_PASSWORD=REPLACE_ME
```

and place the same MySQL password in the **credentials.php** file as shown below.

```
// YOU NEED TO SET THIS PASSWORD (you can use pwgen)
// THIS MUST MATCH THE PASSWORD IN THE docker-compose.yml FILE
$password = "NEW_MYSQL_PASSWORD";
```

You can use `pwgen` to generate a single secure 16 characters long random password:

```
$> pwgen -s -n 16 16
```

### Starting `Docker`

```
$> docker-compose up -d
```

### Configure Your MySQL Environment

Configure your MySQL environment to store your login credentials:

```
$> mysql_config_editor set --login-path=Lab8 --host=127.0.0.1 --user=cmpt310 --password
```

and enter your password.

To execute the **lab8.sql** file on the database, enter the following command:

```
$> mysql --login-path=Lab8 Lab8 < src/sql/lab8.sql
```

**Note:** The path you put in is relative to where you are in the the Laboratory8 directory. Each time you want to see a change in your work you will need to use the above command.

Open your web browser to:

[http://localhost:8080](http://localhost:8080)

### Submission

Only submit your `lab8.sql` file

```
$> git add src/sql/lab8.sql
$> git commit -m "Lab 8 Submission"
$> git push
```

### Helpful Hints

You can create additional tables and/or views to support your procedures.

Useful SQL Functions/Statements

- CONCAT
- COUNT
- AVG
- CASE
- IF
- IFNULL
- TRUNCATE
- SET
- DECLARE
- WHILE
