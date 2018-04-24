<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%ESysLib.SetUser("comm")%>
<% ESysLib.SetUser("inv")%>
<% ESysLib.SetUser("prod")%>
<head>
    <title>Monthly Material Report</title>

    <script>
 //---------------------------------------------------------
 function BodyInit()
 { 
    BindingDataList();
 
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
       var ldate
       var data1 = "<%=ESysLib.SetListDataSQL("Select '%' ,'All' from dual union all SELECT 'IN-' || code, code_nm   FROM comm.tco_abcode a, comm.tco_abcodegrp b WHERE a.TCO_ABCODEGRP_PK =b.pk    AND b.ID='PRDI0070' AND a.use_if = '1' and b.use_if = '1'  and a.del_if =0 and b.del_if =0 union   SELECT 'OUT-' || code, code_nm  FROM comm.tco_abcode a, comm.tco_abcodegrp b	WHERE a.TCO_ABCODEGRP_PK =b.pk AND b.ID='PRDI0080' AND a.use_if = '1' and b.use_if = '1'  and a.del_if =0 and b.del_if =0")%>" ;
       var data2 = "<%=ESysLib.SetListDataSQL("Select 0, 'All' from dual union all select pk, wh_id || '-' || wh_name from TIN_WAREHOUSE where del_if = 0 and use_yn='Y'")%>";
       cboTransType.SetDataText(data1);
       cboWarehouse.SetDataText(data2);
     
       ldate=dtbFrom.value; 
       ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ; 
       dtbFrom.value=ldate ; 

 }

 function OnSearchClick()
 {
	datMonthlyMaterial.Call('SELECT');
 }
function onReceiveSearch()
{
    lblRowCount.text = grdMonthlyMaterial.rows - 1;
} 

function onGridCellDBClick()
{
    var Item_pk = ''+grdMonthlyMaterial.GetGridData(grdMonthlyMaterial.row, 0) ;
    if (Item_pk !="" )
   { 
            var fpath = System.RootURL + '/form/hd/hi/hdhi00010_1.aspx?Item_PK='+Item_pk+'&ItemGroup_PK='+txtItemGroup_PK.text;
             fpath =  fpath + '&cboTransType='+cboTransType.value+'&cboWarehouse='+cboWarehouse.value+'&dtbFrom=' + dtbFrom.value+'&dtbTo=' +dtbTo.value;
            System.OpenModal( fpath , 900 , 500 , 'resizable:yes;status:yes');
   }
}
function OnExcelClick()
{
    if (confirm("Do you want to export data to excel file ?"))
   { 
        var url =System.RootURL + '/reports/hd/hi/hdhi00010.xls?dtbFrom=' + dtbFrom.value+'&dtbTo=' +dtbTo.value+'&cboWarehouse='+cboWarehouse.value;
        url= url+'&txtItemGroup_PK='+txtItemGroup_PK.text+'&txtItem='+txtItem.text+'&cboTransType='+cboTransType.value;
        window.open(url); 
     }
}
    </script>

</head>
<body>
    <gw:data id="datMonthlyMaterial" onreceive="onReceiveSearch()">
    <xml> 
        <dso id="1" type="grid" function="inv.sp_sel_in_out_monthly_material" > 
            <input bind="grdMonthlyMaterial" >
                <input bind="dtbFrom" />
				<input bind="dtbTo" />
                <input bind="cboWarehouse" />
               <input bind="txtItemGroup_PK" />
               <input bind="txtItem" />
               <input bind="cboTransType" />
            </input>
            <output bind="grdMonthlyMaterial" />
        </dso>
    </xml>
</gw:data>
    <table border="0" width="100%" style="background: #BDE9FF">
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" style="background-color: White;">
                    <tr>
                        <td width="5%">
                            <b>&nbsp;&nbsp;Date</b></td>
                        <td width="15%">
                            <table border="0" cellpadding="1" cellspacing="2">
                                <tr>
                                    <td width="45%">
                                        <gw:datebox id="dtbFrom" lang="<%=Application("Lang")%>" mode="01" onchange="" />
                                    </td>
                                    <td width="10%">
                                        <b>&nbsp;~&nbsp;</b></td>
                                    <td width="45%">
                                        <gw:datebox id="dtbTo" lang="<%=Application("Lang")%>" mode="01" onchange="" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="6%">
                            &nbsp;&nbsp;<b>Item</b>&nbsp;&nbsp;</td>
                        <td width="20%">
                            <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearchClick()" />
                        </td>
                        <td width="10%">
                            &nbsp;&nbsp;<b>Warehouse</b>&nbsp;&nbsp;</td>
                        <td width="15%">
                            <gw:list id="cboWarehouse" styles="width:100%;"></gw:list>
                        </td>
                        <td width="10%">
                            &nbsp;&nbsp;<b>Trans. Type</b>&nbsp;&nbsp;</td>
                        <td width="15%">
                            <gw:list id="cboTransType" styles="width:100%;"></gw:list>
                        </td>
                        <td width="2%" align="right">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearchClick()" />
                        </td>
                        <td width="2%" align="right">
                            <gw:imgbtn id="ibtnExcel" img="excel" alt="Excel" text="Excel" onclick="OnExcelClick()" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>&nbsp;&nbsp;Rows :</b></td>
                        <td>
                            &nbsp;&nbsp;&nbsp;&nbsp;<gw:label id="lblRowCount" styles='width:100%'></gw:label></td>
                        <td rowspan="8">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <gw:grid id="grdMonthlyMaterial" header="_item_pk|Item Code|Item Name|Begin|Ins Waiting|Input|Output|End|Warehouse"
                    format="0|0|0|0|0|0|0|0|0" aligns="0|0|0|3|3|3|3|3|0" defaults="||||||||" editcol="0|0|0|0|0|0|0|0"
                    widths="0|1500|2000|1500|1500|1500|1500|1500|1000" styles="width:100%; height:420"
                    sorting="F" oncelldbclick="onGridCellDBClick()" parameter="0,1,2,3,4,5,6,7,8" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtItemGroup_PK" styles='display:none;' text='ALL' />
</body>
</html>
