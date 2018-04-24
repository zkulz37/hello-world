<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Summary By Invoice</title>
     <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
    OnSearch();
    Binding();
}
function Binding()
{
     
}
function OnSearch(){
    dso_jart00080.Call("SELECT");
}
function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00080.rpt&procedure=crm.sp_sel_jart00080_rpt&parameter="+dtDate.GetData();   
     System.OpenTargetPage(url); 
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_jart00080':			
			if (grdData.rows > 1)
			{
				lblRecord.text = grdData.rows - 1 + " record(s)";
				grdData.Subtotal( 1, 2, -1, '3!4!5');
			}
		break;
	}
}
</script>

</head>
<body>
 <gw:data id="dso_jart00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="" function="crm.sp_sel_jart00080" procedure="" >  
                <input bind="grdData" >  
                    <input bind="dtDate" /> 
                </input> 
                <output bind="grdData" /> 
            </dso> 
        </xml> 
    </gw:data> 	
    <table width="100%" style="height:100%">
        <tr style="height: 5%">
            <td width="10%" align="center"><b>Date</b></td>
            <td width="10%"><gw:datebox id="dtDate"  lang="1" onchange="OnSearch()" /></td>
            <td width="21%"></td>
            <td width="17%"></td>
            <td width="30%" align="right"><gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label></td>
            <td with="6%"></td>
            <td with="3%" align="right"><gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
            <td style="width: 3%"><gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" /></td>
        </tr>
        <tr style="height: 95%">
            <td colspan="8">
                 <gw:grid 
                    id="grdData"
                    header="No.|Item Name|Unit|Daily|Month To Date|Year To Date" 
                    format  ="0|0|0|-0|-0|-0"
                    aligns  ="1|0|1|0|0|0" 
                    defaults="|||||" 
                    editcol ="0|0|0|0|0|0"
                    sorting='T'
                    autosize='T'
	                styles="width:100%; height:100%"
                    />
            </td>
        </tr>
    </table>
</body>
</html>
