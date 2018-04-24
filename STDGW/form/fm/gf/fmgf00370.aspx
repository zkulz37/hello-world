<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Return Goods</title>
</head>

<script>

    var  user_pk = "<%=Session("USER_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;

        
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
}
//-----------------------------------------------------
function OnShowPopUp(iObj)
{
	switch(iObj)
	{
		case 'customer':
		var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes');
		if ( object != null )
		{
			if (object[0] != 0)
			{
				txtCustPK.text = object[0];
				txtCustNM.text = object[2];
				txtCustCD.text = object[1];
			}
		}		
		break;
		case 'item':
            var path = System.RootURL + "/form/fm/gf/PopUpGetOneItem.aspx?purchase_yn=&item_code=" + "&item_name=" ;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
            if(object != null)
            {
                txtItemPK.text = object[0] ;
                txtItemCD.text = object[1];
                txtItemNM.text = object[2];
            }                        		
		break;
	}
}
//-----------------------------------------------------
function OnSearch()
{
	fmgf00370.Call("SELECT");
}
//-----------------------------------------------------
function OnPrint()
{
	var url = System.RootURL + "/reports/fm/gf/fmgf00370.aspx?company_pk=" + lstCompany.value + "&from_dt=" + dtRtnFrom.value + "&to_dt=" + dtRtnTo.value ;
	System.OpenTargetPage(url);        	
}
//-----------------------------------------------------
function OnDataReceive()
{
	var i;
	var l_tot_qty = 0, l_tot_amt = 0;
	for(i = 1; i < idGrid.rows; i++)
	{
		l_tot_qty += Number(idGrid.GetGridData(i, 6));
		l_tot_amt += Number(idGrid.GetGridData(i, 7));
	}
	idGrid.AddRow();
	idGrid.SetGridText(idGrid.rows - 1, 1, 'Total');
	idGrid.SetGridText(idGrid.rows - 1, 6, l_tot_qty);
	idGrid.SetGridText(idGrid.rows - 1, 7, l_tot_amt);
	idGrid.SetCellBgColor(idGrid.rows-1, 0,idGrid.rows-1,idGrid.cols-1,0xA9EBD7);
}
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="fmgf00370" onreceive="OnDataReceive()"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00370" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany" />
                    <input bind="dtRtnFrom" />
                    <input bind="dtRtnTo" />
                    <input bind="txtCustPK" />
                    <input bind="txtItemPK" />                    
                    <input bind="lstDO_YN" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
	
    <!-------------------------------------------------------------------->	
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0"  >
    <tr style="height:10%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
                    <td style="width: 12%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 11%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 12%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 20%"></td>
                    <td style="width: 3%"></td>
                </tr>
				<tr>
					<td align="right">Company&nbsp;</td>
					<td align="left"><gw:list id="lstCompany" /></td>
					<td align="right">Returned Date&nbsp;</td>
					<td align="center"><gw:datebox id="dtRtnFrom" lang="1" styles="width:100%" /></td>
					<td align="center">~</td>
					<td align="center"><gw:datebox id="dtRtnTo" lang="1" styles="width:100%" /></td>
					<td align="right"><a title="Click here to select customer" href="#tips" onclick="OnShowPopUp('customer')">Customer&nbsp;</a></td>
					<td><gw:textbox id="txtCustCD" styles="width:100%" /></td>
					<td colspan="2" ><gw:textbox id="txtCustNM" styles="width:100%" /></td>
				</tr>
				<tr>
					<td align="right"><a title="Click here to select item" href="#tips" onclick="OnShowPopUp('item')" >Item Code&nbsp;</a></td>
					<td align="left"><gw:textbox id="txtItemCD" styles="width:100%" /></td>
					<td colspan="4" align="left"><gw:textbox id="txtItemNM" styles="width:100%" /></td>
					<td align="right">Domestic Y/N&nbsp;</td>
					<td align="center"><gw:list id="lstDO_YN" styles="width:100%" >
						<data>DATA|1|Domestic|2|Oversea|0|ALL</data>
						</gw:list>
					</td>
					<td align="right"><gw:imgBtn id="idbtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
					<td align="right"><gw:imgBtn id="idbtnExcel" img="excel" alt="Print" onclick="OnPrint()" /></td>
				</tr>
            </table>            
        </td>                     
    </tr>        
    <tr style="height:90%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                            header="No|Product Code|Pro. Name|Customer ID|Name|Returned Date|Q'ty|Trans Amt|Domestic"
                            format="0|0|0|0|0|4|0|0|0" 
                            aligns="1|1|2|1|2|1|3|3|1"
                            defaults="||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0" 
                            widths="600|1400|2000|1300|2500|1500|1500|1500|800"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="T" 
                            param="" />                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table> 
<gw:textbox id="txtCustPK" style="display:none;" />           
<gw:textbox id="txtItemPK" style="display:none;" />
</body>
</html>