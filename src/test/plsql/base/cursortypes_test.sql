
/*
 * Курсор — получаемый при выполнении запроса результирующий набор записей плюс привязанный к нему указатель текущей записи.
 *
 * Курсоры:
 * - Явные (объявляются разработчиком)
 * - Неявные (не требуют объявления, управляются автоматически)
 *
 * Состояние курсора — атрибуты:
 * - %ISOPEN
 * - %FOUND
 * - %NOTFOUND
 * - %ROWCOUNT
 */

/*
 * Организация работы с явным курсором
 */
DO $BODY$
  DECLARE
    CURSOR курсор IS
      SELECT поле1, поле2
        FROM таблица
        WHERE условия_отбора; -- Объявление курсора
    переменная1 таблица.поле1%TYPE;
    переменная2 таблица.поле2%TYPE;
  BEGIN
    OPEN курсор; -- Открытие курсора
    LOOP -- Цикл по найденным записям
      FETCH курсор INTO переменная1, переменная2; -- Получение данных текущей записи
      EXIT WHEN курсор%NOTFOUND; -- Записи в курсоре закончились - выход из цикла
      -- Дальнейшие действия с переменными
    END LOOP;
    CLOSE курсор; -- Закрыть курсор
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Использование типа REF CURSOR
 */
DO $BODY$
  DECLARE
    TYPE тип_курсора IS REF CURSOR; -- Объявление типа-указателя
    курсор тип_курсора; -- Объявление переменной курсора
  BEGIN
    OPEN курсор FOR
        SELECT поле1, поле2
          FROM таблица
          WHERE условия_отбора;
    LOOP
      -- Цикл по найденным записям
    END LOOP;
    CLOSE курсор;
  END;
$BODY$ LANGUAGE plpgsql;
