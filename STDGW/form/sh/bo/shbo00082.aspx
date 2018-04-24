<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
   <title>Label Printing</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

 var main_m_pk = "<%=Request.querystring("main_m_pk")%>";
 var  emp_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
 var  user_id  = "<%=Session("USER_ID")%>" ;
//===============================================================
function BodyInit()
{
    txtMasterPK.text=main_m_pk;
    dso_shbo00082.Call("SELECT");
    txtEmployeePK.text=emp_pk;
   
}
//===============================================================
function SetEnableControl()
{  
               
}
//==============================================================
function BindingDataList()
{ 
    
}
//===============================================================

function EnalbeCheck()
{  
    
}
//===============================================================
function OnPopUp(pos)
{
    
    switch(pos)
    {
        case'1':

                var fpath = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGMF0102";
                var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
                if (object != null)
                {
                    txtQtyDrum.text = object[2];
                    OnCalculate();
                }      
        break;
    }
    
}
//===============================================================
function OnCalculate()
{

    txtIssueCount.text=Math.ceil(Number(txtInstQty.text)/Number(txtQtyDrum.text));
}
//===============================================================
function OnNew()
{

}
//===============================================================
function OnSave()
{
    
    
}
//===============================================================
function OnClickGridMaster()
{
   //rdRecordType.value="U"
   //rdSubType.value="M"
}
//===============================================================
function OnDataReceive(obj)
{
    if(rdSubType.value=="S")
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00082_1.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00082_1&parameter=" + txtMasterPK.text  ;              
	    System.OpenTargetPage(url);
    }
    else
    {
        if(Number(txtIssueCount.text)<1)
        {
            alert("Please Select Q'ty/Drum !!!");
        }
        else
        {
           if(rdRecordType.value=="U")
           {
            var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00082_2.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00082_2&parameter=" + txtEmployeePK.text  ;              
	        System.OpenTargetPage(url);
	       } else
	       {
	            var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00082_3.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00082_2&parameter=" + txtEmployeePK.text  ;              
	            System.OpenTargetPage(url);
	       }
        }
        
    }
}
//===============================================================
function OnPrint()
{
    data_shbo00082_1.Call();
//    if(rdSubType.value=="B")
//    {
//        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00082_1.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00082_1&parameter=" + txtMasterPK.text  ;              
//	    System.OpenTargetPage(url);
//    }
//    else
//    {
//        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00082_2.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00082_2&parameter=" + txtMasterPK.text  ;              
//	    System.OpenTargetPage(url);
//    }
    
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shbo00082_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shbo00082" > 
                <input>
                    <input bind="txtEmployeePK" /> 
                    <input bind="txtProductCode" /> 
                    <input bind="txtProductName" />
                    <input bind="txtCustCode" /> 
                    <input bind="txtCustName" /> 
                    <input bind="txtMachineCode" /> 
                    <input bind="txtSizeCode" /> 
                    <input bind="txtSizeName" /> 
                    <input bind="txtWeight" /> 
                    <input bind="txtColorCapCode" /> 
                    <input bind="txtColorCapName" /> 
                    <input bind="txtColorBodyCode" /> 
                    <input bind="txtColorBodyName" /> 
                    <input bind="txtLotno" /> 
                    <input bind="txtInstQty" /> 
                    <input bind="txtQtyDrum" /> 
                    <input bind="txtIssueCount" />  
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="dso_shbo00082"> 
        <xml> 
            <dso type="control" function="prod.sp_sel_shbo00082">
            <inout>
                <inout bind="txtMasterPK"  />
                <inout bind="txtProductName"  />
                <inout bind="txtProductCode"  />
                <inout bind="txtCustName"  />
                <inout bind="txtCustCode"  />
                <inout bind="txtMachineCode"  />
                <inout bind="txtSizeCode"  />
                <inout bind="txtSizeName"  />
                <inout bind="txtWeight"  />
                <inout bind="txtColorCapCode"  />
                <inout bind="txtColorCapName"  />
                <inout bind="txtColorBodyCode"  />     
                <inout bind="txtColorBodyName"  /> 
                <inout bind="txtLotno"  /> 
                <inout bind="txtInstQty"  /> 
                <inout bind="txtQtyDrum"  />
                <inout bind="txtIssueCount"  />     
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 80%">
                        <td valign="middle" align="center">
                            <fieldset style="padding: 2; width: 70%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Record Type
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap; border: solid 1 #C9C299">
                                            <gw:radio id="rdRecordType" value="U" styles="width:100%" onclick="OnClickGridMaster()">                                            
			              &nbsp;&nbsp;&nbsp;<span value="U" id="Record1">Unprint&nbsp;&nbsp;</span>
			                                <span value="I" id="Record2">Imprint</span>                   			                                
        			                        </gw:radio>
                                        </td>
                                        <td style="width: 40%" colspan="4" align="right">
                                            <gw:imgbtn img="printer" alt="Print" text="Print" id="btnReport" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Sub Type
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap; border: solid 1 #C9C299">
                                            <gw:radio id="rdSubType" value="M" styles="width:100%" onclick="OnClickGridMaster()">                                            
			              &nbsp;&nbsp;&nbsp;<span value="S" id="Sub1">Sub Part</span>
			                                <span value="M" id="Sub2">Main</span>                   			                                
        			                        </gw:radio>
                                        </td>
                                        <td style="width: 40%" colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Product
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtProductCode" styles="width:100%" readonly="true" />
                                        </td>
                                        <td style="width: 40%" colspan="4">
                                            <gw:textbox id="txtProductName" styles="width:100%" readonly="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Customer
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtCustCode" styles="width:100%" readonly="true" />
                                        </td>
                                        <td style="width: 40%" colspan="4">
                                            <gw:textbox id="txtCustName" styles="width:100%" readonly="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Machine No
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtMachineCode" styles="width:100%" readonly="true" />
                                        </td>
                                        <td style="width: 5%">
                                            Size
                                        </td>
                                        <td style="width: 20%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtSizeCode" styles="width:50%" readonly="true" />
                                            <gw:textbox id="txtSizeName" styles="width:50%" readonly="true" />
                                        </td>
                                        <td style="width: 1%">
                                            Weight
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtWeight" styles="width:100%" readonly="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Color Cap
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtColorCapCode" styles="width:100%" readonly="true" />
                                        </td>
                                        <td style="width: 40%" colspan="4">
                                            <gw:textbox id="txtColorCapName" styles="width:100%" readonly="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Color Body
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtColorBodyCode" styles="width:100%" readonly="true" />
                                        </td>
                                        <td style="width: 40%" colspan="4">
                                            <gw:textbox id="txtColorBodyName" styles="width:100%" readonly="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            LOT No
                                        </td>
                                        <td style="width: 30%">
                                            <gw:textbox id="txtLotno" styles="width:100%" readonly="true" />
                                        </td>
                                        <td colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Instructed Q'ty
                                        </td>
                                        <td style="width: 30%">
                                            <gw:textbox id="txtInstQty" styles="width:100%" type="number" format="###,###.###"
                                                readonly="true" />
                                        </td>
                                        <td colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Q'ty/Drum</b>
                                        </td>
                                        <td style="width: 30%" align="right" style="white-space: nowrap">
                                            <gw:textbox id="txtQtyDrum" styles="width:100%" readonly="true" type="number" format="###,###" />
                                        </td>
                                        <td colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Issue Count
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtIssueCount" styles="width:30%" readonly="true" type="number" format="###,###" />
                                        </td>
                                        <td colspan="4">
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
    <gw:textbox id="txtEmployeePK" style="display: none" />
    <gw:textbox id="txtReturnValue" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
