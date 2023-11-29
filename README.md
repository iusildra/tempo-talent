# Tempo-talent

## What is this?

This is a simple project (still in WIP though) that aims to help people find a temporary job in an easy way. It's a web application that helps recruiters and candidates to find each other, by a (non implemented yet) matching algorithm.

## How to run it?

### Requirements

- Docker
- Docker-compose
- JRE 17

### Running

1. Clone this repository
2. Clone submodules `git submodule update --init --recursive`
3. Go into `modules/tempo-talent-api`
4. Run `docker compose up --build`

The API should be available at `http://localhost:8080`

## Documentation

### Stack

- GraphQL for Java
- Spring Boot
- PostgreSQL
- Docker
- Docker-compose
- React Native
- Expo
- Typescript
- Redux (maybe)

### Endpoints

| Endpoint     | Description | Queries & Mutation definition               |
| ------------ | ----------- | ------------------------------------------- |
| `/recruiter` | Recruiter   | `tempo-talent-recruiter/**/schema.graphqls` |
| `/job`       | Job offer   | `tempo-talent-job/**/schema.graphqls`       |
| `/candidate` | Candidate   | `tempo-talent-candidate/**/schema.graphqls` |

The recruiter and candidate MS are organized by domains, so for the domain `XXX` you can find the relevant files in `modules/tempo-talent-api/tempo-talent-recruiter/src/main/java/com/tempotalent/api/XXX`

The database schema are located in the `**/sql` folders, with a binding to the corresponding database container in the `docker-compose.yml` file, to be able to load the data at creation.

### Adding a new endpoint

1. Create a submodule in `modules/tempo-talent-api` with the name of the domain
2. Customize the endpoint in the `application.yml` file
3. Create a `schema.graphqls` file in `modules/tempo-talent-api/tempo-talent-<domain>/src/main/resources/graphql`
4. Add the `docker-compose.yml` and `Dockerfile` files in the new module
5. Add the new module in the api's `docker-compose.yml` file
