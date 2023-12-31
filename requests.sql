--Суммарная зарплата персонала в каждой больнице:
SELECT Больница.Название_больницы, SUM(Персонал.Зарплата) AS Суммарная_зарплата
FROM Больница
         JOIN Палата ON Больница.Код_больницы = Палата.Код_больницы
         JOIN Персонал ON Палата.Номер_палаты = Персонал.Номер_палаты AND Палата.Код_больницы = Персонал.Код_больницы
GROUP BY Больница.Название_больницы;

--Количество лабораторий доступных в каждой больнице
SELECT Больница.Название_больницы,
       Больница.Код_больницы,
       COUNT(Больница_Лаборатория.Код_лаборатории) AS Количество_лабораторий
FROM Больница
         FULL JOIN Больница_Лаборатория ON Больница.Код_больницы = Больница_Лаборатория.Код_больницы
GROUP BY Больница.Код_больницы;

--Вывод всей информации о заболевании каждого пациента
SELECT Пациент.Фамилия,
       Диагноз.Тип_диагноза,
       Диагноз.Осложнения,
       Диагноз.Предупреждающая_информация
FROM Пациент
         JOIN Диагноз ON Пациент.Регистрационный_номер = Диагноз.Регистрационный_номер;

--Средний возраст пациентов в каждой больнице
SELECT Больница.Название_больницы, AVG(EXTRACT(YEAR FROM AGE(Пациент.Дата_рождения))) AS Средний_возраст
FROM Больница
         JOIN Размещение ON Больница.Код_больницы = Размещение.Код_больницы
         JOIN Пациент ON Размещение.Регистрационный_номер = Пациент.Регистрационный_номер
GROUP BY Больница.Название_больницы;

--Все пациенты, которые находятся в данный момент в больнице
SELECT Пациент.Фамилия, Палата.Номер_палаты, Палата.Код_больницы, Размещение.Номер_койки
FROM Пациент
         JOIN Размещение ON Пациент.Регистрационный_номер = Размещение.Регистрационный_номер
         JOIN Палата
              ON Размещение.Код_больницы = Палата.Код_больницы AND Размещение.Номер_палаты = Палата.Номер_палаты;