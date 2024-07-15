/* Question 1: Show first name, last name, and gender of patients whose gender is 'M' */
 
SELECT first_name,
	last_name,
    gender
from patients
where gender = 'M';

/* Question 2: Show first name and last name of patients who does not have allergies.*/

select first_name, last_name
from patients
where allergies is null;

/* Question 3: Show first name of patients that start with the letter 'C'. */

select first_name
from patients
Where first_name  like 'C%';

/* Question 4: Show first name and last name of patients that weigh within the range of 100 to 120. */

select first_name, last_name
from patients
where weight <= 120
	and weight >= 100;
    
/* Question 5: Update the patients table for the allergies column. If the patient's allergies is null then
replace it with 'NKA'. */

update patients
set allergies = 'NKA'
where allergies is null;

/* Question 6: Show first name and last name concatinated into one column to show their full name. */

select concat (first_name, ' ', last_name) as full_name
from patients;

/* Question 7: Show first name, last name, and the full province name of each patient. */
/* This querry joins the tables patients and province_names on the province_id key. */

select first_name, last_name, province_name
from patients
	join province_names on patients.province_id = province_names.province_id;

/* Question 8: Show how many patients have a birth_date with 2010 as the birth year.*/ 
select count (patients.birth_date)
from patients
where YEAR (birth_date) = 2010; 

/* Question 9: Show the first_name, last_name, and height of the patient with the greatest height.*/ 
select first_name, last_name, max(height) as height
from patients
group by first_name, last_name
order by height desc
limit 1; 

/* Question 10: Show all columns for patients who have one of the following patient_ids: 1,45,535,879,1000. */ 

select * 
from patients
where 
	patient_id in (1, 45, 534, 879, 1000); 
    
/* Question 11: Show the total number of admissions. */ 
select count(patient_id)
from admissions; 

/* Question 12: Show all the columns from admissions where the patient was admitted and discharged on the
same day. */ 

select * 
from admissions
where admission_date = discharge_date; 

/* Question 13: Show the patient id and the total number of admissions for patient_id 579. */

select patient_id, count (*) as total_admissions
from admissions
where patient_id = 579;

/* Question 14: Based on the cities that our patients live in, show unique cities that are in province_id 'NS'. */

select distinct city as distinct_city
from patients
where province_id = 'NS'; 


/* Question 15: Write a query to find the first_name, last name and birthdate of patients who have a height
greater than 160 and weight greater than 70. */

select first_name, last_name, birth_date
from patients
where height > 160
	AND weight > 70;
    
/* Question 16: Write a query to find list of patients first name, last name, and allergies where allergies are not null
and are from the city of 'Hamilton'. */ 

select first_name, last_name, allergies
from patients
where allergies is not null
	AND city = 'Hamilton';
    
/* Question 17: Show unique birth years from patients and order them by ascending. */ 

select distinct year (birth_date) as birth_date
from patients
order by birth_date asc; 

/* Question 18: Show unique first names from the patients table which only occurs once in the list. 
For example, if two or more people are named 'John' in the first_name column, then don't include them in the
output. If only 1 person is named 'Leo' then include them in the output.*/ 

select first_name
from patients 
group by first_name
having count (first_name = '%') = 1; 

/* Question 19: Show patient_id and first name from patients where their first name starts and ends with 's'
and is at least 6 characters long. */ 

select patient_id, first_name
from patients
where first_name like 's____%s';

/* Question 20: Show patient id, first name, last name from patiens whose diagnosis is 'Dementia'. 
Primary diagnosis is stored in the admissions table, so this query should join patients and admissions. */ 

select admissions.patient_id, first_name, last_name
from patients
	join admissions on patients.patient_id = admissions.patient_id
where diagnosis = 'Dementia';

/* Question 21: Display every patient's first name. Order the list by the length of each name and
then alphabetically. */

select first_name
from patients
order by length(first_name) asc, first_name asc; 

/* Question 22: Show the total amount of male patients and the total amount of female patients in the patients
table. Display the two results in the same row. */

select
	(select count (*) from patients where gender = 'M') as male_count,
     (select count (*) from patients where gender = 'F') as female_count; 
     
/* Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
Show results ordered ascending by allergies then by first name the by last name. */ 

select first_name, last_name, allergies
from patients
where allergies = 'Penicillin' OR allergies = 'Morphine'
order by allergies asc, first_name asc, last_name asc; 

/* Question 23: Show patient_id, diagnosis from admissions. Fint patients admitted multiple times for the 
same diagnosis. */ 

select patient_id, diagnosis
from admissions
group by patient_id, diagnosis
having count (diagnosis = '%') >1;

/* Question 24: Show the city and the total number of patients in the city. 
Order from most to least patients and then by city name ascending. */

select city, count(*) as num_patients
from patients
group by city
order by num_patients desc, city asc; 

/* Question 25: Show first name, last name and role of every person that is either patient or doctor. 
The roles are either "Patient" or "Doctor". */

select first_name, last_name, 'Patient' as role
from patients 
union all 
select first_name, last_name, 'Doctor' as role
from doctors; 

/* Question 26: Show all allergies ordered by popularity. Remove NULL values from query. */ 

select allergies, count(*) as total_diagnosis
from patients
where allergies is not null
group by allergies
order by total_diagnosis desc; 

/* Question 27: Show all patient's first name, last name, and birth date who were born in the 1970's 
decade. Sort the list starting from the earliest birth date. */ 

select first_name, last_name, birth_date
from patients
where year (birth_date) >1969
	and year (birth_date) <1980
order by birth_date asc; 

/* Question 28: We want to display each patient's ful name in a single column. Their last name in all upper 
letters must appear first, then first name in all lower case letters. Separate the last name and first name with
a comma. Oder the list by the first name in decending order. EX: SMITH,jane */

select concat (upper(last_name), ",", lower(first_name)) as full_name
from patients
order by first_name desc; 

/* Question 29: Show the province id, sum of height; where the total sum of its patient's height is greater 
than or equal to 7,000. */ 

select province_id, sum(height) as sum_height
from patients
group by province_id
having sum_height >= 7000; 

/* Question 30: Show the difference between the largest weight and smallest weight for patients with the
last name 'Maroni' */

select max(weight) - min(weight) as weight_difference
from patients
where last_name = 'Maroni'; 

/* Question 31: Show all of the days of the month (1-31) and how many admissions_dates occured on that day. 
Sort by the day with most admissions to least admissions. */

select day(admission_date), count(*) as number_of_admissions
from admissions
group by day(admission_date)
order by number_of_admissions desc; 

/* Question 32: Show all columns for patient_id 542's most recent admission_date. */ 

select * 
from admissions
where patient_id = 542
order by admission_date desc
limit 1; 

/* Question 33: Show patient id, attending doctor id, and diagnosis for admissions that match one of the two criteria: 
1. patient id is an odd number and attending doctor id is either 1, 5, or 19. 
2. Attending doctor id contains a 2 and the length of patient id is 3 characters. */ 

select patient_id, attending_doctor_id, diagnosis
from admissions
where patient_id % 2 <> 0
	AND attending_doctor_id in (1, 5, 19)
    OR  (attending_doctor_id like '%2%'
    AND len(patient_id) = 3); 
    
/* Question 34: Show first_name, last_name, and the total number of admissions attended for each doctor. 
Every admissions has been attended by a doctor. */

select first_name, last_name, count(attending_doctor_id) as admissions_total
from admissions
	join doctors on admissions.attending_doctor_id = doctors.doctor_id
group by first_name, last_name; 

/* Question 35: For each doctor, display their full id, full name, and the first and last admission date they 
attended. */ 

select doctors.doctor_id, 
	concat(doctors.first_name, ' ', doctors.last_name) as doctor_name,
    min(admissions.admission_date) as first_admission_date, 
    max(admissions.admission_date) as last_admission_date
from doctors
	join admissions on doctors.doctor_id = admissions.attending_doctor_id
group by doctors.doctor_id, doctor_name;     

/* Question 36: Display the total amount of patients for each province. Order by descending. */ 

select province_name, count(patients.province_id) as province_total
from province_names
	join patients on province_names.province_id = patients.province_id
group by province_name
order by province_total desc; 

/* Question 37: For every admission, display the patient's full name, their admission diagnosis, and their doctor's 
full name who diagnosed their problem. */ 

select concat(patients.first_name, ' ',patients.last_name) as patient_name, 
	admissions.diagnosis, 
    concat(doctors.first_name, ' ',doctors.last_name) as doctor_name
from patients
	join admissions on patients.patient_id = admissions.patient_id
    join doctors on admissions.attending_doctor_id = doctors.doctor_id; 
    
/* Question 38: Display the first name, last name and number of dupicate patients based on their first name
and last name. Ex: a patient with an identical name can be considered a duplicate. */

select first_name, last_name, count(*) as number_of_duplicates
from patients
group by first_name, last_name
having count(*) > 1; 