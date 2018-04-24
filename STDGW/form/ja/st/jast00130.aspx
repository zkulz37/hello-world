<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Student</title>
    <%  ESysLib.SetUser("crm")%>

    <script>
function BodyInit()
{
	 OnSearch();
	
}
function Binding()
{
    
}
function OnSearch(){
    dso_grdCartInternalUse.Call("SELECT");
}
function OnPrint()
{
     if(grdGolfCartManagement.rows > 1)
	 {
			var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/st/jast00130.rpt&procedure=crm.sp_rpt_jast00130&parameter="+dtYear.value;   
			System.OpenTargetPage(url);                                                                                                           
	 }

}
function OnDataReceive(obj)
{
 	if(grdGolfCartManagement.rows > 1)
	{
		lblRows.text = grdGolfCartManagement.rows-1+" Row(s).";
		grdGolfCartManagement.Subtotal( 1, 2, -1,'1!2!3!4!5!6!7!8!9!10!11!12!13');
	}
}
</script>

</head>
<body>
    <gw:data id="dso_grdCartInternalUse" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="crm.sp_sel_jast00130" >  
                <input bind="grdGolfCartManagement" >  
                    <input bind="dtYear" />  
				</input> 
                <output bind="grdGolfCartManagement" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%" style="height: 100%">
        <tr style="height: 2%">
            <td width="6%">
                Year</td>
            <td width="18%">
                 <gw:datebox id="dtYear" type="year" lang="<%=session("lang")%>" onchange="OnSearch()"/>
            </td>
            <td width="2%">
            </td>
			  <td style="width: 3%" align="right">
                    <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
              </td>
			  <td style="width: 3%" align="right">
					<gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint()" />
              </td>
            <td width="12%">
               Total: 
            </td>
			<td width="10%">
			   <gw:label id="lblRows" />
                </td>
            <td width="25%">
            </td>
			<td width="15%"></td>
            <td with="3%">
                
            </td>
			<td style="width: 3%" align="right">
                   
            </td>
             <td style="width: 3%" align="right">
                       
             </td>
            
        </tr>
        <tr style="height: 98%">
            <td colspan="12">
                <gw:grid id="grdGolfCartManagement" header="Cart#|January|February|March|April|May|June|July|August|September|October|November|December|Total holes" 
				    format="0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0"
					editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    sorting='T' autosize='T' styles="width:100%; height:100%" />
            </td>
        </tr>
        <tr>
        <td colspan="7"></td>
        </tr>
    </table>

</body>
</html>
