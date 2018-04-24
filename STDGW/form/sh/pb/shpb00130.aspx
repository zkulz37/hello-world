<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Daily Product Delivery</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>  

 var Add_type = "<%=Request.querystring("Add_type")%>";  
 var Add_no = "<%=Request.querystring("Add_no")%>";  
 var Add_name = "<%=Request.querystring("Add_name")%>";
 var Add_pk = "<%=Request.querystring("Add_pk")%>";
//===============================================================
function BodyInit()
{
    var datalstType = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code3('LGMF0030') FROM DUAL" )%>";
    lstType.SetDataText(datalstType);
    lstType.value=Add_type;
    txtTypePK.text = Add_pk;
    txtTypeNo.text = Add_no+"  "+ Add_name;
    
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
    if(txtTypePK.text!="")
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pb/rpt_shpb00130.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpb00130&parameter=" + txtTypePK.text+','+ lstType.value;                            
	    System.OpenTargetPage(url);
    }
    else
    {
        alert("Please select Type Code to print")
    }
}
//===============================================================
function OnChangeSelect()
{
    txtTypePK.text="";
    txtTypeNo.text="";
}
 //==============================================================
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'TypeNo':
            var a="";
            if(lstType.value=='10')
            {
                a="Add";
            }
            else
            {
                a="Tit";
            }
            var fpath = System.RootURL + "/form/sh/ab/shab00070.aspx?type="+a;
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtTypePK.text = object[0];
                txtTypeNo.text = object[1]+"  "+ object[2];
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
                            <fieldset style="padding: 2; width: 50%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Type
                                        </td>
                                        <td style="width: 75%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:list id="lstType" styles='width:100%' onchange="OnChangeSelect()"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            <a onclick="OnPopUp('TypeNo')" href="#tips" style="color:Blue">Type No.</a>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:textbox id="txtTypePK" styles='width:100%;display:none'/>
                                            <gw:textbox id="txtTypeNo" styles='width:100%'/>
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
