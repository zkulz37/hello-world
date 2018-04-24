﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 <script>
 
 
var lb_select = false;
var lb_delete = false;

function BodyInit()
{
    SetFalseButton();
    BindingDataList();
    dso_upd_trans.StatusInsert();
    txtTrans_Alias.SetEnable(false);
    txtTrans_code.SetEnable(false);
    txtTrans_Alias.SetDataText(lsttrans_grp.GetData());
    OnSearch();
}

function SetFalseButton()
{
    btnDeleteD.SetEnable(false);
    btnUnDeleteD.SetEnable(false);
    btnDeleteC.SetEnable(false);
    btnUnDeleteC.SetEnable(false);
}
 
function BindingDataList()
{ 
    var ls_data1   = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_data2   = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0070','01','') FROM DUAL")%>";
    var ls_data3   = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0040','01','') FROM DUAL")%>";
    var ls_data4   = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0060','','') FROM DUAL")%>";
    lstCompany.SetDataText(ls_data1);
    lsttrangrp_search.SetDataText(ls_data2);
    lsttrans_grp.SetDataText(ls_data2);
    lstvoucher_evt.SetDataText(ls_data3);
    lstvoucher_type.SetDataText(ls_data4);
}

function OnSearch()
{
    dso_search_trans.Call("SELECT");
}

function AddNew()
{
    dso_upd_trans.StatusInsert();
    txtTrans_code.SetEnable(false);
    idGrid_D.ClearData();
    idGrid_C.ClearData();
    lb_select = false;
    lb_delete = false;
}

function Check_Exists()
{
    if (Number(txtExists.GetData()) > 0)
    {
        alert(' Transaction Code is exists. Please check again!!!'+'\n'+'Transaction Code đã tồn tại. Bạn hãy kiểm tra lại!!!')
        return false
    }
    return true
}

function OnSave()
{
    if (On_Check_Control() && Check_Dup_D() && Check_Dup_C() && OnCheck_NullD() && OnCheck_NullC())
    {
        if (rbauto_yn.GetData() == 'Y')
        {
            dso_upd_trans.Call("");
        }
        else
        {
            if (!lb_select)
            {
                dso_sel_exist.Call();
            }
            else
            {
                dso_upd_trans.Call("");
            }
        }
    }
}

function OnDelete()
{
    if (txt_PK.GetData() == "")
    {
	    alert('Please select Transaction Code to delete!!!'+'\n'+'Yêu cầu lựa chọn Transaction Code cần xóa!!!');
	    return;
	}
    else
    {
	    if (confirm('       Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa Transaction Code này?'))
	    {
		    dso_upd_trans.StatusDelete();
		    idGrid_D.ClearData();
            idGrid_C.ClearData();
            lb_delete = true;
		    dso_upd_trans.Call("");
		}
    }
}

function On_Check_Control()
{
    if (rbauto_yn.GetData()== 'N')
    {
        if (txtTrans_code.GetData() == '')
        {
            alert('    Transaction Code is not null!!!'+'\n'+'Transaction Code không được rỗng!!!');
            return false;
            
        }
    }
    if (txttrans_nm.GetData()== '')
    {
        alert('    Transaction Name is not null!!!'+'\n'+'Transaction Name không được rỗng!!!');
        return false;
    }
    return true;
}

function OnClick()
{
    if (idGrid.selrow == -1)
    {
        return;
    }
    if ((idGrid.rows > 1) && (idGrid.selrow < idGrid.rows))
	{
        var ctrl_idGrid = idGrid.GetGridControl();
        txt_PK.text = idGrid.GetGridData(idGrid.selrow, 0);
        lb_select = true;
        lb_delete = false;
        idGrid_D.ClearData();
        idGrid_C.ClearData();
        dso_upd_trans.Call("SELECT");
    }
}

function OnChange_Control()
{
    dso_upd_trans.StatusInsert();
    idGrid_D.ClearData();
    idGrid_C.ClearData();
    lsttrangrp_search.SetDataText(lsttrans_grp.GetData());
    txtTrans_Alias.SetDataText(lsttrans_grp.GetData());
    lb_select = false;
    OnSearch();
}

function OnChange_List()
{
    dso_upd_trans.StatusInsert();
    idGrid_D.ClearData();
    idGrid_C.ClearData();
    lsttrans_grp.SetDataText(lsttrangrp_search.GetData());
    txtTrans_Alias.SetDataText(lsttrangrp_search.GetData());
    lb_select = false;
    OnSearch();
}

function OnChange_Auto()
{
    if (rbauto_yn.GetData() == 'Y')
    {
        txtTrans_code.SetEnable(false);
    }
    else
    {
        txtTrans_code.SetEnable(true);
    }
}
 
function AddRow_D()
{
    /*if (txt_PK.GetData() == '')
    {
        alert('You must select Transaction Code first!!!', '\n'+'Bạn hãy chọn Transaction Code trước!!!')
        return;
    }
    else
    {*/
        idGrid_D.AddRow();
    //}
}

function AddRow_C()
{
    /*if (txt_PK.GetData() == '')
    {
        alert('You must select Transaction Code first!!!', '\n'+'Bạn hãy chọn Transaction Code trước!!!')
        return;
    }
    else
    {*/
        idGrid_C.AddRow();
    //}
}

function Check_Dup_D()
{
    var ctrl = idGrid_D.GetGridControl();
    var lb_exist;
    var i;
    
    i = 1;
    lb_exist = true;
    while ((i < ctrl.Rows -1) && (lb_exist))
    {
        j = i + 1;
        while ((j < ctrl.Rows) && (lb_exist))
        {
            var codei = idGrid_D.GetGridData(i, 2);
            var codej = idGrid_D.GetGridData(j, 2);
            if (codei == codej)
            {
                lb_exist = false;
                alert('Code row '+ j +' in debit is exists!!!'+'\n'+'Code hàng '+ j + ' ở bên nợ đã tồn tại!!!');
                return false;
            }
            j = j + 1;
        }
        i = i + 1;
    }
    return true;
}

function OnCheck_NullD()
{
    var codei;
    var ctrl = idGrid_D.GetGridControl();
    var lb_exist;
    var i;
    
    i = 1;
    lb_exist = true;
    while ((i < ctrl.Rows) && (lb_exist))
    {
        codei = idGrid_D.GetGridData(i, 2);
        if (codei == "")
        {
            lb_exist = false;
            alert('Code row '+ i +' in Debit is not null!'+'\n'+'Code hàng '+ i + ' không được rỗng!');
            return false;
        }
        i = i + 1;
    }
    return true;
}

function OnCheck_NullC()
{
    var codei;
    var ctrl = idGrid_C.GetGridControl();
    var lb_exist;
    var i;
    
    i = 1;
    lb_exist = true;
    while ((i < ctrl.Rows) && (lb_exist))
    {
        codei = idGrid_C.GetGridData(i, 2);
        if (codei == "")
        {
            lb_exist = false;
            alert('Code row '+ i +' in Credit is not null!'+'\n'+'Code hàng '+ i + ' không được rỗng!');
            return false;
        }
        i = i + 1;
    }
    return true;
}

function Check_Dup_C()
{
    var ctrl = idGrid_C.GetGridControl();
    var lb_exist;
    var i;
    
    i = 1;
    lb_exist = true;
    while ((i < ctrl.Rows -1) && (lb_exist))
    {
        j = i + 1;
        while ((j < ctrl.Rows) && (lb_exist))
        {
            var codei = idGrid_C.GetGridData(i, 2);
            var codej = idGrid_C.GetGridData(j, 2);
            if (codei == "")
            {
                lb_exist = false;
                alert('Code row '+ i +' is not null!'+'\n'+'Code hàng '+ i + ' không được rỗng!');
                return false;
            
            }
            if (codej == "")
            {
                lb_exist = false;
                alert('Code row '+ j +' is not null!'+'\n'+'Code hàng '+ j + ' không được rỗng!');
                return false;
            }
            if (codei == codej)
            {
                lb_exist = false;
                alert('Code row '+ j +' in credit is exists!!!'+'\n'+'Code hàng '+ j + ' ở bên có đã tồn tại!!!');
                return false;
            }
            j = j + 1;
        }
        i = i + 1;
    }
    return true;
}

function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
        case "dso_search_trans":
            if (lb_delete)
            {
                dso_upd_trans.StatusInsert();
                lb_delete = false;
                lb_select = false;
            }
        break;
        
        case "dso_sel_exist":
            if (Check_Exists())
            {
                dso_upd_trans.Call("");
            }
        break;
        
        case "dso_upd_trans":
            if (lb_delete)
            {
                dso_search_trans.Call("SELECT");
            }
            else
            {
                OnCheck_Debit();
                OnCheck_Credit();
                OnSave_Detail_Debit();
            }
        break;
        
        case "dso_upd_stardard_d":
            OnSave_Detail_Credit();
        break;
        
        case "dso_upd_stardard_c":
            SetFalseButton();
            if (!lb_select)
            {
                dso_search_trans.Call("SELECT");
            }
        break;
    }
}
 
function RowClick_D()
{
    if (idGrid_D.rows < 2)	
    {
        return;
    }
	else
	{
	    if ((event.col == 2) || (event.col == 3))
		{
		    if ( idGrid_D.GetGridData( idGrid_D.row, 1) == -1)
		    {
		        TabPopUp("ACNT.SP_SEL_POPUP_ACCOUNT_GROUP", txt_PK.GetData(), "D", "1");
		    }
			else
			{
			    TabPopUp("ACNT.SP_SEL_POPUP_ACCOUNT_CODE", txt_PK.GetData(), "D", "0");
			}
		}
    }
}

function RowClick_C()
{
    if (idGrid_C.rows < 2)	
    {
        return;
    }
	else
	{
	    if ((event.col == 2) || (event.col == 3))
		{
		    if (idGrid_C.GetGridData(idGrid_C.row, 1) == -1)
		    {
		        TabPopUp("ACNT.SP_SEL_POPUP_ACCOUNT_GROUP", txt_PK.GetData(), "C", "1");
		    }
			else
			{
			    TabPopUp("ACNT.SP_SEL_POPUP_ACCOUNT_CODE", txt_PK.GetData(), "C", "0");
			}
		}
    }
}

function TabPopUp(name, trans_grp, drcr_type, type)
{
    if (type == "0")
    {
        var fpath   = System.RootURL + "/form/ff/co/ffco002001.aspx?comm_code=" + "" + "&dsqlid=" + name + "&val1=" + trans_grp + "&val2=" + drcr_type;
	    aValue      = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');
	}
	else
	{
	    var fpath   = System.RootURL + "/form/ff/co/ffco002001.aspx?comm_code=" + "" + "&dsqlid=" + name + "&val1=" + trans_grp + "&val2=" + drcr_type +"&col_code=A/C Group Code" + "&col_nm=A/C Group Name";
	    aValue      = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');
	}
    if ( aValue != null )
	{
	    if (aValue.length > 0)
	    {
	        if (drcr_type == 'D')
	        {
	            idGrid_D.RemoveRowAt(idGrid_D.selrow);
                for(i=0; i<aValue.length; i++)
                {
                    var tmp = aValue[i];
                    if (tmp[0] != 0)
                    {
                        idGrid_D.AddRow();
                        idGrid_D.SetGridText(idGrid_D.rows - 1, 2, tmp[0]);
                        idGrid_D.SetGridText(idGrid_D.rows - 1, 3, tmp[1]);
                        idGrid_D.SetGridText(idGrid_D.rows - 1, 4, drcr_type);
                        idGrid_D.SetGridText(idGrid_D.rows - 1, 7, txt_PK.GetData());
                        if (type == "1")
                        {
                            idGrid_D.SetGridText(idGrid_D.rows - 1, 6, "");
                            idGrid_D.SetGridText(idGrid_D.rows - 1, 8, tmp[3]);
                            idGrid_D.SetGridText(idGrid_D.rows - 1, 1, -1);
                        }
                        else if (type == "0")
                        {
                            idGrid_D.SetGridText(idGrid_D.rows - 1, 6, tmp[3]);
                            idGrid_D.SetGridText(idGrid_D.rows - 1, 8, "");
                        }
                    }
                }
                if (idGrid_D.rows > 1)
                {
                    for (i = 1; i < idGrid_D.rows; i++)
                    {
                        idGrid_D.SetGridText(i, 5, i);
                    }
                }
            }
            else if (drcr_type == 'C')
            {
                idGrid_C.RemoveRowAt(idGrid_C.selrow);
                for(i=0; i<aValue.length; i++)
                {
                    var tmp = aValue[i];
                    if (tmp[0] != 0)
                    {
                        idGrid_C.AddRow();
                        idGrid_C.SetGridText(idGrid_C.rows - 1, 2, tmp[0]);
                        idGrid_C.SetGridText(idGrid_C.rows - 1, 3, tmp[1]);
                        idGrid_C.SetGridText(idGrid_C.rows - 1, 4, drcr_type);
                        idGrid_C.SetGridText(idGrid_C.rows - 1, 7, txt_PK.GetData());
                        if (type == "1")
                        {
                            idGrid_C.SetGridText(idGrid_C.rows - 1, 6, "");
                            idGrid_C.SetGridText(idGrid_C.rows - 1, 8, tmp[3]);
                            idGrid_C.SetGridText(idGrid_C.rows - 1, 1, -1);
                        }
                        else if (type == "0")
                        {
                            idGrid_C.SetGridText(idGrid_C.rows - 1, 6, tmp[3]);
                            idGrid_C.SetGridText(idGrid_C.rows - 1, 8, "");
                        }
                    }
                }
                if (idGrid_C.rows > 1)
                {
                    for (i = 1; i < idGrid_C.rows; i++)
                    {
                        idGrid_C.SetGridText(i, 5, i);
                    }
                }
            }
        }
    }
}

function OnCheckDebit()
{
    if( event.col == 1 )
    {
        idGrid_D.SetGridText(idGrid_D.selrow, 2, "");
        idGrid_D.SetGridText(idGrid_D.selrow, 3, "");
        idGrid_D.SetGridText(idGrid_D.selrow, 4, "");
        idGrid_D.SetGridText(idGrid_D.selrow, 5, "");
        idGrid_D.SetGridText(idGrid_D.selrow, 6, "");
        idGrid_D.SetGridText(idGrid_D.selrow, 7, "");
        idGrid_D.SetGridText(idGrid_D.selrow, 8, "");
    }
    if (idGrid_D.rows > 1)
    {
        btnDeleteD.SetEnable(true);
        btnUnDeleteD.SetEnable(true);
    }
    else
    {
        btnDeleteD.SetEnable(false);
        btnUnDeleteD.SetEnable(false);
    }
}

function OnCheckCredit()
{
    if( event.col == 1 )
    {
        idGrid_C.SetGridText(idGrid_C.selrow, 2, "");
        idGrid_C.SetGridText(idGrid_C.selrow, 3, "");
        idGrid_C.SetGridText(idGrid_C.selrow, 4, "");
        idGrid_C.SetGridText(idGrid_C.selrow, 5, "");
        idGrid_C.SetGridText(idGrid_C.selrow, 6, "");
        idGrid_C.SetGridText(idGrid_C.selrow, 7, "");
        idGrid_C.SetGridText(idGrid_C.selrow, 8, "");
    }
    if (idGrid_C.rows > 1)
    {
        btnDeleteC.SetEnable(true);
        btnUnDeleteC.SetEnable(true);
    }
    else
    {
        btnDeleteC.SetEnable(false);
        btnUnDeleteC.SetEnable(false);
    }
}

function OnCheck_Debit()
{
    if (idGrid_D.rows > 1)
    {
        for (i = 1; i < idGrid_D.rows; i++)
        {
            if (idGrid_D.GetGridData(i, 7) == "")
            {
                idGrid_D.SetGridText(i, 7, txt_PK.GetData());
            }
        }
    }
}

function OnCheck_Credit()
{
    if (idGrid_C.rows > 1)
    {
        for (i = 1; i < idGrid_C.rows; i++)
        {
            if (idGrid_C.GetGridData(i, 7) == "")
            {
                idGrid_C.SetGridText(i, 7, txt_PK.GetData());
            }
        }
    }
}

function OnSave_Detail_Debit()
{
    if (idGrid_D.rows > 1)
    {
        txt_drcr_type.SetDataText("D");
 	    dso_upd_stardard_d.Call("");
 	}
 	else
 	{
 	    txt_drcr_type.SetDataText("D");
 	    dso_upd_stardard_d.Call("SELECT");
 	}
}

function OnSave_Detail_Credit()
{
    if (idGrid_C.rows > 1)
    {
        txt_drcr_type.SetDataText("C");
 	    dso_upd_stardard_c.Call("");
 	}
 	else
 	{
 	    txt_drcr_type.SetDataText("C");
 	    dso_upd_stardard_c.Call("SELECT");
 	}
}

function Delete_D()
{
    var ctrl = idGrid_D.GetGridControl();
    if (idGrid_D.rows > 1)
    {
        for (i = 1; i < idGrid_D.rows; i++)
        {
            if (ctrl.isSelected(i) == true)
            {
                if(idGrid_D.GetGridData(i, 0) == "")
                {
		            idGrid_D.RemoveRowAt(i);
		            i = i - 1;
	            }
	            else
	            {
		            idGrid_D.DeleteRow();
	            }
	        }
        }
        txt_drcr_type.SetDataText("D");
    }
}

function Delete_C()
{
    var ctrl = idGrid_C.GetGridControl();
    if (idGrid_C.rows > 1)
    {
        for (i = 1; i < idGrid_C.rows; i++)
        {
            if (ctrl.isSelected(i) == true)
            {
                if(idGrid_C.GetGridData(i, 0) == "")
                {
		            idGrid_C.RemoveRowAt(i);
		            i = i - 1;
	            }
	            else
	            {
		            idGrid_C.DeleteRow();
	            }
	        }
        }
        txt_drcr_type.SetDataText("C");
    }
}

function UnDelete_D()
{
    var ctrl = idGrid_D.GetGridControl();
    if (idGrid_D.rows > 1)
    {
        for (i = 1; i < idGrid_D.rows; i++)
        {
            if (ctrl.isSelected(i) == true)
            {
                idGrid_D.UnDeleteRow();
            }
        }
    }
}

function UnDelete_C()
{
    var ctrl = idGrid_C.GetGridControl();
    if (idGrid_C.rows > 1)
    {
        for (i = 1; i < idGrid_C.rows; i++)
        {
            if (ctrl.isSelected(i) == true)
            {
                idGrid_C.UnDeleteRow();
            }
        }
    }
}

</script>
<body>

    <gw:data id="dso_search_trans" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso type="grid" function="ACNT.SP_SEL_ABTRTYPE" parameter="0,1,2,3"> 
                <input bind="idGrid" > 
                    <input bind="lstCompany" /> 
                    <input bind="lsttrangrp_search" /> 
                    <input bind="txttrcode_search" /> 
                    <input bind="txttrnm_search" /> 
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data> 

    <gw:data id="dso_upd_trans" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="acnt.SP_SEL_ABTRTYPE_ITEM" procedure = "acnt.SP_UDP_ABTRTYPE_ITEM">
            <inout> 
                <inout bind="txt_PK"/>
                <inout bind="lsttrans_grp"/>
                <inout bind="txtTrans_code"/>
                <inout bind="rbsys_yn"/>
                <inout bind="txttrans_nm"/>
                <inout bind="txttrans_nm_lc"/>
                <inout bind="txttrans_nm_kr"/>
                <inout bind="txtslip_desc"/>
                <inout bind="txtslip_desc_lc"/>
                <inout bind="lstvoucher_evt"/>
                <inout bind="lstvoucher_type"/>
                <inout bind="rbAct_YN"/>
                <inout bind="txt_UserID"/>
                <inout bind="rbauto_yn"/>
                <inout bind="lstCompany"/>
            </inout>
            </dso> 
        </xml> 
    </gw:data> 

    <gw:data id="dso_sel_exist" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_SEL_TRANSACTION_CODE_EXIST"> 
                <input> 
                     <input bind="lsttrans_grp"/>
                     <input bind="txtTrans_code"/>
                     <input bind="lstCompany"/>
                </input>  
                <output>  
                     <output bind="txtExists"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data> 
    
    <gw:data id="dso_upd_stardard_d" onreceive="OnDataReceive(this)" >
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8" function="acnt.SP_SEL_STANDARD_SLIP_ENTRY_D" procedure="acnt.SP_UDP_STANDARD_SLIP_ENTRY_D">
                <input bind="idGrid_D" >
                    <input bind="txt_PK"/>
                    <input bind="txt_drcr_type"/>
                </input>
                <output bind="idGrid_D" />
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_upd_stardard_c" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8" function="acnt.SP_SEL_STANDARD_SLIP_ENTRY_D" procedure="acnt.SP_UDP_STANDARD_SLIP_ENTRY_D">
                <input bind="idGrid_C" >
                    <input bind="txt_PK"/>
                    <input bind="txt_drcr_type"/>
                </input>
                <output bind="idGrid_C" />
            </dso>
        </xml>
    </gw:data>
    

<table  width="100%"  cellpadding="0" cellspacing="0" border="1">
<tr>
	<td width="30%" align="right">
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40%" align="right" ><font color="black" ><b>Company&nbsp;</b></font></td>
				<td width="60%">
					<gw:list id="lstCompany" onChange="OnChange_Control()" styles='width:100%'></gw:list >
				</td>
			</tr>
			<tr>
				<td width="40%" align="right" ><font color="black" ><b>Transaction Group&nbsp;</b></font></td>
				<td width="60%">
					<gw:list id="lsttrangrp_search" onChange="OnChange_List()" styles='width:100%'></gw:list >
				</td>
			</tr>
			<tr>
				<td width="40%" align="right" ><font color="black" ><b>Transaction Code&nbsp;</b></font></td>
				<td width="60%"><gw:textbox id="txttrcode_search" maxlen=50 onenterkey="OnChange_Control()" styles='width:100%;'/></td>
			</tr>
			<tr>
				<td width="40%" align="right" ><font color="black" ><b>Transaction Name&nbsp;</b></font></td>
				<td width="60%"><gw:textbox id="txttrnm_search" maxlen=50 onenterkey="OnChange_Control()" styles='width:100%;'/></td>
			</tr>
			<tr>
			    <td colspan="2">  
				    <gw:grid   
					    id="idGrid"  
					    header="_PK|Code|Transaction Name"   
					    format="0|0|0"  
					    aligns="0|0|0"  
					    defaults="||"  
					    editcol="0|0|0"  
					    widths="0|1500|0"  
					    styles="width:100%; height:400"   
					    sorting="T"   
					    param="0,1,2"  
					    oncellclick="OnClick()" />  
			    </td>
		    </tr>
		</table>		  		 
	</td>
	<td width="70%" align="right">
		<table width="100%" cellpadding="2" cellspacing="0">
		    <tr valign="top">
		        <td width="25%"></td>
		        <td width="25%"></td>
		        <td width="25%"></td>
		        <td width="25%">
		            <table id="RightTopTB" height="20" align="right" cellpadding="0" cellspacing="0">
			            <tr>
				            <td width="68%"><gw:textbox id="idInput_PK"  style="display:none"/></td>
				            <td width="8%"></td>					
				            <td width="8%"><gw:imgBtn img="new"    alt="New"    id="idBtnAdd" 		styles='width:100%' 	onclick="AddNew()" /></td>					
				            <td width="8%"><gw:imgBtn img="save"   alt="Save"   id="idBtnUpdate" 	styles='width:100%'     onclick="OnSave()" /></td>
				            <td width="8%"><gw:imgBtn img="delete" alt="Delete" id="idBtnDelete" 	styles='width:100%' 	onclick="OnDelete()" /></td>  
			            </tr>
		            </table>
		        </td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b>Transaction Group&nbsp;</b></font></td>
		        <td width="25%"><gw:list id="lsttrans_grp" styles='width:100%' onChange="OnChange_Control()"> </gw:list></td>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Sys YN&nbsp;</gw:label2></b></font></td>
		        <td width="25%"><gw:radio id="rbsys_yn" value="Y" ><span value="Y">Yes&nbsp;&nbsp;&nbsp;</span><span value="N" >No </span></gw:radio ></td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Transaction Code&nbsp;</gw:label2></b></font></td>
		        <td width="25%">
		            <table width="100%" cellpadding="0" cellspacing= "0">
		                <tr>
		                    <td width="25%"><gw:textbox id="txtTrans_Alias" maxlen=1 styles='width:100%' csstype="mandatory"/></td>
		                    <td width="75%"><gw:textbox id="txtTrans_code" maxlen=6 styles='width:100%' csstype="mandatory"/></td>
		                </tr>
		            </table>
		        </td>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Auto YN&nbsp;</gw:label2></b></font></td>
		        <td width="25%"><gw:radio id="rbauto_yn" value="Y" onChange="OnChange_Auto()" ><span value="Y">Yes&nbsp;&nbsp;&nbsp;</span><span value="N" >No </span></gw:radio ></td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Transaction Name&nbsp;</gw:label2></b></font></td>
		        <td width="25%" colspan= "3"><gw:textbox id="txttrans_nm" maxlen=100 styles='width:100%' csstype="mandatory"/></td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Transaction Name Local&nbsp;</gw:label2></b></font></td>
		        <td width="25%" colspan= "3"><gw:textbox id="txttrans_nm_lc" maxlen=100 styles='width:100%'/></td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Transaction Name Kor&nbsp;</gw:label2></b></font></td>
		        <td width="25%" colspan= "3"><gw:textbox id="txttrans_nm_kr" maxlen=100 styles='width:100%'/></td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Slip Description&nbsp;</gw:label2></b></font></td>
		        <td width="25%" colspan= "3"><gw:textbox id="txtslip_desc" maxlen=150 styles='width:100%'/></td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Slip Local Description&nbsp;</gw:label2></b></font></td>
		        <td width="25%" colspan= "3"><gw:textbox id="txtslip_desc_lc" maxlen=150 styles='width:100%'/></td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Voucher Event&nbsp;</gw:label2></b></font></td>
		        <td width="25%"><gw:list id="lstvoucher_evt" styles='width:100%'> </gw:list></td>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Voucher Type&nbsp;</gw:label2></b></font></td>
		        <td width="25%"><gw:list id="lstvoucher_type" styles='width:100%'> </gw:list></td>
		    </tr>
		    <tr>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>Active&nbsp;</gw:label2></b></font></td>
		        <td width="25%"><gw:radio id="rbAct_YN" value="Y" ><span value="Y" >Yes&nbsp;&nbsp;&nbsp;</span><span value="N">No</span></gw:radio></td>
		        <td width="25%" align="right"><font color="black" ><b><gw:label2>User ID&nbsp;</gw:label2></b></font></td>
		        <td width="25%"><gw:textbox id="txt_UserID" styles='width:100%'/></td>
		    </tr>
		    <tr>
		        <td width="25%"><font color="black"><b>&nbsp;&nbsp;<u>Debit</u></b></font></td>
		        <td width="25%">
		            <table id="Table1" height="20" align="right" cellpadding="0" cellspacing="0">
			            <tr>
				            <td width="68%"></td>
				            <td width="8%"><gw:imgBtn img="new"    alt="New"        id="btnAddD" 		styles='width:100%' 	onclick="AddRow_D()" /></td>					
				            <td width="8%"><gw:imgBtn img="delete" alt="Delete"     id="btnDeleteD" 	styles='width:100%' 	onclick="Delete_D()" /></td>
				            <td width="8%"><gw:imgBtn img="udelete"alt="UnDelete"   id="btnUnDeleteD"   styles='width:100%'     onclick="UnDelete_D()"/></td>
			            </tr>
		            </table>
		        </td>
		        <td width="25%"><font color="black"><b>&nbsp;&nbsp;<u>Credit</u></b></font></td>
		        <td width="25%">
		            <table id="Table2" height="20" align="right" cellpadding="0" cellspacing="0">
			            <tr>
				            <td width="68%"></td>
				            <td width="8%"><gw:imgBtn img="new"    alt="New"        id="btnAddC" 		styles='width:100%' 	onclick="AddRow_C()" /></td>					
				            <td width="8%"><gw:imgBtn img="delete" alt="Delete"     id="btnDeleteC" 	styles='width:100%' 	onclick="Delete_C()" /></td>  
				            <td width="8%"><gw:imgBtn img="udelete"alt="UnDelete"   id="btnUnDeleteC"    styles='width:100%'     onclick="UnDelete_C()"/></td>
			            </tr>
		            </table>
		        </td>
		    </tr>
		    
		    <tr>
		        <td width="25%" colspan="2">
					<table width="100%" border ="1" cellpadding="0" cellspacing="0">
		            <tr>
			            <td>				
							<gw:grid
								id="idGrid_D"  
								header  ="_PK|CodeGrp|AcGrpCode|AcGrpName|_DRCR_TYPE|_DRCR_ORD|_TAC_ABACCTCODE_PK|_TAC_ABTRTYPE_PK|_TAC_ABTRACGRP_PK"   
								format  ="0|3|0|0|0|0|0|0|0"  
								aligns  ="0|0|0|0|0|0|0|0|0"  
								defaults="||||||||"  
								editcol ="1|1|0|0|0|0|0|0|0"  
								widths  ="0|0|0|0|0|0|0|0|0"  
								styles  ="width:100%; height:200"   
								sorting ="T"   
								param   ="0,1,2,3,4,5,6,7,8"  
								oncelldblclick  ="RowClick_D()" 
								oncellclick     ="OnCheckDebit()"/>
						</td>
					</tr>
					</table>	
				</td>
		        <td width="25%" colspan="2">
		            <table width="100%" cellpadding="0" cellspacing="0" border ="1">
			        <tr>
				        <td>
							<gw:grid
								id="idGrid_C"  
								header  ="_PK|CodeGrp|AcGrpCode|AcGrpName|_DRCR_TYPE|_DRCR_ORD|_TAC_ABACCTCODE_PK|_TAC_ABTRTYPE_PK|_TAC_ABTRACGRP_PK"   
								format  ="0|3|0|0|0|0|0|0|0"  
								aligns  ="0|0|0|0|0|0|0|0|0"  
								defaults="||||||||"  
								editcol ="1|1|0|0|0|0|0|0|0"  
								widths  ="0|0|0|0|0|0|0|0|0"  
								styles  ="width:100%; height:200"   
								sorting ="T"   
								param   ="0,1,2,3,4,5,6,7,8"  
								oncelldblclick  ="RowClick_C()"
								oncellclick     ="OnCheckCredit()"/>
                        </td>
					</tr>
					</table>
                </td>
		    </tr>
		</table>
	</td>
</tr>
</table>

<gw:textbox id="txt_PK"             style="display:none"/> 
<gw:textbox id="txtExists"          style="display:none"/> 
<gw:textbox id="txt_drcr_type"      style="display:none"/> 

</body>
</html>
