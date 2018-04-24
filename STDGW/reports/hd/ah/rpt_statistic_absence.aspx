<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

string p_to,p_org,p_status,p_nation, p_month;    

       
		p_org = Request["p_org"].ToString();
		p_status = Request["p_status"].ToString();
		p_nation = Request["p_nation"].ToString();
		p_month = Request["p_month"].ToString();
        
string SQL
    = "select decode(max(b.EMPLOYEE_TYPE),'01','OFFICE','FACTORY'), b.EMP_ID as emp_1, b.FULL_NAME, c.org_nm as name_2 " + 
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)-1||'1216' and substr('"+ p_month +"',1,4)||'0115' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)-1||'1216' and substr('"+ p_month +"',1,4)||'0115' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)-1||'1216' and substr('"+ p_month +"',1,4)||'0115' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)-1||'1216' and substr('"+ p_month +"',1,4)||'0115' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)-1||'1216' and substr('"+ p_month +"',1,4)||'0115' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0116' and substr('"+ p_month +"',1,4)||'0215' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0116' and substr('"+ p_month +"',1,4)||'0215' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0116' and substr('"+ p_month +"',1,4)||'0215' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0116' and substr('"+ p_month +"',1,4)||'0215' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0116' and substr('"+ p_month +"',1,4)||'0215' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0216' and substr('"+ p_month +"',1,4)||'0315' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0216' and substr('"+ p_month +"',1,4)||'0315' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0216' and substr('"+ p_month +"',1,4)||'0315' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0216' and substr('"+ p_month +"',1,4)||'0315' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0216' and substr('"+ p_month +"',1,4)||'0315' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0316' and substr('"+ p_month +"',1,4)||'0415' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0316' and substr('"+ p_month +"',1,4)||'0415' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0316' and substr('"+ p_month +"',1,4)||'0415' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0316' and substr('"+ p_month +"',1,4)||'0415' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0316' and substr('"+ p_month +"',1,4)||'0415' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0416' and substr('"+ p_month +"',1,4)||'0515' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0416' and substr('"+ p_month +"',1,4)||'0515' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0416' and substr('"+ p_month +"',1,4)||'0515' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0416' and substr('"+ p_month +"',1,4)||'0515' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0416' and substr('"+ p_month +"',1,4)||'0515' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0516' and substr('"+ p_month +"',1,4)||'0615' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0516' and substr('"+ p_month +"',1,4)||'0615' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0516' and substr('"+ p_month +"',1,4)||'0615' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0516' and substr('"+ p_month +"',1,4)||'0615' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0516' and substr('"+ p_month +"',1,4)||'0615' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0616' and substr('"+ p_month +"',1,4)||'0715' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0616' and substr('"+ p_month +"',1,4)||'0715' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0616' and substr('"+ p_month +"',1,4)||'0715' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0616' and substr('"+ p_month +"',1,4)||'0715' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0616' and substr('"+ p_month +"',1,4)||'0715' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0716' and substr('"+ p_month +"',1,4)||'0815' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0716' and substr('"+ p_month +"',1,4)||'0815' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0716' and substr('"+ p_month +"',1,4)||'0815' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0716' and substr('"+ p_month +"',1,4)||'0815' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0716' and substr('"+ p_month +"',1,4)||'0815' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0816' and substr('"+ p_month +"',1,4)||'0915' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0816' and substr('"+ p_month +"',1,4)||'0915' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0816' and substr('"+ p_month +"',1,4)||'0915' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0816' and substr('"+ p_month +"',1,4)||'0915' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0816' and substr('"+ p_month +"',1,4)||'0915' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0916' and substr('"+ p_month +"',1,4)||'1015' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0916' and substr('"+ p_month +"',1,4)||'1015' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0916' and substr('"+ p_month +"',1,4)||'1015' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0916' and substr('"+ p_month +"',1,4)||'1015' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'0916' and substr('"+ p_month +"',1,4)||'1015' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1016' and substr('"+ p_month +"',1,4)||'1115' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1016' and substr('"+ p_month +"',1,4)||'1115' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1016' and substr('"+ p_month +"',1,4)||'1115' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1016' and substr('"+ p_month +"',1,4)||'1115' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1016' and substr('"+ p_month +"',1,4)||'1115' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1116' and substr('"+ p_month +"',1,4)||'1215' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as al_3 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1116' and substr('"+ p_month +"',1,4)||'1215' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_4 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1116' and substr('"+ p_month +"',1,4)||'1215' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as unpay_5 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1116' and substr('"+ p_month +"',1,4)||'1215' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as sick_6 " +
        ", sum(case when a.ABSENCE_DT between substr('"+ p_month +"',1,4)||'1116' and substr('"+ p_month +"',1,4)||'1215' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as other_7 " +
        ", sum(case when substr(a.ABSENCE_DT,1,6)<='"+ p_month +"' and a.ABSENCE_TYPE='01' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as total_al_3 " +
        ", sum(case when substr(a.ABSENCE_DT,1,6)<='"+ p_month +"' and a.ABSENCE_TYPE='19' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as total_unpay_4 " +
        ", sum(case when substr(a.ABSENCE_DT,1,6)<='"+ p_month +"' and a.ABSENCE_TYPE in ('05','13') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as total_unpay_5 " +
        ", sum(case when substr(a.ABSENCE_DT,1,6)<='"+ p_month +"' and a.ABSENCE_TYPE='07' then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as total_sick_6 " +
        ", sum(case when substr(a.ABSENCE_DT,1,6)<='"+ p_month +"' and a.ABSENCE_TYPE not in ('01','19','05','13','07') then decode(a.ABSENCE_TIME,9,8,nvl(a.ABSENCE_TIME,0))/8 else 0 end ) as total_other_7 " +
        "from thr_absence a, thr_employee b, comm.tco_org c " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
        "and a.THR_EMP_PK = b.pk and b.TCO_ORG_PK = c.pk " +
        "and substr(a.ABSENCE_DT,1,4)= substr('"+ p_month +"',1,4) " +
        "and Decode('"+ p_status +"','ALL','ALL', b.STATUS )= '"+ p_status +"' " +
		"and Decode('"+ p_nation +"','ALL','ALL', b.NATION )= '"+ p_nation +"' " +
		" and (b.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_org + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_org + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_org + "' = 'ALL') " +
		"group by c.org_nm, b.EMP_ID, b.FULL_NAME, b.EMPLOYEE_TYPE " +
        "order by b.EMPLOYEE_TYPE, c.ORG_NM, b.FULL_NAME " ;


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }

    int mon = int.Parse(p_month.Substring(4, 2).ToString());
    int col_span = 10 + (mon*5);
    string[] mon_name = new string[12] { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_statistic_absence_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_statistic_absence_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_statistic_absence_vhpc_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>user</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-03-14T01:58:25Z</o:LastPrinted>
  <o:Created>2011-03-10T07:57:15Z</o:Created>
  <o:LastSaved>2011-03-14T02:53:27Z</o:LastSaved>
  <o:Company>Hewlett-Packard Company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .5in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl65
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022?_-\;_-\@_-";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022?_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10995</x:WindowHeight>
  <x:WindowWidth>19095</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>150</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1049 style='border-collapse:
 collapse;table-layout:fixed;width:786pt'>
 <col class=xl68 width=64 style='width:48pt'>
 <col class=xl72 width=64 style='width:48pt'>
 <col class=xl72 width=154 style='mso-width-source:userset;mso-width-alt:5632;
 width:116pt'>
 <col class=xl72 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
   <%
    
    for (int k = 0; k < mon; k++)
    {
   %>
 <col class=xl65 width=47 span=4 style='mso-width-source:userset;mso-width-alt:
 1718;width:35pt'>
 <col class=xl65 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <%} %>
 <col class=xl65 width=47 span=4 style='mso-width-source:userset;mso-width-alt:
 1718;width:35pt'>
 <col class=xl65 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl65 width=64 span=3 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl68 width=64 style='height:15.75pt;width:48pt'></td>
  <td class=xl72 width=64 style='width:48pt'></td>
  <td class=xl72 width=154 style='width:116pt'></td>
  <td class=xl72 width=93 style='width:70pt'></td>
  <td class=xl65 width=47 style='width:35pt'></td>
  <td class=xl65 width=47 style='width:35pt'></td>
  <td class=xl65 width=47 style='width:35pt'></td>
  <td class=xl65 width=47 style='width:35pt'></td>
  <td class=xl65 width=53 style='width:40pt'></td>
  <td class=xl65 width=47 style='width:35pt'></td>
  <td class=xl65 width=47 style='width:35pt'></td>
  <td class=xl65 width=47 style='width:35pt'></td>
  <td class=xl65 width=47 style='width:35pt'></td>
  <td class=xl65 width=53 style='width:40pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=<%= col_span %> rowspan=2 height=49 class=xl100 style='height:36.75pt'>EMPLOYEE
  ABSENCE RECORD IN YEAR <%= p_month.Substring(0,4).ToString() %></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'></td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=3 height=89 class=xl91 style='border-bottom:.5pt solid black;
  height:66.75pt'>No</td>
  <td rowspan=3 class=xl91 style='border-bottom:.5pt solid black'>Code</td>
  <td rowspan=3 class=xl91 style='border-bottom:.5pt solid black'>Full Name</td>
  <td rowspan=3 class=xl91 style='border-bottom:.5pt solid black'>Department</td>
  <%
    
    for (int k = 0; k < mon; k++)
    {
   %>
      <td colspan=5 class=xl96 style='border-right:.5pt solid black;border-left:
      none'><%= mon_name[k].ToString() %></td>
  <%} %>
  <td colspan=5 class=xl88 style='border-right:.5pt solid black;border-left:
  none'>TOTAL</td>
  <td class=xl75 style='border-left:none'>Remark</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
   <%
    
    for (int k = 0; k < mon; k++)
    {
   %>
  <td rowspan=2 height=57 class=xl94 style='border-bottom:.5pt solid black;
  height:42.75pt;border-top:none' x:str="AL ">AL<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl96 style='border-right:.5pt solid black;border-left:
  none'>A</td>
  <td rowspan=2 class=xl94 style='border-bottom:.5pt solid black;border-top:
  none'>S</td>
  <td rowspan=2 class=xl94 style='border-bottom:.5pt solid black;border-top:
  none'>Other</td>
  <%} %>
  <td rowspan=2 class=xl86 style='border-bottom:.5pt solid black;border-top:
  none' x:str="AL ">AL<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl88 style='border-right:.5pt solid black;border-left:
  none'>A</td>
  <td rowspan=2 class=xl86 style='border-bottom:.5pt solid black;border-top:
  none'>S</td>
  <td rowspan=2 class=xl86 style='border-bottom:.5pt solid black;border-top:
  none'>Other</td>
  <td class=xl76 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
    <%
    
    for (int k = 0; k < mon; k++)
    {
   %>
  <td height=29 class=xl81 style='height:21.75pt;border-top:none;border-left:
  none'>Private</td>
  <td class=xl82 style='border-top:none;border-left:none'>Absence</td>
  <%} %>
  <td class=xl84 style='border-top:none;border-left:none'>Private</td>
  <td class=xl85 style='border-top:none;border-left:none'>Absence</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <%
     int i = 0;
	 int count =1;
     
	 Boolean flag= true;
	 string emp_type_old, emp_type_new ; 
     for (i = 0; i < irow_emp; i++)
     {  
		emp_type_old = dt_Emp.Rows[i][0].ToString();
		
		if(flag)
		{
  %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=3 height=32 class=xl90 style='height:24.0pt'><%=dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl74 style='border-top:none'>&nbsp;</td>
  <%
      for (int k = 0; k < mon; k++)
    {
   %>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <%} %>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
  <%	
			flag=false;
		}
 %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl69 style='height:24.0pt;border-top:none' x:num><%= count %></td>
  <td class=xl70 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl101 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl101 style='border-top:none'><%=dt_Emp.Rows[i][3].ToString() %></td>
    <%
        for (int k = 0; k < mon; k++)
        {
   %>
  <td class=xl80 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][5*k+4].ToString()%> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][5*k+5].ToString()%> </td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][5*k+6].ToString()%><span style='mso-spacerun:yes'> 
  </span></td>
  <td class=xl80 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][5*k+7].ToString()%><span style='mso-spacerun:yes'> 
  </span></td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%=dt_Emp.Rows[i][5*k+8].ToString()%><span style='mso-spacerun:yes'> 
  </span></td>
  <%     } %>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][64].ToString()%> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][65].ToString()%> </td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][66].ToString()%><span style='mso-spacerun:yes'> 
  </span></td>
  <td class=xl80 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][67].ToString()%><span style='mso-spacerun:yes'> 
  </span></td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%=dt_Emp.Rows[i][68].ToString()%><span style='mso-spacerun:yes'> 
  </span></td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <%
			
			if(i<irow_emp-1)
			{
				count = count +1;
				emp_type_new = dt_Emp.Rows[i+1][0].ToString();
				if( emp_type_new != emp_type_old)
				{	
					flag = true;
					
				}
			}
			else flag = true;
		
		}	
	%>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl68 style='height:15.75pt'></td>
  <td colspan=3 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl68 style='height:15.75pt'></td>
  <td colspan=3 class=xl72 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
