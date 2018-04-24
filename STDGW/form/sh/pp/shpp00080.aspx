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
        data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE||' - '||a.CODE_NM FROM Sale.LG_CODE a, Sale.LG_CODE_GROUP b WHERE  b.GROUP_ID='LGMF0020' AND a.LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>"
        lstSizeF.SetDataText(data);
        lstSizeF.value ='100'
        lstSizeT.SetDataText(data);
        lstSizeT.value='116'
        dtFromDate.SetEnable(false)
        dtToDate.SetEnable(false) 
}
function OnCheckSort()
{
    if(chkSort_YN.value=='Y')
    {
        dtFromDate.SetEnable(true)
        dtToDate.SetEnable(true)
    }else
    {
        dtFromDate.SetEnable(false)
        dtToDate.SetEnable(false)        
    }
}

function OnPrint()
{
   if(chkSort_YN.value=='N')
   {
    if (rdoPrint.value =='Y')
    {
        if(rdoDE.value =='Y')
        {
             var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00080.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00080&parameter=" + rdoDE.value + "," + lstSizeF.value + "," + lstSizeT.value ;                            
	         System.OpenTargetPage(url);
        }else
        {
              var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00081.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00080&parameter=" + rdoDE.value + "," + lstSizeF.value + "," + lstSizeT.value ;                            
	         System.OpenTargetPage(url);
        }
    }else
    {
         if(rdoDE.value =='Y')
        {
             var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00082.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00082&parameter=" + rdoDE.value + "," + lstSizeF.value + "," + lstSizeT.value ;                            
	         System.OpenTargetPage(url);
        }else
        {
             var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00083.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00082&parameter=" + rdoDE.value + "," + lstSizeF.value + "," + lstSizeT.value ;                            
	         System.OpenTargetPage(url);
        }
    }
   }else ///sorting mafg
   {
        if (rdoPrint.value =='Y')
        {
            if(rdoDE.value =='Y')
            {
                 var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00084.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00084&parameter=" + rdoDE.value + "," + lstSizeF.value + "," + lstSizeT.value+","+dtFromDate.value +"," + dtToDate.value ;                            
	             System.OpenTargetPage(url);
            }else
            {
                 var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00085.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00084&parameter=" + rdoDE.value + "," + lstSizeF.value + "," + lstSizeT.value+","+dtFromDate.value +"," + dtToDate.value ;                            
	             System.OpenTargetPage(url);
            }
        }else
        {
            if(rdoDE.value =='Y')
            {
                 var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00086.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00086&parameter=" + rdoDE.value + "," + lstSizeF.value + "," + lstSizeT.value+","+dtFromDate.value +"," + dtToDate.value ;                            
	             System.OpenTargetPage(url);
            }else
            {
                 var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00087.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00086&parameter=" + rdoDE.value + "," + lstSizeF.value + "," + lstSizeT.value+","+dtFromDate.value +"," + dtToDate.value ;                            
	             System.OpenTargetPage(url);
            }
        }
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
                                        <td style="width: 75%; white-space: nowrap" colspan="3" align="right">
                                        </td>                                        
								        <td  align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Company
                                        </td>
                                        <td style="width: 75%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:list id="lstCompany" styles='width:100%' />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            Prod. Type
                                        </td>
                                        <td style="width: 50%" align="left" style="white-space: nowrap" colspan="2">
                                             <gw:radio id="rdoPrint" value="Y" styles='height:22'>
									            <span value="Y">Print</span>
									            <span value="N">Unprint</span>
								            </gw:radio >
								        </td>
								        
                                    </tr>
                                     <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            DOM/EXP
                                        </td>
                                        <td style="width: 50%" align="left" style="white-space: nowrap" colspan="2">
                                             <gw:radio id="rdoDE" value="N" styles='height:22' >
									            <span value="Y">Dom</span>
									            <span value="N">Exp</span>
								            </gw:radio >
								        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            Size From
                                        </td>
                                        <td style="width: 50%" align="left" style="white-space: nowrap" colspan="2">
                                             <gw:list id="lstSizeF" styles='width:100%' />                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                           To
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                             <gw:list id="lstSizeT" styles='width:100%' />                                       
                                        </td>
                                    </tr>
                                     <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            <gw:checkbox id="chkSort_YN" value="N" defaultvalue="Y|N" onchange="OnCheckSort()" />
                                        </td>
                                        <td style="width: 50%" align="left" style="white-space: nowrap" colspan="2">
                                              Sorting in order of MFG Date                                 
                                        </td>
                                    </tr>  
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            Period
                                        </td>
                                        <td style="width: 50%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%"  />
                                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%"  />
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
   
</body>
<!--------------------------------------------------------------------------------------->
</html>
