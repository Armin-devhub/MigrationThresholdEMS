-- ============================================================================
-- PAGE 373 MIGRATION - DATABASE CHANGES REQUIRED
-- ============================================================================
-- This script creates the missing view that PAGE 373 depends on
-- Run this in STAGING database BEFORE importing page 373
-- ============================================================================

CREATE OR REPLACE FORCE EDITIONABLE VIEW "PLUTOV6"."V_STUDENT_ATTENDANCE_CHECKIN_DISTANCE" (
    "ATTENDANCE_KEY", 
    "INSTITUTE_KEY", 
    "CAMPUS_KEY", 
    "CAMPUS_CODE", 
    "CAMPUS_NAME", 
    "CAMPUS_LATITUDE", 
    "CAMPUS_LONGITUDE", 
    "CAMPUS_DISTANCE_THRESHOLD", 
    "CLASS_CODE", 
    "CLASS_SESSION", 
    "STUDY_INTAKE", 
    "LECTURER_KEY", 
    "LECTURER", 
    "ATTENDANCE_DATE", 
    "TIME_FROM", 
    "TIME_TO", 
    "ATTENDANCE_DETAIL_KEY", 
    "STUDENT_KEY", 
    "STUDENT_NAME", 
    "STUDENT_NUMBER", 
    "CHECK_IN", 
    "CHECK_IN_TIME", 
    "LATITUDE", 
    "LONGITUDE", 
    "CHECKIN_BY", 
    "CHECKIN_DISTANCE_KM", 
    "ATTENDED", 
    "LATE", 
    "VALID_REASON"
) AS 
SELECT 
    A.ATTENDANCE_KEY, 
    B.INSTITUTE_KEY, 
    B.CAMPUS_KEY, 
    C.CAMPUS_CODE, 
    C.CAMPUS_NAME, 
    C.LATITUDE, 
    C.LONGITUDE, 
    C.DISTANCE_THRESHOLD, 
    B.CLASS_CODE, 
    B.CLASS_SESSION, 
    B.STUDY_INTAKE, 
    B.LECTURER_KEY, 
    (SELECT CUSTOMER_NAME FROM CUSTOMER WHERE CUSTOMER_KEY = B.LECTURER_KEY), 
    B.ATTENDANCE_DATE, 
    B.TIME_FROM, 
    B.TIME_TO, 
    A.ATTENDANCE_DETAIL_KEY, 
    A.STUDENT_KEY, 
    D.STUDENT_NAME, 
    COALESCE(
        (SELECT MAX(SCM_STUDENT_NUMBER) 
         FROM V_STUDENT_COURSE_SUBJECT S 
         WHERE S.STUDENT_KEY = A.STUDENT_KEY 
         AND S.CLASS_CODE = B.CLASS_CODE 
         AND S.SUBJECT_STATUS IN ('Active','Completed')), 
        D.STUDENT_NUMBER 
    ), 
    A.CHECK_IN, 
    A.CHECK_IN_TIME, 
    A.LATITUDE, 
    A.LONGITUDE, 
    A.CHECKIN_BY, 
    ROUND(GET_ATT_CHECKIN_DISTANCE(IN_ATT_DETAIL_KEY => A.ATTENDANCE_DETAIL_KEY), 2), 
    A.ATTENDED, 
    A.LATE, 
    A.VALID_REASON 
FROM 
    ATTENDANCE_DETAIL A, 
    ATTENDANCE_MASTER B, 
    CAMPUS_MASTER C, 
    STUDENT_PROFILE D 
WHERE 
    A.ATTENDANCE_KEY = B.ATTENDANCE_KEY 
    AND B.CAMPUS_KEY = C.CAMPUS_KEY 
    AND A.STUDENT_KEY = D.STUDENT_KEY;

-- ============================================================================
-- VERIFICATION AFTER VIEW CREATION
-- ============================================================================
-- Run this to verify the view was created successfully:
-- SELECT VIEW_NAME FROM USER_VIEWS WHERE VIEW_NAME = 'V_STUDENT_ATTENDANCE_CHECKIN_DISTANCE';
-- SELECT COLUMN_NAME FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'V_STUDENT_ATTENDANCE_CHECKIN_DISTANCE' ORDER BY COLUMN_ID;
