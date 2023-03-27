-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

--didnt realize there was already a column for this in the table... *facepalm
--but i guess heres a pretty query that does it too.
SELECT cf_id, COUNT(backer_id) AS bc
FROM (
	SELECT ba.backer_id, ca.cf_id, outcome
	FROM backers AS ba
	LEFT JOIN campaign AS ca
	ON ba.cf_id = ca.cf_id
	WHERE outcome = 'live'
	) as ad
GROUP BY ad.cf_id
ORDER BY bc DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cf_id, COUNT(backer_id) AS bc
FROM backers
GROUP BY cf_id
ORDER BY bc DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT co.first_name,
       co.last_name,
	   co.email,
	   (ca.goal-ca.pledged) AS remaining_goal_amount
INTO email_contacts_remaining_goal_amount
FROM contacts AS co
JOIN campaign AS ca
ON (co.contact_id=ca.contact_id)
WHERE ca.outcome='live'
ORDER BY remaining_goal_amount DESC;


-- Check the table

SELECT * FROM email_contacts_remaining_goal_amount;
-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

--Hey, my pretty query came in handy.
SELECT first_name,
       last_name,
	   email,
	   remaining_goal_amount
INTO email_backers_remaining_goal_amount
FROM (
	SELECT ba.first_name,
	ba.last_name,
	ba.email,
	ba.cf_id,
	ca.goal-ca.pledged AS remaining_goal_amount
	FROM backers AS ba
	LEFT JOIN campaign AS ca
	ON ba.cf_id = ca.cf_id
	WHERE outcome = 'live'
	) as baca
ORDER BY baca.remaining_goal_amount DESC;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

