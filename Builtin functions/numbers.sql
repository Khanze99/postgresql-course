-- числовые функции

-- round

select products.price,
       round(products.price) as rounded,
       round(products.price, 1) as rounded_1_dec
from products;


-- ceil - окр верх, floor - окр вниз, trunc - отбрасывает дробную часть

select
    products.price,
    ceil(products.price) as rounded_up,
    floor(products.price) as rounded_down,
    trunc(products.price) as truncated
from products;

-- abs - модуль числа, sign - -1, 0, 1

select products.price, abs(products.price) as absolute, sign(products.price) as signed from products;

-- power - квадрат, sqrt - квадратный корень, ln - натуральный логарифм

select products.price, power(products.price, 2) as squared, sqrt(products.price) as square_root, ln(products.price) as log
from products;


-- mod, div

select products.price, mod(products.price, 10), div(products.price, 10) from products;
