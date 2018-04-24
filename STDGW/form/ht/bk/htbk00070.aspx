<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Rental</title>
     <%  ESysLib.SetUser("CRM")%>

<script>
function BodyInit()
{ 
	Binding();
    OnSearch();
}
function Binding()
{
    
}
function OnSearch(){
    dso_grdGolfer.Call("SELECT");
}
function OnPopUp()
{
	var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
			var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
				txtCustomer_PK.text  = object[0];
				txtCustomer.text			= object[4];
				OnSearch();
			}

}
function OnDataReceive(obj)
{
	switch(obj.id)
	{ 
		case 'dso_grdGolfer':
		      lblRows.text=grdGolfer.rows-1 + " Room(s).";
			  grdGolfer.Subtotal( 1, 2, -1,'6');


		break; 
	}
}
function OnReport()
{  
    url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/bk/htbk00070.rpt&procedure=CRM.sp_sel_htbk00070&parameter="+dtfr.value+","+dtTo.value+","+txtCustomer_PK.text;   
         	System.OpenTargetPage(url); 
}

</script>

</head>
<body>
 <gw:data id="dso_grdGolfer" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="CRM.sp_sel_htbk00070" >  
                <input bind="grdGolfer" >  
                    <input bind="dtfr" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtCustomer_PK" /> 	 															
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data> 
    <table width="100%" style="height:100%">
        <tr style="height: 2%">
            <td style="width: 5%" >
                Date</td>
            <td style="width: 8%" >
                <gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" />
            </td>
            <td style="width: 2%">~</td>
            <td style="width: 8%" >
                <gw:datebox id="dtTo"  lang="1" onchange="OnSearch()" />
            </td>
            <td  style="width: 5%"></td>
            <td style="width: 1%" align="right">
                <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp()">Customer</b></td>
            <td style="width: 37%" > 
                <gw:textbox id="txtCustomer" onenterkey="OnSearch()" readonly="true" />
            </td>
			<td style="width: 2%"><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtCustomer_PK.text='';txtCustomer.text=''" /></td>

            <td style="width: 6%">Total:</td>
            <td style="width: 13%"><gw:label id="lblRows" /> </td>
			<td style="width:4%"> 
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
			<td width="3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td>

        </tr>
        <tr style="height: 61%">
            <td colspan="13">
                <gw:grid 
                    id="grdGolfer"
                    header="Room No|Room Type|Last Name|First Name|Checkin Date|Checkout Date|Nights|Partner ID|Partner Name" 
                    format="0|0|0|0|0|0|-0|0|0"
                    aligns="0|0|0|0|0|0|0|0|0" 
                    editcol="0|0|0|0|0|0|0|0|0" 
                    sorting='T' autosize='T'
	                styles="width:100%; height:100%"
					oncellclick=""
                    />
            </td>
        </tr>
       
    </table>
	<gw:textbox id="txtMasterPK" style="display: none" />
	<gw:textbox id="txtCustomer_PK" style="display: none" />
	<gw:textbox id="txtTGM_VISITORFEE_GOLFER_PK" styles="display:none" />
	<gw:textbox id="txtReturnMsg" styles="display:none" />
	<gw:textbox id="txtTmpCaddieNo" styles="display:none" />
	 <gw:grid id="grdCaddieList" header="caddie_pk|caddie_no|caddie_name" 
         format="0|0|0" sorting='T'   styles="width:100%; height:100%;display:none"
     />
</body>
</html>
