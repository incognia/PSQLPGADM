## PostgreSQL and pgAdmin
This example provides a base setup for using [PostgreSQL](https://www.postgresql.org/) and [pgAdmin](https://www.pgadmin.org/).
More details on how to customize the installation and the compose file can be found [here (PostgreSQL)](https://hub.docker.com/_/postgres) and [here (pgAdmin)](https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html).

Project structure:
```
PSQLPGADM//
├── clean.sh*
├── compose.yaml
├── docker-entrypoint.sh*
├── Dockerfile
├── LICENSE
└── README.md
```

[_compose.yaml_](compose.yaml)
``` yaml
services:
  psql01:
    container_name: PostgreSQL_01
    hostname: psql01
    build:
      context: .
      dockerfile: Dockerfile
    image: cdmx.fondeso/postgres:0.0.1-bookworm-slim
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PW}
      - POSTGRES_DB=${POSTGRES_DB} #optional (specify default database instead of $POSTGRES_DB)
    ports:
      - "10022:22"
      - "15432:5432"
    restart: always
    volumes:
      - psql01_data:/var/lib/postgresql/data

  psql02:
    container_name: PostgreSQL_02
    hostname: psql02
    image: cdmx.fondeso/postgres:0.0.1-bookworm-slim
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PW}
      - POSTGRES_DB=${POSTGRES_DB} #optional (specify default database instead of $POSTGRES_DB)
    ports:
      - "20022:22"
      - "25432:5432"
    restart: always
    volumes:
      - psql02_data:/var/lib/postgresql/data

  psql03:
    container_name: PostgreSQL_03
    hostname: psql03
    image: cdmx.fondeso/postgres:0.0.1-bookworm-slim
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PW}
      - POSTGRES_DB=${POSTGRES_DB} #optional (specify default database instead of $POSTGRES_DB)
    ports:
      - "30022:22"
      - "35432:5432"
    restart: always
    volumes:
      - psql03_data:/var/lib/postgresql/data

  psql04:
    container_name: PostgreSQL_04
    hostname: psql04
    image: cdmx.fondeso/postgres:0.0.1-bookworm-slim
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PW}
      - POSTGRES_DB=${POSTGRES_DB} #optional (specify default database instead of $POSTGRES_DB)
    ports:
      - "40022:22"
      - "45432:5432"
    restart: always
    volumes:
      - psql04_data:/var/lib/postgresql/data

  pgadmin:
    container_name: pgAdmin
    hostname: pgadmin
    image: dpage/pgadmin4:latest
    environment:
      - PGADMIN_DEFAULT_EMAIL=${PGADMIN_MAIL}
      - PGADMIN_DEFAULT_PASSWORD=${PGADMIN_PW}
    ports:
      - "8080:80"
    restart: always
volumes:
  psql01_data:
  psql02_data:
  psql03_data:
  psql04_data:
```

## Configuration

### .env
Before deploying this setup, you need to configure the following values in the [.env](.env) file.
- POSTGRES_USER
- POSTGRES_PW
- POSTGRES_DB (can be default value)
- PGADMIN_MAIL
- PGADMIN_PW

## Deploy with docker compose
When deploying this setup, the pgAdmin web interface will be available at port 8080 (e.g. http://docker.fondeso.mx:8080).  

``` shell
$ docker compose up
Starting postgres ... done
Starting pgadmin ... done
```

## Add postgres database to pgAdmin
After logging in with your credentials of the .env file, you can add your database to pgAdmin. 
1. Right-click "Servers" in the top-left corner and select "Create" -> "Server..."
2. Name your connection
3. Change to the "Connection" tab and add the connection details:
- Hostname: "postgres" (this would normally be your IP address of the postgres database - however, docker can resolve this container ip by its name)
- Port: "5432"
- Maintenance Database: $POSTGRES_DB (see .env)
- Username: $POSTGRES_USER (see .env)
- Password: $POSTGRES_PW (see .env)
  
## Expected result

Check containers are running:
```
$ docker ps
CONTAINER ID   IMAGE                                       COMMAND                  CREATED         STATUS         PORTS                                                                                  NAMES
301ca7c902a3   cdmx.fondeso/postgres:0.0.1-bookworm-slim   "docker-entrypoint.s…"   9 minutes ago   Up 9 minutes   0.0.0.0:10022->22/tcp, :::10022->22/tcp, 0.0.0.0:15432->5432/tcp, :::15432->5432/tcp   PostgreSQL_01
3defcf38febe   cdmx.fondeso/postgres:0.0.1-bookworm-slim   "docker-entrypoint.s…"   9 minutes ago   Up 9 minutes   0.0.0.0:20022->22/tcp, :::20022->22/tcp, 0.0.0.0:25432->5432/tcp, :::25432->5432/tcp   PostgreSQL_02
e9e727bc4e7c   cdmx.fondeso/postgres:0.0.1-bookworm-slim   "docker-entrypoint.s…"   9 minutes ago   Up 9 minutes   0.0.0.0:30022->22/tcp, :::30022->22/tcp, 0.0.0.0:35432->5432/tcp, :::35432->5432/tcp   PostgreSQL_03
a6df4e9893ba   cdmx.fondeso/postgres:0.0.1-bookworm-slim   "docker-entrypoint.s…"   9 minutes ago   Up 9 minutes   0.0.0.0:40022->22/tcp, :::40022->22/tcp, 0.0.0.0:45432->5432/tcp, :::45432->5432/tcp   PostgreSQL_04
ca277fa25dc6   dpage/pgadmin4:latest                       "/entrypoint.sh"         9 minutes ago   Up 9 minutes   443/tcp, 0.0.0.0:8080->80/tcp, :::8080->80/tcp                                         pgAdmin
```

Stop the containers with
``` shell
$ docker compose down
# To delete all data run:
$ docker compose down -v
```
