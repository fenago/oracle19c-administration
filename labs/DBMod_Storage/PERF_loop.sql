SELECT /*+ monitor USE_NL(d l pi i) 
                FULL(d) FULL(l) FULL(pi) FULL(i) */
            l.order_id, SUM(unit_price * quantity) amount
     FROM   odr.orders d , odr.order_items l,          
            odr.product_information pi, odr.inventories i
     WHERE  d.order_id = l.order_id
     AND    pi.product_id = l.product_id
     AND    pi.product_id = i.product_id      
     AND    d.order_date < to_DATE('10-12-2021','DD-MM-YYYY') 
     AND    d.order_total  BETWEEN 1394  AND 100000
     AND    l.quantity between 10 AND 300
     AND    pi.min_price between 100 and 500
     AND    i.QUANTITY_ON_HAND > 100
     GROUP BY l.order_id; 
