DROP TABLE IF EXISTS coffeeorder;
CREATE TABLE coffeeorder
(
    order_id character varying(30), 
    order_date date,
    customer_id character varying(30) ,
    product_id character varying(30), 
    quantity integer,
    customer_name character varying(30), 
    email character varying(40), 
    country character varying(30), 
    coffee_type character varying(5),
    roast_type character varying(5),
    size numeric,
    unit_price numeric,
    sales numeric,
    coffee_typename character varying(15),
    roast_typename character varying(10)
);

