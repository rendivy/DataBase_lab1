CREATE TABLE Больница
(
    Код_больницы      SERIAL PRIMARY KEY,
    Название_больницы VARCHAR(255) NOT NULL,
    Адрес             VARCHAR(255) NOT NULL,
    Число_коек        INT          NOT NULL
);

CREATE TABLE Палата
(
    Номер_палаты    INT,
    Код_больницы    INT,
    Название_палаты VARCHAR(255),
    Число_коек      SERIAL NOT NULL,
    FOREIGN KEY (Код_больницы) REFERENCES Больница (Код_больницы) ON DELETE CASCADE,
    PRIMARY KEY (Номер_палаты, Код_больницы)
);

CREATE TABLE Персонал
(
    Код_больницы INT,
    Номер_палаты INT,
    Фамилия      VARCHAR(255),
    Должность    VARCHAR(255) CHECK ( Должность IN ('медсестра', 'няня', 'сиделка', 'санитар')),
    Смена        VARCHAR(255) CHECK ( Смена IN ('утренняя', 'вечерняя', 'ночная')),
    Зарплата     INT CHECK (Зарплата BETWEEN 1000 AND 10000),
    FOREIGN KEY (Код_больницы, Номер_палаты) REFERENCES Палата (Код_больницы, Номер_палаты)
);

CREATE TABLE Пациент
(
    Регистрационный_номер     INT PRIMARY KEY,
    Фамилия                   VARCHAR(255),
    Адрес                     VARCHAR(255),
    Дата_рождения             DATE CHECK (Дата_рождения > DATE('01.01.1900')),
    Пол                       VARCHAR CHECK (Пол IN ('мужской', 'женский')),
    Номер_медицинского_полиса INT
);

CREATE TABLE Врач
(
    Код_врача     SERIAL PRIMARY KEY,
    Код_больницы  INT,
    Фамилия       VARCHAR(255),
    Специальность VARCHAR(255),
    FOREIGN KEY (Код_больницы) REFERENCES Больница (Код_больницы)
);

CREATE TABLE Размещение
(
    Код_больницы          INT,
    Номер_палаты          INT,
    Номер_койки           INT,
    Регистрационный_номер INT,
    FOREIGN KEY (Код_больницы, Номер_палаты) REFERENCES Палата (Код_больницы, Номер_палаты) ON DELETE CASCADE,
    FOREIGN KEY (Регистрационный_номер) REFERENCES Пациент (Регистрационный_номер) ON DELETE CASCADE,
    PRIMARY KEY (Код_больницы, Номер_палаты, Номер_койки)

);

CREATE TABLE Диагноз
(
    Регистрационный_номер      INT NOT NULL,
    Тип_диагноза               VARCHAR,
    Осложнения                 VARCHAR,
    Предупреждающая_информация VARCHAR,
    FOREIGN KEY (Регистрационный_номер) REFERENCES Пациент (Регистрационный_номер) ON DELETE CASCADE
);

CREATE TABLE Лаборатория
(
    Код_лаборатории SERIAL PRIMARY KEY,
    Название        VARCHAR,
    Адрес           VARCHAR
);

CREATE TABLE Больница_Лаборатория
(
    Код_больницы    INT,
    Код_лаборатории INT,
    FOREIGN KEY (Код_больницы) REFERENCES Больница (Код_больницы) ON DELETE CASCADE,
    FOREIGN KEY (Код_лаборатории) REFERENCES Лаборатория (Код_лаборатории) ON DELETE CASCADE
);

CREATE TABLE Анализ
(
    Регистрационный_номер INT NOT NULL,
    Код_лаборатории       INT NOT NULL,
    Тип_анализа           VARCHAR,
    Назначенная_дата      DATE,
    Назначенное_время     TIME,
    Номер_направления     INT,
    Состояние             VARCHAR,
    FOREIGN KEY (Регистрационный_номер) REFERENCES Пациент (Регистрационный_номер) ON DELETE CASCADE,
    FOREIGN KEY (Код_лаборатории) REFERENCES Лаборатория (Код_лаборатории) ON DELETE CASCADE
);

CREATE TABLE Телефон_больницы
(
    Код_больницы INT,
    Телефон      VARCHAR CHECK (Телефон ~ '+7[0-9]{9}'),
    FOREIGN KEY (Код_больницы) REFERENCES Больница (Код_больницы),
    PRIMARY KEY (Код_больницы, Телефон)
);

CREATE TABLE Телефон_лаборатории
(
    Код_лаборатории INT,
    Телефон         VARCHAR CHECK (Телефон ~ '+7[0-9]{9}'),
    FOREIGN KEY (Код_лаборатории) REFERENCES Лаборатория (Код_лаборатории),
    PRIMARY KEY (Код_лаборатории, Телефон)
);

CREATE TABLE Врач_Пациент
(
    Код_врача             INT,
    Регистрационный_номер INT,
    FOREIGN KEY (Код_врача) REFERENCES Врач (Код_врача) ON DELETE CASCADE,
    FOREIGN KEY (Регистрационный_номер) REFERENCES Пациент (Регистрационный_номер) ON DELETE CASCADE,
    PRIMARY KEY (Код_врача, Регистрационный_номер)
);