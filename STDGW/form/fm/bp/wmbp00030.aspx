<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>PO Sheet Issue</title>
  </head>
  
 <%ESysLib.SetUser("comm")%>
 
 <script>
 //---------------------------------------------------------
 function BodyInit()
 { 
    BindingDataList();
 
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
        var data1 = "<%=ESysLib.SetListDataSQL("select '-1' code, 'Select All' code_nm from dual union all select a.code, a.code_nm from comm.tco_abcode a,comm.tco_abcodegrp b where   b.pk=a .tco_abcodegrp_pk  and UPPER(b.id) like UPPER('PRCP0020') and a.use_if='1'")%>" ;
        var data2 ="<%= ESysLib.SetListDataSQL(" select pk,partner_id from tco_company where del_if = 0") %>";
        cboStatus.SetDataText(data1); 
        cboOrganization.SetDataText(data2);
 }
 
 function onVendorClick()
 {
	alert("Vendor");
 }
 
 function onItemClick()
 {
	alert("Item");
 }

 function OnExcelClick()
 {
	alert("Excel");
 }
 function OnEmailClick()
 {
	alert('Email');
 }
 
  function SearchOnClick()
 {
	idData_Dsql_PO_Inquiry.Call('SELECT');
 }
 
function ongrdPOClick()
{
     if(event.row >0)
   {
        txtPurOrdPK.text =""+grdPO.GetGridData(event.row,0);
        grdPODetail.ClearData();
        idData_Dsql_PO_Detail.Call('SELECT');
   } 
    
} 
 
 function OnConfirmClick()
 {
if (confirm("Do you want to confirm the selected rows ?"))
{ 
	var l_rows = grdPO.rows;
	grdPO.SetRowStatus(0,0);
	for (i=1;i<l_rows;i++)
	{
	    if (grdPO.GetGridData(i,1) ==0)
	    {
	        grdPO.SetRowStatus(i,0);
	    }
	}
	idData_Dsql_PO_Inquiry.Call('');
	}
 } 
 </script>

<body>
<gw:data id="idData_Dsql_PO_Inquiry" >
    <xml> 
        <dso id="1" type="grid" parameter="0" function="comm.sp_sel_po_sheet_inquiry"  procedure = "comm.sp_upd_po_sheet_inquiry"> 
            <input bind="grdPO" >
                <input bind="cboOrganization" />
                <input bind="txtVendor" />
				<input bind="dtbFrom" />
                <input bind="dtbTo" />
				<input bind="txtPONo" />
                <input bind="txtItem" />
				<input bind="cboStatus" />
            </input>
            <output bind="grdPO" />
        </dso>
    </xml>
</gw:data>

<gw:data id="idData_Dsql_PO_Detail" >
    <xml> 
        <dso id="1" type="grid" function="comm.sp_sel_po_sheet_inquiry_detail" > 
            <input bind="grdPODetail" >
                <input bind="txtPurOrdPK" />
            </input>
            <output bind="grdPODetail" />
        </dso>
    </xml>
</gw:data>


  <table border="1" cellpadding="0" cellspacing="0" width="100%">
        <tr valign="top">
                <td>
                       <table border="0" cellpadding="0" cellspacing="0" style=" margin-top:2;">
                <tr>
                    <td width="10%" ><b>&nbsp;&nbsp;Organization&nbsp;</b></td>
                    <td width="8%"><gw:list id="cboOrganization"   styles="width:98%;margin-left:3;" ></gw:list></td>
            <td  width="14%" >&nbsp;&nbsp;&nbsp;&nbsp;<b style="color: #1b2ff2; cursor: hand" onclick="onVendorClick()">Vendor </b></td>
            <td  width="20%"><gw:textbox id="txtVendor" styles='width:100%'  onenterkey="SearchOnClick()" /></td>
            <td width="8%"></td>
            <td width="20%"></td>
            <td width="10%"></td>
           <td width="15%">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="3%"><gw:imgBtn id="ibtnConfirm" img="confirm" alt="Confirm" text="Confirm"  onclick="OnConfirmClick()" /></td>
                            <td width="3%"><gw:imgBtn id="ibtnExcel" img="excel" alt="Excel" text="Excel"  onclick="OnExcelClick()" /></td>
                           <td width="3%"><gw:icon id="ibtnEmail" img="in" alt="E-mail" text="E-mail"  onclick="OnEmailClick()" /></td>
                           <td width="3%"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" text="Search"  onclick="SearchOnClick()" /></td> 
                        </tr>
                    </table>
            </td>
    </tr>
   <tr>
            <td ><b>&nbsp;&nbsp;P/O Date</b></td>
            <td>
                    <table border="0" cellpadding="1" cellspacing="2">
                        <tr>
                                <td width="45%"><gw:datebox id="dtbFrom" lang="<%=Application("Lang")%>" mode="01" onchange=""  /></td>
                                <td width="10%"><b>&nbsp;~&nbsp;</b></td>
                                <td width="45%"><gw:datebox id="dtbTo" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                        </tr>
                    </table>
            </td>
            <td ><b>&nbsp;&nbsp;&nbsp;&nbsp;P/O No</b>&nbsp;</td>
            <td><gw:textbox id="txtPONo" styles="width:100%"  onenterkey="SearchOnClick()" /></td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;<b style="color: #1b2ff2; cursor: hand" onclick="onItemClick()">Item</b>&nbsp;</td>
            <td><gw:textbox id="txtItem" styles="width:100%"  onenterkey="SearchOnClick()" /></td>
            <td><b>&nbsp;&nbsp;&nbsp;&nbsp;Status</b></td>
            <td ><gw:list id="cboStatus"   styles="width:90%;" ></gw:list></td>
                </tr>
            </table> 
                </td>
        </tr>
        <tr >
                <td valign="top">
						<table border="0" cellspacing="0" cellpadding="3" width="100%">
							<tr valign="top">
								<td width="40%">
										<gw:grid
		                                id="grdPO"
		                                header="_PK|Check|PO Date|PO NO|Status|Vendor|Charger"
		                                format="0|3|0|0|0|0"
		                                aligns="0|0|0|0|0|0"
		                                defaults="||||||"
		                                editcol="1|0|0|1|0|0"
		                                widths="0|800|1200|1500|1500|1500"
		                                styles="width:100%; height:450"
		                                sorting="T"
		                                oncelldblclick="ongrdPOClick(this)"
		                                param="0" />
								</td>
								<td width="60%">
										<gw:grid   
							        id="grdPODetail"  
							        header="Part name|P. Lot|Qty/Lot|PO Qty|U/Price|Amount|ETD|ETA|Remark|Close"   
							        format="0|0|0|0|0|0|0|0|0|0"  
							        aligns="0|0|0|0|0|0|0|0|0|0"  
							        defaults="|||||||||"  
							        editcol="1|1|1|1|1|1|1|1|1|1"  
							        widths="1500|1000|1000|1000|1000|2000|1000|1000|2000|1000"  
							        styles="width:100%; height:450;"
							        sorting="T"   
							        param="0,1,2,3,4,5,6,7,8,9"  />
								</td>
							</tr>
						</table>
                </td>
        </tr>
  </table>
  
  <gw:textbox id="txtPurOrdPK" styles="width:100%;display:none;"  />
</body>
</html>
