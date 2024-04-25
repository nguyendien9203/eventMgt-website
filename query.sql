select * from events

SELECT * FROM events e JOIN categories c ON e.category_id = c.id

SELECT * FROM events e JOIN event_user eu ON e.id = eu.user_id JOIN users u ON u.id = eu.user_id JOIN categories c ON e.category_id = c.id WHERE eu.role = 'ATTENDEES'

SELECT * FROM events e JOIN event_user eu ON e.id = eu.user_id JOIN users u ON u.id = eu.user_id JOIN categories c ON e.category_id = c.id WHERE u.id = 1

DELETE FROM event_user WHERE event_id = 5;
DELETE FROM events WHERE id = 5;
select * from events

select * from event_user

select * from users

SELECT * FROM events e 
INNER JOIN event_user eu ON e.id = eu.event_id
WHERE eu.user_id = 1 AND eu.role = 'ORGANIZER'

SELECT COUNT(*) FROM event_user WHERE event_id = 1 AND status = 'ACCEPT'

SELECT * FROM event_user eu JOIN users u ON eu.user_id = u.id WHERE u.id = '2' AND eu.event_id = 1 AND eu.role = 'ATTENDEES'

SELECT * 
FROM events e 
JOIN event_user eu ON e.id = eu.event_id 
JOIN users u ON u.id = eu.user_id 
JOIN categories c ON e.category_id = c.id 
WHERE u.id = 1;

SELECT e.id, e.category_id, e.title, e.location, e.start_datetime, e.end_datetime, e.description, e.status, CAST(c.category_name AS VARCHAR) AS category_name
FROM events e
INNER JOIN event_user eu ON e.id = eu.event_id
INNER JOIN categories c ON e.category_id = c.id
WHERE eu.user_id = 1 AND eu.role = 'ORGANIZER'

UNION

SELECT e.id, e.category_id, e.title, e.location, e.start_datetime, e.end_datetime, e.description, e.status, CAST(c.category_name AS VARCHAR) AS category_name
FROM events e
INNER JOIN event_user eu ON e.id = eu.event_id
INNER JOIN categories c ON e.category_id = c.id
WHERE eu.user_id = 1 AND eu.role = 'ATTENDEES';

SELECT *
FROM events e
INNER JOIN event_user eu ON e.id = eu.event_id
WHERE (eu.user_id = 2 AND eu.role = 'ORGANIZER')
   OR (eu.user_id = 2 AND eu.role = 'ATTENDEES');


   select * from categories

