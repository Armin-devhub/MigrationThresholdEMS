prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>1651965819442497
,p_default_application_id=>410
,p_default_id_offset=>30232038658782278
,p_default_owner=>'PLUTOV6'
);
end;
/
 
prompt APPLICATION 410 - PLUTO - Campus Management Software
--
-- Application Export:
--   Application:     410
--   Name:            PLUTO - Campus Management Software
--   Exported By:     ARMI
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 373
--   Manifest End
--   Version:         24.2.0
--   Instance ID:     203759755733853
--

begin
null;
end;
/
prompt --application/pages/delete_00373
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>373);
end;
/
prompt --application/pages/page_00373
begin
wwv_flow_imp_page.create_page(
 p_id=>373
,p_name=>'RPT List of Attendance Detail'
,p_step_title=>'Attendance Detail'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(34855491113432677)
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(283278623216951945)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(351159149269199425)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(228358058476962859)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(351196260548199452)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(283279215233951946)
,p_plug_name=>'Attendance Detail'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(351149927112199422)
,p_plug_display_sequence=>31
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT va.student_name,',
'va.ic_passport,',
'va.scm_student_number,',
'va.student_mobile_no,',
'va.e_mail,',
'va.course_code,',
'va.study_intake,',
'va.academic_semester,',
'va.subject_code,',
'va.class_code,',
'va.class_session,',
'va.attendance_date,',
'va.time_from,',
'va.time_to,',
'nvl(va.attended,''N'') attended,',
'nvl(va.late,''N'') late,',
'nvl(va.valid_reason,''N'') valid_reason,',
'nvl(va.check_in,''N'') check_in,',
'va.checkin_by,',
'va.remarks,',
'(select resource_name from fm_resources where resource_key = va.resource_key) resource_name,',
'lp.lecturer_name,',
'lp.lecturer_ic_passport,',
'lp.lecturer_phone,',
'lp.lecturer_email,',
'(case',
'    when va.mc_doc is not null and va.verify_flag=''Y'' then',
'        ''Y''',
'    else',
'        NULL',
'    end) "Absent with M/C",',
'-- Add the check-in remarks subquery here:',
'(SELECT ''STUDENT ID : ''||va.scm_student_number||'' is outside campus. Distance : ''||D.CHECKIN_DISTANCE_KM||'' km''',
' FROM   V_STUDENT_ATTENDANCE_CHECKIN_DISTANCE D',
' WHERE  D.ATTENDANCE_DETAIL_KEY = va.attendance_detail_key',
' AND    D.CHECKIN_DISTANCE_KM > D.CAMPUS_DISTANCE_THRESHOLD) CHECK_IN_REMARKS,',
'subject_status',
'FROM V_ATTENDANCE_LIST_SUMMARY va,',
'lecturer_profile lp',
'WHERE va.lecturer_key=lp.lecturer_key',
'AND va.institute_key=:GLO_INSTITUTE_KEY',
'AND TO_CHAR(va.CAMPUS_KEY)  IN  (select * from table(apex_string.split(:GLO_USER_CAMPUS,'':'')))',
'AND va.STUDY_INTAKE = :P373_STUDY_INTAKE',
'AND (va.CLASS_CODE = :P373_CLASS_CODE OR :P373_CLASS_CODE IS NULL)'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P373_CAMPUS,P373_STUDY_INTAKE,P373_CLASS_CODE'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_SUBS_FATTS VARCHAR2(1);',
'',
'BEGIN',
'',
'    SELECT SUBS_FATTS INTO V_SUBS_FATTS FROM INSTITUTE_MASTER',
'    WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY;',
'',
'    IF NVL(V_SUBS_FATTS,''N'') = ''N'' THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'END;'))
,p_plug_display_when_cond2=>'PLSQL'
,p_prn_content_disposition=>'ATTACHMENT'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(283279246764951946)
,p_name=>'Student Exam Result (by Course Subject)'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_download_formats=>'XLSX:PDF'
,p_enable_mail_download=>'N'
,p_owner=>'AFIQ'
,p_internal_uid=>283279246764951946
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41826765260381222)
,p_db_column_name=>'STUDENT_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Student Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41827183951381227)
,p_db_column_name=>'IC_PASSPORT'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'IC Passport'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41827587905381227)
,p_db_column_name=>'COURSE_CODE'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Programme Code'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41827911951381227)
,p_db_column_name=>'STUDY_INTAKE'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Study Intake'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41828342700381227)
,p_db_column_name=>'ACADEMIC_SEMESTER'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Academic Semester'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41828707836381227)
,p_db_column_name=>'SUBJECT_CODE'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Course Code'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41829109535381228)
,p_db_column_name=>'E_MAIL'
,p_display_order=>24
,p_column_identifier=>'AG'
,p_column_label=>'Email'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41829563746381228)
,p_db_column_name=>'CLASS_CODE'
,p_display_order=>34
,p_column_identifier=>'AH'
,p_column_label=>'Class Code'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41833175477381230)
,p_db_column_name=>'STUDENT_MOBILE_NO'
,p_display_order=>124
,p_column_identifier=>'AQ'
,p_column_label=>'Mobile No'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41788208894069812)
,p_db_column_name=>'CLASS_SESSION'
,p_display_order=>134
,p_column_identifier=>'AR'
,p_column_label=>'Class Session'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41788349193069813)
,p_db_column_name=>'ATTENDANCE_DATE'
,p_display_order=>144
,p_column_identifier=>'AS'
,p_column_label=>'Attendance Date'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41788444983069814)
,p_db_column_name=>'TIME_FROM'
,p_display_order=>154
,p_column_identifier=>'AT'
,p_column_label=>'Time From'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41788584414069815)
,p_db_column_name=>'TIME_TO'
,p_display_order=>164
,p_column_identifier=>'AU'
,p_column_label=>'Time To'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41788645594069816)
,p_db_column_name=>'ATTENDED'
,p_display_order=>174
,p_column_identifier=>'AV'
,p_column_label=>'Attended'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41788711736069817)
,p_db_column_name=>'LATE'
,p_display_order=>184
,p_column_identifier=>'AW'
,p_column_label=>'Late'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41788825057069818)
,p_db_column_name=>'VALID_REASON'
,p_display_order=>194
,p_column_identifier=>'AX'
,p_column_label=>'Valid Reason'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41788945394069819)
,p_db_column_name=>'REMARKS'
,p_display_order=>204
,p_column_identifier=>'AY'
,p_column_label=>'Remarks'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41789068478069820)
,p_db_column_name=>'LECTURER_NAME'
,p_display_order=>214
,p_column_identifier=>'AZ'
,p_column_label=>'Lecturer Name'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41789181818069821)
,p_db_column_name=>'LECTURER_IC_PASSPORT'
,p_display_order=>224
,p_column_identifier=>'BA'
,p_column_label=>'Lecturer IC Passport'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41789236861069822)
,p_db_column_name=>'LECTURER_PHONE'
,p_display_order=>234
,p_column_identifier=>'BB'
,p_column_label=>'Lecturer Phone'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(41789347249069823)
,p_db_column_name=>'LECTURER_EMAIL'
,p_display_order=>244
,p_column_identifier=>'BC'
,p_column_label=>'Lecturer Email'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(50940817298789641)
,p_db_column_name=>'SCM_STUDENT_NUMBER'
,p_display_order=>254
,p_column_identifier=>'BD'
,p_column_label=>'Student Number'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(9738307499564743)
,p_db_column_name=>'CHECK_IN'
,p_display_order=>264
,p_column_identifier=>'BE'
,p_column_label=>'Checked In'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(9738466340564744)
,p_db_column_name=>'CHECKIN_BY'
,p_display_order=>274
,p_column_identifier=>'BF'
,p_column_label=>'Checked In By'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(118249092009755602)
,p_db_column_name=>'RESOURCE_NAME'
,p_display_order=>284
,p_column_identifier=>'BG'
,p_column_label=>'Venue'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1077384218967568301)
,p_db_column_name=>'Absent with M/C'
,p_display_order=>294
,p_column_identifier=>'BH'
,p_column_label=>'Absent With M&#x2F;C'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1829643492431492401)
,p_db_column_name=>'SUBJECT_STATUS'
,p_display_order=>304
,p_column_identifier=>'BI'
,p_column_label=>'Course Status'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(202240111347965354)
,p_db_column_name=>'CHECK_IN_REMARKS'
,p_display_order=>314
,p_column_identifier=>'BJ'
,p_column_label=>'Check In Remarks'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(283290647140960171)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'418335'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'STUDENT_NAME:IC_PASSPORT:SCM_STUDENT_NUMBER:E_MAIL:STUDENT_MOBILE_NO:COURSE_CODE:STUDY_INTAKE:ACADEMIC_SEMESTER:RESOURCE_NAME:SUBJECT_CODE:SUBJECT_STATUS:CLASS_CODE:CLASS_SESSION:ATTENDANCE_DATE:TIME_FROM:TIME_TO:ATTENDED:LATE:VALID_REASON:CHECK_IN:C'
||'HECKIN_BY:REMARKS:LECTURER_NAME:LECTURER_IC_PASSPORT:LECTURER_PHONE:LECTURER_EMAIL:Absent with M/C:CHECK_IN_REMARKS:'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(343202900309289633)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Export For Excel'
,p_report_seq=>10
,p_report_alias=>'3432030'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'STUDENT_NAME:IC_PASSPORT:SCM_STUDENT_NUMBER:E_MAIL:STUDENT_MOBILE_NO:COURSE_CODE:STUDY_INTAKE:ACADEMIC_SEMESTER:RESOURCE_NAME:SUBJECT_CODE:CLASS_CODE:CLASS_SESSION:ATTENDANCE_DATE:TIME_FROM:TIME_TO:ATTENDED:LATE:VALID_REASON:CHECK_IN:CHECKIN_BY:REMAR'
||'KS:LECTURER_NAME:LECTURER_IC_PASSPORT:LECTURER_PHONE:LECTURER_EMAIL:'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(343203754292292918)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Export For PDF'
,p_report_seq=>10
,p_report_alias=>'3432038'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'STUDENT_NAME:IC_PASSPORT:SCM_STUDENT_NUMBER:E_MAIL:STUDENT_MOBILE_NO:COURSE_CODE:STUDY_INTAKE:ACADEMIC_SEMESTER:RESOURCE_NAME:SUBJECT_CODE:CLASS_CODE:CLASS_SESSION:ATTENDANCE_DATE:TIME_FROM:TIME_TO:ATTENDED:LATE:VALID_REASON:CHECK_IN:CHECKIN_BY:REMAR'
||'KS:LECTURER_NAME:LECTURER_IC_PASSPORT:LECTURER_PHONE:LECTURER_EMAIL:'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(341882730423146908)
,p_plug_name=>'Button'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(351129857791199404)
,p_plug_display_sequence=>11
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(377579005370717518)
,p_plug_name=>'Parameter'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(351149927112199422)
,p_plug_display_sequence=>21
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(641144341415127025)
,p_plug_name=>'Attendance Detail FATTS'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(351149927112199422)
,p_plug_display_sequence=>41
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT student_name,',
'ic_passport,',
'scm_student_number,',
'student_mobile_no,',
'e_mail,',
'course_code,',
'study_intake,',
'academic_semester,',
'subject_code,',
'class_session,',
'attendance_date,',
'time_from,',
'time_to,',
'NVL(attended,''N'') attended,',
'NVL(late,''N'') late,',
'NVL(valid_reason,''N'') valid_reason,',
'NVL(check_in,''N'') check_in,',
'checkin_by,',
'remarks,',
'resource_name,',
'lecturer_name,',
'lecturer_ic_passport,',
'lecturer_phone,',
'lecturer_email,',
'absent_with_mc,',
'(SELECT ''STUDENT ID : ''||v_student_attendance_fatts.scm_student_number||'' is outside campus. Distance : ''||D.CHECKIN_DISTANCE_KM||'' km''',
' FROM   V_STUDENT_ATTENDANCE_CHECKIN_DISTANCE D',
' WHERE  D.ATTENDANCE_DETAIL_KEY = v_student_attendance_fatts.attendance_detail_key',
' AND    D.CHECKIN_DISTANCE_KM > D.CAMPUS_DISTANCE_THRESHOLD) CHECK_IN_REMARKS,',
'subject_status,',
'FATTS_CHECKIN_BY,',
'FATTS_CHECKIN_DATE,',
'FATTS_CHECKOUT_BY,',
'FATTS_CHECKOUT_DATE,',
'CHECK_OUT,',
'CHECK_IN_TIME,',
'CHECKOUT_BY,',
'CHECK_OUT_TIME',
'FROM v_student_attendance_fatts',
'WHERE institute_key = :GLO_INSTITUTE_KEY',
'AND TO_CHAR(campus_key) IN (SELECT * FROM TABLE(APEX_STRING.SPLIT(:GLO_USER_CAMPUS,'':'')))',
'AND study_intake = :P373_STUDY_INTAKE'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P373_STUDY_INTAKE'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_SUBS_FATTS VARCHAR2(1);',
'',
'BEGIN',
'',
'    SELECT SUBS_FATTS INTO V_SUBS_FATTS FROM INSTITUTE_MASTER',
'    WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY;',
'',
'    IF NVL(V_SUBS_FATTS,''N'') = ''Y'' THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'END;'))
,p_plug_display_when_cond2=>'PLSQL'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(641144396390127026)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_download_formats=>'XLSX:PDF'
,p_enable_mail_download=>'N'
,p_owner=>'MUZA'
,p_internal_uid=>671376435048909304
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641144483104127027)
,p_db_column_name=>'STUDENT_NAME'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Student Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641144633015127028)
,p_db_column_name=>'IC_PASSPORT'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'IC Passport'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641144737612127029)
,p_db_column_name=>'COURSE_CODE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Programme Code'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641144798581127030)
,p_db_column_name=>'STUDY_INTAKE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Study Intake'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641144893606127031)
,p_db_column_name=>'ACADEMIC_SEMESTER'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Academic Semester'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145021918127032)
,p_db_column_name=>'SUBJECT_CODE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Course Code'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145122189127033)
,p_db_column_name=>'E_MAIL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Email'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145356084127035)
,p_db_column_name=>'STUDENT_MOBILE_NO'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Mobile No'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145369366127036)
,p_db_column_name=>'CLASS_SESSION'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Class Session'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145517815127037)
,p_db_column_name=>'ATTENDANCE_DATE'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'Attendance Date'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145641127127038)
,p_db_column_name=>'TIME_FROM'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>'Time From'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145711406127039)
,p_db_column_name=>'TIME_TO'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>'Time To'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145805269127040)
,p_db_column_name=>'ATTENDED'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>'Attended'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641145878984127041)
,p_db_column_name=>'LATE'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>'Late'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146010163127042)
,p_db_column_name=>'VALID_REASON'
,p_display_order=>160
,p_column_identifier=>'O'
,p_column_label=>'Valid Reason'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146123006127043)
,p_db_column_name=>'REMARKS'
,p_display_order=>170
,p_column_identifier=>'P'
,p_column_label=>'Remarks'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146207331127044)
,p_db_column_name=>'LECTURER_NAME'
,p_display_order=>180
,p_column_identifier=>'Q'
,p_column_label=>'Lecturer Name'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146316945127045)
,p_db_column_name=>'LECTURER_IC_PASSPORT'
,p_display_order=>190
,p_column_identifier=>'R'
,p_column_label=>'Lecturer IC Passport'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146422021127046)
,p_db_column_name=>'LECTURER_PHONE'
,p_display_order=>200
,p_column_identifier=>'S'
,p_column_label=>'Lecturer Phone'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146527323127047)
,p_db_column_name=>'LECTURER_EMAIL'
,p_display_order=>210
,p_column_identifier=>'T'
,p_column_label=>'Lecturer Email'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146653213127048)
,p_db_column_name=>'SCM_STUDENT_NUMBER'
,p_display_order=>220
,p_column_identifier=>'U'
,p_column_label=>'Student Number'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146732110127049)
,p_db_column_name=>'CHECK_IN'
,p_display_order=>230
,p_column_identifier=>'V'
,p_column_label=>'Checked In'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146839431127050)
,p_db_column_name=>'CHECKIN_BY'
,p_display_order=>240
,p_column_identifier=>'W'
,p_column_label=>'Checked In By'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641146897040127051)
,p_db_column_name=>'RESOURCE_NAME'
,p_display_order=>250
,p_column_identifier=>'X'
,p_column_label=>'Venue'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641147073263127053)
,p_db_column_name=>'SUBJECT_STATUS'
,p_display_order=>270
,p_column_identifier=>'Y'
,p_column_label=>'Course Status'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(641147192724127054)
,p_db_column_name=>'ABSENT_WITH_MC'
,p_display_order=>280
,p_column_identifier=>'Z'
,p_column_label=>'Absent With Mc'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(80383306608916460)
,p_db_column_name=>'FATTS_CHECKIN_BY'
,p_display_order=>290
,p_column_identifier=>'AA'
,p_column_label=>'Attendance Checkin By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(80383460186916461)
,p_db_column_name=>'FATTS_CHECKIN_DATE'
,p_display_order=>300
,p_column_identifier=>'AB'
,p_column_label=>'Attendance Checkin Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(80383525722916462)
,p_db_column_name=>'FATTS_CHECKOUT_BY'
,p_display_order=>310
,p_column_identifier=>'AC'
,p_column_label=>'Attendance Checkout By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_CHECK NUMBER;',
'',
'BEGIN',
'',
'    SELECT COUNT(*) INTO V_CHECK',
'    FROM V_ATTENDANCE_POLICY',
'    WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY',
'    AND CAMPUS_KEY IN (select * from table(apex_string.split(:GLO_USER_CAMPUS,'':'')))',
'    AND NVL(IS_FATTS_CO,''N'') = ''Y'';',
'',
'    IF NVL(V_CHECK,0) > 0 THEN',
'',
'        RETURN TRUE;',
'',
'    END IF;',
'',
'END;'))
,p_display_condition2=>'PLSQL'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(80383645513916463)
,p_db_column_name=>'FATTS_CHECKOUT_DATE'
,p_display_order=>320
,p_column_identifier=>'AD'
,p_column_label=>'Attendance Checkout Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_CHECK NUMBER;',
'',
'BEGIN',
'',
'    SELECT COUNT(*) INTO V_CHECK',
'    FROM V_ATTENDANCE_POLICY',
'    WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY',
'    AND CAMPUS_KEY IN (select * from table(apex_string.split(:GLO_USER_CAMPUS,'':'')))',
'    AND NVL(IS_FATTS_CO,''N'') = ''Y'';',
'',
'    IF NVL(V_CHECK,0) > 0 THEN',
'',
'        RETURN TRUE;',
'',
'    END IF;',
'',
'END;'))
,p_display_condition2=>'PLSQL'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(80383846698916465)
,p_db_column_name=>'CHECKOUT_BY'
,p_display_order=>340
,p_column_identifier=>'AF'
,p_column_label=>'Checkout By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_CHECK NUMBER;',
'',
'BEGIN',
'',
'    SELECT COUNT(*) INTO V_CHECK',
'    FROM V_ATTENDANCE_POLICY',
'    WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY',
'    AND CAMPUS_KEY IN (select * from table(apex_string.split(:GLO_USER_CAMPUS,'':'')))',
'    AND NVL(IS_FATTS_CO,''N'') = ''Y'';',
'',
'    IF NVL(V_CHECK,0) > 0 THEN',
'',
'        RETURN TRUE;',
'',
'    END IF;',
'',
'END;'))
,p_display_condition2=>'PLSQL'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(80383880856916466)
,p_db_column_name=>'CHECK_OUT_TIME'
,p_display_order=>350
,p_column_identifier=>'AG'
,p_column_label=>'Student Check Out Time'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_CHECK NUMBER;',
'',
'BEGIN',
'',
'    SELECT COUNT(*) INTO V_CHECK',
'    FROM V_ATTENDANCE_POLICY',
'    WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY',
'    AND CAMPUS_KEY IN (select * from table(apex_string.split(:GLO_USER_CAMPUS,'':'')))',
'    AND NVL(IS_FATTS_CO,''N'') = ''Y'';',
'',
'    IF NVL(V_CHECK,0) > 0 THEN',
'',
'        RETURN TRUE;',
'',
'    END IF;',
'',
'END;'))
,p_display_condition2=>'PLSQL'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(6611076346517173)
,p_db_column_name=>'CHECK_OUT'
,p_display_order=>360
,p_column_identifier=>'AH'
,p_column_label=>'Check Out'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_CHECK NUMBER;',
'',
'BEGIN',
'',
'    SELECT COUNT(*) INTO V_CHECK',
'    FROM V_ATTENDANCE_POLICY',
'    WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY',
'    AND CAMPUS_KEY IN (select * from table(apex_string.split(:GLO_USER_CAMPUS,'':'')))',
'    AND NVL(IS_FATTS_CO,''N'') = ''Y'';',
'',
'    IF NVL(V_CHECK,0) > 0 THEN',
'',
'        RETURN TRUE;',
'',
'    END IF;',
'',
'END;'))
,p_display_condition2=>'PLSQL'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(6611027163517172)
,p_db_column_name=>'CHECK_IN_TIME'
,p_display_order=>370
,p_column_identifier=>'AI'
,p_column_label=>'Student Check In Time'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(200507224629363834)
,p_db_column_name=>'CHECK_IN_REMARKS'
,p_display_order=>380
,p_column_identifier=>'AJ'
,p_column_label=>'Check In Remarks'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(80612095608739330)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1108442'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'STUDENT_NAME:IC_PASSPORT:COURSE_CODE:STUDY_INTAKE:ACADEMIC_SEMESTER:SUBJECT_CODE:E_MAIL:STUDENT_MOBILE_NO:CLASS_SESSION:ATTENDANCE_DATE:TIME_FROM:TIME_TO:ATTENDED:LATE:VALID_REASON:REMARKS:LECTURER_NAME:LECTURER_IC_PASSPORT:LECTURER_PHONE:LECTURER_EM'
||'AIL:SCM_STUDENT_NUMBER:CHECK_IN:CHECKIN_BY:RESOURCE_NAME:SUBJECT_STATUS:ABSENT_WITH_MC:CHECK_IN_REMARKS:'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(41826043535381213)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(341882730423146908)
,p_button_name=>'EXIT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_imp.id(351195491941199451)
,p_button_image_alt=>'Back To Previous Page'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:378:&SESSION.::&DEBUG.:373::'
,p_icon_css_classes=>'fa-arrow-left-alt'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377579162607717519)
,p_name=>'P373_CAMPUS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(377579005370717518)
,p_prompt=>'Campus'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LIST OF CAMPUS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select CAMPUS_CODE as display_value, CAMPUS_KEY as return_value ',
'  from V_USER_CAMPUS',
'where institute_key = :glo_institute_key',
'and Customer_Key  = :glo_user_key',
'and Allowed = ''Y'' --Option hide if want release or show all campus',
'and App_ID = NV(''APP_ID'')',
'GROUP BY CAMPUS_CODE,CAMPUS_KEY',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(303295507693972048)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_inline_help_text=>'Please select campus.'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377579235008717520)
,p_name=>'P373_STUDY_INTAKE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(377579005370717518)
,p_prompt=>'Study Intake'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    STUDY_INTAKE D,',
'    STUDY_INTAKE R',
'FROM ATTENDANCE_MASTER',
'WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY',
'AND CAMPUS_KEY = :P373_CAMPUS',
'AND STUDY_INTAKE NOT IN (SELECT STUDY_INTAKE FROM JPK_STUDENT_SUBJECT WHERE STUDY_INTAKE = ATTENDANCE_MASTER.STUDY_INTAKE',
'                    AND CAMPUS_KEY IN (select * from table(apex_string.split(:GLO_USER_CAMPUS,'':''))))',
'GROUP BY STUDY_INTAKE',
'ORDER BY STUDY_INTAKE DESC'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P373_CAMPUS'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(303295507693972048)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_inline_help_text=>'Please select study intake.'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(377579327996717521)
,p_name=>'P373_CLASS_CODE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(377579005370717518)
,p_prompt=>'Class Code'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    CLASS_CODE D,',
'    CLASS_CODE R',
'FROM ATTENDANCE_MASTER',
'WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY',
'AND CAMPUS_KEY = :P373_CAMPUS',
'AND STUDY_INTAKE = :P373_STUDY_INTAKE',
'GROUP BY CLASS_CODE',
'ORDER BY CLASS_CODE DESC'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P373_CAMPUS,P373_STUDY_INTAKE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_SUBS_FATTS VARCHAR2(1);',
'',
'BEGIN',
'',
'    SELECT SUBS_FATTS INTO V_SUBS_FATTS FROM INSTITUTE_MASTER',
'    WHERE INSTITUTE_KEY = :GLO_INSTITUTE_KEY;',
'',
'    IF NVL(V_SUBS_FATTS,''N'') = ''N'' THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'END;'))
,p_display_when2=>'PLSQL'
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_imp.id(303295507693972048)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_inline_help_text=>'Please select class code.'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'POPUP',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(377579496163717522)
,p_name=>'When Study Intake Selected'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P373_STUDY_INTAKE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(377579513182717523)
,p_event_id=>wwv_flow_imp.id(377579496163717522)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(283279215233951946)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(641144162203127024)
,p_event_id=>wwv_flow_imp.id(377579496163717522)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(641144341415127025)
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(377579663884717524)
,p_name=>'When Class Code Selected'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P373_CLASS_CODE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(377579789545717525)
,p_event_id=>wwv_flow_imp.id(377579663884717524)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(283279215233951946)
,p_attribute_01=>'N'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
