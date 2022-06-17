START TRANSACTION;

insert into core.pd_roles(id, c_name, c_description, n_weight) values 
(1, 'master', 'Мастер', 1000),
(2, 'admin', 'Администратор', 900),
(3, 'user', 'Пользователь',	800);

insert into core.pd_levels(id, f_parent, c_name) values
('ac64692c-e52e-60c6-bb0f-741a1b224c16', null, 'Филиал'),
('2a71cbac-d1b9-4d5b-adf6-530aae966003', 'ac64692c-e52e-60c6-bb0f-741a1b224c16', 'Отделение'),
('69192787-f315-4b49-b061-44b9331a6d6f', '2a71cbac-d1b9-4d5b-adf6-530aae966003', 'Участок');

insert into core.pd_users(id, c_login, c_password, c_about, f_level) values
(1, 'admin', 'qwe-123', 'Администратор ресурса', null),
(2, 'user', '1234', 'Сотрудник', 'ac64692c-e52e-60c6-bb0f-741a1b224c16');

insert into core.pd_userinroles(f_user, f_role)
values(1, 2), (2, 3);

insert into dbo.cs_route_statuses(id, c_name, c_const, n_order) values
(1, 'Создан', 'CREATED', 0),
(2, 'Назначен', 'ASSIGNED', 1),
(3, 'Проверено', 'VERIFIED', 2),
(4, 'Не проверено', 'NO_VERIFIED', 3),
(5, 'Отмена', 'CANCEL', 4);

-- тестовые данные
insert into dbo.cd_routes(id, c_name, c_description, f_user, f_status) values
('e6c4bd3d-afc4-4669-ae5b-a79082f8b8bd', 'Первый маршрут #1', 'simple route <b>#<font color="red">1</font></b>', 2, 2),
('732fded2-2417-4018-9edb-f499de11caf5', 'Мой маршрут', 'Нужно выполнить задания в короткие сроки до февраля 2023', null, null);

insert into dbo.cd_points(id, fn_route, c_address, c_description, n_order, n_longitude, n_latitude, jb_data) values
('9411304d-9f3e-4f9c-9aca-f7d81aa8f4ff', 'e6c4bd3d-afc4-4669-ae5b-a79082f8b8bd', 'Автомойка', 'simple description <b>#<font color="red">1</font></b>', 0, 47.223519000000000, 56.140905000000000, '{"{5}": "auto"}'),
('b5c55feb-367b-45c6-9015-f117d796da4e', 'e6c4bd3d-afc4-4669-ae5b-a79082f8b8bd', 'Магазин пятерочка', 'simple description <b>#<font color="red">1</font></b>', 1, 47.219839000000000, 56.140080000000000, '{"{5}": "soc"}');

insert into dbo.cd_points(id, fn_route, c_address, c_description, n_order, n_longitude, n_latitude, jb_data) values
('f8566b1a-fb22-469a-ba90-d41140e265c0', 'e6c4bd3d-afc4-4669-ae5b-a79082f8b8bd', 'Моя точка', 'Для примера импорта', 0, 47.238421000000000, 56.143206000000000),
('1d2aec12-a4f3-4403-9e4a-bd5052c5cd0b', 'e6c4bd3d-afc4-4669-ae5b-a79082f8b8bd', 'Магазин пятерочка', null, 1, 47.219839000000000, 56.140080000000000);

COMMIT TRANSACTION;