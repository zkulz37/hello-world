<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Melting Batch No. Register</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>
function BodyInit()
{
  dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
  OnSearch()
}
 function OnDataReceive(obj)
{
     lblRecord.text = (grdSearch.rows -1 )+ ' record(s).'
}
function OnSearch()
{
    data_shbo00110.Call('SELECT');
}
function OnPrint()
{
   /*var url =System.RootURL + '/reports/sh/bo/rpt_shbo00110.aspx?from_dt=' + dtFromDate.value+'&to_dt=' + dtToDate.value +'&tank='+txtTank.text  ;
  System.OpenTargetPage(url); */
   var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00110.rpt&export_pdf=Y&procedure=PROD.sp_rpt_shbo00110_d&parameter=" + dtFromDate.value + "," + dtToDate.value+"," + txtTank.text ;              
  System.OpenTargetPage(url); 
  	
}
</script>
<body>
   <!--------------------------------------------------------------------------------------->
   <gw:data id="data_shbo00110" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="PROD.sp_sel_shbo00110">
                <input bind="grdSearch" >
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />
                    <input bind="txtTank" />
                </input>
                <output bind="grdSearch" />
            </dso>
        </xml>
    </gw:data>
 
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" >
        <tr style="height:5%">
            <td style="width: 15%" align="left" id="left">
                Instructed Period
            </td>
            <td style="width: 30%">
                <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch()" />
                 ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch()" />
            </td>
             <td style="width: 10%" align="left" id="Td1">
                M/Tank No.
            </td>
            <td style="width: 20%">
                <gw:textbox id="txtTank" styles='width:100%' onenterkey="OnSearch()" />
            </td>
            <td style="width: 23%" align="right">
                <gw:label id="lblRecord" styles="color:blue" text ="record." />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="printer" alt="Search" id="btnReport" onclick="OnPrint()" />
            </td>
        </tr>
       
        <tr style="height:90%">
            <td colspan="7">
                <gw:grid id='grdSearch'
                    header='_PK|First Issued Date|Entered Date|Batch No.|TR/OP|Batch Quantity|Add. Solution Batch No|Type No.|Remark|Deleted'
                    format='0|4|4|0|0|1|0|0|0|0'
                    aligns='0|1|1|0|0|0|0|0|0|1'
                    defaults='|||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0'
                    widths='0|1500|1500|1500|1500|1500|1500|1500|2000|1000'
                    sorting='T'
                    styles='width:100%; height:100%'
                    autosize='T'
                    />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
