<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_dept,p_group,p_status,p_type,p_pay_type,p_emp_id,p_work_mon;
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    string p_m_type = Request.QueryString["l_m_type"].ToString();
    //" and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
      
    
    
   string SQL
	= "select c.PARTNER_LNAME,  " +                                  //0
        "c.TCO_BPPHOTO_PK,  " +                                             //1
        "to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY'),  " +   //2
        "A.FULL_NAME,  " +                                             //3
        "A.EMP_ID,  " +                                             //4
        "a.THR_GROUP_NM,  " +                                          //5
        "to_char(to_date(A.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy'),  " +  //6
        "A.POS_NM,    " +  //7
        "to_char(to_date(A.left_DT,'yyyymmdd'),'dd/mm/yyyy'),  " +  //8
        "round(NVL(A.SALARY_LEVEL1,0),3),  " +                               //9
        "round(NVL(A.SALARY_LEVEL2,0),3),  " +                               //10
        "round(NVL(A.ALLOW_AMT1,0),3),  " +                                  //11
        "ROUND(NVL(A.ALLOW_AMT2,0),3),  " +                                  //12
        "ROUND(NVL(A.ALLOW_AMT3,0),3),  " +                                  //13
        "ROUND(NVL(A.ALLOW_AMT4,0),3),  " +                                  //14
        "ROUND(NVL(A.ALLOW_AMT5,0),3),  " +                                  //15
        "ROUND(NVL(A.ALLOW_AMT6,0),3),  " +                                  //16
        "ROUND(NVL(A.ALLOW_AMT7,0),3),  " +                                  //17
        "ROUND(NVL(A.ALLOW_AMT8,0),3),  " +                                  //18
        "ROUND(NVL(A.WT_L1,0) + NVL(a.HOL_DAY_L1,0)*8,3), " +                                       //19
        "ROUND(NVL(A.WT_L2,0) + NVL(a.HOL_DAY_L2,0)*8 ,3), " +                                        //20
        "ROUND(NVL(A.WT_L1_AMT,0) + NVL(a.HOL_DAY_L1_AMT,0) + NVL(A.WT_L2_AMT,0) + NVL(a.HOL_DAY_L2_AMT,0),3), " + //21
        "ROUND(NVL(A.ABS_ALE_L1,0),3), " +                                    //22
        "ROUND(NVL(A.ABS_ALE_L2,0),3), " +                                    //23
        "ROUND(NVL(A.ABS_ALE_L1_AMT,0) + NVL(A.ABS_ALE_L2_AMT,0),3), " +      //24 tong tien vang phep nam
        "ROUND(NVL(A.ABS_OTHER_PAY_L1,0),3), " +        //25
        "ROUND(NVL(A.ABS_OTHER_PAY_L2,0),3), " +        //26
        "ROUND(NVL(A.ABS_OTHER_PAY_L1_AMT,0) + nvl(A.ABS_OTHER_PAY_L2_AMT,0),3), " +        //27 nho  tru lai tien vang khac 
        "ROUND(NVL(A.OT_L1,0),3), " +                                        //28
        "ROUND(NVL(A.OT_L2,0),3), " +                                        //29
        "ROUND(NVL(A.OT_L1_AMT,0)+ NVL(A.OT_L2_AMT,0),3), " +                                        //30
        "ROUND(NVL(A.ST_L1,0) + nvl(A.HT_L1,0),3), " +                       //31
        "ROUND(NVL(A.ST_L2,0) + nvl(A.HT_L2,0),3), " +                       //32
        "ROUND(NVL(A.ST_L1_AMT,0) + nvl(A.HT_L1_AMT,0)+ nvl(A.ST_L2_AMT,0) + nvl(A.HT_L2_AMT,0),3), " +     //33
        "ROUND(NVL(A.NT_30_L1,0),3), " +                                     //34
        "ROUND(NVL(A.NT_30_L2,0),3), " +                                     //35
        "ROUND(NVL(A.NT_30_L1_AMT,0) + NVL(A.NT_30_L2_AMT,0) ,3), " +        //36
        "ROUND(NVL(A.NT_45_L1,0),3), " +                                     //37
        "ROUND(NVL(A.NT_45_L2,0),3), " +                                     //38
        "ROUND(NVL(A.NT_45_L1_AMT,0) + NVL(A.NT_45_L2_AMT,0),3), " +         //39
        "ROUND(NVL(A.NT_60_L1,0),3), " +                                     //40
        "ROUND(NVL(A.NT_60_L2,0),3), " +                                     //41
        "ROUND(NVL(A.NT_60_L1_AMT,0) + NVL(A.NT_60_L2_AMT,0),3), " +         //42
        "ROUND(NVL(A.NT_90_L1,0),3), " +                                     //43
        "ROUND(NVL(A.NT_90_L2,0),3), " +                                     //44
        "ROUND(NVL(A.NT_90_L1_AMT,0) + NVL(A.NT_90_L2_AMT,0),3), " +         //45
        "ROUND(NVL(A.ALLOW_K1_AMT,0),3),  " +                                //46
        "ROUND(NVL(A.ALLOW_K2_AMT,0),3),  " +                                //47
        "ROUND(NVL(A.ALLOW_K3_AMT,0),3),  " +                                //48
        "ROUND(NVL(A.ALLOW_K4_AMT,0),3),  " +                                //49
        "ROUND(NVL(A.ALLOW_K5_AMT,0),3),  " +                                //50
        "ROUND(NVL(A.ALLOW_K6_AMT,0),3),  " +                                //51
        "ROUND(NVL(A.ALLOW_K7_AMT,0),3),  " +                                //52
        "ROUND(NVL(A.ALLOW_K8_AMT,0),3),  " +                                //53
        "ROUND(NVL(A.RETURN_AMT,0)  ,3), " +                //54
        "ROUND(NVL(A.ALE_STOP,0),3),  " +                                    //55
        "ROUND(NVL(A.ALE_STOP_AMT,0),3),  " +                                //56
        "ROUND(NVL(A.SEVERANCE_MONTH,0),3),  " +                             //57
        "ROUND(NVL(A.SEVERANCE_AMT,0),3),  " +                               //58
        "ROUND(NVL(A.GROSS_AMT,0),3),  " +                            //59
        "ROUND(NVL(A.BREAK_CONTRACT_DAYS,0),3), " +                           //60
        "ROUND(NVL(A.BREAK_CONTRACT_AMT,0),3), " +                           //61
        "ROUND(NVL(A.ADVANCE_AMT,0),3),  " +                                 //62
        "ROUND(NVL(A.INCOME_BEFORE_TAX,NVL(A.INCOME_AMT,0)),3),  " +                           //63
        "ROUND(NVL(A.INCOME_TAX,0),3),  " +                           //64
        "ROUND(NVL(A.UNION_AMT,0),3),  " +                                   //65
        "ROUND(NVL(A.SOCIAL_AMT,0) + nvl(A.HEALTH_AMT,0),3) ,  " +           //66
        "ROUND(NVL(A.RETURN_NO_PIT,0),3)," + //67 
        "ROUND(NVL(A.ADVANCE_NO_PIT,0),3)," + //68 
        "DECODE('" + p_m_type + "','ALL',round(NVL(A.NET_amt,0),0),'01',round(NVL(A.NET_amt,0),0),round(NVL(A.NET_AMT,0),2)),  " +        //69
        "ROUND(NVL(A.UNEMP_INS,0),3) , " +        //70
        "ROUND(NVL(A.OT_TAX_L1_AMT,0)+NVL(A.OT_TAX_L2_AMT,0),3),  " +        //71
        "ROUND(NVL(A.DEDUCT_PIT,0),3),  " +        //72
        "ROUND(nvl(A.INC_AMT,0),3),  " +        //73
        "ROUND( nvl(A.OST_L1,0),3), " +                       //74
        "ROUND( nvl(A.OST_L2,0),3), " +                       //75
        "ROUND( nvl(A.OST_L1_AMT,0) + nvl(A.OST_L2_AMT,0),3), " +     //76
        "ROUND( nvl(A.OHT_L1,0),3), " +                       //77
        "ROUND( nvl(A.OHT_L2,0),3), " +                       //78
        "ROUND( nvl(A.OHT_L1_AMT,0) + nvl(A.OHT_L2_AMT,0),3) " +     //79
        "from thr_month_salary a,comm.tco_dept b,tco_company c " +         
        "where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
        "and b.del_if=0 and a.tco_dept_pk=b.pk " +
        "and c.del_if(+)=0 and b.tco_company_pk(+)=c.pk " +
        " and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
        " and a.emp_id like '%" + p_emp_id + "%' " + 
        " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
        " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
        " and nvl(a.net_amt,0) " + p_type  + 
        "order by a.dept_nm,a.thr_group_nm,a.emp_id" ;



//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
    
    string SQL_Allow
	= "   SELECT MAX (code1), MAX (code2), MAX (code3), MAX (code4), MAX (code5), " + 
        "             MAX (code6), MAX (code7), MAX (code8), MAX (c1), MAX (c2), " +
        "             MAX (c3), MAX (c4), MAX (c5), MAX (c6), MAX (c7), MAX (c8), " +
        "           MAX (codef1), MAX (codef2), MAX (codef3), MAX (codef4), MAX (codef5), " + 
        "             MAX (codef6), MAX (codef7), MAX (codef8) " +
        "        FROM (SELECT DECODE (code, 'A1', a.code_nm, '') AS code1, " +
        "                     DECODE (code, 'A2', a.code_nm, '') AS code2, " +
        "                     DECODE (code, 'A3', a.code_nm, '') AS code3, " +
        "                     DECODE (code, 'A4', a.code_nm, '') AS code4, " +
        "                     DECODE (code, 'A5', a.code_nm, '') AS code5, " +
        "                     DECODE (code, 'A6', a.code_nm, '') AS code6, " +
        "                     DECODE (code, 'A7', a.code_nm, '') AS code7, " +
        "                     DECODE (code, 'A8', a.code_nm, '') AS code8, " +
        "                     DECODE (code, 'A1', a.num_2, '') AS c1, " +
        "                     DECODE (code, 'A2', a.num_2, '') AS c2, " +
        "                     DECODE (code, 'A3', a.num_2, '') AS c3, " +
        "                     DECODE (code, 'A4', a.num_2, '') AS c4, " +
        "                     DECODE (code, 'A5', a.num_2, '') AS c5, " +
        "                     DECODE (code, 'A6', a.num_2, '') AS c6, " +
        "                     DECODE (code, 'A7', a.num_2, '') AS c7, " +
        "                     DECODE (code, 'A8', a.num_2, '') AS c8, " +
        "                     DECODE (code, 'A1', a.code_fnm, '') AS codef1, " +
        "                     DECODE (code, 'A2', a.code_fnm, '') AS codef2, " +
        "                     DECODE (code, 'A3', a.code_fnm, '') AS codef3, " +
        "                     DECODE (code, 'A4', a.code_fnm, '') AS codef4, " +
        "                     DECODE (code, 'A5', a.code_fnm, '') AS codef5, " +
        "                     DECODE (code, 'A6', a.code_fnm, '') AS codef6, " +
        "                     DECODE (code, 'A7', a.code_fnm, '') AS codef7, " +
        "                     DECODE (code, 'A8', a.code_fnm, '') AS codef8 " +
        "                FROM vhr_hr_code a " +
        "               WHERE a.ID = 'HR0019'  ) allow_amt " ;
    DataTable dt_Allow = ESysLib.TableReadOpen(SQL_Allow);
    int irow_Allow,icol_Allow;
    irow_Allow = dt_Allow.Rows.Count;
    icol_Allow=0;
    if (irow_Allow == 0)
    {
        Response.Write("There is no data of allowance");
        Response.End();
    }
    else
    {
        icol_Allow=0;
        for (int i=0;i<8;i++)
        {
            if (dt_Allow.Rows[0][i+7].ToString()=="1")
                icol_Allow+=1;
        }
    }
    
    string SQL_Allowk
	= " SELECT max(name1),max(name2),max(name3),max(name4),max(name5),max(name6),max(name7),max(name8) " + 
        "        FROM (SELECT DECODE (kind, '01', a.name, '') AS name1, " +
        "                     DECODE (kind, '02', a.name, '') AS name2, " +
        "                     DECODE (kind, '03', a.name, '') AS name3, " +
        "                     DECODE (kind, '04', a.name, '') AS name4, " +
        "                     DECODE (kind, '05', a.name, '') AS name5, " +
        "                     DECODE (kind, '06', a.name, '') AS name6, " +
        "                     DECODE (kind, '07', a.name, '') AS name7, " +
        "                     DECODE (kind, '08', a.name, '') AS name8 " +
        "                FROM THR_ALLOWANCE_MASTER A  " +
        "               WHERE del_if=0) allow_k " ;

    DataTable dt_Allowk = ESysLib.TableReadOpen(SQL_Allowk);
    int irow_Allowk,icol_Allowk;
    irow_Allowk = dt_Allowk.Rows.Count;
    icol_Allowk=0;
    if (irow_Allowk == 0)
    {
        Response.Write("There is no data of allowance");
        Response.End();
    }
    else
    {
        icol_Allowk=0;
        for (int i=0;i<8;i++)
        {
            if (dt_Allowk.Rows[0][i].ToString()!="")
                icol_Allowk+=1;
        }
    }
    //khai bao bien
     string cur_grp,next_grp;
    
 %>


<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_salary_pay_slip_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_salary_pay_slip_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_salary_pay_slip_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-09-16T01:38:24Z</o:LastPrinted>
  <o:Created>2008-09-09T06:34:57Z</o:Created>
  <o:LastSaved>2008-09-16T02:26:23Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.02in .25in .17in .25in;
	mso-header-margin:.17in;
	mso-footer-margin:.17in;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
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
.xl24
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;
	}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt hairline windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt hairline windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl94
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;}
.xl96
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl104
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl105
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt hairline windowtext;}
.xl107
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl108
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>11</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>150</x:Zoom>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>12</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <% 
        int irow=0;
        for (int k=0;k<irow_emp;k++)
        {
            if (p_status=="A")
                irow+=53 - (8-icol_Allow) - (8-icol_Allowk)-2 ;
            else
                irow+=53 - (8-icol_Allow) - (8-icol_Allowk) ;
            %>
            
            <x:RowBreak>
                <x:Row><%=irow %></x:Row>
            </x:RowBreak>
            <%    
               
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7680</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>360</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=503 style='border-collapse:
 collapse;table-layout:fixed;width:379pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=166 style='mso-width-source:userset;mso-width-alt:6070;
 width:125pt'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl24 width=56 span=2 style='mso-width-source:userset;mso-width-alt:
 2048;width:42pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <%
    for (int i=0;i<irow_emp;i++)
    {
  %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=7 height=23 width=503 style='border-right:.5pt solid black;
  height:17.25pt;width:379pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:3pt;margin-top:2.25pt;width:64.5pt;height:48.75pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Emp.Rows[i][1].ToString()%>&table_name=tco_bpphoto" o:title="vinagenuwin"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:3px;width:86px;
  height:65px'><img width=86 height=65
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Emp.Rows[i][1].ToString()%>&table_name=tco_bpphoto" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=7 height=23 class=xl69 width=503 style='border-right:.5pt solid black;
    height:17.25pt;width:379pt'><%=dt_Emp.Rows[i][0].ToString()%></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=7 height=23 class=xl72 style='border-right:.5pt solid black;
  height:17.25pt'>PAY-SLIP IN <%=dt_Emp.Rows[i][2].ToString()%></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=7 height=23 class=xl75 style='border-right:.5pt solid black;
  height:17.25pt'>PHI&#7870;U L&#431;&#416;NG THÁNG <%=p_work_mon.Substring(4,2).ToString() + "-" + p_work_mon.Substring(0,4).ToString() %></td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=7 height=25 class=xl78 style='border-right:.5pt solid black;
  height:18.75pt' >H&#7885; tên :<%=dt_Emp.Rows[i][3].ToString()%> <span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl101 style='height:16.5pt'>Mã NV<span
  style='mso-spacerun:yes'>     </span>:</td>
  <td class=xl102><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl103></td>
  <td class=xl103 colspan=2 style='mso-ignore:colspan'>B&#7897; ph&#7853;n<span
  style='mso-spacerun:yes'>           </span>:</td>
  <td colspan=2 class=xl102 style='border-right:.5pt solid black'><%=dt_Emp.Rows[i][5].ToString()%></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl28 style='height:16.5pt'>Ngày vào<span
  style='mso-spacerun:yes'>  </span>:</td>
  <td class=xl105><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl29><span style='mso-spacerun:yes'> </span></td>
  <td class=xl29 colspan=2 style='mso-ignore:colspan'>
  <%if (p_status=="A") 
        {%> Chức vụ
  <%}
  else
  {
    %>
    Ngày ngh&#7881;
  vi&#7879;c
    <%
  } %>
  :</td>
  <td colspan=2 class=xl105 style='border-right:.5pt solid black'>
  <%if (p_status=="A") 
    {
        Response.Write(dt_Emp.Rows[i][7].ToString());
    }
  else
  {
    Response.Write(dt_Emp.Rows[i][8].ToString());
  } %></td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=3 height=18 class=xl87 style='height:13.5pt'>Tiêu &#273;&#7873;</td>
  <td colspan=2 class=xl89>Th&#7917; vi&#7879;c (TV)</td>
  <td colspan=2 class=xl89 style='border-right:.5pt solid black;border-left:
  none'>Chính th&#7913;c (CT)</td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl37 colspan=2 style='height:17.25pt;mso-ignore:colspan'>L&#432;&#417;ng
  (<font class="font12">Salary</font><font class="font8">)</font></td>
  <td class=xl39>:</td>
  <td colspan=2 class=xl91 x:num><span
  style='mso-spacerun:yes'>         </span><%=dt_Emp.Rows[i][9].ToString() %></td>
  <td colspan=2 class=xl92 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>              
  </span><%=dt_Emp.Rows[i][10].ToString() %></td>
 </tr>
 <%
    if (dt_Allow.Rows[0][8].ToString()=="1")
    {
    %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl26 colspan=2 style='height:17.25pt;mso-ignore:colspan'><% =dt_Allow.Rows[0][0].ToString()%>(<font class="font12"><% =dt_Allow.Rows[0][16].ToString()%></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][11].ToString() %></td>
 </tr>
  <%} %>
 <%
    if (dt_Allow.Rows[0][9].ToString()=="1")
    {
    %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl26 colspan=2 style='height:17.25pt;mso-ignore:colspan'><% =dt_Allow.Rows[0][1].ToString()%> (<font class="font12"><% =dt_Allow.Rows[0][17].ToString()%></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl59 style='mso-ignore:colspan'></td>
  <td class=xl60 x:num><span style='mso-spacerun:yes'>   
  </span><%=dt_Emp.Rows[i][12].ToString() %></td>
 </tr>
 <%} %>
 <%
    if (dt_Allow.Rows[0][10].ToString()=="1")
    {
    %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl26 colspan=2 style='height:17.25pt;mso-ignore:colspan'><% =dt_Allow.Rows[0][2].ToString()%>(<font class="font12"><% =dt_Allow.Rows[0][18].ToString()%></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl59 style='mso-ignore:colspan'></td>
  <td class=xl60 x:num><span style='mso-spacerun:yes'>   
  </span><%=dt_Emp.Rows[i][13].ToString() %></td>
 </tr>
 <%} %>
 <%
    if (dt_Allow.Rows[0][11].ToString()=="1")
    {
    %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl26 colspan=2 style='height:17.25pt;mso-ignore:colspan'><% =dt_Allow.Rows[0][3].ToString()%> (<font class="font12"><% =dt_Allow.Rows[0][19].ToString()%></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl59 style='mso-ignore:colspan'></td>
  <td class=xl60 x:num><span style='mso-spacerun:yes'>   
  </span><%=dt_Emp.Rows[i][14].ToString() %> </td>
 </tr>
 <%} %>
 <%
    if (dt_Allow.Rows[0][12].ToString()=="1")
    {
    %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl26 colspan=2 style='height:17.25pt;mso-ignore:colspan'><% =dt_Allow.Rows[0][4].ToString()%> (<font class="font12"><% =dt_Allow.Rows[0][20].ToString()%></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl59 style='mso-ignore:colspan'></td>
  <td class=xl60 x:num><span style='mso-spacerun:yes'>   
  </span><%=dt_Emp.Rows[i][15].ToString() %></td>
 </tr>
 <%} %>
 <%
    if (dt_Allow.Rows[0][13].ToString()=="1")
    {
    %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl26 colspan=2 style='height:17.25pt;mso-ignore:colspan'><% =dt_Allow.Rows[0][5].ToString()%> (<font class="font12"><% =dt_Allow.Rows[0][21].ToString()%></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl59 style='mso-ignore:colspan'></td>
  <td class=xl60 x:num><span style='mso-spacerun:yes'>   
  </span><%=dt_Emp.Rows[i][16].ToString() %></td>
 </tr>
 <%} %>
 <%
    if (dt_Allow.Rows[0][14].ToString()=="1")
    {
    %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl26 colspan=2 style='height:17.25pt;mso-ignore:colspan'><% =dt_Allow.Rows[0][6].ToString()%> (<font class="font12"><% =dt_Allow.Rows[0][22].ToString()%></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl59 style='mso-ignore:colspan'></td>
  <td class=xl60 x:num><span style='mso-spacerun:yes'>   
  </span><%=dt_Emp.Rows[i][17].ToString() %></td>
 </tr>
 <%} %>
 <%
    if (dt_Allow.Rows[0][15].ToString()=="1")
    {
    %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl40 colspan=2 style='height:17.25pt;mso-ignore:colspan'><% =dt_Allow.Rows[0][7].ToString()%> (<font class="font12"><% =dt_Allow.Rows[0][23].ToString()%></font><font class="font8">)</font></td>
  <td class=xl42>:</td>
  <td class=xl61 style='border-left:none'>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63 x:num><span style='mso-spacerun:yes'>   
  </span><%=dt_Emp.Rows[i][18].ToString() %></td>
 </tr>
 <%} %>
 
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl94 style='height:14.25pt'>Tiêu &#273;&#7873;</td>
  <td class=xl47 style='border-left:none'>TV</td>
  <td class=xl47 style='border-left:none'>CT</td>
  <td class=xl47 style='border-left:none'>&#272;VT</td>
  <td class=xl48 style='border-left:none'>Thành ti&#7873;n</td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl37 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Ngày
  công (<font class="font12">Working Days</font><font class="font8">)</font></td>
  <td class=xl39>:</td>
  <td class=xl49 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][19].ToString() %> </td>
  <td class=xl50 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][20].ToString() %> </td>
  <td class=xl43 style='border-left:none'>Gi&#7901;</td>
  <td class=xl44 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][21].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Ngh&#7881;
  phép n&#259;m (<font class="font12">ALE Absence</font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][22].ToString() %> </td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][23].ToString() %>  </td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][24].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Ngày
  v&#7855;ng khác (Other Absence)</td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][25].ToString() %>  </td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][26].ToString() %>  </td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][27].ToString() %>  </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>T&#259;ng
  ca th&#432;&#7901;ng (<font class="font12">Overtime 1.5</font><font
  class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][28].ToString() %> </td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][29].ToString() %></td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][30].ToString() %></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Làm CN/l&#7877; (<font class="font12">ST & HT 2.0</font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][31].ToString() %></td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][32].ToString() %> </td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][33].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>T&#259;ng
  ca CN (<font class="font12">OST</font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][74].ToString() %></td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][75].ToString() %> </td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][76].ToString() %> </td>
 </tr>
  <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>T&#259;ng
  ca Lễ (<font class="font12">OHT</font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][77].ToString() %></td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][78].ToString() %> </td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][79].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>PC
  ca &#273;êm (<font class="font12">NT 0.3</font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][34].ToString() %> </td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][35].ToString() %> </td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][36].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>PCTC
  &#273;êm th&#432;&#7901;ng (<font class="font12">NT 0.45</font><font
  class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][37].ToString() %> </td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][38].ToString() %> </td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][39].ToString() %></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>PCTC
  &#273;êm CN (<font class="font12">NT 0.6</font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][40].ToString() %> </td>
  <td class=xl30 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][41].ToString() %></td>
  <td class=xl31 style='border-left:none'>Gi&#7901;</td>
  <td class=xl32 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][42].ToString() %></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl40 colspan=2 style='height:15.75pt;mso-ignore:colspan'>PCTC
  &#273;êm l&#7877; (<font class="font12">NT 0.9</font><font class="font8">)</font></td>
  <td class=xl42>:</td>
  <td class=xl51 x:num><span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][43].ToString() %></td>
  <td class=xl52 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][44].ToString() %></td>
  <td class=xl45 style='border-left:none'>Gi&#7901;</td>
  <td class=xl46 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][45].ToString() %></td>
 </tr>
 <%
        if (dt_Allowk.Rows[0][0].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl37 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=dt_Allowk.Rows[0][0].ToString() %>(<font class="font12"></font><font class="font8">)</font></td>
  <td class=xl39 style='border-top:none'>:</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=dt_Emp.Rows[i][46].ToString() %> </td>
 </tr>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][1].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=dt_Allowk.Rows[0][1].ToString() %>(<font class="font12"></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl54 align=right x:num><%=dt_Emp.Rows[i][47].ToString() %></td>
 </tr>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][2].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=dt_Allowk.Rows[0][2].ToString() %> (<font class="font12"></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl54 align=right x:num><%=dt_Emp.Rows[i][48].ToString() %></td>
 </tr>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][3].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=dt_Allowk.Rows[0][3].ToString() %> (<font class="font12"></font><font class="font8">)</font></td>
  <td class=xl34>:</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl54 align=right x:num><%=dt_Emp.Rows[i][49].ToString() %></td>
 </tr>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][4].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=dt_Allowk.Rows[0][4].ToString() %>()</td>
  <td class=xl34>:</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl54 align=right x:num><%=dt_Emp.Rows[i][50].ToString() %></td>
 </tr>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][5].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=dt_Allowk.Rows[0][5].ToString() %> ()</td>
  <td class=xl34>:</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl54 align=right x:num><%=dt_Emp.Rows[i][51].ToString() %></td>
 </tr>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][6].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=dt_Allowk.Rows[0][6].ToString() %>()</td>
  <td class=xl34>:</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl54 align=right x:num><%=dt_Emp.Rows[i][52].ToString() %></td>
 </tr>
 <%} %>
 <%
        if (dt_Allowk.Rows[0][7].ToString()!="") //kiem tra xem co cac loai tro cap khong co dinh khong?
        {
    %>  
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=dt_Allowk.Rows[0][7].ToString() %>()</td>
  <td class=xl34>:</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl54 align=right x:num><%=dt_Emp.Rows[i][53].ToString() %></td>
 </tr>
 <%} %>
 
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl40 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Tr&#7843;
  khác (<font class="font12">Other Compensation</font><font class="font8">)</font></td>
  <td class=xl42>:</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl54 align=right style='border-bottom:.5pt hairline windowtext' ;x:num><%=dt_Emp.Rows[i][54].ToString() %></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl40 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Thưởng khác (<font class="font12">Incentive</font><font class="font8">)</font></td>
  <td class=xl42>:</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl54 align=right style='border-bottom:.5pt hairline windowtext' ;x:num><%=dt_Emp.Rows[i][73].ToString() %></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl37 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Phép
  n&#259;m còn l&#7841;i (<font class="font12">Remain ALE</font><font
  class="font8">)</font></td>
  <td class=xl39 style='border-top:none'>:</td>
  <td colspan=2 class=xl65 x:num><span
  style='mso-spacerun:yes'>                </span><%=dt_Emp.Rows[i][55].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'>Ngày</td>
  <td class=xl44 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][56].ToString() %></td>
 </tr>
 <% if (p_status!="A") 
    {%>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl40 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Tr&#7907;
  c&#7845;p thôi vi&#7879;c (<font class="font12">Severance</font><font
  class="font8">)</font></td>
  <td class=xl42>:</td>
  <td colspan=2 class=xl67 x:num><span
  style='mso-spacerun:yes'>                </span><%=dt_Emp.Rows[i][57].ToString() %> </td>
  <td class=xl45 style='border-left:none'>Tháng</td>
  <td class=xl46 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][58].ToString() %>  </td>
 </tr>
 <%} %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='border-bottom:.5pt hairline windowtext;height:15.75pt;mso-ignore:colspan'>T&#7893;ng
  thu nh&#7853;p (<font class="font12">Gross Salary</font><font class="font8">)</font></td>
  <td class=xl34 style='border-bottom:.5pt hairline windowtext;'>:</td>
  <td colspan=4 class=xl95 style='border-bottom:.5pt hairline windowtext;border-right:.5pt solid black'
  x:num><span
  style='mso-spacerun:yes'>                                     
  </span><%=dt_Emp.Rows[i][59].ToString() %> </td>
 </tr>
 <% if (p_status!="A") 
    {%>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl108 colspan=2 style='height:15.75pt;mso-ignore:colspan;
  border-right:.5pt hairline windowtext'>Vi ph&#7841;m H&#272; (<font class="font12">Break
  Contract</font><font class="font8">)</font></td>
  <td class=xl39 style='border-left:none'>:</td>
  <td colspan=2 class=xl106 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=dt_Emp.Rows[i][60].ToString() %> </td>
  <td class=xl53 style='border-left:none'>Ngày</td>
  <td class=xl107 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][61].ToString() %>  </td>
 </tr>
 <%} %>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl40 colspan=2 style='border-bottom:none;height:15.75pt;mso-ignore:colspan'>BHXH
  &amp; BHYT (<font class="font12">Insurance AMT</font><font class="font8">)</font></td>
  <td class=xl42 style='border-bottom:none;'>:</td>
  <td colspan=4 class=xl84 style='border-bottom:none;border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                             
  </span><%=dt_Emp.Rows[i][66].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl40 colspan=2 style='border-bottom:none;height:15.75pt;mso-ignore:colspan'>BH Thất nghiệp (<font class="font12">Unemployee Ins(1%)</font><font class="font8">)</font></td>
  <td class=xl42 style='border-bottom:none;'>:</td>
  <td colspan=4 class=xl84 style='border-bottom:none;border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                             
  </span><%=dt_Emp.Rows[i][70].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl40 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Tr&#7915;
  khác (<font class="font12">Other Deduction</font><font class="font8">)</font></td>
  <td class=xl42 >:</td>
  <td colspan=4 class=xl84 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                             
  </span><%=dt_Emp.Rows[i][62].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Tăng ca 100%(<font class="font12">Overtime 100%</font><font
  class="font8">)</font></td>
  <td class=xl34 >:</td>
  <td colspan=3 class=xl97 x:num><span
  style='mso-spacerun:yes'>                                             
  </span></td>
  <td class=xl97 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                             
  </span><%=dt_Emp.Rows[i][71].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Giảm trừ thuế(<font class="font12">Deduct PIT</font><font
  class="font8">)</font></td>
  <td class=xl34 >:</td>
  <td colspan=3 class=xl97 x:num><span
  style='mso-spacerun:yes'>                                             
  </span></td>
  <td class=xl97 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                             
  </span><%=dt_Emp.Rows[i][72].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Thu nhập chịu thuế(<font class="font12">Payable Income</font><font
  class="font8">)</font></td>
  <td class=xl34 >:</td>
  <td colspan=3 class=xl97 x:num><span
  style='mso-spacerun:yes'>                                             
  </span></td>
  <td class=xl97 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                             
  </span><%=dt_Emp.Rows[i][63].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl26 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Thuế thu nhập(<font class="font12">Income Tax</font><font
  class="font8">)</font></td>
  <td class=xl34 >:</td>
  <td colspan=3 class=xl97 x:num><span
  style='mso-spacerun:yes'>                                             
  </span> </td>
  <td class=xl97 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                             
  </span><%=dt_Emp.Rows[i][64].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl37 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Ti&#7873;n
  công &#273;oàn (<font class="font12">Union AMT</font><font class="font8">)</font></td>
  <td class=xl39 >:</td>
  <td colspan=4 class=xl82 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                               
  </span><%=dt_Emp.Rows[i][65].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl37 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Hoàn trả khác (<font class="font12">Other Comp (No PIT)</font><font class="font8">)</font></td>
  <td class=xl39 >:</td>
  <td colspan=4 class=xl82 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                               
  </span><%=dt_Emp.Rows[i][67].ToString() %> </td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl37 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Tr&#7915; khác (<font class="font12">Other Ded (No PIT)</font><font class="font8">)</font></td>
  <td class=xl39 >:</td>
  <td colspan=4 class=xl82 style='border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                               
  </span><%=dt_Emp.Rows[i][68].ToString() %> </td>
 </tr>
 
 <tr class=xl25 height=23 style='mso-height-source:userset;height:15.75pt'>
  <td height=23 class=xl33 colspan=2 style='border-top:.5pt hairline windowtext;height:15.75pt;mso-ignore:colspan'>Th&#7921;c
  lãnh (<font class="font13">Net Amount</font><font class="font9">)</font></td>
  <td class=xl35  style='border-top:.5pt hairline windowtext;'>:</td>
  <td colspan=4 class=xl64 style='border-top:.5pt hairline windowtext;border-right:.5pt solid black' x:num><span
  style='mso-spacerun:yes'>                                           
  </span><%=dt_Emp.Rows[i][69].ToString() %> </td>
 </tr>
 
 <%
 }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=81 style='width:61pt'></td>
  <td width=166 style='width:125pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=90 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
