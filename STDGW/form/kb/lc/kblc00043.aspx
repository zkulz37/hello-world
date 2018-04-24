<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Bussiness Partner Entry</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>

 var status_control;
 var G_BUS_PK       = 0,
     G_ACC_BANK_PK  = 1,
     G_CCY          = 2,
     G_PARTNER_ID   = 3,
     G_PARTNER_NM   = 4,
     G_ACC_NO       = 5,
     G_TAX_CODE     = 6;
 //---------------------------------------------------------
 function BodyInit()
 { 
     System.Translate(document);
     txtCCY.text = "<%=Request.querystring("p_ccy")%>";
     onSearch(0);
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {
        var data="";
        data = "<%=ESysLib.SetListDataFUNC("SELECT F_COMMONCODE('CODC0010','','') FROM DUAL")%>|ALL|--Select All--"; 
        lstType.SetDataText(data); 
		lstType.value = 'ALL';
 }
 //---------------------------------------------------------
 function onSearch(index)
 {
    switch(index)
    {
        case 0:
            data_agic00010_1.StatusSelect();
            data_agic00010_1.Call("SELECT");
        break;
    }
 }
 //---------------------------------------------------------
 function loadBSDetail1()
 {
	var row  = grdPartner.row;	
    txtPartnerPk.SetDataText(grdPartner.GetGridData(row,0));
    
	data_agic00010.StatusSelect();
	data_agic00010.Call("SELECT");	
 }
 //---------------------------------------------------------
 function openEmpLookup(num)
 {
//    var url = '/form/sys/auth/wsyau00001_1.aspx' ; neu khong dung thi xoa
	var url = '/form/ch/ae/chae00010_search_emp.aspx' ;
	
	o = System.OpenModal( System.RootURL+ url , 900 , 600 , 'resizable:yes;status:yes') 
	
	if ( o != null )
	{
		grdCharger.SetGridText(grdCharger.row,G_Charger_EmpPK,o[0]); // Emp PK  
		grdCharger.SetGridText(grdCharger.row,G_Charger_EmployeeID,o[1]); // Emp ID
		grdCharger.SetGridText(grdCharger.row,G_Charger_Emp_Name,o[2]); // Emp Name
		grdCharger.SetGridText(grdCharger.row,G_Charger_Department,o[4]); // Department
	}	
 }
 //---------------------------------------------------------
 function OnDataReceive(oId)
 {
    switch(oId.id)
    {
    }
 }
  //---------------------------------------------------------
function OnSelect()
{
    var code_data=new Array()
	var ctrl = grdPartner.GetGridControl();
	var index, rowNo
	
	index =0;
	rowNo = 0 ;
	
	if ( ctrl.SelectedRows == 0 )
    {
           return ;
    }
    else
	{
	    for(i=0; i < ctrl.SelectedRows; i++)
		{	  
		        rowNo = ctrl.SelectedRow(i)
		        for(j=0; j < grdPartner.cols -1; j++)
	        	{
            		code_data[index] = grdPartner.GetGridData(rowNo , j );
            		index ++;
            	}        
		}
	}
	window.returnValue = code_data; 
	this.close(); 	
}
</script>
<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_agic00010_1"> 
        <xml> 
            <dso id="1" type="grid" function="lg_sel_kblc00043" > 
                <input> 
                    <input bind="txtPartnerQuery" /> 
                    <input bind="txtTaxcode_Q" /> 
                    <input bind="txtCCY" />
                </input> 
                <output bind="grdPartner" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <table style="width: 100%; height: 100%" border="1" id="tableID1">
        <tr>
            <td id="left" style="width: 40%" valign="top">
                <table style="width: 100%;" border="0">
                    <tr>
                        <td style="width: 10%" align="right">
                            Customer
                        </td>
                        <td style="width: 90%" colspan="3">
                            <gw:textbox id="txtPartnerQuery" csstype="filter" onenterkey="onSearch(0)" styles="width: 100%" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%" align="right">
                            Tax code
                        </td>
                        <td style="width: 90%">
                            <gw:textbox id="txtTaxcode_Q" csstype="filter" onenterkey="onSearch(0)" styles="width: 100%" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch(0)" />
                        </td>
                    </tr>
                    <tr style="height: 100%" valign="top">
                        <td colspan="3">
                            <gw:grid id="grdPartner" 
                                header="_PK_BUS|_pk_acc_bank|_ccy|_partner_id|Partner Name|Account No|Tax Code" 
                                format="0|0|0|0|0|0|0" 
                                aligns="0|0|0|0|0|0|0"
                                defaults="||||||" 
                                editcol="0|0|0|0|0|0|0" 
                                widths="1|90|225|110|110|225|110" styles="width:150; height:500"
                                sorting="T" autosize="true" oncelldblclick="OnSelect()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------------------------------------->
    <gw:textbox id="txtPartnerPk" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txtCCY" text="" styles='display:none' />
    <!----------------------------------------------------------------------------------------->
</body>
</html>
