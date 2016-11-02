
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
-- Прочие объекты БД (синонимы, представления)
-- Системные представления
-- Механизм заданий (jobs)

/*
 * Прочие объекты БД
 * - Синонимы
 */
DO $BODY$
  CREATE SYNONYM синоним FOR объект;
$BODY$ LANGUAGE plpgsql;


/*
 * Прочие объекты БД
 * - Представления
 *   -- Получение данных об объектах БД:
 *      all_objects — все объекты
 *      all_tables — таблицы
 *      all_tab_columns — колонки таблиц
 *      all_source — хранимый код PL/SQL
 *      all_triggers — триггеры
 *      all_synonyms — синонимы
 *      all_constraints — ограничения
 *      all_views — представления

 *   -- Префикс all: все доступные объекты

 *   -- Префикс user: все объекты в схеме данного пользователя
 *
 *   -- Представления all_jobs, user_jobs:
 *      THIS_DATE — дата/время старта выполняющегося в данный момент задания
 *      LAST_DATE — дата/время последнего успешного старта
 *      NEXT_DATE — дата/время следующего запланированного старта
 *      TOTAL_TIME — общее время работы задания
 *      FAILURES — количество стартов с ошибкой с момента последнего успешного
 */
DO $BODY$
  CREATE OR REPLACE VIEW имя
  AS запрос;
$BODY$ LANGUAGE plpgsql;


/*
 * Прочие объекты БД
 * - Последовательности
 */
DO $BODY$
  CREATE SEQUENCE имя INCREMENT BY шаг
  START WITH начальное_значение;
$BODY$ LANGUAGE plpgsql;


/*
 * Механизм заданий (jobs)
 * - Пакет DBMS_JOB
 * - Создание задания
 */
DO $BODY$
  DECLARE
      job1 NUMBER;
  BEGIN
      DBMS_JOB.submit(job1, 'PL/SQL тело задания', дата_старта, 'вычисление_след_старта');
      COMMIT;
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Механизм заданий (jobs)
 * - Принудительный запуск задания
 */
DO $BODY$
  BEGIN
    DBMS_JOB.run(номер_задания);
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Механизм заданий (jobs)
 * - Остановка задания
 */
DO $BODY$
  BEGIN
    DBMS_JOB.broken(номер_задания, TRUE); -- true = остановить; false = возобновить
  END;
$BODY$ LANGUAGE plpgsql;
