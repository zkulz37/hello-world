<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=Generator content="Microsoft Word 11 (filtered)">
<%
    string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL = " select  " 
        + "a.FULL_NAME  "//0
        + ",decode(nvl(a.sex,'0'),'M','Nam','Nữ') as FeMale " //1
         + ",case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4) end as Namsinh " //2
        + ",a.PERMANENT_ADDR " //3
        + ",a.health_no" //4
        + ",to_char(to_date(e.old_from_dt,'YYYYMMdd'),'dd/mm/yyyy') " //5
        + ",to_char(to_date(e.old_to_dt,'YYYYMMdd'),'dd/mm/yyyy') " //6
        + ",e.reason " //7
        + " from thr_employee a,thr_ins_modify e"
        + " where a.del_if=0 and e.del_if=0 and e.thr_emp_pk =a.pk "
       + " and e.pk in (" + emp_pk + ") " ;
        
//Response.Write(SQL);
//Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    //getting employeer
    SQL
    = "select code_nm " +
        "from vhr_hr_code " +
        "where id='HR0049' order by code  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
   
%>

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
@page Section1
	{size:8.5in 11.0in;
	margin:.75in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=EN-US>

<div class=Section1>
<% 
     
    for (int i = 0; i < irow; i++)
    {
       
    %>
<p class=MsoNormal>                                                                                                           <i>M&#7851;u
s&#7889;: 02/THE           </i></p>

<p class=MsoNormal><i>&nbsp;</i></p>

<p class=MsoNormal><i>                                </i><b>C&#7896;NG HÒA XÃ
H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T NAM</b></p>

<p class=MsoNormal><b>                                              &#272;&#7897;c
L&#7853;p – T&#7921; Do – H&#7841;nh Phúc.</b></p>

<p class=MsoNormal>                                                        ---------------------</p>

<p class=MsoNormal>                                                              <i><%=dt_name.Rows[10][0].ToString()%>,ngày <%= DateTime.Today.Day%> tháng <%= DateTime.Today.Month%>
  n&#259;m <%= DateTime.Today.Year%></i></p>

<p class=MsoNormal>                                                                        </p>

<p class=MsoNormal>                                                        <b><span
style='font-size:14.0pt'>&#272;&#416;N &#272;&#7872; NGH&#7882;</span></b></p>

<p class=MsoNormal><b><span style='font-size:14.0pt'>                              C&#7844;P
L&#7840;I TH&#7866; B&#7842;O HI&#7874;M Y T&#7870;</span></b></p>

<p class=MsoNormal>                                 </p>

<p class=MsoNormal>                                 <b><u>Kính g&#7917;i</u></b>:
B&#7843;o hi&#7875;m xã h&#7897;i <b><%=dt_name.Rows[10][0].ToString()%></b>.</p>

<p class=MsoNormal>                                 </p>

<p class=MsoNormal>Tôi tên: <b><%=dt_total.Rows[i][0].ToString()%></b> . &nbsp;Nam,N&#7919;: <%=dt_total.Rows[i][1].ToString()%> &nbsp;.N&#259;m sinh: <%=dt_total.Rows[i][2].ToString()%>.</p>

<p class=MsoNormal>&#272;&#7883;a ch&#7881;:<%=dt_total.Rows[i][3].ToString()%>.</p>

<p class=MsoNormal>Th&#7867; BHYT s&#7889;:<b><%=dt_total.Rows[i][4].ToString()%></b>.</p>

<p class=MsoNormal>Th&#7901;i h&#7841;n s&#7917; d&#7909;ng t&#7915; ngày:<%=dt_total.Rows[i][5].ToString()%> &#273;&#7871;n
ngày:<%=dt_total.Rows[i][6].ToString()%> </p>

<p class=MsoNormal>Lý do c&#7845;p l&#7841;i th&#7867; BHYT:<%=dt_total.Rows[i][7].ToString()%>
…………………………………………………………………........................... .……………………………………………………………………………………………</p>

<p class=MsoNormal>            &#272;&#7873; ngh&#7883; c&#417; quan B&#7843;o
hi&#7875;m xã h&#7897;i c&#7845;p l&#7841;i th&#7867; BHYT &#273;&#7875;
thu&#7853;n ti&#7879;n &#273;i khám ch&#7919;a b&#7879;nh theo ch&#7871;
&#273;&#7897; b&#7843;o BHYT.</p> 
<p class=MsoNormal>                                                                             <%=dt_name.Rows[10][0].ToString()%>,ngày <%= DateTime.Today.Day%> tháng <%= DateTime.Today.Month%>
  n&#259;m <%= DateTime.Today.Year%>.</p>

<p class=MsoNormal>XÁC NH&#7852;N C&#7910;A T&#7892; CH&#7912;C &#272;&#416;N
V&#7882;                             NG&#431;&#7900;I
&#272;&#7872; NGH&#7882;</p>

<p class=MsoNormal>(HO&#7862;C UBND XÃ PH&#431;&#7900;NG, TH&#7882; TR&#7844;N)                   (Ký
và ghi rõ h&#7885; tên)</p>

<p class=MsoNormal>&nbsp;</p>
<p class=MsoNormal>&nbsp;</p>
<p class=MsoNormal>&nbsp;</p>
<p class=MsoNormal>&nbsp;</p>
<p class=MsoNormal>&nbsp;</p>
<p class=MsoNormal><span style='mso-tab-count:7'></span><%=dt_total.Rows[i][0].ToString()%></p>
<% if (dt_total.Rows.Count-1 != i)
   {%>
<b><span lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-fareast-language:
VI;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>
<%}
} %>
</div>

</body>

</html>
