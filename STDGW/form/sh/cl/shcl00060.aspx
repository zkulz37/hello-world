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
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
}
//===============================================================

//==============================================================
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/cl/rpt_shcl00060.rpt&export_pdf=Y&procedure=inv.sp_rpt_shcl00060&parameter=" + txtresult1.text+","+dtFromDate.value+","+dtToDate.value;                            
	System.OpenTargetPage(url);
}
//--------------------------------------------------------------
 function OnDataReceive(po_oData)
 {
      switch (po_oData.id)         
      {
        case "shcl00060_pro" :
             OnPrint();          
        break;
      }  
 }
 //===============================================================
 function OnProcess()
 {
    shcl00060_pro.Call();
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
    <gw:data id="shcl00060_pro" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="inv.sp_pro_shcl00060" > 
                <input>
                    <input bind="dtFromDate" />  
                    <input bind="dtToDate" /> 
                </input> 
                <output> 
                    <output bind="txtresult1" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
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
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnProcess()" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Plant
                                        </td>
                                        <td style="width: 75%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:list id="lstCompany" styles='width:100%' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            Instructed Date
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            <b>Product Type</b>
                                        </td>
                                        <td style="width: 3%" align="left" style="white-space: nowrap">
                                            <gw:checkbox id="chkProType" value='T' styles='width:100%' />
                                        </td>
                                        <td style="width: 35%">
                                            Gelatin Cap.
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
    <gw:textbox id="txtresult1" style="display: none" />
    
</body>
<!--------------------------------------------------------------------------------------->
</html>
