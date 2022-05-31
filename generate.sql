insert into core.pd_roles(id, c_name, c_description, n_weight, c_created_user, d_created_date) values 
(1, 'master', 'Мастер', 1000),
(2, 'admin', 'Администратор', 900),
(3, 'user', 'Пользователь',	800);

insert into core.pd_users(id, c_login, c_password, c_about, f_org, f_level) values
(1, 'admin', 'qwe-123', 'Администратор ресурса', 1, null),
(2, 'user', '1234', 'Сотрудник', 1, 'ac64692c-e52e-60c6-bb0f-741a1b224c16');

insert into core.pd_userinroles(f_user, f_role)
values(1, 2), (2, 3);

insert into core.pd_levels(id, f_parent, c_name, f_org) values
('ac64692c-e52e-60c6-bb0f-741a1b224c16', null, 'Филиал', 1),
('2a71cbac-d1b9-4d5b-adf6-530aae966003', 'ac64692c-e52e-60c6-bb0f-741a1b224c16', 'Отделение', 1),
('69192787-f315-4b49-b061-44b9331a6d6f', '2a71cbac-d1b9-4d5b-adf6-530aae966003', 'Участок', 1);

insert into dbo.cs_route_statuses(id, c_name, c_const, n_order) values
(1, '{"en": "Created","ru": "Создан"}', 'CREATED', 0),
(2, '{"en": "Assigned","ru": "Назначен"}', 'ASSIGNED', 1),
(3, '{"en": "Doned","ru": "Выполнено"}', 'DONED', 2),
(4, '{"en": "Verified","ru": "Проверено"}', 'VERIFIED', 3),
(5, '{"en": "No verified","ru": "Не проверено"}', 'NO_VERIFIED', 4),
(6, '{"en": "Cancel","ru": "Отмена"}', 'CANCEL', 5);