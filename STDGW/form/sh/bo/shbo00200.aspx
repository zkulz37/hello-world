<!-- #include file="../../../system/lib/form.inc"  -->
<html>
  <head>
    <title>Manufacturing Instruction and Record (1.Color Matching)</title>
  </head>
 <%ESysLib.SetUser("prod")%>
 
<script>
function BodyInit()
{
    txtIssue_PK.text= "<%=Session("EMPLOYEE_PK")%>";   
    //alert(txtIssue_PK.text);
    txtLotNo.text	= "<%=Request.querystring("p_lotno")%>";
    DtFrom.value= "<%=Request.querystring("p_dtfrom")%>";  
    DtTo.value= "<%=Request.querystring("p_dtfrom")%>";   
    //alert(txtIssue_PK.text+''+DtIssue.value''+txtLotNo.text);
    var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
}
function OnDataReceive(obj)
{
        var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=sh/bo/shbo00200.rpt&procedure=PROD.sp_sel_shbo00200_rpt&parameter="+txtLotNo.text;              
	    System.OpenTargetPage(url); 
        //window.close();
}
function OnDataReceive1(obj)    
{
        //var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=sh/bo/shbo00200_1.rpt&procedure=PROD.sp_sel_shbo00200_1_rpt|PROD.sp_sel_shbo00200_1_dt_rpt|PROD.sp_sel_shbo00200_colrant_b|PROD.sp_sel_shbo00200_colpack_b|PROD.sp_sel_shbo00200_sum_sl_can&parameter="+txtLotNo.text+","+txtIssue_PK.text+"|"+txtLotNo.text+"|"+txtLotNo.text+"|"+txtLotNo.text+"|"+txtLotNo.text;   
         var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=sh/bo/shbo00200_1.rpt&procedure=PROD.sp_sel_shbo00200_1_rpt|PROD.sp_sel_shbo00200_1_dt_rpt|PROD.sp_sel_shbo00200_colrant_b|PROD.sp_sel_shbo00200_colpack_b|PROD.sp_sel_shbo00200_sum_sl_can&parameter="+ 
         txtLotNo.text+"|"+txtLotNo.text+","+txtIssue_PK.text+"|"+txtLotNo.text+"|"+txtLotNo.text+"|"+txtLotNo.text;   
	    System.OpenTargetPage(url); 
        //window.close();
}
function OnDataReceive2(obj)
{
        var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=sh/bo/shbo00200_2.rpt&procedure=PROD.sp_sel_shbo00200_2_all_m_rpt|PROD.sp_sel_shbo00200_active_add|PROD.sp_sel_shbo00200_rpt_at_clrant|PROD.sp_sel_shbo00200_rpt_active_p&parameter="+txtIssue_PK.text+","+txtLotNo.text+"|"+txtLotNo.text+"|"+txtLotNo.text+"|"+txtLotNo.text;              
        //var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=sh/bo/shbo00200_2.rpt&procedure=PROD.sp_sel_shbo00200_2_rpt|PROD.sp_sel_shbo00200_active_add&parameter="+txtIssue_PK.text+"|"+txtLotNo.text;              
        System.OpenTargetPage(url); 
        //window.close();
}
function OnPrint()
{
  
    if(rdPrint.value==1)
    {
	    shbo00200_afterreport.Call(); 
	}
	if(rdPrint.value==2)
    {
	    shbo00200_afterreport1.Call();
	}
	if(rdPrint.value==3)
    {
         shbo00200_BeforeReport.Call();
	}

}
</script>
<body>
<gw:data id="shbo00200_afterreport" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="process" procedure="PROD.sp_upd_shbo00200_afterreport"> 
                <input > 
                    <input bind="txtLotNo" />
                    <input bind="DtIssue" />
                    <input bind="txtIssue_PK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="shbo00200_afterreport1" onreceive="OnDataReceive1(this)"> 
        <xml>                                                               
            <dso id="1" type="process" procedure="PROD.sp_upd_shbo00200_afterreport"> 
                <input > 
                    <input bind="txtLotNo" />
                    <input bind="DtIssue" />
                    <input bind="txtIssue_PK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="shbo00200_BeforeReport" onreceive="OnDataReceive2(this)"> 
        <xml>                                                               
            <dso id="1" type="process" procedure="PROD.SP_SEL_SHBO00200_beforereport"> 
                <input > 
                    <input bind="txtIssue_PK" />
                    <input bind="txtLotNo" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
</gw:data>
        <table style="height: 100%; width: 100%; background-color: #B4CFEC">
        <tr>
            <td style="width: 13%">
            </td>
            <td style="width: 75%">
            <fieldset><legend><font><b><i>Optional</i></b></font></legend>
            <table style="height: 100%; width: 100%">
             <!--<tr style="height: 1%;" valign="top">
                <td style="width: 20%"></td>
                <td style="width: 80%" align="right"><gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnReportAcct()" styles='width:100%'/></td>
            </tr>-->
             <tr valign="top" style="height: 2%;">
                <td style="width: 35%" align="right"></td>
                <td style="width: 65%" align="right">
                    <table style="height: 100%; width: 100%">
                        <tr>
                            <td style="width: 33%" align="center">
                              
                            </td>
                            <td style="width: 34%" align="center">
                                
                            </td>
                            <td style="width: 33%" align="right">
                               <gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnPrint()" styles='width:100%'/>
                            </td>
                        </tr>
                    </table>  
    		</td>
            </tr>
            <tr valign="top" style="height: 2%;">
                <td style="width: 35%" align="right"></td>
                <td style="width: 65%">
                    <table style="height: 100%; width: 100%">
                        <tr>
                            <td style="width: 33%" align="center">
                              batbr60 
                            </td>
                            <td style="width: 34%" align="center">
                             batbr61   
                            </td>
                            <td style="width: 33%" align="center">
                              batbr63  
                            </td>
                        </tr>
                    </table>  
    		</td>
            </tr>
            <tr valign="top" style="height: 2%;">
                <td style="width: 35%" align="right">Printing Terms</td>
                <td style="width: 65%">
                <fieldset>
                    <table style="height: 100%; width: 100%">
                        <tr>
                            <td style="width: 100%">
                                <gw:radio id="rdPrint" value="1" styles="width:100%; height:100%">                   
		                                                    <span value="1" id="rd1">Instruction A</span>                      
		                                                    <span value="2" id="rd2">Instruction B</span>  
		                                                    <span value="3" id="rd3">Actual</span> 
    			                                </gw:radio>
                            </td>
                        </tr>
                    </table>  
                    </fieldset> 
    		</td>
            </tr>
            <tr valign="top" style="height: 2%;">
                <td style="width: 35%" align="right">Instructed Date</td>
                <td style="width: 65%">
                    <table>
                        <tr>
                            <td>
                            <gw:datebox id="DtFrom" maxlen="10"   styles='width:100%' lang="<%=Session("Lang")%>"/></td>
                            <td>
                            ~
                            </td>
                            <td>
                            <gw:datebox id="DtTo" maxlen="10"   styles='width:100%' lang="<%=Session("Lang")%>"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr valign="top" style="height: 2%;">
                <td style="width: 35%" align="right">Pant</td>
                <td style="width: 65%"><gw:list id="lstCompany" styles='width:100%' /></td>
            </tr>
            <tr valign="top" style="height: 2%;">
                <td style="width: 35%" align="right">Issue Date</td>
                <td style="width: 65%">
                    <table>
                        <tr>
                            <td>
                            <gw:datebox id="DtIssue" maxlen="10"   styles='width:100%' lang="<%=Session("Lang")%>"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr valign="top" style="height: 12%;">
                <td style="width: 35%" align="right">Lot No</td>
                <td style="width: 65%"><gw:textbox id="txtLotNo" styles="width: 100%;" csstype="mandatory"  /></td>
            </tr>
            </table>
            </fieldset>
            </td>
            <td style="width: 12%">
            <table style="height: 100%; width: 100%">
               <tr style="height: 100%;" valign="top">
                <td style="width: 35%"></td>
                <td style="width:65%" align="right"></td>
            </tr>
            </table>
            </td>
        </tr>
            <tr valign="top" style="height: 97%;"></tr>
        </table>
        <gw:textbox id="txtIssue_PK" styles="width: 100%;display:none" />
        <gw:textbox id="txtReturnValue" styles="width: 100%;display:none" />
</body>
</html>
