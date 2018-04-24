<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script language="javascript">
function BodyInit()
{
	System.Translate(document);
	data = "<%=ESysLib.SetListDataFUNC("SELECT ACNT.SF_A_GET_COMMONCODE('TPS0038') FROM DUAL")%>"; 
	lstPayDescrip.SetDataText(data);
	lstPayDescrip.value=2;
	data = "data|01|Inputted Personel|02|Equipment Outsourcing Cost|03|Contruction Material |04|Expenditures";
    lstType.SetDataText(data); 
	data     = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('COAB0070') FROM DUAL")%>";
	lstLanguage.SetDataText(data);
	OnShowHideBudget();
}
function OnPopUp(obj)
{
        switch(obj)
        {
                case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {   
                                    f_lag="1";
									txtProject_Pk.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2];  
									dso_BudgetNo.Call("SELECT");
                            } 
                break;
        }
} 
function OnShowHideBudget()
{
	if(lstPayDescrip.value=='1')
	{
		lstPrv_S_No.GetControl().style.display = "none";

	}
	else
	{
		lstPrv_S_No.GetControl().style.display = "";

	}
}
//////////////////////////////////////////////////////////////////////////
function OnDataReceive(obj)
{
	if(obj.id=='dso_BudgetNo')
	{
		dso_BudgetNoPreview.Call("SELECT");
	}
}
//////////////////////////////////////////////////////////////////////////
function OnSearch()
{
	if(lstType.value=='01'&& txtProject_Pk.text!="")
	{
		var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=kp/bm/kpbm2112_AutoColumn.rpt&procedure=ec111.sp_sel_kpbm2112|EC111.sp_rpt_kpbm2112_budgetno|EC111.sp_rpt_kpbm2112_prv_budgetno&parameter="+txtProject_Pk.text+","+lstBudget.value+","+lstPayDescrip.value+","+lstType.value+"|"+lstBudget.value+"|"+lstPrv_S_No.value+","+lstPayDescrip.value;   
		System.OpenTargetPage(url); 														   
	}
else
{
	alert("Please,choose project to search.");
}	
}
</script>

<body>
<gw:data id="dso_BudgetNo" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="list" procedure="ec111.sp_sel_kpbm2112_budgetno" > 
			<input> 
				<input bind="txtProject_Pk" />
			</input> 
			<output>
				<output bind="lstBudget" /> 
			</output>
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_BudgetNoPreview" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="list" procedure="ec111.sp_sel_kpbm2112_budgetno_prv" > 
			<input> 
				<input bind="txtProject_Pk" />
			</input> 
			<output>
				<output bind="lstPrv_S_No" /> 
			</output>
		</dso> 
	</xml> 
</gw:data>
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
		<tr style="height: 6%">
		<td>
		<table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td  width="10%">
			</td>
			<td width="10%">
			</td>
			<td width="7%">
			</td>
			<td width="25%">
			</td>
			<td width="3%">
			</td>
			<td width="17%">
			</td>
			<td width="25%">
			</td>
			<td width="3%">
			</td>
		</tr>
		<tr style="height: 2%;width:100%" valign="top">
			<td   align="right">
				<a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">
																Project&nbsp;</a>
			</td>
			<td  colspan="3">
				<gw:textbox id="txtProject_Cd" readonly="true" styles='width:35%' /><gw:textbox id="txtProject_Nm" readonly="true" styles='width:64%' />
			</td>
			<td width="3%">
				<gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
			</td>
			<td  align="right">
				Budget Statement No&nbsp;
			</td>
			<td >
				<gw:list id="lstBudget" styles='width:100%' />  
			</td>
			<td >
				<gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
			</td>
		</tr>
		
		<tr style="height: 2%;width:100%" valign="top">
			<td   align="right">Description&nbsp;</td>
			<td ><gw:list id="lstPayDescrip" styles='width:100%' onchange="OnShowHideBudget()" /></td>
			<td  align="right">Type&nbsp;</td>
			<td><gw:list id="lstType" styles='width:100%' /></td>
			<td  colspan="2" align="right">Prev. Times (Serial No.) &nbsp;</td>
			<td ><gw:list id="lstPrv_S_No" styles='width:100%' /></td>
			
		</tr>
        <tr style="height: 94%;" valign="top">
        	<td   align="right"  colspan="4"></td>
			<td  colspan="2" align="right">Language&nbsp;</td>
			<td ><gw:list id="lstLanguage" styles='width:100%' /></td>	
        </tr>
    </table>
	</td>
	</tr>
	<tr style="height: 94%;" valign="top">
        		
        </tr>
	 </table>
	<gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
</body>
</html>
