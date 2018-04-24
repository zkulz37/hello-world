<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Operation Expenses</title>
</head>

<script>

    var  user_pk = "<%=Session("USER_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
    txtAccountCode.SetEnable(false);
    txtAccountName.SetEnable(false);
    txtPLCode.SetEnable(false);
    txtPLName.SetEnable(false);
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
}
//------------------------------------------------------------------------
function OnPopUp(iObj)
{
    switch(iObj)
    {
    case 'Account':
            if(Trim(lstCompany.value)=='')
            {
                alert('Must select Company!!!');
                return ;
            }            
            var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
            if ((object != null) &&(object[0]!="0"))
        {
            txtTAC_ABACCTCODE_PK.SetDataText(object[3]);
            txtAccountCode.SetDataText(object[0]);
            txtAccountName.SetDataText(object[1]);
        }

    case 'PL':
        if(Trim(lstCompany.value)=='')
        {
            alert('Must select Company!!!');
            return ;
        }              
        var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_fmgf00050_2&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" +  + "&val1=" ;
        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
        if(object != null)
        {
            txttac_abplcenter_pk.text = object[2];
            txtPLCode.text = object[0];
            txtPLName.text = object[1];
        }
        break;
    }
}
//------------------------------------------------------------------------
function OnSearch()
{
     data_fmgf00420.Call("SELECT")            
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{
    if(obj.id == "data_fmgf00420")
    {
        OnFormatGrid();
        OnChangeColor();
        var i;
        var v_injection = 0, v_assembly = 0, v_packing = 0, v_total_exp = 0;
        for(i = 1; i < idGrid.rows; i++)
        {
            v_injection += Number(idGrid.GetGridData(i, 2));
            v_assembly += Number(idGrid.GetGridData(i, 3));
            v_packing += Number(idGrid.GetGridData(i, 4));
            v_total_exp += Number(idGrid.GetGridData(i, 5));
        }
        idGrid.AddRow();
        idGrid.SetGridText(idGrid.rows - 1, 0, 'Total');
        idGrid.SetGridText(idGrid.rows - 1, 2, v_injection);
        idGrid.SetGridText(idGrid.rows - 1, 3, v_assembly);
        idGrid.SetGridText(idGrid.rows - 1, 4, v_packing );
        idGrid.SetGridText(idGrid.rows - 1, 5, v_total_exp );
        idGrid.SetCellBgColor(idGrid.rows - 1, 0, idGrid.rows - 1, 15, 0xA9EBD7);
    }
}
//------------------------------------------------------------------------
function OnExcel()
{
/*    var url = System.RootURL + "/reports/fm/gf/fmgf00400.aspx?comp_pk=" + lstCompany.value + "&std_ym=" + dbMonthly.value + "&warehouse_pk=" + lstWH.value + "&acpk=" + txtTAC_ABACCTCODE_PK.GetData() + "&item_pk=" + txtTCO_ITEM_PK.GetData() + "&abplcenter_pk=" + txttac_abplcenter_pk.GetData();
    System.OpenTargetPage(url);                
*/
 alert('Not Yet, Waiting for design...');    
}
//-----------------------------------------------------
function OnReset(iObj)
{
    switch(iObj)
    {
        case 'Account':
            txtAccountCode.text = "" ;
            txtAccountName.text = "" ;
            txtTAC_ABACCTCODE_PK.text = "" ;
        break;
        case 'PL':         
            txtPLCode.text = '';
            txtPLName.text = '';
            txttac_abplcenter_pk.text = '' ;
        break ;            
    }
}
//-----------------------------------------------------
//function Upcase()
//{
//    var c = String.fromCharCode (event.keyCode);
//	var x = c.toUpperCase().charCodeAt(0);
//	event.keyCode = x;
//}
//-----------------------------------------------------
//-----------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------------
function OnFormatGrid()
{
    var fg = idGrid.GetGridControl();
    fg.ColFormat(2) = "###,###,###,###,###,###R";
    fg.ColFormat(3) = "###,###,###,###,###,###R";
    fg.ColFormat(4) = "###,###,###,###,###,###R";
    fg.ColFormat(5) = "###,###,###,###,###,###R";    
}
//-----------------------------------------------------
function OnChangeColor()
{
    var ctrl = idGrid.GetGridControl();
    for (i = 1; i < ctrl.Rows; i++)
	{
	    if(idGrid.GetGridData(i,13)== "B")
        {
	        ctrl.Cell(14, i, 1, i, 15) = false;
	        idGrid.SetCellBold(i, 0, i, 15, true);
        }
        else if (idGrid.GetGridData(i,13)== "I")
        {
	        idGrid.SetCellBold(i, 1, i, 15, false);
	        ctrl.Cell(14, i, 1, i, 15) = true; // Chu nghieng
	    }
	    else
	    {
	        ctrl.Cell(14, i, 1, i, 15) = false;
	        idGrid.SetCellBold(i, 1, i, 15, false);
	    }
	    idGrid.SetCellBgColor(i, 0, i, 15, Number(idGrid.GetGridData(i, 14)));
	}
}
//-----------------------------------------------------

</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="data_fmgf00420" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00420" > 
                <input bind="idGrid" >  
                    <input bind="txtKind"/>               
                    <input bind="lstStatus"/>
                    <input bind="lstCompany"/>
                    <input bind="dbMonthly"/>	
                    <input bind="dbMonthly_to"/>					                    
                    <input bind="txtTAC_ABACCTCODE_PK"/>                               
                    <input bind="txttac_abplcenter_pk"/>                                                           
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
                    <td style="width: 8%"></td>
                    <td style="width: 14%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 16%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 16%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 4%"></td>
                    <td style="width: 3%"></td>
                    <td style="width: 3%"></td>
                </tr>
				<tr>
                    <td align="right">Company</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>				
					<td align="right"><a title="Click here to select account" onclick="OnPopUp('Account')" href="#tips">Account</a></td>
					<td align="left" ><gw:textbox id="txtAccountCode" text="" styles="width:100%; " /></td>
					<td align="right" colspan="1" ><gw:textbox id="txtAccountName" text="" styles="width:100%; " /></td>
					<td><gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset('Account')" /></td>
                    <td align="right" ><a title="Click here to select PL" onclick="OnPopUp('PL')" href="#tips">PL</a></td>
                    <td align="left" ><gw:textbox id="txtPLCode" text="" styles="width:100%; " /></td>
                    <td align="left" ><gw:textbox id="txtPLName" text="" styles="width:100%; " /></td>
                    <td align="right">
						<gw:imgbtn img="reset" alt="Reset" id="btnReset2" onclick="OnReset('PL')" />
                    </td>                                                            					
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" /></td>
                    <td align="right"><gw:imgbtn img="printer" alt="Report by STItem" id="btnExcel" onclick="OnExcel()" /></td>
                    <td align="right"></td>					
				</tr>
				<tr>
                    <td align="right" >Status</td>
                    <td colspan="1" align="left" ><gw:list id="lstStatus" onchange="OnSearch()" >
                        <data>DATA|2|Confirmed|0|Approved</data>
                        </gw:list>
                    </td>				
                    <td align="right" >Month</td>
                    <td align="left"><gw:datebox id="dbMonthly" type="month" lang="1" /></td>                    
                    <td align="right"><gw:datebox id="dbMonthly_to" type="month" lang="1" /></td>
                    <td align="right"></td>
                    <td align="right" ></td>
                    <td align="left"></td>
                    <td align="left" ></td>                    
                    <td align="right"></td>                    					
					<td colspan="3" align="right" ></td>					
				</tr>
					<td colspan="10" align="right"></td>
					<td colspan="3" align="right"></td>
				<tr>
				</tr>
            </table>            
        </td>                     
    </tr>        
    <tr style="height:86%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                            header="Account Code|Account Name|Injection|Assembly|Packing|Total|_|_|_|_|_|_|_|_|_|_"
                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="2|2|3|3|3|3|0|0|0|0|0|0|0|0|0|0"
                            defaults="|||||||||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            widths="1300|4000|1500|1500|1500|1500|0|0|0|0|0|0|0|0|0|0"
                            styles="width:100%; height:100% "                             
                            sorting="F" 
                            />                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>            
<gw:textbox id="txtTAC_ABACCTCODE_PK" styles="display:none; " />
<gw:textbox id="txttac_abplcenter_pk" styles="display:none; " />
<gw:textbox id="txtReturn" styles="display:none; " />
<gw:textbox id="txtKind" text="17" styles="display:none; " />
</body>
</html>