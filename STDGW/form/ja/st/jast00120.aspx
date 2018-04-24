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
	var url = '/reports/ja/ms/jams0040_rpt.aspx?p_dt_frm='+ dtfr.value+'&p_dt_to='+dtTo.value;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
}
function OnDataReceive(obj){
	lblRows.text = grdGolfCartManagement.rows;
}
</script>

</head>
<body>
    <gw:data id="dso_grdCartInternalUse" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="crm.sp_sel_jams0040_rpt" >  
                <input bind="grdGolfCartManagement" >  
                    <input bind="dtfr" />  
					<input bind="dtTo" />  					
                </input> 
                <output bind="grdGolfCartManagement" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%" style="height: 100%">
        <tr style="height: 2%">
            <td width="6%">
                Date</td>
            <td width="18%">
                <gw:datebox id="dtfr" lang="1" onchange="OnSearch()" />~<gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
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
                <gw:grid id="grdGolfCartManagement" header="Date|Cart#|Golfer Name|Locker#|Bag No|Caddy#|Teeup time|Finish Time|Hole|Total Time" 
				    format="4|0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|0|0|0" editcol="0|0|0|0|0|0|0|0|0|0"
                    sorting='T' autosize='T' oncelldblclick="OnPopupEmp('Emp')" styles="width:100%; height:100%" />
            </td>
        </tr>
        <tr>
        <td colspan="7"></td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
</body>
</html>
