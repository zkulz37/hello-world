<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Galetin Weight & Melting Instruction and Record</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

 var main_m_pk = "<%=Request.querystring("main_m_pk")%>";
 var lotno="<%=Request.querystring("lotno")%>";
 var hoki="<%=Request.querystring("hoki")%>";
 var  emp_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
 var  user_id  = "<%=Session("USER_ID")%>" ;
 var batchno = "<%=Request.querystring("batchno")%>";
 var inst_dt = "<%=Request.querystring("inst_dt")%>";   
 var tankno = "<%=Request.querystring("tankno")%>";   
//===============================================================
function BodyInit()
{
    txtMasterPK.text=main_m_pk;
    txtEmpPK.text= emp_pk;
    dtFromDate.value = inst_dt;
    dtToDate.value = inst_dt;
    txtBatchno.text = batchno;
    txtMTno.text = tankno;
}
//===============================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'data_shbo00160_1':
            if(rdClass.value=='1')
            {
                var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00160_1.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00160_1&parameter=" + txtBatchno.text + ',' + dtFromDate.value + ',' + dtToDate.value + ',' + txtMTno.text + "," + dtIssueDate.value + "," + emp_pk + "," + user_id ;                
	            System.OpenTargetPage(url);
            }
            else
            { 
                var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00160_2.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00160_2&parameter=" + txtBatchno.text + ',' + dtFromDate.value + ',' + dtToDate.value + ',' + txtMTno.text + "," + dtIssueDate.value + "," + emp_pk + "," + user_id ;   
	            System.OpenTargetPage(url);
            }
        break;
    }
}
//===============================================================
function OnPrint()
{
    data_shbo00160_1.Call();  
}
//===============================================================
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'BatchNo':
            var fpath = System.RootURL + "/form/sh/bo/shbo00161.aspx";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                dtFromDate.value = object[1];
                dtToDate.value   = object[1];
                txtBatchno.text = object[2];
                txtMTno.text =  object[3];
            }
        break;
    }
}
</script>

<body>
    <gw:data id="data_shbo00160_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shbo00160" > 
                <input>
                    <input bind="txtBatchno" /> 
                    <input bind="txtMTno" /> 
                    <input bind="dtIssueDate" /> 
                    <input bind="txtEmpPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 80%">
                        <td valign="middle"  align="center">
                            <fieldset style="padding: 2; width: 50%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="right">
                                            <gw:imgbtn id="btnPrint" img="printer" alt="Print" text="Print" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <b>Class</b>
                                        </td>
                                        <td>
                                            <gw:radio id="rdClass" value="1" styles="width:100%">                                            
			                                <span value="1" id="Class1">Weighing</span>
			                                <span value="2" id="Class2">Melting</span>                   			                                
        			                        </gw:radio>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%; white-space: nowrap" align="right">
                                            <b>Instructed Period</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                            <b>Issued Date</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:datebox id="dtIssueDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                            <b>M/T No.</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtMTno" styles="width:50%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('BatchNo')">Batch No.</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtBatchno" styles="width:70%" />
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
    <gw:textbox id="txtReturnValue" style="display: none" />
    <gw:textbox id="txtEmpPK" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
