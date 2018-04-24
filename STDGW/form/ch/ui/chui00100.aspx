<!-- #include file="../../../system/lib/form.inc"  -->
  <% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var bSelect =false;
var bSearch =false;
var codeadmin_yn;
var is_popup;
var post_flag='N';
var v_language = "<%=Session("SESSION_LANG")%>";
    var check_init = 0;

function BodyInit()
{   
   

    if (v_language!="ENG")
        System.Translate(document);

    idGrid.GetGridControl().FrozenCols = 3;
    idGrid.GetGridControl().ScrollTrack = true;
    iduser_pk.text = "<%=session("USER_PK")%>";
   
    txtHr_level.text= "<%=session("HR_LEVEL")%>";

    dso_chui00100.Call();
    
}

//---------------------------------------------------------
function OnSearch()
{
    txtRefreshData.text="N";
    dso_chui00100_1.Call("SELECT");
}
//----------------------------------------------------------

function OnDataReceive(obj)
{
    if (obj.id == "dso_chui00100") {
        //alert(txtResult.text);
        if (txtResult.text == "Y")  //thang da dong
        {
            lblStatus.text = "";
            ibtnProcess.SetEnable(true);
            ibtnDelete.SetEnable(true);
            ibtnPosInf.SetEnable(true);
        }
        else {
            lblStatus.text = "This month is openning.";
            ibtnProcess.SetEnable(false);
            ibtnDelete.SetEnable(false);
            ibtnPosInf.SetEnable(false);
        }

        if (txtPostInf.text == "N")     //chua post infterface
        {
            lblStatus2.text = "";
        }
        else
        {
            lblStatus2.text = txtPostInf.text;
        }

        if (txtInfYN.text == "Y")     //Da get infterface
        {
            lblStatus.text = "This month has get Interface data.";
            ibtnProcess.SetEnable(false);
            ibtnDelete.SetEnable(false);
            ibtnPosInf.SetEnable(false);

        }
        

        dso_chui00100_1.Call("SELECT");
        
    }
    if (obj.id == "dso_chui00100_1")
    {
        lblRecord.text=idGrid.rows-1 + "(s).";
        auto_resize_column(idGrid, 0, idGrid.cols - 1, 9);
        if (txtInfYN.text == "Y")     //Da get infterface
        {
                idGrid.SetCellBgColor(1, 0, idGrid.rows - 1, idGrid.cols - 1, 0xFFEEFF);

        }
        check_init = 1;
    }
    if (obj.id == "dso_chui00100_2")
    {
        alert(txtFlag.text + " successful!");
        lblStatus2.text = "";
        
        dso_chui00100_1.Call("SELECT");
    }
    if (obj.id == "dso_chui00100_3") {
        alert("Post successful!");
        dso_chui00100.Call();
    }
	
	if (obj.id=="datFind_Report")
   {
        var url =System.RootURL + '/reports/ch/ui/'+txtReport_tmp.text+'?p_work_mon=' + dtWorkMon.value;
		//alert(url);
		window.open(url);
          
   }
}

//-------------------
function auto_resize_column(obj, col1, col2, font_size) {
    if (font_size != 0)
        obj.GetGridControl().FontSize = font_size;
    obj.GetGridControl().AutoSize(col1, col2, false, 0);
}



function OnPostInf(obj)
{
	txtFlag.text = obj;
    if (check_init == 1)
        if (confirm("Are you want to " + txtFlag.text + " interface this month?"))
            dso_chui00100_3.Call();
}

function OnProcess(obj) {
    if (check_init == 1) {
        txtFlag.text = obj;
        if (confirm("Are you want to " + txtFlag.text + " this month?"))
            dso_chui00100_2.Call();
    }
}

function OnCheckMonth()
{
    if (check_init == 1)
        dso_chui00100.Call();
}

function OnReport()
{
	txtReport_tmp.text="rpt_chui00100.aspx";
        
    datFind_Report.Call();  
}
</script>
<body style="margin-top:0">

<!------------main control---------------------->

<gw:data id="dso_chui00100" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="hr_pro_chui00100" > 
            <input>
                <input bind="dtWorkMon" />
            </input> 
            <output>
                <output bind="txtResult" />
                <output bind="txtPostInf" />
                <output bind="txtInfYN" />
            </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_chui00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0" function="hr_sel_chui00100_1" procedure="">  
                <input bind="idGrid">  
                    <input bind="dtWorkMon" />
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dso_chui00100_2" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="hr_pro_chui00100_2" > 
            <input>
                <input bind="dtWorkMon" />
                <input bind="txtFlag" />
            </input> 
            <output>
                <output bind="txtResult" />
            </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_chui00100_3" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="hr_pro_chui00100_3" > 
            <input>
                <input bind="dtWorkMon" />
				<input bind="txtFlag" />
            </input> 
            <output>
                <output bind="txtResult" />
            </output>
        </dso> 
    </xml> 
</gw:data>
 
<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data> 

<!------------------table--------------------------->
   <table width="100%" id="tblMain" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
        <tr style="border:0;width:100%;height:1%" >
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        </tr>
        
        <tr style="border:0;width:100%;height:5%" >
            <td colspan="10" align="right">Work Month</td>
            <td colspan="10" align="left"><gw:datebox id="dtWorkMon" type="month" onchange="OnCheckMonth()" styles="width:100%" lang="<%=Session("Lang")%>" /></td>
            <td colspan="15" align="right"><gw:label id="lblStatus" styles="font-weight:bold; color:blue; font-size: 13" text="" /></td>
            <td colspan=25 align=right style="border:0"><gw:label id="lblStatus2" styles="font-weight:bold; color:blue; font-size: 13" text="" /></td>
            <td colspan="5" align="left"></td>
            <td colspan="5" align="center"><gw:icon id="ibtnProcess"  text="Process"  img="in"  styles="width:90%" onclick="OnProcess('PROCESS')"/></td>
            <td colspan="5" align="left"><gw:icon id="ibtnDelete"  text="Delete"  img="in"  styles="width:90%" onclick="OnProcess('DELETE')"/></td>
            <td colspan=5 align=center><gw:icon id="ibtnPosInf"  text="Post Inf"  img="in"  styles="width:90%" onclick="OnPostInf('post')"/></td>
			<td colspan=5 align=center><gw:icon id="ibtnDeleteInf"  text="Cancel Inf"  img="in"  styles="width:90%" onclick="OnPostInf('cancel')"/></td>
			<td colspan=5 align=center><gw:icon id="ibtnReport"  text="Report"  img="in"  styles="width:90%" onclick="OnReport()"/></td>
            <td colspan=5 align=center><gw:label id="lblRecord" styles="font-weight:bold; color:red; font-size: 13" text="" /></td>
        </tr>
       
        <tr style="border:1;width:100%;height:94%" valign="top">
            <td colspan=100 "> 
                <table width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
                    <tr><td>
                        <gw:grid   
                            id="idGrid"  
                            header="HR_SEQ_NO|HR_TRX_T|REGIS_CANC_D|SH_LCL_CORP_C|BRNO|BNKERNO|BNKR_NM|ENG_BNKR_NM|STND_DT1|REGIS_DT|REGIS_TIME|REGIS_BNKERNO|LCL_STF_YN|GEP_SLR_PMT_D|GEP_SLR_K|SLR_PMT_DT|SLR_PMT_YN|TRX_EXRT|CCY_C|SLR_ACNO|PSN_INTAX_TX_GRP_C|WORK_DCNT|USD_BSCPAY_AMT|BSCPAY_AMT|ACTL_BSCPAY_AMT|USD_ING_FMLA_BIG_AMT|ING_FMLA_BIG_AMT|USD_TREXPS_AMT|TREXPS_AMT|OVTM_ALWC_AMT|SPC_REGN_WORK_ALWC_AMT|ALL_ALWC_AMT|ETC_ALWC_AMT|GROS_SLR_AMT|SCT_INSFEE_BNK_BUDN_AMT|HLTH_INSFEE_BNK_BUDN_AMT|JBLS_INS_AMT|SCT_INSFEE_STF_BUDN_AMT|HLTH_INSFEE_STF_BUDN_AMT|JBLS_INS_AMT_2|INTAX_AMT|IDENT_DDT_AMT|DPDFMLY_CNT|SPT_FMLY_DDT_AMT|TOT_DDT_AMT|LBUN_CST_AMT|NET_PAYMT_USD|NET_PAYMT_VND
								|OUT_FILE_YN|INTERFACE_YN"
                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                            aligns="0|0|0|0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                            defaults="|||||||||||||||||||||||||||||||||||||||||||||||||"  
                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                            widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                            styles="width:100%; height:100%"   
                            sorting="T"   
                            /> 
                    </td></tr>
                </table>
            </td>
            
        </tr>
               
    </table>
</body>
   
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtRefreshData" styles="display:none"/>
    <gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtPostInf" styles="display:none"/>
    <gw:textbox id="txtInfYN" styles="display:none"/>
    <gw:textbox id="txtFlag" styles="display:none"/>
	<gw:textbox id="txtReport_tmp" styles="display:none"/>
</html>
