-- Найти всех пользователей, у которых нет ни одного заказа. Вывести их email, имя и дату регистрации.


INSERT INTO users (email, password_hash, first_name, last_name, phone, date_of_birth) VALUES
('newuser1@mail.ru', 'hash123', 'Сергей', 'Иванов', '+79161111111', '1990-01-01'),
('newuser2@mail.ru', 'hash124', 'Анна', 'Смирнова', '+79161111112', '1992-05-15'),
('newuser3@mail.ru', 'hash125', 'Павел', 'Кузнецов', '+79161111113', '1988-11-20');


