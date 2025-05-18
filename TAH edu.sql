SELECT * 
FROM education3.assessments
WHERE assessment_type = "Final";

SELECT * 
FROM education3.assessments;

SELECT * 
FROM education3.students;

SELECT * 
FROM education3.classes;

SELECT * 
FROM education3.subjects; 

SELECT * 
FROM education3.teachers;

# Top performing student
SELECT A.student_id, S.student_name, ROUND(AVG(A.score),2) Avg_score
FROM education3.assessments A
JOIN education3.students S
USING (student_id)
Group By A.student_id, S.student_name
Order by Avg_score DESC
Limit 5;

# Struggling subjects
SELECT SB.subject_name, ROUND(AVG(A.score),2) Avg_score
FROM education3.assessments A
JOIN education3.subjects SB
USING (subject_id)
Group By SB.subject_name
HAVING AVG(A.score) < 50
Order by Avg_score DESC;

# Teacher effectiveness
SELECT T.teacher_id, T.teacher_name, SB.subject_name, ROUND(AVG(A.score),2) Avg_score
FROM education3.assessments A
JOIN education3.subjects SB
USING (subject_id)
JOIN education3.teachers T
ON SB.subject_name = T.subject
Group By T.teacher_name, SB.subject_name, T.teacher_id
Order by T.teacher_id;

# Performance by class
SELECT C.class_id, C.class_name, ROUND(AVG(A.score),2) Avg_score
FROM education3.assessments A
JOIN education3.students S
USING (student_id)
JOIN education3.classes C
USING (class_id)
Group By C.class_name, C.class_id
Order by C.class_id;

# Assessment frequency
SELECT SB.subject_id, SB.subject_name, COUNT(assessment_id) num_assessments
FROM education3.assessments A
JOIN education3.subjects SB
USING (subject_id)
WHERE assessment_date BETWEEN '2023-09-01' AND '2023-12-31'
Group By SB.subject_id, SB.subject_name
Order by SB.subject_id DESC;

# Student progress tracking
SELECT S.student_id, S.student_name, MONTH(A.assessment_date) Assessment_month, ROUND(AVG(A.score),2) Avg_score
FROM education3.assessments A
JOIN education3.students S
USING (student_id)
Group By S.student_id, S.student_name, Assessment_month
Order by S.student_id, Assessment_month;

# Subject popularity
SELECT SB.subject_id, SB.subject_name, COUNT(assessment_id) num_assessments
FROM education3.assessments A
JOIN education3.subjects SB
USING (subject_id)
Group By SB.subject_id, SB.subject_name
Order by num_assessments DESC
LIMIT 5;

# Gender-based performance
SELECT SB.subject_name, SB.subject_id, S.gender, ROUND(AVG(A.score),2) Avg_score
FROM education3.assessments A
JOIN education3.subjects SB
USING (subject_id)
JOIN education3.students S
USING (student_id)
Group By SB.subject_name, SB.subject_id, S.gender
Order by SB.subject_id;