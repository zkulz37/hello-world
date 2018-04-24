<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Daily Product Delivery</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>  
//===============================================================
function BodyInit()
{   
    var data="";    
        data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code4('LGMF0020') FROM DUAL" )%>";    
        lstSizeFrom.SetDataText(data);
        lstSizeTo.SetDataText(data);
        lstSizeTo.value='116';
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGMF0070') FROM DUAL" )%>";    
        lstTypeCap.SetDataText(data);
        lstTypeCap.value="";
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGMF0070') FROM DUAL" )%>";    
        lstTypeBody.SetDataText(data);
        lstTypeBody.value="";
        txtMasterPK.text="<%=Request.querystring("Master_pk")%>";
}
//===============================================================
//function OnDataReceive(obj)
//{
//    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00170.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00170&parameter=" + txtBatchNo.text + "," + dtIssueDate.value + "," + emp_pk + "," + user_id ;                            
//	System.OpenTargetPage(url); 
//}
//==============================================================
function OnPrint()
{
    if(rdType.value=="Ship")
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/ex/rpt_shex00020_1.rpt&export_pdf=Y&procedure=sale.sp_rpt_shex00020_1&parameter=" + txtMasterPK.text+ "," + lstSizeFrom.value + "," + lstSizeTo.value + "," + dtFrom.value + "," + dtTo.value ;                            
	    System.OpenTargetPage(url);
    }
    if(rdType.value=="Rele")
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/ex/rpt_shex00020_2.rpt&export_pdf=Y&procedure=sale.sp_rpt_shex00020_2&parameter=" + txtMasterPK.text+ "," + lstSizeFrom.value + "," + lstSizeTo.value + "," + dtFrom.value + "," + dtTo.value ;                            
	    System.OpenTargetPage(url);
    }
     
	
}
 //==============================================================
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'BatchNo':
            var fpath = System.RootURL + "/form/sh/bo/shbo00171.aspx";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                dtFromDate.value = object[1];
                dtToDate.value   = object[1];
                txtBatchNo.text = object[2];
            }
        break;
    }
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 100%">
                        <td valign="middle" align="center">
                            <fieldset style="padding: 2; width: 60%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="center">
                                            <gw:radio id="rdType" value="Ship" styles="width:100%; height:100%">                   
		                                        &nbsp;&nbsp;&nbsp;<span value="Ship" id="Span1">Shipment</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                      
		                                        <span value="Rele" id="Span2">Release Date</span>  
    			                            </gw:radio>
                                        </td>
                                        <td align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%; white-space: nowrap" align="right">
                                            Size
                                        </td>
                                        <td style="width: 35%" align="left" style="white-space: nowrap" >
                                            <gw:list id="lstSizeFrom" styles='width:100%' />
                                        </td>
                                        <td style="width: 35%" align="left" style="white-space: nowrap" >
                                            <gw:list id="lstSizeTo" styles='width:100%' />
                                        </td>
                                        <td>
                                            </td>
                                    </tr>
                                    <%--<tr>
                                        <td style="width: 15%; white-space: nowrap" align="right">
                                        </td>
                                        <td style="width: 60%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:list id="lstSizeTo" styles='width:100%' />
                                        </td>
                                        <td>
                                            To
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td align="right">
                                            Customer</td>
                                        <td style="white-space: nowrap" colspan="2">
                                            <gw:textbox id="txtCustomerID" styles="width:30%" />
                                            <gw:textbox id="txtCustomerName" styles="width:70%" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td align="right" colspan="2">
                                            <gw:textbox id="txtNation" styles="width:70%" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            Print Type</td>
                                        <td style="white-space: nowrap">
                                            <gw:list id="lstTypeCap" styles='width:100%' />
                                        </td>
                                        <td style="width: 30%">
                                            <gw:list id="lstTypeBody" styles='width:100%' />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Period</td>
                                        <td colspan="2" style="white-space: nowrap">
                                            <gw:datebox id="dtFrom" lang="1" />
                                            ~
                                            <gw:datebox id="dtTo" lang="1" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
    <gw:textbox id="txtEmpPK" style="display: none" />
    <gw:textbox id="txtReturnValue" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
