INSERT INTO Больница(Название_больницы, Адрес, Число_коек)
VALUES ('Мордор', 'Томск', 0);

INSERT INTO Больница(Название_больницы, Адрес, Число_коек)
VALUES ('Иркутская областная больница', 'Иркутск', 0);

INSERT INTO Палата(Номер_палаты, Число_коек, Код_больницы, Название_палаты)
VALUES (1, 4, 1, '666');

INSERT INTO Пациент(Регистрационный_номер, Фамилия, Адрес, Дата_рождения, Пол, Номер_медицинского_полиса)
VALUES (5, 'Янгель', 'Барнаул', DATE ('2005.05.21'), 'мужской', 123);

INSERT INTO Лаборатория(Название, Адрес)
VALUES ('Лаборатория Омега', 'Томск, Буяновский 3А');

INSERT INTO Врач(Код_больницы, Фамилия, Специальность)
VALUES (1, 'Змеев', 'Лор');

INSERT INTO Врач_Пациент(Код_врача, Регистрационный_номер)
VALUES (1, 1);

INSERT INTO Больница_Лаборатория(Код_больницы, Код_лаборатории)
VALUES (2, 2);

INSERT INTO Анализ(Регистрационный_номер, Код_лаборатории, Тип_анализа, Назначенная_дата, Назначенное_время,
                   Номер_направления, Состояние)
VALUES (1, 1, 'Платный', DATE ('2023.09.01'), TIME '23:11:49', 12, 'Тяжелое');

INSERT INTO Размещение(Код_больницы, Номер_палаты, Номер_койки, Регистрационный_номер)
VALUES (1, 1, 3, 5);

INSERT INTO Персонал (Код_больницы, Номер_палаты, Фамилия, Должность, Смена, Зарплата)
VALUES (2, 1, 'Сидоров', 'санитар', 'ночная', 2000);

INSERT INTO Персонал (Код_больницы, Номер_палаты, Фамилия, Должность, Смена, Зарплата)
VALUES (2, 1, 'Янгель', 'санитар', 'ночная', 10000);

INSERT INTO Персонал (Код_больницы, Номер_палаты, Фамилия, Должность, Смена, Зарплата)
VALUES (1, 1, 'Янгель', 'санитар', 'ночная', 10000);

INSERT INTO Диагноз(Регистрационный_номер, Тип_диагноза, Осложнения, Предупреждающая_информация)
VALUES (4, '', 'Нет', 'Нет');