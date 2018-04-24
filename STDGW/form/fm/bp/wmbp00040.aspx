<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
   <%ESysLib.SetUser("comm")%>
  <head>
    <title>PO Inquiry</title>
  </head>
 <script>
 //---------------------------------------------------------
 function BodyInit()
 { 
    BindingDataList();
 
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
        var data1 = "<%=ESysLib.SetListDataSQL("select '-1' code, 'Select All' code_nm from dual union all select code, code_nm from comm.tco_abcode,comm.tco_abcodegrp where   comm.tco_abcodegrp.pk=comm.tco_abcode.tco_abcodegrp_pk   and UPPER(comm.tco_abcodegrp.id) like UPPER('PRCP0020') and comm.tco_abcode.use_if='1'")%>" ;
       var data2 ="<%= ESysLib.SetListDataSQL("select pk,partner_id from tco_company where del_if = 0 ") %>";
	   
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
 function SearchOnClick()
 {
	idData_Dsql_tco_buspartner.Call('SELECT');
 }
 
 function onExcelClick()
 {
	alert("This report is in design");
 }
 </script>

<body>
  <gw:data id="idData_Dsql_tco_buspartner" >
    <xml> 
        <dso id="1" type="grid" function="comm.sp_sel_po_inquiry" > 
            <input bind="grdPO_Inquiry" >
                <input bind="cboOrganization" />
                <input bind="txtVendor" />
				<input bind="dtbFrom" />
                <input bind="dtbTo" />
				<input bind="txtPONo" />
                <input bind="txtItem" />
				<input bind="cboStatus" />
            </input>
            <output bind="grdPO_Inquiry" />
        </dso>
    </xml>
</gw:data>
  
  <table border="2" cellpadding="0" cellspacing="0" width="100%">
    <tr valign="top">
    <td width="100%" >
            <table border="0" cellpadding="0" cellspacing="0" style=" margin-top:2;">
                <tr>
                    <td width="10%" ><b>&nbsp;&nbsp;Organization&nbsp;</b></td>
                    <td width="10%"><gw:list id="cboOrganization"   styles="width:98%;" ></gw:list></td>
            <td  width="12%" >&nbsp;&nbsp;&nbsp;<b style="color: #1b2ff2; cursor: hand" onclick="onVendorClick()">Vendor </b></td>
            <td  width="22%"><gw:textbox id="txtVendor" styles='width:100%'  onenterkey="SearchOnClick()" /></td>
            <td width="10%"></td>
            <td width="15%"></td>
            <td width="10%"></td>
            <td width="5%"></td>
            <td width="10%"></td>
            <td width="3%"><gw:imgBtn id="ibtnExcel" img="excel" alt="Excel" text="Excel"  onclick="onExcelClick()" /></td>
            <td width="3%"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" text="Search"  onclick="SearchOnClick()" /></td>
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
            <td ><b>&nbsp;&nbsp;&nbsp;P/O No</b></td>
            <td><gw:textbox id="txtPONo" styles="width:100%"  onenterkey="SearchOnClick()" /></td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b style="color: #1b2ff2; cursor: hand" onclick="onItemClick()">Item</b></td>
            <td><gw:textbox id="txtItem" styles="width:100%"  onenterkey="SearchOnClick()" /></td>
            <td><b>&nbsp;&nbsp;&nbsp;&nbsp;Status</b></td>
            <td  colspan="3"><gw:list id="cboStatus"   styles="width:100%;" ></gw:list></td>
            <td>&nbsp;</td>
                </tr>
            </table> 
    </td>          
   </tr> 
   <tr>
    <td>
        <gw:grid
                                id="grdPO_Inquiry"
                                header="PO No| PO Date|Vendor|Item Code|Item Name|EDT Date|PO Qty|On the way|Req IQC|Take in Qty|Balance|Remark"
                                format="0|0|0|0|0|0|0|0|0|0|0"
                                aligns="0|0|0|0|0|0|0|0|0|0|0"
                                defaults="||||||||||||"
                                editcol="1|1|1|0|0|0|0|0|0|0|0|0|0"
                                widths="1000|1000|1000|1500|2000|1000|1000|1200|1000|1500|1000|1000"
                                styles="width:100%; height:350"
                                sorting="F"
                                param="0,1,2,3,4,5,6,7,8,9,10,11"  />
   
    </td>
   </tr>
  </table>
</body>
</html>


