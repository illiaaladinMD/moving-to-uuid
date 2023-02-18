# Moving to UUID in existing Rails application

Hi! This is an example project for the article about the migration from numeric IDs to UUIDs in existing Rails application. It does not have any user features and is focused on the migration process, you can play with the project to follow the migration process in detail though.

## Setup

To setup the project you have to clone the repository and have Docker installed on you machine.
Then run:
1. `docker-compose build`
2. `docker-compose run web rails db:create db:migrate`

Thats it! If setup was successful let`s consider the way you can discover the migration process step by step.

## Steps to discover the migration process

1. Make sure that you in the **main** branch.
2. Run `docker-compose up` and navigate to `localhost:3000` in your browser.
3. Press **Generate test data** button.
4. If test data was generated successfully (flash message will appear) - check your database in the preferred DB manager. You'll see how database looks like now (with numeric IDs)
5. Navigate to **migration-to-uuid** branch and check new migrations in **db/migrate** folder.
6. Run `docker-compose run web rails db:migrate` and check your database in the DB manager one more time. You'll notice how it changed after migration to UUIDs.
