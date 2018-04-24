﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
<%ESysLib.SetUser("acnt")%>

<script>

 
function BodyInit()
{
    System.Translate(document);
    <%=ESysLib.SetGridColumnComboFormat("grGrid", 1,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0250' AND A.USE_IF = 1")%>;
    <%=ESysLib.SetGridColumnComboFormat("grGrid",11,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACBG0030' AND A.USE_IF = 1")%>;
    <%=ESysLib.SetGridColumnComboFormat("grGrid",12,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0270' AND A.USE_IF = 1")%>;
    
    <%=ESysLib.SetGridColumnComboFormat("grGrid",14,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0240' AND A.USE_IF = 1 ORDER BY A.CODE_NM")%>;
    <%=ESysLib.SetGridColumnComboFormat("grGrid",15,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0020' AND A.USE_IF = 1 ")%>;
    
    BindingDataList();
    lstLevel.SetDataText("");
    
    onSearch();
}

function BindingDataList()
{ 
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_data2    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACBG0020','','') FROM DUAL")%>";
    var ls_data3    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0020','','') FROM DUAL")%>||";
    lstCompany.SetDataText(ls_data);
    lstFormtype.SetDataText(ls_data2);
    lstLevel.SetDataText(ls_data3);
    btGenAuto.style.display = 'none';
    txtac_nm.SetEnable(false);
    txt_lang.SetDataText('ENG');
    txtac_cd.GetControl().focus();
    
}

function OnClick_Auto()
{
    if (rbAUTO_YN.GetData() == 'Y')
    {
        btGenAuto.style.display = '';	
    }
    else
    {
        btGenAuto.style.display = 'none';	
    }
}

function CheckNumeric()
{
   var key = window.event.keyCode;
   if (key > 47 && key < 58)
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise
}

function onNew()
{
    grGrid.DeselectRow(grGrid.selrow);
	grGrid.AddRow();
	grGrid.SelectRow(grGrid.rows - 1);
	grGrid.SetGridText( grGrid.rows - 1 ,20, lstFormtype.GetData());
	grGrid.SetGridText( grGrid.rows - 1 ,21, lstCompany.GetData());
}

function onBatchEntry()
{
    if(confirm('Are you sure you want to batch entry ?'+'\n'+''))
	{
        lstLevel.SetDataText("");
        dso_sel_financeform_batch_entry.Call("SELECT");
    }
}

function ChangeColor()
{
    var ctrl = grGrid.GetGridControl();
    for (i = 1; i < ctrl.Rows; i++)
	{
	    if(grGrid.GetGridData(i,12)== "B")
        {
	        ctrl.Cell(14, i, 1, i, 20) = false;
	        grGrid.SetCellBold(i, 1, i, 20, true);
        }
        else if (grGrid.GetGridData(i,12)== "I")
        {
	        grGrid.SetCellBold(i, 1, i, 20, false);
	        ctrl.Cell(14, i, 1, i, 20) = true; // Chu nghieng
	    }
	    else
	    {
	        ctrl.Cell(14, i, 1, i, 20) = false;
	        grGrid.SetCellBold(i, 1, i, 20, false);
	    }
	    grGrid.SetCellBgColor(i, 0, i, 20, Number(grGrid.GetGridData(i, 14)));
	}
}

function onSearch()
{
    dso_sel_grd_financeform.Call("SELECT");
}

function OnChangeList()
{
    grGrid.ClearData();
    onSearch();
}

function UpClick()
{
	var lb_flag
    ctrl = grGrid.GetGridControl();
	rows = ctrl.Rows  - 1;
	if (rows > 1)
	{
	    i = 1;
	    lb_flag = false;
	    while ((i <= rows) && !lb_flag)
	    {
	        if (ctrl.isSelected (i) == true)
	        {
	            lb_flag = true;
	        }
	        else
	        {
	            i = i + 1;
            }
	    }
	}
	if (lb_flag)
	{
        grGrid.UpRow();
	}
	else
	{
		alert('  Please select one row to move!!!'+'\n'+'Bạn hãy chọn 1 dòng để di chuyển');
	}
}

function DownClick()
{
	var lb_flag
    ctrl = grGrid.GetGridControl();
	rows = ctrl.Rows  - 1;
	if (rows > 1)
	{
	    i = 1;
	    lb_flag = false;
	    while ((i <= rows) && !lb_flag)
	    {
	        if (ctrl.isSelected (i) == true)
	        {
	            lb_flag = true;
	        }
	        else
	        {
	            i = i + 1;
            }
	    }
	}
	if (lb_flag)
	{
        grGrid.DownRow();
	}
	else
	{
		alert('  Please select one row to move!!!'+'\n'+'Bạn hãy chọn 1 dòng để di chuyển');
	}
}

function onSave()
{
    if (CheckItemLength())
    {
        dso_sel_grd_financeform.Call();
    }
}

function OnChangeLevel()
{
	dso_sel_grd_financeform.Call("SELECT");
}

function Reset_Acc()
{
	txtac_cd.SetDataText('');
	txtac_nm.SetDataText('');
	txtac_pk.SetDataText('');
}

function Popup_Acc()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
    if (o != null)
	{
		if(o[0] != 0)
		{
		    txtac_cd.SetDataText(o[0]);
			txtac_nm.SetDataText(o[1]);
			txtac_pk.SetDataText(o[3]);
		}
    }
}

function RowClick()
{
    var ctrl = grGrid.GetGridControl();
    
    if (event.col ==6 && (grGrid.GetGridData(event.row, 1) == "01" || grGrid.GetGridData(event.row, 1) == "05" ))
	{
        if (grGrid.GetGridData(event.row, 1) == "01")
        {
            var fpath = System.RootURL + "/form/ff/co/ffco002001.aspx?comm_code=" + "" + "&dsqlid=ACNT.SP_SEL_POPUP_ACC_FS" + "&val1=" + lstFormtype.GetData() + "&val2=" + lstCompany.GetData();
        }
        else if (grGrid.GetGridData(event.row, 1) == "05")
        {
            var fpath = System.RootURL + "/form/ff/co/ffco002001.aspx?comm_code=" + "" + "&dsqlid=ACNT.SP_SEL_POPUP_PL_FS" + "&val2=" + lstCompany.GetData();
        }
        aValue    = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');
		if ( aValue != null )  
		{
			if (aValue.length > 0)
			{
			    var j = 0;
			    for(i=0; i<aValue.length; i++)
                {
                    var tmp = aValue[i];
                    if (tmp[0] != 0)
                    {
                        if (j > 0) 
                        {
                            grGrid.AddRow();
                            grGrid.SetGridText(grGrid.rows - 1, 1, '01');
                            grGrid.SetGridText(grGrid.rows - 1, 5, tmp[3]);
                            grGrid.SetGridText(grGrid.rows - 1, 6, tmp[0]);
                            grGrid.SetGridText(grGrid.rows - 1, 7, tmp[1]);
                            grGrid.SetGridText(grGrid.rows - 1, 8, tmp[6]);
                            grGrid.SetGridText(grGrid.rows - 1, 9, tmp[7]);
                            grGrid.SetGridText(grGrid.rows - 1, 3, tmp[0].substr(0, 3));
                            grGrid.SetGridText( grGrid.rows - 1, 20, lstFormtype.GetData());
	                        grGrid.SetGridText( grGrid.rows - 1, 21, lstCompany.GetData());
	                        j = j + 1;
                        }
                        else
                        {
                            grGrid.SetGridText(event.row, 1, '01');
                            grGrid.SetGridText(event.row, 5, tmp[3]);
                            grGrid.SetGridText(event.row, 6, tmp[0]);
                            grGrid.SetGridText(event.row, 7, tmp[1]);
                            grGrid.SetGridText(event.row, 8, tmp[6]);
                            grGrid.SetGridText(event.row, 9, tmp[7]);
                            grGrid.SetGridText(event.row, 3, tmp[0].substr(0, 3));
                            grGrid.SetGridText(event.row, 20, lstFormtype.GetData());
	                        grGrid.SetGridText(event.row, 21, lstCompany.GetData());
                            j = j + 1;
                        }
                        if (tmp[4] == 'D')
                        {
                            grGrid.SetGridText( event.row, 11, "L");
                        }
                        else
                        {
                            grGrid.SetGridText( event.row, 11, "R");
                        }
                    }
                }
			}
        }
    }
    else if(event.col == 7 || event.col == 8 || event.col == 9)
    {
        if (grGrid.GetGridData(event.row, 1) == "01")
        {
            grGrid.SetColEdit(7, 0);
		    grGrid.SetColEdit(8, 0);
            grGrid.SetColEdit(9, 0);
        }
        else
        {
            grGrid.SetColEdit(7, 1);
		    grGrid.SetColEdit(8, 1);
            grGrid.SetColEdit(9, 1);
        }
    }
   
   if((lstFormtype.value=="24" ) && (event.col ==16)&& (Trim(grGrid.GetGridData(event.row, 3))!=""))
   {
         var fpath = System.RootURL + "/form/gf/ka/gfka00010_cf.aspx?com_pk=" + lstCompany.GetData()+"&row_pk="+grGrid.GetGridData(event.row, 0)+"&cf_type="+lstFormtype.value;
         aValue    = System.OpenModal( fpath , 850 , 450 , 'resizable:yes;status:yes');
         if ( aValue != null )  
		{
		    
		}
   } 
   
   
   if((lstFormtype.value=="93" ) && (event.col ==16)&& (Trim(grGrid.GetGridData(event.row, 3))!=""))
   {
         var fpath = System.RootURL + "/form/gf/ka/gfka00010_cf.aspx?com_pk=" + lstCompany.GetData()+"&row_pk="+grGrid.GetGridData(event.row, 0)+"&cf_type="+lstFormtype.value;
         aValue    = System.OpenModal( fpath , 850 , 450 , 'resizable:yes;status:yes');
         if ( aValue != null )  
		{
		    
		}
   } 
   
   if((lstFormtype.value=="23" ) && (event.col ==18)&& (Trim(grGrid.GetGridData(event.row, 3))!=""))
   {
        
         var fpath = System.RootURL + "/form/gf/ka/gfka00010_cf.aspx?com_pk=" + lstCompany.GetData()+"&row_pk="+grGrid.GetGridData(event.row, 0)+"&cf_type="+lstFormtype.value;
         aValue    = System.OpenModal( fpath , 850 , 450 , 'resizable:yes;status:yes');
         if ( aValue != null )  
		{
		    
		}
   } 
   
   if((lstFormtype.value=="92" ) && (event.col ==18)&& (Trim(grGrid.GetGridData(event.row, 3))!=""))
   {
        
         var fpath = System.RootURL + "/form/gf/ka/gfka00010_cf.aspx?com_pk=" + lstCompany.GetData()+"&row_pk="+grGrid.GetGridData(event.row, 0)+"&cf_type="+lstFormtype.value;
         aValue    = System.OpenModal( fpath , 850 , 450 , 'resizable:yes;status:yes');
         if ( aValue != null )  
		{
		    
		}
   } 
   
}

function Trim(sString)
{
	while (sString.substring(0,1) == ' ')
	{
		sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' ')
	{
		sString = sString.substring(0,sString.length-1);
	}
	return sString;
}

function Gen_Auto()
{
    ctrl = grGrid.GetGridControl();
	rows = ctrl.Rows  - 1;
	if (rows > 0)
	{
	    for (i = 1; i <= rows; i++)
	    {
	        grGrid.SetGridText( i , 2, i*10);
	    }
	}
}

function onDelete() 
{	
	var ctrl 	= grGrid.GetGridControl();
	var rownum 	= Number(ctrl.Row);
	var rownums = Number(ctrl.Rows);
	
	if ((rownums > 1) && (rownum > 0))
	{
		if(confirm('Are you sure you want to delete?'+'\n'+'Bạn có chắc xóa những dòng này?'))
		{
			for(i=1; i<rownums; i++)
			{
				if (ctrl.isSelected(i) == true)
                {
				    grGrid.DeleteRow();
				}
			}
		}
	}
	else
	{
		alert('Please select row for delete!!!'+'\n'+'Bạn hãy chọn 1 dòng để xóa');
	}
}

function onReport()
{
    var  url= System.RootURL + "/reports/gf/ka/gfka00010_Trial_Balance.aspx?p_compk="+lstCompany.value+"&p_accd="+txtac_cd.text
        +"&p_level=" + lstLevel.value + "&p_formtype=" + lstFormtype.value + '&p_frm_type=' + escape(lstFormtype.GetText());
        System.OpenTargetPage( url, "_blank" );
}

function onPopup()
{
	var path = System.RootURL + '/form/gf/ka/gfka00010_popup.aspx?com_pk='+ lstCompany.GetData();
	var o = System.OpenModal( path , 800 , 300 , 'resizable:yes;status:yes');
	if ( o != null )
	{
		if(o[0] != 0)
		{
			//idcause.SetDataText(o[0]);
			//idData_Dso_TrApprCancell.Call("SELECT");
		}
	}
}

function CheckItemLength()
{
    var ctrl 	= grGrid.GetGridControl();
	var rownum 	= ctrl.Rows;
	for(i = 1; i < rownum; i++)
	{
	    if(grGrid.GetGridData(i, 1)== "01")
		{
			if (grGrid.GetGridData(i, 5) == "")
			{
				alert('Please enter Code at row ' + i + ' is empty ...'+'\n'+'    Code tại dòng '+ i + ' không được rỗng.');
				grGrid.SelectRow(i);
				return false;
			}
		}
	}
   	return true;
}

function onSetStatus()
{
    var ctrl 	= grGrid.GetGridControl();
	var rownum 	= ctrl.Rows;
    for (i = 1; i < rownum; i++)
    {
        grGrid.SetRowStatus(i, 0x20);
    }
    ChangeColor();
}

function onEnter()
{
    dso_pro_acc.Call();
}

</script>
<body style="margin:0; padding:0;">

    <gw:data id="dso_sel_grd_financeform" onreceive="ChangeColor()">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="acnt.SP_SEL_GRD_DTL_FINANCE_FORM" procedure="acnt.SP_UPD_GRD_DTL_FINANCE_FORM">
                <input bind="grGrid">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstLevel"/>
                    <input bind="lstFormtype"/>
                </input>
                <output bind="grGrid"/>
            </dso>
        </xml>
    </gw:data>


    <gw:data id="dso_sel_financeform_batch_entry" onreceive="onSetStatus()">
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRD_FINANCE_BATCH_ENTRY" >
                <input bind="grGrid">
                    <input bind="lstCompany"/>
                    <input bind="lstFormtype"/>
                </input>
                <output bind="grGrid"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_pro_acc" onreceive="onSearch()">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_SEL_ACCOUNT" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="txtac_cd"/>
                     <input bind="txt_lang"/>
                </input>
                <output>
                     <output bind="txtac_pk"/>
                     <output bind="txt_temp"/>
                     <output bind="txtac_nm"/>
               </output>
            </dso> 
        </xml> 
    </gw:data>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr>
    <td width="100%">
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
	        <td width="8%"></td>
	        <td width="12%"></td>
	        <td width="8%"></td>
	        <td width="15%"></td>
	        <td width="6%"></td>
	        <td width="12%"></td>
	        <td width="15%"></td>
	        <td width="5%"></td>
	        <td width="9%"></td>
	        <td width="10%"></td>
	    </tr>
	    <tr>
	        <td>Company</td>
            <td colspan="2"><gw:list id="lstCompany" onChange="OnChangeList()"  styles='width:100%'></gw:list></td>
            <td align="right">Account</td>
            <td colspan="5">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="40%"><gw:textbox id="txtac_cd" styles='width:100%' onenterkey="onEnter()" onkeypress="CheckNumeric()"/></td>
                    <td width="50%"><gw:textbox id="txtac_nm" styles='width:100%'/></td>
                    <td width="0%"><gw:textbox  id="txtac_pk" styles='display:none'/></td>
                    <td width="5%"><gw:imgBtn   img="popup"	id="idSearchTr" alt="Popup" onclick="Popup_Acc()"/></td> 
                    <td width="5%"><gw:imgBtn   img="reset"	id="idResetTr"  alt="Reset" onclick="Reset_Acc()"/></td>
                </tr>
                </table>
            </td>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td ><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"        onclick="onSearch()"/></td>
                    <td ><gw:imgBtn id="ibtnNew"    img="new"       alt="New"           onclick="onNew()"/></td>
				    <td ><gw:imgBtn id="ibtnSave"   img="save"      alt="Save"          onclick="onSave()"/></td>
				    <td ><gw:imgBtn id="ibtnDelete" img="delete"    alt="Delete"        onclick="onDelete()"/></td>
				    <td ><gw:imgBtn id="ibtnReport" img="printer"   alt="Print"         onclick="onReport()"/></td>
				    <td><gw:icon    id="btnSearch"  img="in" text="Batch Entry"  styles='width:100%' onclick="onBatchEntry()"/></td>
                </tr>
                </table>
            </td>
	    </tr>
	    </table>
	</td>
</tr>
<tr>
	<td width="100%">
	    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="12%">Sort Print Seq</td>
                    <td width="16%" align="center">
                        <table border ="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <gw:radio id="rbAUTO_YN" value="N" onclick="OnClick_Auto()">
                                    <span value="Y" >Auto</span>
                                    <span value="N" >Manual</span>
                                </gw:radio >
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td width="12%" align="right">Form Type</td>
                    <td width="34%"><gw:list id="lstFormtype" onChange="OnChangeList()" styles='width:100%'></gw:list></td>
                    <td width="6%" align="right">Level</td>
                    <td width="7%"><gw:list id="lstLevel" onChange="OnChangeLevel()" styles='width:100%'></gw:list></td>
                     <td width="2%"><gw:imgBtn id="ibtnPopup"  img="popup"     alt="Popup"         onclick="onPopup()"/></td>
                    
                    <td width="3%"><gw:imgBtn img="auto"        id="btGenAuto" 	    alt="Gen Auto" 	    onclick="Gen_Auto()"/></td>
                    <td width="3%"><gw:icon                     id="btnUp_Dr"       alt="Up"            onclick="UpClick()"><img src="../../../system/images/up.gif"/></gw:icon></td>
                    <td width="3%"><gw:icon                     id="btnDown_Dr"     alt="Down"          onclick="DownClick()"><img src="../../../system/images/down.gif"/></gw:icon></td> 
                </tr>
                </table>
            </td>
        </tr>
        <tr>
            <!--0_PK|1.Group|2.Print Seq|3.Code|4.Header|5_AcPK|6.Ac Code|7.Account Name|8.Local Account Name|9.Korean Account Name|10.Print|11.L/R|12.Font stype|13.Rem|14.Color|15.Level|16.Formular 1|17.Formular 2|18.Formular 3|19.Formular 4|20_FormType|21_Com_PK"-->
            <td>
                <gw:grid   
			        id="grGrid"  
			        header="_PK|Group|Print Seq|Code|Header|_AcPK|Ac Code|Account Name|Local Account Name|Korean Account Name|Print|L/R|Font stype|Rem|Color|Level|Formular 1|Formular 2|Formular 3|Formular 4|_FormType|_Com_PK"
			        format  ="0|0|0|0|0|0|0|0|0|0|3|0|0|3|0|0|0|0|0|0|0|0"
			        aligns  ="0|1|1|1|1|1|0|0|0|0|1|0|1|1|0|1|1|1|1|1|0|0"
			        defaults="|03|||||||||-1|L|R|-1|0XFFFFFF|1||||||"
			        editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0"
			        acceptNullDate="T"
			        widths  ="0|1200|900|600|700|0|800|2500|2500|2500|500|1000|1000|500|1500|1000|1650|1650|1650|1500|0|0"
			        styles  ="width:100%; height:435"
			        sorting ="T"
			        oncelldblclick  ="RowClick()"
			        OnSelChange     ="ChangeColor()"
		        /> 
            </td>
        </tr>
        </table>
	</td>
</tr>
</table>

<gw:textbox id="txt_temp" maxlen="100" styles='width:100%;display:none'/>
<gw:textbox id="txt_lang" maxlen="100" styles='width:100%;display:none'/>

</body>
</html>

