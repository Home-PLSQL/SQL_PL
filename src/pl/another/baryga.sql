/*
 * http://www.securitylab.ru/forum/forum28/topic44944/
 *
 * 1. Написать процедуру, которая получает на вход номер производителя и цену, и для товаров заданного производителя, которые дороже заданной цены, в поле DESCTIPTION записывает "Дорогой товар", а для остальных его товаров-"Дешёвый товар".
 * 2. Написать функцию с курсором, которая получает на вход цену и возвращает список производителей, которые производят товары дороже заданной цены через запятую.
 */

CREATE OR REPLACE FUNCTION BARYGA(OURPRICE IN NUM) RETURN VARCHAR2
IS

declare

res varchar2 := '';

cursor c_f is
    select PRODUCTS.PRICE, MANUFACTURERS.MFR
      from PRODUCTS, MANUFACTURERS
     where PRODUCTS.MFR_ID = MANUFACTURERS.MFR_ID;
    v_a PRODUCTS.PRICE%type;
    v_b MANUFACTURERS.MFR%type;


BEGIN

open c_f;
  loop
    fetch c_f into v_a, v_b;
    exit when c_f%notfound;
    if ourprice > v_a then res := res + v_b + ', ';
    else res := res;

  end loop;

  close c_f;
  return (res);

END BARYGA;