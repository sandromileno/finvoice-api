# This challenge was created using two dependencies

- [Postgres](https://hub.docker.com/_/postgres)
- [Redis](https://hub.docker.com/_/redis)

```yaml
version: "3.9"
services:
  invoice_db:
    image: "postgres"
    container_name: "invoice-postgres"
    environment:
      POSTGRES_USER: finvoice_app_user
      POSTGRES_PASSWORD: "Pa55w0rd"
      POSTGRES_DB: invoice_db
    ports:
      - "5432:5432"
  invoice_redis:
    image: "redis:6.2.1-alpine"
    container_name: "invoice-redis"
    ports:
      - "6379:6379"
  invoice_api:
    image: "finvoice-api:latest"
    container_name: "invoice-app"
    environment:
      DATABASE_USER: "finvoice_app_user"
      DATABASE_PASSWORD: "Pa55w0rd"
      DATABASE_HOST: "invoice_db"
      REDIS_URL: "redis://invoice_redis:6379/0/cache"
      RAILS_ENV: "development"
    ports:
      - "3000:3000"
    depends_on:
      - "invoice_db"
      - "invoice_redis"
```

Requirements
-----------
- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Postman](https://www.postman.com/)

Quick Start
-----------
All stack can be created only running `development/up_development_environemnt.sh`:
1. To create entire stack run `./development/up_development_environemnt.sh`(Attention: check if `.sh` has execution permission).
   - `chmod u+x up_development_environment.sh`
2. To destroy the stack just run `docker-compose down`.
3. Open postman and import collection file `finvoice_postman_collection.json` in the same folder as the file sh file.
4. Create four global variables in postman.
```javascript
host = localhost
port = 3000
// These variable has no value
jwt_token     
customer_id
invoice_id
```
Instructions
-----------
1. First of all we need to create a user, using `Sign Up` API.
2. Authenticate the user, using `Sign In` API.
3. Create a customer, using `Create Customer` API (A customer can be a company).
4. Create a invoice, using `Create Invoice` API.
5. After that you can explore the APIs.

Notes
-----------
- The endpoints that have financial operations have idempotency control, which can be used by passing the header: `Idempotency-key`, so you can retain the same operation avoiding duplication of information in the database.
- The application is using a real control of authentication and can be used with browser clients(cookies) and backend clients(JWT).
