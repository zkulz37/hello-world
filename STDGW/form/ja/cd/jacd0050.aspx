<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Student</title>
     <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
    OnSearch();
    Binding();
}
function Binding()
{
     var ctrl,datagolfCourse;
     ctrl = grdGolferScore.GetGridControl();
     ctrl.ColEditMask(2) = "00:00";   
     var dataLstParNo ="#Par3;Par 3|#Par4;Par 4|#Par5;Par 5|#Par6;Par 6"; 
     var dataScoreType ="#G;Gold|#B;Blue|#W;White|#R;Red";
    grdGolferScore.SetComboFormat(5,dataLstParNo);
    grdGolferScore.SetComboFormat(6,dataScoreType);
    datagolfCourse  = "<%=ESysLib.SetGridColumnDataSQL("select PK, COURSE_ID ||' - '|| COURSE_NAME from crm.tgm_golf_course where del_if=0" ) %> "; 
    grdGolferScore.SetComboFormat(7,datagolfCourse);
    var data ="#1;1|#2;2|#3;3|#4;4|#5;5|#6;6|#7;7|#8;8|#9;9|#10;10|#11;11|#12;12|#13;13|#14;14|#15;15|#16;16|#17;17|#18;18"; 
        grdGolferScore.SetComboFormat(3,data);
        var data ="#1;1|#2;2|#3;3|#4;4|#5;5|#6;6|#7;7|#8;8|#9;9|#10;10|#11;11|#12;12|#13;13|#14;14|#15;15|#16;16|#17;17|#18;18|#19;19|#20;20|#21;21|#22;22|#23;23|#24;24|#25;25|#26;26|#27;27"; 
        grdGolfer.SetComboFormat(17,data);
}
function OnSearch(){
    dso_grdGolfer.Call("SELECT");
}
function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/cd/jacd0050.rpt&procedure=CRM.sp_sel_jams0040_caddy_rpt&parameter="+dtfr.GetData()+","+dtTo.GetData()+","+txtName.text;   
     System.OpenTargetPage(url); 
}
</script>

</head>
<body>
 <gw:data id="dso_grdGolfer"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="crm.sp_sel_jams0040_caddy_rpt" procedure="CRM.sp_upd_jams0040" >  
                <input bind="grdGolfer" >  
                    <input bind="dtfr" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtName" /> 	 															
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data> 	
    <table width="100%" style="height:100%">
        <tr style="height: 2%">
            <td width="10%" >
                <b>Date</b></td>
            <td width="10%" >
                <gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" />
            </td>
            <td width="2%">~</td>
            <td width="10%" >
                <gw:datebox id="dtTo"  lang="1" onchange="OnSearch()" />
            </td>
            <td width="9%"></td>
            <td width="17%">
                Player Name</td>
            <td width="30%" >
                <gw:textbox id="txtName" onenterkey="OnSearch()" />
            </td>
            <td with="6%"></td>
            <td with="3%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td>
            
        </tr>
        <tr style="height: 98%">
            <td colspan="11">
                 <gw:grid 
                    id="grdGolfer"
                    header="No|Locker#|Bagtag#|Player Name|Cart Holes|Cart#|Caddy Name|Caddy#|_Caddy1_pk|Golf Course|_Caddy2|_Caddy2_pk|_Caddy3|_Caddy3_pk
                    |_Caddy1 Holes|_Caddy2 Holes|_Caddy3 Holes|_In Course|_Out Course|_E9 Course|Play Holes|Tee Time|_Printted Invoice
                    |_Print Time|_Finish Game|Finish Time|Remark" 
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|3|0|0"
                    aligns="0|0|0|0|0|0|0|3|0|0|0|0|0|0|3|3|3|3|3|3|3|0|0|0|0|0|0" 
                    defaults="||||||||||||||||||||||||||" 
                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0" 
                    sorting='T'
                    autosize='T'
	                styles="width:100%; height:100%"
                    />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
</body>
</html>
