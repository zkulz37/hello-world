<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>    
</head>
<%ESysLib.SetUser("acnt")%>

<script>
//-----------------------------------------              
function BodyInit()
{
    System.Translate(document);
    var ls_date_fr = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE, -1)) + 1, 'YYYYMMDD') FROM DUAL")%>";
    dtTakeout_fr.SetDataText(ls_date_fr);
    txtcompk.text = "<%=Request.querystring("company")%>";
	dtTakeout_fr.value = "<%=Request("takeout_dt")%>";
	dtTakeout_to.value = "<%=Request("takeout_dt")%>";
	//set data for item group
	var l_grp_list = "<%=ESysLib.SetListDataSQL("select pk, GRP_NM from comm.TCO_ITEMGRP where del_if = 0 ")%>|ALL|Select all";
	lstGroup.SetDataText(l_grp_list);
	lstGroup.value = 'ALL';	
}
//------------------------------------------
function OnSelect()
{
    var i, j ;
	var aValue = new Array();
	for(i=1; i<grdDtl.rows; i++)
    {
		if(grdDtl.GetGridData(i, 0)== "-1")
		{
			tmp= new Array();
			for(j = 0; j < grdDtl.cols; j++)
			{
				tmp[tmp.length] = grdDtl.GetGridData(i, j);
			}			
			aValue[aValue.length]=tmp;
		}
    }
	window.returnValue = aValue;
	window.close();
}
//--------------------------------------------
function OnSearch()
{
	dso_takeout_mat.Call('SELECT');
}
//--------------------------------------------
function OnDataReceive(iObj)
{
	switch(iObj.id)
	{
		case 'dso_takeout_mat':			
		break ;
	}
}
//--------------------------------------------
function OnCheckAll()
{
	var i;
	if(chkAll.value == "F")
	{
		for(i = 1; i < grdDtl.rows; i++)
		{
			grdDtl.SetGridText(i, 0, "0");
		}
	}
	else if(chkAll.value == "T")
	{
		for(i = 1; i < grdDtl.rows; i++)
		{
			grdDtl.SetGridText(i, 0, "-1");
		}		
	}
}
//--------------------------------------------
function CheckOnlyDate()
{
	var l_from = dtTakeout_fr.value ;
	var l_to = dtTakeout_to.value ;
	if(l_from != l_to)
	{
		alert("Only search data on a day");
		dtTakeout_to.value = l_from ;
	}
}
//--------------------------------------------
</script>
<body style="margin:0; padding:0;">
<!----------------------------------------------------------------------------------------------------------------->
<gw:data id="dso_takeout_mat" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="acnt.sp_sel_vin_project_rtn"  > 
            <input bind="grdDtl" > 
                 <input bind="txtcompk" />
				 <input bind="dtTakeout_fr" />
				 <input bind="dtTakeout_to" />				 
				 <input bind="lstGroup" />
				 <input bind="txtItem" />
				 <input bind="txtSlipNo" />
             </input> 
            <output bind="grdDtl" /> 
        </dso> 
    </xml> 
</gw:data>

<!----------------------------------------------------------------------------------------------------------------->
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
	<tr style="height:0%">    
    	<td width="12%"></td>
    	<td width="10%"></td>
    	<td width="2%"></td>
    	<td width="10%"></td>
    	<td width="10%"></td>
    	<td width="20%"></td>
    	<td width="10%"></td>
   		<td width="13%"></td>
		<td width="5%"></td>
		<td width="2%"></td>
	    <td width="3%"></td>
   		<td width="3%"></td>
	</tr>   
    <tr style="height:5%">
		<td align="right">T/O Date&nbsp;</td>
		<td align="left"><gw:datebox id="dtTakeout_fr" lang="1" onchange="CheckOnlyDate()" /></td>
		<td>~</td>
		<td align="left"><gw:datebox id="dtTakeout_to" lang="1" onchange="CheckOnlyDate()" /></td>
		<td align="right">Group&nbsp;</td>
		<td align="left"><gw:list id="lstGroup" styles="width:100%" onchange="OnSearch()" /></td>
		<td align="right">Item&nbsp;</td>
		<td align="left"><gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch()" /></td>
		<td align="right">Check All&nbsp;</td>
		<td align="right"><gw:checkbox id="chkAll" value="F" onchange="OnCheckAll()" /></td>
		<td align="right"><gw:imgBtn id="idBtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
		<td align="right"><gw:imgBtn id="idBtnSelect" img="select" alt="Select" onclick="OnSelect()" /></td>
	</tr> 
    <tr style="height:5%">
		<td align="right">Slip No&nbsp;</td>
		<td align="left"><gw:textbox id="txtSlipNo" /></td>
	</tr> 	
	<tr style="height:90%">
		<td colspan="12">
            <gw:grid
                id      ="grdDtl"  
                header  ="|_tin_linemattakeoutd_pk|_tco_item_pk|Item code|Item name|Unit|Qty|Takeout date|Slip No|WH Name|Description|_tac_abacctcode_pk|Acc. Code|Acc. Name|_tin_warehouse_pk|_acct_expense|_tac_abplcenter_pk|PL CD|PL NM|_accd_expense|_acnm_expense"
                format  ="3|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0"
                aligns  ="1|0|0|1|0|1|3|1|0|0|0|0|0|0|0|0|0|0|0|0|0"
                defaults="||||||||||||||||||||"
                editcol ="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                widths  ="500|0|0|1000|2500|800|1200|1200|1200|1500|1500|0|1200|1500|0|0|0|1200|1500|0|0"
                styles  ="width:100%; height:100%"
				acceptNullDate='T'
                sorting ="F"                
            />
		</td>
	</tr>
</table>

<gw:textbox id="txtcompk"           style="display:none" />
<!---------------------------------------------------------------------------------------------------->
</body>
</html>