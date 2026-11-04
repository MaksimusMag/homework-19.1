-- Запрос 1: Компания заказчика и ФИО сотрудника, оба в London, доставка United Package
SELECT
    c.company_name AS "Название компании",
    CONCAT(e.first_name, ' ', e.last_name) AS "ФИО сотрудника"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN employees e ON o.employee_id = e.employee_id
JOIN shippers s ON o.ship_via = s.shipper_id
WHERE c.city = 'London'
  AND e.city = 'London'
  AND s.company_name = 'United Package';

-- Запрос 2: Продукты не снятые с продажи, <25 шт, категории Dairy Products и Condiments
SELECT
    p.product_name AS "Наименование продукта",
    p.units_in_stock AS "Количество товара",
    s.contact_name AS "Имя поставщика",
    s.phone AS "Телефон поставщика"
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
JOIN categories c ON p.category_id = c.category_id
WHERE p.discontinued = 0
  AND p.units_in_stock < 25
  AND c.category_name IN ('Dairy Products', 'Condiments')
ORDER BY p.units_in_stock ASC;

-- Запрос 3: Компании заказчики, не сделавшие ни одного заказа
SELECT
    c.company_name AS "Название компании"
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Запрос 4: Уникальные продукты, заказанные ровно 10 единиц (с подзапросом)
SELECT DISTINCT p.product_name AS "Название продукта"
FROM products p
WHERE p.product_id IN (
    SELECT od.product_id
    FROM order_details od
    WHERE od.quantity = 10
);
