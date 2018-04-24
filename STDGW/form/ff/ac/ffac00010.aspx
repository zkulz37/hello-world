<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 <script>
 
var Insert      = 'F';
var Modify      = 'F';
var Delelete    = 'F';

function BodyInit()
{
    txtAcc_nm.SetEnable(false);
    txtAcc_cd.SetEnable(false);
    
    BindingDataList();
    txt_PAC_CD.SetEnable(false);
    txt_PAC_NM.SetEnable(false);
    txt_BAL.SetEnable(false);
    txt_COM_AC_PK.SetEnable(false);
    txt_COM_AC_CD.SetEnable(false);
    txt_COM_AC_NM.SetEnable(false);
    <%=ESysLib.SetGridColumnComboFormat("idGrid_Item" , 7, "SELECT a.CODE, a.CODE || '  ' || a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='ACAB0030' AND a.TCO_ABCODEGRP_PK=b.PK ORDER BY a.CODE , a.CODE_NM")%>;

    Control_Item_Menu(1);
    /*dso_upd_acc_entry.StatusInsert();
    dso_sel_tree_account.Call("SELECT");*/
    OnSearch();
}

function BindingDataList()
{ 
    var ls_data     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0090','','') FROM DUAL")%>";
    var ls_data1    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0100','','') FROM DUAL")%>";
    var ls_data2    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','','') FROM DUAL")%>";
    var ls_data3    = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";

    lst_BUDGET_TYPE.SetDataText(ls_data);
    lst_ACC_TYPE.SetDataText(ls_data1);
    lst_PL_TYPE.SetDataText(ls_data2);
    lst_TCO_EOCOMPANY_PK.SetDataText(ls_data3);
    lstCompany.SetDataText(ls_data3);
}

function OnSearch()
{
    dso_upd_acc_entry.StatusInsert();
    idGrid_Item.ClearData();
    dt_STD_DT.SetDataText('');
    dt_END_DT.SetDataText('');
    chk_CUST_YN.SetDataText('');
    chk_CUST_REMYN.SetDataText('');
    chk_PL_YN.SetDataText('');
    chk_BUDGET_YN.SetDataText('');
    chk_BGCON_YN.SetDataText('');
    chk_Emp_YN.SetDataText('');
    chk_Bank_YN.SetDataText('');
    txt_COM_AC_CD.SetDataText('');
    txt_COM_AC_NM.SetDataText('');
    txt_COM_AC_PK.SetDataText('');
    txt_REMARK.SetDataText('');
    dt_STD_DT.SetDataText('');
    dt_END_DT.SetDataText('');
    txt_BAL.SetDataText('0');
    dso_sel_tree_account.Call("SELECT");
}

function OnTreeClick()
{
	var obj = event.srcElement.GetCurrentNode();
	txt_PK.SetDataText( obj.oid );
	txt_Parent_PK.SetDataText( obj.oid );
	Insert   = 'F';
	Modify   = 'F';
	Delelete = 'F';
	dso_upd_acc_entry.Call("SELECT");
}

function OnChange_rb_USE_YN()
{
    if(Number(txt_BAL.GetData()) > 0 && rb_USE_YN.GetData() == "N" )
	{
		rb_USE_YN.SetDataText("Y");
		alert('Ending Balance not equal zero');
	}	
	if(Number(txt_BAL.GetData()) < 0 && rb_USE_YN.GetData() == "N" )
	{
		rb_USE_YN.SetDataText("Y");
		alert('Ending Balance not equal zero');
	}
	if (rb_USE_YN.GetData() == "N")
	{
	    dt_END_DT.SetDataText(idUSE_DT.GetData());
	}
	else
	{
	    dt_END_DT.SetDataText('');
	}
}
 
function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
        case "dso_upd_acc_entry":
            if ((Insert   == 'T') || (Modify   == 'T'))
            {
                if (idGrid_Item.rows > 1)
                {
                    for (i = 1; i < idGrid_Item.rows; i++)
                    {
                        if (idGrid_Item.GetGridData(i, 1) == "")
                        {
                            idGrid_Item.SetGridText(i, 1, txt_PK.GetData());
                        }
                    }
                }

                dso_upd_acc_entry.StatusUpdate();
                dso_upd_abacctitem.Call("");
            }
            else if (Delelete == 'T')
            {
                dso_upd_acc_entry.StatusInsert();
                dso_sel_tree_account.Call("SELECT");
            }
            else
            {
                dso_upd_abacctitem.Call("SELECT");
            }
        break;
        
        case "dso_upd_abacctitem":
            if ((Insert   == 'T'))
            {
                Insert   == 'F'
                dso_upd_acc_entry.StatusUpdate();
                dso_sel_tree_account.Call("SELECT");
            }
        break;
        
        case "dso_pro_accdup":
            OnCheckDup();
        break;
        
        case "dso_sel_abacctitem":
            dso_upd_abacctitem.Call("SELECT");
        break;
        
        case "dso_pro_childacc":
            On_Check_Child();
        break;
        
        case "dso_pro_possum":
            On_Check_Summary();
        break;
    }
}


function OnAdd()
{
    if(txt_PAC_PK.GetData() == "")
    {
		alert('Please Select Upper Account Code!!!'+'\n'+' Yêu cầu nhập tài khoản cấp cha!!!');
	}
	else
	{
	    if (txt_AC_LEVEL_TMP.text == 5)
	    {
	        alert('Current Level is level 5 ...');
	    }
	    else
	    {
	        Insert   = 'T';
	        Modify   = 'F';
	        Delelete = 'F';
	        dso_sel_accparent.Call("SELECT");
	    }
    }
}

function OnCheck_Child()
{
	if(txt_LEAF_YN_TMP.GetData() == "N")
	{
		var level = txt_AC_LEVEL_TMP.GetData()
		if (txt_level.GetData() == '')
		{
		    txt_level.SetDataText(level);
		}
		if (level == '')
		{
		    level = txt_level.GetData();
		}
		level = Number(level) + 1;
		
		if (level < 6)
		{
			alert('Please Input Information...'+'\n'+'Mời bạn nhập thông tin...');
		    
		    var ls_PAC_CD = txt_ACCD.GetData();
		    var ls_PAC_NM = txt_ACNM.GetData();
		    var ls_PAC_PK = txt_PK.GetData();
		    
		    var ls_PAC_CD_tmp = txt_PAC_CD.GetData();
		    var ls_PAC_NM_tmp = txt_PAC_NM.GetData();
		    var ls_PAC_PK_tmp = txt_PAC_PK.GetData();
		    
		    dso_upd_acc_entry.StatusInsert();
			idGrid_Item.ClearData();
			
			if (txt_DRCR_TYPE_TMP.GetData() != '')
			{
			    txt_PAC_CD.SetDataText(ls_PAC_CD);
			    txt_PAC_NM.SetDataText(ls_PAC_NM);
			    txt_PAC_PK.SetDataText(ls_PAC_PK);
			}
			
			if (txt_PAC_CD.GetData() == '')
			{
			    txt_PAC_CD.SetDataText(ls_PAC_CD_tmp);
			    txt_PAC_NM.SetDataText(ls_PAC_NM_tmp);
			    txt_PAC_PK.SetDataText(ls_PAC_PK_tmp);
			}
			
			rb_AC_LEVEL.SetDataText(level);
			rb_DRCR_TYPE.SetDataText(txt_DRCR_TYPE_TMP.GetData()) ;
			rb_CARRY_YN.SetDataText(txt_CARRY_YN_TMP.GetData()) ;
			chk_CUST_YN.SetDataText(txt_CUST_YN_TMP.GetData());	
			chk_CUST_REMYN.SetDataText(txt_CUST_REMYN_TMP.GetData());
			chk_PL_YN.SetDataText(txt_PL_YN_TMP.GetData());
			lst_PL_TYPE.SetDataText(txt_PL_TYPE_TMP.GetData());

			chk_BUDGET_YN.SetDataText(txt_BUDGET_YN_TMP.GetData());
			lst_BUDGET_TYPE.SetDataText(txt_BUDGET_TYPE_TMP.GetData());
			chk_BGCON_YN.SetDataText(txt_BGCON_YN_TMP.GetData());
			lst_ACC_TYPE.SetDataText(txt_AC_TYPE_TMP.GetData()) ;
			txt_AC_GRP.SetDataText(txt_AC_GRP_TMP.GetData());
			
			var ls_data;
			
			if (txt_PL_YN_TMP.GetData() == 'N')
			{
			    ls_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','02','') FROM DUAL")%>";
			}
			else
			{
			    ls_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','01','') FROM DUAL")%>";
			}
			
			lst_PL_TYPE.SetDataText(ls_data);
			Set_PL_TYPE();
		}	
		else
		{
			alert('Please Select level less then or equal level 5'+'\n'+'     Yêu cầu chọn cấp độ!!!');
			return;
		}
	}	
	else
	{
	    alert('Can not add child count a (Posting/Summary) is Posting. Please Select Summary...'+'\n'+'');
	}
}

function Set_PL_TYPE()
{
	if(lst_PL_TYPE.GetData() != "AC")
	{
		txt_COM_AC_PK.SetDataText("");
		txt_COM_AC_CD.SetDataText("");
		txt_COM_AC_NM.SetDataText("");
		btn_ACCD.SetEnable(false);
		btn_Reset.SetEnable(false);
	}
	else
	{
	    btn_ACCD.SetEnable(true);
	    btn_Reset.SetEnable(true);
	}
}

function OnResetAc_CD()
{	
	txt_COM_AC_PK.SetDataText("");
	txt_COM_AC_CD.SetDataText("");
	txt_COM_AC_NM.SetDataText("");
}

function OnSave()
{
    dso_pro_accdup.Call();
}

function OnDelete()
{
    if (txt_PK.GetData() == "")
    {
	    alert('Please select account code to delete!!!'+'\n'+'Yêu cầu lựa chọn tài khoản cần xóa!!!');
	    return;
	}
    else
    {
	    if (confirm('  Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa tài khoản này?'))
	    {
		    dso_pro_childacc.Call();
		}
    }
}

function On_Check_Child()
{
    var ctrl 	= idGrid_Item.GetGridControl();
    
    if (ctrl.Rows > 1)
    {
        alert('You must delete Item frist then delete Account!!!' + '\n' + 'Bạn phải xóa Item trước, sau đó xóa tài khoản!!!')
        return;
    }
    
    if ( Number(txt_Child.GetData()) > 0 )
    {
        alert('You must delete child account then delete upper account!!!' + '\n' + 'Bạn phải xóa tài khoản con trước, sau đó xóa tài khoản cha!!!')
        return;
    }
    else
    {
        var ctrl 	= idGrid_Item.GetGridControl();
	    for (i=0; i<ctrl.Rows; i++)
		{
			idGrid_Item.SetRowStatus(i, 0x40);
		}
		dso_upd_acc_entry.StatusDelete();
		Insert   = 'F';
	    Modify   = 'F';
	    Delelete = 'T';
        dso_upd_acc_entry.Call("");
    }
}

function OnCheckDup()
{
    if (CheckData() && OnCheck_Upper_Child() && OnCheck_Item() && OnCheck_Item_Dup()) 
    {
       Modify   = 'T';
       dso_upd_acc_entry.Call("");
    }
}

function OnCheck_Item_Dup()
{
    var ctrl 	= idGrid_Item.GetGridControl();
	var rows 	= ctrl.Rows;
	
	for (i=1; i<ctrl.Rows - 1; i++)
	{
		for (j= i + 1; j<ctrl.Rows; j++)
		{
			var data1 = idGrid_Item.GetGridData(i, 2);
			var data2 = idGrid_Item.GetGridData(j, 2);
			if(Number(data1) == Number(data2))
			{
				alert(' Item in row '+ j + ' is exists!!! Please check again.'+'\n'+'Dữ liệu dòng '+ j + ' đã tồn tại. Yêu cầu kiễm tra lại.');
				return false;
			}
		}
	}
	return true;
}


function OnCheck_Item()
{
    var ctrl 	= idGrid_Item.GetGridControl();
	var rows 	= ctrl.Rows;
	
	for (i=1; i<ctrl.Rows; i++)
	{
		for (j=3; j< 7; j++)
		{
			var data = idGrid_Item.GetGridData(i, j);
			if(data.length < 1)
			{
				alert('    Item in row '+ i + ' col ' + (j-2) + ' is not null'+'\n'+'Dữ liệu dòng '+ i + ' cột ' + (j-2) + ' không được rỗng');
				return false;
			}
		}
	}
	return true;
}

function CheckData()
{
	if(txt_PAC_CD.GetData() == '')
	{
		alert('Please select upper account code ...'+'\n'+'Yêu cầu chọn chọn tài khoản ...');
		return false;
	}
	if(txt_PAC_NM.GetData() == '')
	{
		alert('Please select upper account code ...'+'\n'+'Yêu cầu chọn tài khoản cấp cha ...');
		return false;
	}
	if(txt_AC_GRP.GetData() == '')
	{
		//alert('Please input account group ...'+'\n'+'Yêu cầu nhập loại tài khoản ...');
		//return false;
	    txt_AC_GRP.SetDataText('VIE');
	}
	if(txt_ACCD.GetData() == '')
	{
		alert('Please input account code ...'+'\n'+'Yêu cầu nhập số hiệu tài khoản ...');
		return false;
	}
	if(rb_AC_LEVEL.GetData() == '')
	{
		alert('Please input level ...'+'\n'+'Yêu cầu nhập cấp tài khoản ...');
		return false;
	}
	if(txt_ACNM.GetData() == '')
	{
		alert('Please input account name ...'+'\n'+'Yêu cầu nhập tên tài khoản ...');
		return false;
	}
	if(txt_ACSNM.GetData() == '')
	{
		alert('Please input short account name ...'+'\n'+'Yêu cầu nhập tên rút gọn tài khoản ...');
		return false;
	}
	if(rb_DRCR_TYPE.GetData() == '')
	{
		alert('Please input debit and credit type ...'+'\n'+'Yêu cầu chọn loại tài khoản(Nợ/Có)');
		return false;
	}
	if (Insert == 'T')
	{
	    if (Number(txt_Duplicate.GetData()) > 0)
	    {
	        alert('Account code is exists!!! Please select Account code again'+'\n'+'Tài khoản này đã tồn tại!!! Yêu cầu chọn lại tài khoản.');
		    return false;
	    }
	}
	return true;
}

function CheckLength()
{
    var ctrl 	= idGrid_Item.GetGridControl();
	var rows 	= ctrl.Rows;
	for (i=1; i<ctrl.Rows; i++)
	{
		for (j=5; j< 7; j++)
		{
			var data = idGrid_Item.GetGridData(i, j);
			if(data.length > 30)
			{
				alert('Data too large for column'+'\n'+'   Dữ liệu quá lớn!!!');
				return false;
			}
		}
	}
	return true;
}

function OnAddItem()
{
    if (rb_LEAF_YN.GetData() == 'N')
    {
        alert('Account code have Summary. You must choose Posting and then Add New Item Code!!!'+'\n'+'             Tài khoản này là tài khoản cấp tổng. Bạn không được thêm Item!!!');
        return;
    }
    else if (rb_LEAF_YN.GetData() == 'Y')
    {
        idGrid_Item.AddRow();
	    var ctrl= idGrid_Item.GetGridControl();          
	    var row =  ctrl.Rows - 1;   
	    idGrid_Item.SetGridText(row, 1, txt_PK.GetData());
	    idGrid_Item.SetRowStatus(row, 0x20);
    }
    /*if(txt_PK.GetData() == "")
    {
		alert('Please Select Upper Account Code!!!'+'\n'+'Yêu cầu nhập tài khoản cha!!!');
	}
	else
	{*/
	    //dso_upd_acc_entry.StatusUpdate();
        
	//}
}

function CheckDelete()
{
	var ctrl 	= idGrid_Item.GetGridControl();
	var rownum 	= ctrl.Row;
	if(rownum > 0)
	{
		if(ctrl.Col == 9)
		{
			idGrid_Item.SetGridText(ctrl.Row, 8, idGrid_Item.GetGridData( ctrl.Row, 9));
		}
		if(idGrid_Item.GetRowStatus(ctrl.Row) >= 64)
		{
			btn_DeleteItem.SetEnable(false);
			//btn_UnDeleteItem.SetEnable(true);
		}
		else
		{
			btn_DeleteItem.SetEnable(true);
			//btn_UnDeleteItem.SetEnable(false);
		}
	}
}

function Popup()
{
    var ctrl = idGrid_Item.GetGridControl();
	if( event.col == 3 || event.col == 4 )
	{
		var path = System.RootURL + '/form/ff/co/ffco001000.aspx?comm_nm=' + '' + '&dsqlid=ACNT.SP_SEL_POPUP_ITEM' + '&col_code=' + 'Item Code'  + '&col_nm=' + 'Item Name Local';
		o = System.OpenModal( path ,500 , 500 ,  'resizable:yes;status:yes');
		if (o != null)
		{
			if(o[0] != 0)
			{
				idGrid_Item.SetGridText(ctrl.Row, 2, o[2]); // PK
				idGrid_Item.SetGridText(ctrl.Row, 3, o[0]); // Item Name
				idGrid_Item.SetGridText(ctrl.Row, 4, o[1]); // Item Name Local
			}
		}
	}
}

function Control_Item_Menu(p_check)
{
    if (p_check == 1)
    {
        btn_DeleteItem.SetEnable(false);
        //btn_UnDeleteItem.SetEnable(false);
    }
    else if (p_check == 2)
    {
        btn_DeleteItem.SetEnable(true);
        //btn_UnDeleteItem.SetEnable(true);
    }
}

function OnDeleteItem()
{
    var ctrl 	= idGrid_Item.GetGridControl();
	var rownum  = ctrl.Rows - 1;
	
	if (ctrl.Row < 0) 
	{
	    if (rownum > 0)
	    {
	        alert('Please select Item Code for delete.'+'\n'+'Yêu cầu lựa chọn Item để xóa');
	        return;
	    }
	}
	else
	{
	    if (confirm('Are you sure you want to delete Item?'+'\n'+'  Bạn có chắc muốn xóa Item này?'))
	    {
	        for (i=1; i < ctrl.Rows; i++ )
	        {
                if (ctrl.isSelected(i) == true)
                {
                    if(idGrid_Item.GetGridData(i, 0) == "")
	                {
			            idGrid_Item.RemoveRowAt(i);
			            i = i - 1;
		            }
		            else
		            {
			            if(idGrid_Item.GetGridData(i, 3) != "" )
				        {
					        idGrid_Item.DeleteRow();
			            }
		            }
		        }
            }
            //dso_upd_acc_entry.Call("SELECT");
        }
	}
}

function Ac_CodeEnter()
{
	txt_accd_tmp.SetDataText( txt_ACCD.GetData() );
	dso_sel_abacctitem.Call("SELECT");
}

function Popup_Search()
{
    var fpath = System.RootURL + "/form/ff/co/ffco002000.aspx?comm_code=" + "" + "&dsqlid=ACNT.SP_SEL_ACCT_SUM_PARENT";
	o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txt_PAC_PK.SetDataText(o[3]);
			txt_PAC_CD.SetDataText(o[0]);
			txt_PAC_NM.SetDataText(o[1]);
			txt_level.SetDataText(o[6]);
			txt_PK.SetDataText(o[3]);
		}
		else
		{
		    if(o[0].length == 6)
		    {
			    txt_PAC_PK.SetDataText(o[3]);
			    txt_PAC_CD.SetDataText(o[0]);
			    txt_PAC_NM.SetDataText(o[1]);
			    txt_level.SetDataText(o[6]);
			    
		    }
		}
	}
}

function Popup_Search_Child()
{
    var fpath = System.RootURL + "/form/ff/co/ffco002000.aspx?comm_code=" + "" + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
	o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txt_ACCD.SetDataText( o[0] );
			txt_ACNM.SetDataText( o[1] );
		}
	}
}

function Popup_Search_Main()
{
    var fpath = System.RootURL + "/form/ff/co/ffco002000.aspx?comm_code=" + "" + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
	o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txt_COM_AC_PK.SetDataText( o[2] );
			txt_COM_AC_CD.SetDataText( o[0] );
			txt_COM_AC_NM.SetDataText( o[1] );
		}
	}
}

function Reset_Upper_Main()
{
    txt_COM_AC_PK.SetDataText('');
	txt_COM_AC_CD.SetDataText('');
	txt_COM_AC_NM.SetDataText('');
}

function Reset_Upper()
{
    txt_PAC_PK.SetDataText('');
	txt_PAC_CD.SetDataText('');
	txt_PAC_NM.SetDataText('');
}

function Reset_Upper_Acc()
{
    txt_ACCD.SetDataText('');
    txt_ACNM.SetDataText('');
}

function OnCheck_Upper_Child()
{
    var ls_upper_accd;
    var ls_child_accd;
    ls_upper_accd = txt_PAC_CD.GetData();
    ls_child_accd = txt_ACCD.GetData();

    ls_upper_accd = ls_upper_accd.substr(0,3);
    ls_child_accd = ls_child_accd.substr(0,3);
    
    var level_upper = txt_level.GetData();
    var level_child = rb_AC_LEVEL.GetData();
    
    if (Number(level_child) <= Number(level_upper))
    {
        alert('Level Child Account is not less than Upper Account. Please Choose Again!!!'+'\n'+'    Cấp độ của tài khoản cấp con không được nhỏ hơn cấp cấp cha!!!');
        return false;
    }
    else
    {
        if ((Number(rb_AC_LEVEL.GetData()) == 1) || (Number(rb_AC_LEVEL.GetData()) == 2))
        {
            return true;
        }
        if (Number(ls_upper_accd) != Number(ls_child_accd))
        {
	        alert('Child Account different to Upper Account. Please Choose Again!!!'+'\n'+'     Tài khoản cấp cha và cấp con không tương thích!!!');
	        return false;
        }
    }
	return true;
}

function CheckKey() 
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}

function OnChange_Rem()
{
	if(chk_CUST_YN.GetData() == "N")
	{
		chk_CUST_REMYN.SetDataText("N");
	}
}

function OnChange_PL()
{
    if (chk_PL_YN.GetData() == 'N')
    {
        ls_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','02','') FROM DUAL")%>";
    }
    else
    {
        ls_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','01','') FROM DUAL")%>";
    }
    lst_PL_TYPE.SetDataText(ls_data);
	Set_PL_TYPE();
}

/*-------------------------------------------------Acc_Inquiry----------------------------------------------------*/
function Popup_Search_Inquiry()
{
    var fpath = System.RootURL + "/form/ff/co/ffco002000.aspx?comm_code=" + "" + "&dsqlid=ACNT.SP_SEL_ACCT_SUM_PARENT";
	o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txtAcc_pk.SetDataText(o[3]);
		    txtAcc_nm.SetDataText(o[1]);
		    txtAcc_cd.SetDataText(o[0]);
		}
		else
		{
		    if(o[0].length == 6)
		    {
			    txtAcc_pk.SetDataText(o[3]);
			    txtAcc_nm.SetDataText(o[1]);
			    txtAcc_cd.SetDataText(o[0]);
		    }
		}
	}
}

function Reset_Acc_Inquiry()
{
    txtAcc_pk.SetDataText('');
    txtAcc_nm.SetDataText('');
    txtAcc_cd.SetDataText('');
}

function OnSearchInquiry()
{
    dso_upd_acc_code_inquiry.Call('SELECT');
}

function On_Change_Color()
{
    var ctrl 	= idGrid.GetGridControl();
	for (i=1; i<ctrl.Rows; i++)
    {
        if((idGrid.GetGridData(i,9)== "0") || (idGrid.GetGridData(i,9)== "1") || (idGrid.GetGridData(i,9)== "2"))
        {
            idGrid.SetCellBold(i,1,i,17,true);
        }
        else
        {   
            idGrid.SetCellBold(i,1,i,17,false);
        }
        
        if (idGrid.GetGridData(i,9)== "1")
        {
            idGrid.SetCellBgColor(i,0,i,17, Number('0X99CCFF'));
        }
        else if (idGrid.GetGridData(i,9)== "2")
        {
            idGrid.SetCellBgColor(i,0,i,17, Number('0XCCFFCC'));
        }
        else if (idGrid.GetGridData(i,9)== "3")
        {
            idGrid.SetCellBgColor(i,0,i,17, Number('0XEFFFFF'));
        }
        else if (idGrid.GetGridData(i,9)== "0")
        {
            idGrid.SetCellBgColor(i,0,i,17, Number('0XF4E6E0'));
        }
    }
}

function checkValue()
{
    var i = idTab.GetCurrentPageNo();
    switch(i)
    {
        case 0:
            txtAcc_nm.SetDataText('');
            txtAcc_cd.SetDataText('');
            idGrid.ClearData();
        break;
        
        case 1:
            dso_upd_acc_entry.StatusInsert();
            idGrid_Item.ClearData();
            dt_STD_DT.SetDataText('');
            dt_END_DT.SetDataText('');
            chk_CUST_YN.SetDataText('');
            chk_CUST_REMYN.SetDataText('');
            chk_PL_YN.SetDataText('');
            chk_BUDGET_YN.SetDataText('');
            chk_BGCON_YN.SetDataText('');
            chk_Emp_YN.SetDataText('');
            chk_Bank_YN.SetDataText('');
            txt_COM_AC_CD.SetDataText('');
            txt_COM_AC_NM.SetDataText('');
            txt_COM_AC_PK.SetDataText('');
            txt_REMARK.SetDataText('');
            dt_STD_DT.SetDataText('');
            dt_END_DT.SetDataText('');
            txt_BAL.SetDataText('0');
            idGrid_Item.ClearData();
        break;
    }
}

function OnRefressInquiry()
{
    idGrid.ClearData();
}

function OnNewInquiry()
{
    idGrid.AddRow();
}

function OnCheckInquiry()
{
    var ctrl 	= idGrid.GetGridControl();
	var i;
	var j;
	var flag;
	var codei;
	
	i = 1;
	flag = true;
	while ((i < ctrl.Rows) && flag)
    {
        codei = idGrid.GetGridData(i, 1);
        if (codei == '')
        {
            alert('   Upper Account Code in row '+ i +' is not null. Please check again!!!'+'\n'+'Tài khoản cấp cha ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        flag = false;
	        return;
        }
        codei = idGrid.GetGridData(i, 2);
        if (codei == '')
        {
            alert('   Account Code in row '+ i +' is not null. Please check again!!!'+'\n'+'Account Code ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        flag = false;
	        return;
        }
        codei = idGrid.GetGridData(i, 3);
        if (codei == '')
        {
            alert('     Account name in row '+ i +' is not null. Please check again!!!'+'\n'+'Account name ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        flag = false;
	        return;
        }
        codei = idGrid.GetGridData(i, 6);
        if (codei == '')
        {
            alert('     Balance Type(Dr/CR) in row '+ i +' is not null. Please check again!!!'+'\n'+'Loại tài khoản (Nợ/Có) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        flag = false;
	        return;
        }
        codei = idGrid.GetGridData(i, 7);
        if (codei == '')
        {
            alert('      Posting/Summary in row '+ i +' is not null. Please check again!!!'+'\n'+'Cấp độ(nút lá/gốc) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        flag = false;
	        return;
        }
        codei = idGrid.GetGridData(i, 8);
        if (codei == '')
        {
            alert('                   Report Type(Profit & Loss) in row '+ i +' is not null. Please check again!!!'+'\n'+'Loại tài khoản dùng cho báo cáo(Balance/Profit & Loss) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        flag = false;
	        return;
        }
        codei = idGrid.GetGridData(i, 9);
        if (codei == '')
        {
            alert('      Level in row '+ i +' is not null. Please check again!!!'+'\n'+'Cấp tài khoản ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        flag = false;
	        return;
        }
        i = i + 1;
    }
    
	flag = true;
	i = 1;
	if (ctrl.Rows > 2)
	{
	    while ((i < ctrl.Rows - 1) && flag)
	    {
	        j = i + 1;
	        var codej;
	        codei = idGrid.GetGridData(i, 2);
	        while ((j < ctrl.Rows) && flag)
	        {
	            codej = idGrid.GetGridData(j, 2);
	            if (codei == codej)
	            {
	                alert('  Account Code in row '+ j +' exists. Please check again!!!'+'\n'+'Account Code ở dòng '+ j +' đã tồn tại. Bạn hãy kiểm tra lại!!!')
	                flag = false;
	            }
	            j = j + 1;
	        }
	        i = i + 1;
        }
    }
	if (!flag)
	{
	    return false;
	}
	else
	{
	    return true;
	}
}

function OnSaveInquiry()
{
    var ctrl 	= idGrid.GetGridControl();
    if (!OnCheckInquiry())
    {
        return;
    }
    for (i=1; i < ctrl.Rows; i++ )
	{
	    if (idGrid.GetGridData(i, 17) == '')
	    {
	        idGrid.SetGridText(i, 17, lstCompany.GetData());
	    }
	}
	dso_upd_acc_code_inquiry.Call("");
}

function OnDelInquiry()
{
    var ctrl 	= idGrid.GetGridControl();
	var rownum  = ctrl.Rows - 1;
	
	if (ctrl.Row < 0) 
	{
	    if (rownum > 0)
	    {
	        alert('Please select Account Code for delete.'+'\n'+'Yêu cầu lựa chọn tài khoản để xóa');
	        return;
	    }
	}
	else
	{
	    if (confirm('Are you sure you want to delete Account?'+'\n'+'  Bạn có chắc muốn xóa tài khoản này?'))
	    {
	        for (i=1; i < ctrl.Rows; i++ )
	        {
                if (ctrl.isSelected(i) == true)
                {
                    if(idGrid.GetGridData(i, 0) == "")
	                {
			            idGrid.RemoveRowAt(i);
			            i = i - 1;
		            }
		            else
		            {
			            if(idGrid.GetGridData(i, 3) != "" )
				        {
					        idGrid.DeleteRow();
			            }
		            }
		        }
            }
        }
	}
}


function OnChangPosSum()
{
    if (rb_LEAF_YN.GetData() == 'N')
    {
        if (idGrid_Item.rows > 1)
        {
            alert('           You must del all Item code first then change Posting to Summary!!!'+'\n'+'Bạn hãy xóa hết các Item Code trước sau đó chuyển từ Posting sang Summary!!!');
            rb_LEAF_YN.SetDataText('Y');
            return;
        }
    }
    else if(rb_LEAF_YN.GetData() == 'Y')
    {
        dso_pro_possum.Call('');
    }
}

function On_Check_Summary()
{
    if (Number(txt_possum.GetData()) > 0)
    {
        alert('               You must delete all child account then change Posting!!!' + '\n' + 'Bạn phải xóa hết tất cả tài khoản con trước, sau đó bạn mới thay đổi được Posting!!!')
        rb_LEAF_YN.SetDataText('N');
        return;
    }
}

</script>
<body>
     <gw:data id="dso_upd_abacctitem" onreceive="OnDataReceive(this)" >
        <xml>
            <dso type="grid" parameter="0,1,2,5,6,7,8,9" function="acnt.SP_SEL_ABACCTITEM" procedure = "acnt.SP_UDP_ABACCTITEM">
                <input bind="idGrid_Item" >
                    <input bind="txt_PK"/>
                </input>
                <output bind="idGrid_Item" />
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_abacctitem" onreceive="OnDataReceive(this)" >
        <xml>
            <dso type="control" parameter="0" function="acnt.SP_SEL_ACC_ENTRY_ACCD">
                <inout> 
                    <inout bind="txt_accd_tmp"/>
                    <inout bind="txt_PAC_CD" />
                    <inout bind="txt_PAC_NM" />
                    <inout bind="txt_ACCD" />
                    <inout bind="txt_ACNM" />
                    <inout bind="txt_ACSNM" />
                    <inout bind="txt_ACLNM" />
                    <inout bind="txt_ACKNM" />
                    <inout bind="rb_DRCR_TYPE" />
                    <inout bind="rb_LEAF_YN" />
                    <inout bind="rb_CARRY_YN" />
                    <inout bind="chk_CUST_YN" />
                    <inout bind="chk_CUST_REMYN" />
                    <inout bind="chk_PL_YN" />
                    <inout bind="lst_PL_TYPE" />
                    <inout bind="chk_BUDGET_YN" />
                    <inout bind="lst_BUDGET_TYPE" />
                    <inout bind="lst_ACC_TYPE" />
                    <inout bind="chk_BGCON_YN" />         
                    <inout bind="rb_AC_LEVEL" />
                    <inout bind="txt_REMARK" />
                    <inout bind="txt_BAL" />
                    <inout bind="dt_STD_DT" />
                    <inout bind="dt_END_DT" />
                    <inout bind="rb_USE_YN" />
                    <inout bind="txt_AC_GRP" />
                    <inout bind="txt_PAC_PK" />
                    <inout bind="txt_PK" />
                    <inout bind="chk_Emp_YN" />
                    <inout bind="chk_Bank_YN" />
                </inout>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_tree_account">
        <xml>
            <dso type="tree" parameter="0,1" function="acnt.SP_SEL_ACC_TREE">
                <input bind="oTreeAcCODE" >
                    <input bind="lst_TCO_EOCOMPANY_PK"/>
                    <input bind="idUSE_DT"/>
                </input>
                <output bind="oTreeAcCODE" />
            </dso>
        </xml>
    </gw:data>
    
    
 <gw:data id="dso_upd_acc_entry" onreceive="OnDataReceive(this)" onerror="">
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31" function="acnt.SP_SEL_ACC_ENTRY" procedure = "acnt.SP_UDP_ACC_CODE_ENTRY">
              <inout> 
                <inout bind="txt_PK"/>
                <inout bind="txt_PAC_CD" />
                <inout bind="txt_PAC_NM" />
                <inout bind="txt_ACCD" />
                <inout bind="txt_ACNM" />
                <inout bind="txt_ACSNM" />
                <inout bind="txt_ACLNM" />
                <inout bind="txt_ACKNM" />
                <inout bind="rb_DRCR_TYPE" />
                <inout bind="rb_LEAF_YN" />
                <inout bind="rb_CARRY_YN" />
                <inout bind="chk_CUST_YN" />
                <inout bind="chk_CUST_REMYN" />
                <inout bind="chk_PL_YN" />
                <inout bind="lst_PL_TYPE" />
                <inout bind="chk_BUDGET_YN" />
                <inout bind="lst_BUDGET_TYPE" />
                <inout bind="lst_ACC_TYPE" />
                <inout bind="chk_BGCON_YN" />         
                <inout bind="rb_AC_LEVEL" />
                <inout bind="txt_REMARK" />
                <inout bind="txt_BAL" />
                <inout bind="dt_STD_DT" />
                <inout bind="dt_END_DT" />
                <inout bind="rb_USE_YN" />
                <inout bind="txt_AC_GRP" />
                <inout bind="txt_PAC_PK" />
                <inout bind="txt_level" />
                <inout bind="lst_TCO_EOCOMPANY_PK" />
                <inout bind="chk_Emp_YN" />
                <inout bind="chk_Bank_YN" />
              </inout>
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dso_sel_accparent" onreceive="OnCheck_Child()" onerror=""> 
        <xml> 
            <dso type="control" parameter="0" function="acnt.SP_SEL_ACC_ENTRY_PARENT"> 
            <inout> 
                <inout bind="txt_PK"/>
                <inout bind="txt_AC_LEVEL_TMP" />
                <inout bind="txt_LEAF_YN_TMP" />
                <inout bind="txt_DRCR_TYPE_TMP" />
                <inout bind="txt_CARRY_YN_TMP" />
                <inout bind="txt_CUST_YN_TMP" />
                <inout bind="txt_CUST_REMYN_TMP" />
                <inout bind="txt_PL_YN_TMP" />
                <inout bind="txt_PL_TYPE_TMP" />
                <inout bind="txt_BUDGET_YN_TMP" />
                <inout bind="txt_BUDGET_TYPE_TMP" />
                <inout bind="txt_BGCON_YN_TMP" />
                <inout bind="txt_AC_TYPE_TMP" />
                <inout bind="txt_AC_GRP_TMP" />
            </inout>
            </dso> 
        </xml> 
    </gw:data> 
    
    
    <gw:data id="dso_pro_accdup" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ACC_DUPLICATE" > 
                <input> 
                     <input bind="lst_TCO_EOCOMPANY_PK"/>
                     <input bind="txt_ACCD"/>
                </input>  
                <output>  
                     <output bind="txt_Duplicate"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data> 
    
    <gw:data id="dso_pro_childacc" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ACC_CHECK_CHILD" > 
                <input> 
                     <input bind="lst_TCO_EOCOMPANY_PK"/>
                     <input bind="txt_PK"/>
                </input>  
                <output>  
                     <output bind="txt_Child"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dso_pro_possum" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ACC_CHECKSUMPOS" > 
                <input> 
                     <input bind="lst_TCO_EOCOMPANY_PK"/>
                     <input bind="txt_ACCD"/>
                </input>  
                <output>  
                     <output bind="txt_possum"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
 <!---------------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_upd_acc_code_inquiry" onreceive="On_Change_Color()">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,17" function="acnt.SP_SEL_ACC_INQUIRY" procedure = "acnt.SP_UPD_ACCOUNT_ENTRY_INQUIRY">
                <input bind="idGrid" >
                    <input bind="lstCompany"/>
                    <input bind="txtAcc_cd"/>
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>
 <!---------------------------------------------------------------------------------------------------------------->
<gw:tab id="idTab" onclick ="return checkValue(this)">

    <form name="Account Code Entry" id="Acc_Entry" type="hidden">

        <table width="100%" cellpadding="0" cellspacing="0" border="1">
        <tr>
		    <td width="25%">
			    <table id="LeftTopTB" cellpadding="0" cellspacing="0" height="20">
				    <tr>
				        <td width="20%" align="center"><font color="black" ><b>Company&nbsp;</b></font></td>
				        <td width="75%"><gw:list id="lst_TCO_EOCOMPANY_PK" styles="width:100%" onchange="OnSearch()"></gw:list ></td>
				        <td width="5%"></td>
				    </tr>
				    <tr>
					    <td width="20%" align="center"><font color="black" ><b>Date &nbsp;</b></font></td>
					    <td width="75%"><gw:datebox id="idUSE_DT" maxlen="10"   styles='width:100%'  lang="<%=Session("Lang")%>"/></td>
						<td width="5%"><gw:imgBtn   id="idSearch" img="search"  alt="search"        onclick="OnSearch()"/></td>
				    </tr>
			    </table>
		    </td>
		    <td width="75%">
			    <table id="RightTopTB" height="20" width="100%">
				    <tr>
					    <td width="90%"></td>
					    <td><gw:imgBtn img="new"     alt="New"     id="idBtnAdd" 		styles='width:100%' onclick="OnAdd()" /></td>					
					    <td><gw:imgBtn img="save"    alt="Save"    id="idBtnUpdate" 	styles='width:100%' onclick="OnSave()" /></td>
					    <td><gw:imgBtn img="delete"  alt="Delete"  id="idBtnDelete" 	styles='width:100%' onclick="OnDelete()" /></td>  
					    <td><gw:imgBtn img="printer" alt="Print"   id="ibtnPrint" 		styles='width:100%'	onclick="OnPrint()" /></td>
				    </tr>							
			    </table>
		    </td>
	    </tr>
	    <tr>
		    <td width="30%">
			    <table id="LeftBottomTB" width="100%" align="top">
				    <tr>
					    <td><gw:tree id="oTreeAcCODE" align="top" style="width:100%; height:420; overflow:auto;" onclicknode="OnTreeClick()" ></gw:tree></td>
				    </tr>
			    </table>						
		    </td>
		    <td width="70%">
		        <table id="RightBottomTB" width="100%" height="100%"  align="top" >
							<tr>
								<td width="100%"> <!-- Detail Grid Control here --> 
									<table width="100%">
											<tr>
													<td width="90%">
														<table width="100%"> <!-- table1 75%-->
															<tr>
																		<td width="100%">
																			<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse"  width="100%" id="AutoNumber3">
																			  <tr>
																					<td width="30%" align="right"><font color="black" ><b>Upper Account Code &nbsp;</b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="25%"><gw:textbox id="txt_PAC_CD"  text="" 		maxlen = "6" styles='width:100%'/> </td>
																							<td width="65%"><gw:textbox id="txt_PAC_NM"  text=""  	    maxlen = "100" 	styles='width:100%'/></td>
																							<td width="5%"><gw:imgBtn id="bt_SearchUpper"     img="popup"     alt="Search"    onclick="Popup_Search()"/></td>
																							<td width="5%"><gw:imgBtn id="bt_ResetUpper"      img="reset"     alt="Reset"     onclick="Reset_Upper()" /></td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			  <tr>
																					<td width="30%" align="right"><font color="black" ><b><gw:label2 forid="id_alt_A" akey="a"><u>A</u>ccount Code &nbsp;</gw:label2></b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="25%"><gw:textbox id="txt_ACCD"  keyid="id_alt_A" maxlen = "6" text="" styles='width:100%' onkeypress="CheckKey()" onenterkey="Ac_CodeEnter()" csstype="mandatory"/></td>
																							<td width="5%"><gw:imgBtn id="idSearch1"        img="popup" alt="Search"    onclick="Popup_Search_Child()"/></td>
																							<td width="5%"><gw:imgBtn id="ibtnResetClient"  img="reset" alt="Reset"     onclick="Reset_Upper_Acc()"/></td>
																							<td width="65%"></td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			  
																			 </table>
																		</td>
															</tr>
															<tr>
																		<td width="100%">
																			<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse"  width="100%" id="Table1">
																			  <tr>
																					<td width="30%" align="right"><font color="black" ><b><gw:label2 forid="id_alt_N" akey="n">Account <u>N</u>ame &nbsp;</gw:label2></b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="100%"><gw:textbox id="txt_ACNM" keyid="id_alt_N" maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			   <tr>
																					<td width="30%" align="right"><font color="black" ><b><gw:label2 forid="id_alt_S" akey="s"><u>S</u>horted Account Name &nbsp;</gw:label2></b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="100%"><gw:textbox id="txt_ACSNM" keyid="id_alt_S"  maxlen = "100" text="" styles='width:100%'  onkeypress="CheckKey()" csstype="mandatory"/></td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			  <tr>
																					<td width="30%" align="right"><font color="black" ><b><gw:label2 forid="id_alt_L" akey="L"><u>L</u>ocal Account Name &nbsp;</gw:label2></b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="100%"><gw:textbox id="txt_ACLNM" keyid="id_alt_L"  maxlen = "100" text="" styles='width:100%'  onkeypress="CheckKey()" type = ''/></td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			  <tr>
																					<td width="30%" align="right"><font color="black" ><b><gw:label2 forid="id_alt_k" akey="k"><u>K</u>orean Account Name &nbsp;</gw:label2></b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="100%"><gw:textbox id="txt_ACKNM" keyid="id_alt_k" maxlen = "100" text="" styles='width:100%' type = ''/></td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			</table>
																		</td>
															  </tr>
															  <tr>
																		<td width="100%">
																			<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
																			  <tr>
																					<td width="30%" align="right"><font color="black" ><b>Balance Type &nbsp;</b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="100%" bordercolor="#009999">
																									<gw:radio id="rb_DRCR_TYPE" value="D" > 
																									 <span value="D" >Debit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
																									 <span value="C" >Credit&nbsp;&nbsp;&nbsp;&nbsp;</span>
																									 
																									</gw:radio >
																							</td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			   <tr>
																					<td width="30%" align="right"><font color="black" ><b>Posting/Summary &nbsp;</b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="100%" bordercolor="#009999">
																									<gw:radio id="rb_LEAF_YN" value="Y" onchange="OnChangPosSum()"> 
																										 <span value="Y">Posting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
																										 <span value="N">Summary</span>
																									</gw:radio >
																							</td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			  <tr>
																					<td width="30%" align="right"><font color="black" ><b>Report Type &nbsp;</b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																							<td width="100%" bordercolor="#009999">
																									<gw:radio id="rb_CARRY_YN" value="Y" > 
																										 <span value="Y" >Balance Sheet&nbsp;&nbsp;</span>
																										 <span value="N" >Profit & Loss</span>
																									</gw:radio >
																							</td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			  <tr>
																					<td width="30%" align="right"><font color="black" ><b>Level &nbsp;</b></font></td>
																					<td width="70%">
																						<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
																						  <tr>
																						    <td width="70%" bordercolor="#009999">
																                                <gw:radio id="rb_AC_LEVEL" value="" > 
																	                                 <span value="1" >Level 1</span>
																	                                 <span value="2" >Level 2</span>
																	                                 <span value="3" >Level 3</span>
																	                                 <span value="4" >Level 4</span>
																	                                 <span value="5" >Level 5</span>
																                                </gw:radio >
															                                </td>
															                                <td width="10%" align="center"><font color="black" ><b>Active</b></font></td>
															                                <td width="20%"><gw:radio id="rb_USE_YN" value="Y" onchange="OnChange_rb_USE_YN()"> 
																				                        <span value="Y">Yes</span>
																				                        <span value="N">No</span>
																			                        </gw:radio ></td>
																						  </tr>
																						</table>
																					</td>
																			  </tr>
																			</table>
																		</td>
															     </tr>
														     </table>
													    </td>
													    <td width="10%" ></td>
											</tr>
									</table>
									
								</td>
							</tr>
							<tr>
							    <td width="100%">
							        <gw:tab id="idTab_Child"  onclick ="" >
							            <table name="Item Account" align = "top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:120;" >
							                <tr>
							                    <td width="100%" align = "top">
							                        <table border = "0" cellpadding = "0" cellspacing= "0">
							                            <tr>
							                                <td width="94%"></td>
							                                <td width="3%"><gw:imgBtn img="new"      alt="New"      id="btn_AddItem" 	    onclick="OnAddItem()" /></td>					
    											            <td width="3%"><gw:imgBtn img="delete"   alt="Delete"   id="btn_DeleteItem"     onclick="OnDeleteItem()" /></td>  
												        </tr>
							                        </table>
							                    </td>
							                </tr>
							                <tr>
							                    <td width="100%">
								                    <gw:grid   
													            id="idGrid_Item"  
													            header="_PK|_TAC_ABACCTCODE_PK|_TAC_ABITEM_PK|Item Name|Item Local Name|Item Alias|Item Local Alias|DrCr|Mandatory|Bal"   
													            format  ="0|0|0|0|0|0|0|2|3|3"  
													            aligns  ="0|0|0|0|0|0|0|0|0|0"  
													            defaults="|||||||A|-1|-1"  
													            editcol ="0|0|0|0|0|1|1|1|1|1"  
													            widths  ="0|0|0|2000|2000|2000|2000|1500|1500|0"  
													            styles="width:100%; height:108"   
													            sorting="F"   
													            param="0,1,2,3,4,5,6,7,8,9" 
													            oncelldblclick  = "Popup()"
													            onafteredit     = "CheckLength()" 
													            oncellclick     = "CheckDelete()"/> 
										         </td>
                                            </tr>
                                        </table>
							            
							            <table  name="Item Control"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:138;" >
							                <tr valign="top">
							                    <td>
							                        <table width="100%" cellpadding = "0" cellspacing = "0" border = "0" >
							                            <tr>
							                                <td width="5%"><gw:checkbox id="chk_CUST_YN"  value="Y" defaultvalue="Y|N" onclick="OnChange_Rem()"/> </td>
												            <td width="20%" align="left"><font color="black" ><b>Customer&nbsp;</b> </font></td>
												            <td width="5%"><gw:checkbox id="chk_CUST_REMYN"  value="Y" defaultvalue="Y|N" onclick="OnChange_Rem()"/> </td>
												            <td width="20%" align="left"><font color="black" ><b>Customer Bal&nbsp;</b> </font></td>
							                            </tr>
							                            <tr>
							                                <td width="5%"><gw:checkbox id="chk_PL_YN"  value="Y" defaultvalue="Y|N" onclick="OnChange_PL()"/> </td>
												            <td width="20%" align="left"><font color="black" ><b>Profit/Cost Center&nbsp;</b> </font></td>
												            <td width="5%"><gw:checkbox id="chk_BUDGET_YN"  value="Y" defaultvalue="Y|N"/> </td>
												            <td width="20%" align="left"><font color="black" ><b>Budget&nbsp;</b> </font></td>
							                            </tr>
							                            <tr>
							                                <td width="5%"><gw:checkbox id="chk_BGCON_YN"  value="Y" defaultvalue="Y|N"/></td>
												            <td width="20%" align="left"><font color="black" ><b>Budget Control&nbsp;</b> </font></td>
												            <td width="5%"><gw:checkbox id="chk_Emp_YN"  value="Y" defaultvalue="Y|N"/></td>
												            <td width="20%" align="left"><font color="black" ><b>Emp Control&nbsp;</b> </font></td>
							                            </tr>
							                            <tr>
							                                <td width="5%"><gw:checkbox id="chk_Bank_YN"  value="Y" defaultvalue="Y|N"/></td>
												            <td width="20%" align="left"><font color="black" ><b>Bank Control&nbsp;</b> </font></td>
												            <td width="5%"></td>
												            <td width="20%" align="left"></td>
							                            </tr>
							                        </table>
							                    </td>
							                </tr>
                                        </table>
                                        
                                        <table  name="Item Type" align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:138;" >
							                <tr valign="top">
							                    <td>
							                        <table width="100%" cellpadding = "0" cellspacing = "0" border = "0" >
							                            <tr>
							                                <td width="15%" align="right"><font color="black" ><b>Budget Type &nbsp;</b></font></td>
							                                <td width="30%" bordercolor="#009999"><gw:list id="lst_BUDGET_TYPE" styles='width:100%'></gw:list></td>
							                                <td width="15%" align="right"><font color="black" ><b>Account Type &nbsp;</b></font></td>
							                                <td width="40%" bordercolor="#009999"><gw:list id="lst_ACC_TYPE" styles='width:100%'></gw:list></td>
							                            </tr>
							                            <tr>
							                                <td width="15%" align="right"><font color="black" ><b>Profit/Cost Type &nbsp;</b></font></td>
							                                <td width="30%" bordercolor="#009999"><gw:list id="lst_PL_TYPE" styles='width:100%'></gw:list></td>
							                                <td width="15%" align="right"><font color="black" ><b>Main Account&nbsp;</b></font></td>
							                                <td width="40%" bordercolor="#009999">
							                                    <table cellpadding = "0" cellspacing = "0" border="0" width="100%">
							                                        <tr>
							                                            <td width="100%">
							                                                <table cellpadding = "0" cellspacing = "0" border="0" width="100%">
							                                                    <tr>
							                                                        <td width="90%"><gw:textbox id="txt_COM_AC_PK"  maxlen = "10" text="" styles='width:100%;display:none'  />
																		            <gw:textbox id="txt_COM_AC_CD"  maxlen = "10" text="" styles='width:40%'  />
																		            <gw:textbox id="txt_COM_AC_NM"   text="" styles='width:60%'  /></td>
																		            <td width="5%"><gw:imgBtn id="btn_ACCD"     img="popup"     alt="List Account"      onclick="Popup_Search_Main()" /></td>
																		            <td width="5%"><gw:imgBtn id="btn_Reset"    img="reset"     alt="Reset Acount Code" onclick="Reset_Upper_Main()" /></td>        
																		        </tr>
							                                                </table>
							                                            </td>
							                                            
							                                        </tr>
							                                    </table>
							                                </td>
							                            </tr>
							                            <tr>
							                                <td width="15%" align="right"><font color="black" ><b>Description&nbsp;</b></font></td>
							                                <td width="30%" bordercolor="#009999"><gw:textbox id="txt_REMARK"  keyid="id_alt_D" styles="width:100%;" /></td>
							                                <td width="15%" align="right"><font color="black" ><b>Date&nbsp;</b></font></td>
							                                <td width="40%" bordercolor="#009999">
							                                    <table cellpadding = "0" cellspacing = "0" border="0" width="100%">
							                                        <tr>
							                                            <td width="100%">
							                                                <table cellpadding = "0" cellspacing = "0" border="0" width="100%">
							                                                <tr>
							                                                    <td width="45%"><gw:datebox id="dt_STD_DT" maxlen = "10" styles='width:80%' lang="<%=Session("Lang")%>" nullaccept onchange = "OnCheck()"/></td>
							                                                    <td width="10%" align="center">~</td>
																		        <td width="45%"><gw:datebox id="dt_END_DT" maxlen = "10" styles='width:80%' lang="<%=Session("Lang")%>" nullaccept onchange = "OnCheck()"/></td>
                															</tr>
                															</table>
                														</td>
							                                        </tr>
							                                    </table>
							                                </td>
							                            </tr>
							                        </table>
							                    </td>    
                                            </tr>
                                        </table>
                                        <table  name="Balance" align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:138;" >
							                <tr valign="top">
                                                <td>
							                        <table width="100%" cellpadding = "0" cellspacing = "0" border = "0" >
					                                    <tr>
					                                        <td width="10%"></td>
					                                        <td width="20%" align="right"><font color="black" ><b>Current Balance&nbsp;</b></font></td>
					                                        <td width="60%" bordercolor="#009999"><gw:textbox id="txt_BAL" styles="width:100%;text-align: Right" type="number" format="#,###,###,###,###.##R" csstype="mandatory"/></td>
					                                        <td width="10%"></td>
                                                        </tr>
                                                    </table>
							                     </td>           
							                </tr>
							            </table>
							        </gw:tab>
							    </td>
							</tr>
						</table>
	            </td>
	        </tr>
	        
	    </table>
    </form>

    <form name="Account Code Inquiry"   id="Acc_Inquiry"    type="hidden">
        
        <table width = "100%" border = "1" cellpadding = "1" cellspacing = "0">
            <tr>
                <td>
                    <table width = "100%" border = "0" cellpadding = "0" cellspacing = "0">
                        <tr>
                            <td align="center" width="5%"><b>Company</b></td>
                            <td width="20%"><gw:list id="lstCompany" styles='width:100%'></gw:list></td>
                            <td width="5%" align="center"><font color="black"><b>  Account  </b></font></td> 
                            <td width="25%">
                                <table width = "100%" border = "0" cellpadding = "0" cellspacing = "0">
                                    <tr>
                                        <td width="30%"><gw:textbox id="txtAcc_cd" styles='width:100%'/></td>
                                        <td width="50%"><gw:textbox id="txtAcc_nm" styles='width:100%'/></td>
                                        <td width="0%"><gw:textbox  id="txtAcc_pk" styles='display:none'/></td>
                                        <td width="10%"><gw:imgBtn img="popup"	id="idSearchP" alt="Popup" onclick="Popup_Search_Inquiry()"/></td> 
                                        <td width="10%"><gw:imgBtn img="reset"	id="idReset"  alt="Reset"  onclick="Reset_Acc_Inquiry()"/></td>
                                    </tr>
                                </table>   
                            </td>       
                            <td width="15%">
                                <table width = "100%" border = "0" cellpadding = "0" cellspacing = "0">
                                    <tr>
                                        <td width="15%"></td>
                                        <td width="5%"><gw:imgBtn img="refresh"     id="idBtnRefresh"	    alt="Refresh"       onclick="OnRefressInquiry()" /></td>
                                        <td width="5%"><gw:imgBtn img="search"		id="idSearchInq"  		alt="Search" 		onclick="OnSearchInquiry()"/></td>
                                        <td width="5%"><gw:imgBtn img="new"    		id="idBtnAddInq" 		alt="New"    		onclick="OnNewInquiry()" /></td>
                                        <td width="5%"><gw:imgBtn img="save"    	id="idBtnUpdateInq" 	alt="Save"   		onclick="OnSaveInquiry()" /></td>
                                        <td width="5%"><gw:imgBtn img="delete"  	id="idBtnDeleteInq" 	alt="Delete"  		onclick="OnDelInquiry()" /></td>
                                    </tr>
                                </table>        
                            </td>
                        </tr>
                    </table>
                </td>
        </tr>
        
        <tr>
            <td>
                <table width = "100%" border = "0" cellpadding = "0" cellspacing = "0">
                    <tr>
                        <td>
                            <gw:grid
                            id="idGrid"
                            header  ="_PK|UpperAc.Code|Ac.Code|Account Name|Local Account Name|Korean Account Name|Balance Type(Dr/CR)|Posting/ Summary|Report Type/Carry YN|Level|Customer|Customer Bal|Profit/Cost Center|_PL_TYPE|_BUDGET_YN|_BUDGET_TYPE|_BGCON_YN|_COM_AC_PK"
                            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                            aligns  ="0|1|1|0|0|0|1|1|1|1|1|1|1|0|0|0|0|0"
                            defaults="|||||||||||||||||"
                            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"
                            widths  ="0|1300|1300|4500|4500|2500|2500|2500|2500|2500|2500|2500|2500|1000|1000|500|800|500"
                            styles  ="width:100%; height:420"
                            sorting ="F"
                            param   ="0,1,2,3,4,5,6,7,8,9,10,11,12,17"/>
                        </td>
                    </tr>                
                </table>
            </td>            
        </tr>
    </table> 

    </form>
</gw:tab>

<gw:textbox id="txt_PK"                  style="display:none"/> 
<gw:textbox id="txt_AC_GRP" 			 style="display:none"/>
<gw:textbox id="txt_PAC_PK" 			 style="display:none"/>

<gw:textbox id="txt_AC_LEVEL_TMP"        style="display:none"/> 
<gw:textbox id="txt_LEAF_YN_TMP"         style="display:none"/> 
<gw:textbox id="txt_DRCR_TYPE_TMP"       style="display:none"/> 
<gw:textbox id="txt_CARRY_YN_TMP"        style="display:none"/> 
<gw:textbox id="txt_CUST_YN_TMP"         style="display:none"/> 
<gw:textbox id="txt_CUST_REMYN_TMP"      style="display:none"/> 
<gw:textbox id="txt_PL_YN_TMP"           style="display:none"/> 
<gw:textbox id="txt_PL_TYPE_TMP"         style="display:none"/> 
<gw:textbox id="txt_BUDGET_YN_TMP"       style="display:none"/> 
<gw:textbox id="txt_BUDGET_TYPE_TMP"     style="display:none"/> 
<gw:textbox id="txt_BGCON_YN_TMP"        style="display:none"/> 
<gw:textbox id="txt_AC_TYPE_TMP"         style="display:none"/> 
<gw:textbox id="txt_AC_GRP_TMP"          style="display:none"/> 

<gw:textbox id="txt_Duplicate"           style="display:none"/>
<gw:textbox id="txt_accd_tmp"            style="display:none"/>
<gw:textbox id="txt_Child"               style="display:none"/>

<gw:textbox id="txt_Parent_PK"           style="display:none"/>
<gw:textbox id="txt_level"               style="display:none"/>
<gw:textbox id="txt_possum"              style="display:none"/>

</body>
</html>
