-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Checking all reports of the crimes happened on 28 July on Humphrey Street, then checking info for the duck stolen one.
SELECT * FROM crime_scene_reports WHERE month = 7 AND day = 28 AND street = 'Humphrey Street';

-- Checking the interviews of poeple on 28th July regarding the theft
SELECT * FROM interviews WHERE month = 7 AND day = 28 AND transcript LIKE '%bakery%';

-- HINT 1 : checking the account number in atm transactions (withdraw) made on 28 July in the Leggett Street (which is stated in one of the interviews)
SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw';

-- HINT 2 : checking license plate of all cars exited within the time frame (10:15 to 10:25) as said in interview
SELECT licence_plate FROM bakery_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND activity = 'exit' AND minute BETWEEN 15 AND 25;

-- HINT 3 : checking the caller and reciever phone nums on 28 july whih less less than a minute.
SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration <= 60;

-- HINT 4 : cheking passport number of all passenger on 29th July's earliest flight from Fiftyville
SELECT passengers.passport_number FROM flights, passengers WHERE flights.id = passengers.flight_id
AND origin_airport_id = 8
AND flights.month = 7 AND flights.day = 29
AND hour = (SELECT hour FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
AND flights.month = 7 AND flights.day = 29 ORDER BY hour, minute LIMIT 1)
AND minute = (SELECT minute FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
AND flights.month = 7 AND flights.day = 29 ORDER BY hour, minute LIMIT 1);



-- finally, factoring out the common person name who is common in all 4 hints above
SELECT name FROM people, bank_accounts WHERE people.id = bank_accounts.person_id
AND account_number IN (SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
AND people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND activity = 'exit' AND minute BETWEEN 15 AND 25)
AND people.phone_number IN (SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60)
AND passport_number IN (
    SELECT passengers.passport_number FROM flights, passengers WHERE flights.id = passengers.flight_id
AND origin_airport_id = 8
AND flights.month = 7 AND flights.day = 29
AND hour = (SELECT hour FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
AND flights.month = 7 AND flights.day = 29 ORDER BY hour, minute LIMIT 1)
AND minute = (SELECT minute FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
AND flights.month = 7 AND flights.day = 29 ORDER BY hour, minute LIMIT 1)
);



-- what city he flew to -
SELECT city FROM airports WHERE id = ( SELECT destination_airport_id FROM flights, passengers WHERE flights.id = passengers.flight_id
AND origin_airport_id = 8
AND flights.month = 7 AND flights.day = 29
AND hour = (SELECT hour FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
AND flights.month = 7 AND flights.day = 29 ORDER BY hour, minute LIMIT 1)
AND minute = (SELECT minute FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
AND flights.month = 7 AND flights.day = 29 ORDER BY hour, minute LIMIT 1) LIMIT 1);



-- His Accomplice
SELECT name FROM people WHERE phone_number = (SELECT receiver FROM phone_calls WHERE month = 7
AND day = 28 AND duration < 60 AND caller = (
    SELECT phone_number FROM people, bank_accounts WHERE people.id = bank_accounts.person_id
AND account_number IN (SELECT account_number FROM atm_transactions WHERE month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
AND people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE month = 7 AND day = 28 AND hour = 10 AND activity = 'exit' AND minute BETWEEN 15 AND 25)
AND people.phone_number IN (SELECT caller FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60)
AND passport_number IN (
    SELECT passengers.passport_number FROM flights, passengers WHERE flights.id = passengers.flight_id
AND origin_airport_id = 8
AND flights.month = 7 AND flights.day = 29
AND hour = (SELECT hour FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
AND flights.month = 7 AND flights.day = 29 ORDER BY hour, minute LIMIT 1)
AND minute = (SELECT minute FROM flights WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
AND flights.month = 7 AND flights.day = 29 ORDER BY hour, minute LIMIT 1)
)));

