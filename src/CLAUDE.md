# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a CodeIgniter 4 web application running in a Docker environment with PHP 8.3, Nginx, and MySQL 8.0.

## Essential Commands

### Development

```bash
# Start the Docker environment
docker-compose up -d

# Stop the Docker environment
docker-compose down

# View container logs
docker-compose logs -f app
docker-compose logs -f webserver
docker-compose logs -f db

# Execute commands in the PHP container
docker-compose exec app php spark <command>

# Run database migrations
docker-compose exec app php spark migrate

# Clear cache
docker-compose exec app php spark cache:clear
```

### Testing

```bash
# Run all tests
docker-compose exec app composer test

# Run specific test file
docker-compose exec app vendor/bin/phpunit tests/unit/ExampleTest.php

# Run tests with coverage
docker-compose exec app vendor/bin/phpunit --coverage-html build/coverage
```

### Build & Dependencies

```bash
# Install/update PHP dependencies
docker-compose exec app composer install
docker-compose exec app composer update

# Switch between stable and development versions
docker-compose exec app ./builds development
docker-compose exec app ./builds release
```

## Architecture

### Directory Structure
- `/app/` - Core application code (MVC components)
  - `Controllers/` - Request handlers
  - `Models/` - Data models
  - `Views/` - View templates
  - `Config/` - Application configuration
- `/public/` - Web root (only publicly accessible directory)
- `/tests/` - Unit and integration tests
- `/writable/` - Runtime files (cache, logs, sessions, uploads)
- `/vendor/` - Composer dependencies

### Key Entry Points
- Web requests: `/public/index.php`
- CLI commands: `/spark`

### Configuration
- Environment variables: `.env` (database, app settings)
- Docker setup: `docker-compose.yml`
- PHP dependencies: `composer.json`
- Web server: `/docker/nginx/conf.d/app.conf`

### Database
- Default connection: MySQL on `db` host, `webapp` database
- Test database: SQLite in-memory (configured in `phpunit.xml`)
- Migrations: `/app/Database/Migrations/`

### Routes
Routes are defined in `/app/Config/Routes.php`. Currently only the home route is configured.

## Development Notes

1. The application runs on HTTPS (https://localhost) with self-signed certificates
2. File changes are reflected immediately due to volume mounts
3. Writable directories must maintain proper permissions for www-data user
4. Use `php spark` command for CodeIgniter CLI operations (migrations, caching, etc.)
5. Test database uses SQLite for isolation - production uses MySQL