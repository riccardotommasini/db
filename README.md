# PostgreSQL Interview Environment

A complete PostgreSQL + pgAdmin setup for GitHub Codespaces, designed for database interview questions and testing.

## Quick Start

1. Open this repository in GitHub Codespaces
2. Wait for the containers to start (about 2-3 minutes)
3. Access pgAdmin at the forwarded port 5050
4. Login with: `admin@interview.com` / `admin123`
5. The database connection is pre-configured

## Database Details

- **Host**: db (the whole environment runs in docker) or localhost (external)
- **Port**: 5432
- **Database**: demodb
- **Username**: postgresuser
- **Password**: postgrespass

## Sample Schema

The database includes an e-commerce schema with:

- `customers` - Customer information
- `categories` - Product categories
- `products` - Product catalog
- `orders` - Customer orders
- `order_items` - Order line items
- `order_summary` - View for order analytics

## Sample Interview Questions

### Basic Queries
1. Find all customers from New York
2. List products with stock less than 50
3. Show all orders with their customer names

### Intermediate Queries
1. Calculate total revenue by category
2. Find customers who have never placed an order
3. Show the top 5 best-selling products

### Advanced Queries
1. Calculate running total of orders by date
2. Find customers with above-average order values
3. Create a report showing monthly sales trends

## Testing Your Queries

1. Open pgAdmin in the browser
2. Navigate to Servers > Interview Database > demodb
3. Use the Query Tool to run your SQL
4. View results in the data output panel

## Architecture Testing Topics

This setup tests knowledge of:
- Database normalization
- Primary/Foreign key relationships
- Indexing strategies
- View creation
- Query optimization
- Data modeling best practices
