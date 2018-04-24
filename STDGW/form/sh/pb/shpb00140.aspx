<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Blending Type Display </title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>
 var  main_m_pk    = "<%=Session("main_m_pk")%>" ;
 var  emp_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
 var  user_id  = "<%=Session("USER_ID")%>" ; 
 var batchno = "<%=Request.querystring("batchno")%>";
 var inst_dt = "<%=Request.querystring("inst_dt")%>";
 var blend_type = "<%=Request.querystring("blend_type")%>";  
 var blend_no = "<%=Request.querystring("blend_no")%>";  
//===============================================================
function BodyInit()
{

    txtBlendingNo.text = batchno;
    lstBlendingType.value=blend_type;
    txtBlendingNo.text=blend_no;
}
//===============================================================
function OnDataReceive(obj)
{
    
}
//==============================================================
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pb/rpt_shpb00140.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpb00140&parameter=" + lstBlendingType.value + "," + txtBlendingNo.text + "," + lstBlendingType.GetText().substring(lstBlendingType.GetText().indexOf("-")+1)  ;                            
	System.OpenTargetPage(url); 
}
 //==============================================================
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'Blending':
            var fpath = System.RootURL + "/form/sh/ab/shab00100.aspx?type=Blend&typeCode=" + lstBlendingType.value;
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtBlendingNo.text = object[3];
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
                            <fieldset style="padding: 2; width: 80%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan=2 align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="width:25%" align="right">
                                            Type
                                        </td>
                                        <td style="width:30%"  align="left" style="white-space:nowrap" >
                                            <gw:list id="lstBlendingType" styles="width: 100%" onchange="OnSearch()" >
                                            <data>
                                                <%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code2('LGMF0030') FROM DUAL" )%>
                                            </data>
                                            </gw:list>
                                        </td>
                                        <td style="width:35%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:25%" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Blending')">Blending No.</b>
                                        </td>
                                        <td style="width:30%"  align="left" style="white-space:nowrap" >
                                            <gw:textbox id="txtBlendingNo" styles='width:100%' />
                                        </td>
                                        <td style="width:35%">
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
