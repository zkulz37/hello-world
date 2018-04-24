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
	System.Translate(document);
    txt_Company_PK.text = "<%=Session("COMPANY_PK")%>";
    txt_ACCD.GetControl().readOnly= true;
    BindingDataList();
    txt_PAC_CD.SetEnable(false);
    txt_PAC_NM.SetEnable(false);
    OnSearch();
    //alert(rb_USE_YN.value);
//    idEnd_DT.text="";
//    alert(idEnd_DT.value);
}

function BindingDataList()
{ 
    var ls_data2    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','','') FROM DUAL")%>";
    var ls_data3    = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //ccy
    lstccy.SetDataText(data);
    lst_TCO_EOCOMPANY_PK.SetDataText(ls_data3);
    lstCompany.SetDataText(ls_data3);
    rb_AC_LEVEL.SetDataText('DATA|1|Level 1|2|Level 2|3|Level 3|4|Level 4|5|Level 5');
    rb_DRCR_TYPE.SetDataText('DATA|D|Debit|C|Credit');
    rb_LEAF_YN.SetDataText('DATA|Y|Posting|N|Summary');
    rb_CARRY_YN.SetDataText('DATA|Y|Balance Sheet|N|Profit & Loss');
    
    
    data ="#1;Level 1|#2;Level 2|#3;Level 3|#4;Level 4|#5;Level 5"; 
    idGrid.SetComboFormat(8,data);
    data1 ="#D;Debit|#C;Credit"; 
    idGrid.SetComboFormat(9,data1);
    data2 ="#Y;Posting|#N;Summary"; 
    idGrid.SetComboFormat(10,data2);
}

function OnSearch()
{
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
    if(rb_USE_YN.value=="Y")
    {
        idEnd_DT.value="";
    }
    if(rb_USE_YN.value=="N")
    {
        var a=idEnd_GetDT.GetData();
        idEnd_DT.SetDataText(a);
    }
//    if(Number(txt_BAL.GetData()) > 0 && rb_USE_YN.GetData() == "N" )
//	{
//		rb_USE_YN.SetDataText("Y");
//		alert('Ending Balance not equal zero');
//	}	
//	if(Number(txt_BAL.GetData()) < 0 && rb_USE_YN.GetData() == "N" )
//	{
//		rb_USE_YN.SetDataText("Y");
//		alert('Ending Balance not equal zero');
//	}
//	if (rb_USE_YN.GetData() == "N")
//	{
//	    dt_END_DT.SetDataText(idUSE_DT.GetData());
//	}
//	else
//	{
//	    dt_END_DT.SetDataText('');
//	}
}
 
function OnDataReceive(obj)
{
    if(obj.id == 'dso_upd_acc_entry')
        {
            if((Insert=='T') || (Delelete=='T'))
            {
               
                if(Delelete=='T')
                {
                    txt_PAC_CD.text = '';
                    txt_PAC_NM.text = '';
                   
                }
               
                    dso_sel_tree_account.Call("SELECT"); 
                    Insert = 'F';
                    Delelete = 'F';
               
            }
            else
            {
                datAccCode_Name.Call();
            }   
        }
}


function OnAdd()
{
    if(txt_PK.GetData() == "")
    {
		alert('Please Select Upper Account Code!!!'+'\n'+' Yêu cầu nhập tài khoản cấp cha!!!');
	}
	else
	    {
	        Insert   = 'T';
	        Modify   = 'F';
	        Delelete = 'F';
	        txt_PAC_CD.SetDataText(txt_ACCD.GetData());
            txt_PAC_NM.SetDataText(txt_ACNM.GetData());
            bt_ResetUpper.SetEnable(false);
            ClearData();
            var p_pk =  txt_PK.GetData();
            var company_pk  =  txt_Company_PK.GetData();
            dso_upd_acc_entry.StatusInsert();
            txt_Parent_pk_hide.text = p_pk;
            txt_ComPK1.text = company_pk ;
            rb_USE_YN.SetDataText("Y");
            rb_LEAF_YN.SetDataText("Y");	
	    }
}
function ClearData()
{
    txt_ACCD.text="";
    txt_ACNM.text="";
    txt_ACSNM.text="";
    txt_ACLNM.text="";
    txt_ACKNM.text="";
    txt_Description.SetDataText("");
    txt_LDescription.SetDataText("");
    txt_KDescription.SetDataText("");
}
function OnCheck_Child()
{
//	if(txt_LEAF_YN_TMP.GetData() == "N")
//	{
//		var level = txt_AC_LEVEL_TMP.GetData()
//		if (txt_level.GetData() == '')
//		{
//		    txt_level.SetDataText(level);
//		}
//		if (level == '')
//		{
//		    level = txt_level.GetData();
//		}
//		level = Number(level) + 1;
//		
//		if (level < 6)
//		{
//			//alert('Please Input Information...'+'\n'+'Mời bạn nhập thông tin...');
//		    txt_ACCD.GetControl().focus();
//		    
//		    var ls_PAC_CD = txt_ACCD.GetData();
//		    var ls_PAC_NM = txt_ACNM.GetData();
//		    var ls_PAC_PK = txt_PK.GetData();
//		    
//		    var ls_PAC_CD_tmp = txt_PAC_CD.GetData();
//		    var ls_PAC_NM_tmp = txt_PAC_NM.GetData();
//		    var ls_PAC_PK_tmp = txt_PAC_PK.GetData();
//		    
//		    dso_upd_acc_entry.StatusInsert();
//		    rb_USE_YN.SetDataText("Y")
//		    rb_LEAF_YN.SetDataText("Y")
//			idGrid_Item.ClearData();
//			
//			if (txt_DRCR_TYPE_TMP.GetData() != '')
//			{
//			    txt_PAC_CD.SetDataText(ls_PAC_CD);
//			    txt_PAC_NM.SetDataText(ls_PAC_NM);
//			    txt_PAC_PK.SetDataText(ls_PAC_PK);
//			}
//			
//			if (txt_PAC_CD.GetData() == '')
//			{
//			    txt_PAC_CD.SetDataText(ls_PAC_CD_tmp);
//			    txt_PAC_NM.SetDataText(ls_PAC_NM_tmp);
//			    txt_PAC_PK.SetDataText(ls_PAC_PK_tmp);
//			}
//			
//			rb_AC_LEVEL.SetDataText(level);
//			rb_DRCR_TYPE.SetDataText(txt_DRCR_TYPE_TMP.GetData()) ;
//			rb_CARRY_YN.SetDataText(txt_CARRY_YN_TMP.GetData()) ;
//			chk_CUST_YN.SetDataText(txt_CUST_YN_TMP.GetData());	
//			chk_CUST_REMYN.SetDataText(txt_CUST_REMYN_TMP.GetData());
//			chk_PL_YN.SetDataText(txt_PL_YN_TMP.GetData());
//			lst_PL_TYPE.SetDataText(txt_PL_TYPE_TMP.GetData());

//			chk_BUDGET_YN.SetDataText(txt_BUDGET_YN_TMP.GetData());
//			chk_BGCON_YN.SetDataText(txt_BGCON_YN_TMP.GetData());
//			lst_ACC_TYPE.SetDataText(txt_AC_TYPE_TMP.GetData()) ;
//			txt_AC_GRP.SetDataText(txt_AC_GRP_TMP.GetData());
//			
//			var ls_data;
//			
//			if (txt_PL_YN_TMP.GetData() == 'N')
//			{
//			    ls_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','02','') FROM DUAL")%>";
//			}
//			else
//			{
//			    ls_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','01','') FROM DUAL")%>";
//			}
//			
//			lst_PL_TYPE.SetDataText(ls_data);
//			Set_PL_TYPE();
//		}	
//		else
//		{
//			alert('Please Select level less then or equal level 5'+'\n'+'     Yêu cầu chọn cấp độ!!!');
//			return;
//		}
//	}	
//	else
//	{
//	    alert('Can not add child count a (Posting/Summary) is Posting. Please Select Summary...'+'\n'+'');
//	}
}

function Set_PL_TYPE()
{
//	if(lst_PL_TYPE.GetData() != "AC")
//	{
//		txt_COM_AC_PK.SetDataText("");
//		txt_COM_AC_CD.SetDataText("");
//		txt_COM_AC_NM.SetDataText("");
//		btn_ACCD.SetEnable(false);
//		btn_Reset.SetEnable(false);
//	}
//	else
//	{
//	    btn_ACCD.SetEnable(true);
//	    btn_Reset.SetEnable(true);
//	}
}

function OnResetAc_CD()
{	
//	txt_COM_AC_PK.SetDataText("");
//	txt_COM_AC_CD.SetDataText("");
//	txt_COM_AC_NM.SetDataText("");
}

function OnSave()
{
       dso_upd_acc_entry.Call();
       Insert='T';  
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
	        Delelete = 'T';
	        dso_upd_acc_entry.StatusDelete();
		    dso_upd_acc_entry.Call();
		}
    }
}

function On_Check_Child()
{
//    var ctrl 	= idGrid_Item.GetGridControl();
//    
//    if (ctrl.Rows > 1)
//    {
//        alert('You must delete Item frist then delete Account!!!' + '\n' + 'Bạn phải xóa Item trước, sau đó xóa tài khoản!!!')
//        return;
//    }
//    
//    if ( Number(txt_Child.GetData()) > 0 )
//    {
//        alert('You must delete child account then delete upper account!!!' + '\n' + 'Bạn phải xóa tài khoản con trước, sau đó xóa tài khoản cha!!!')
//        return;
//    }
//    else
//    {
//        var ctrl 	= idGrid_Item.GetGridControl();
//	    for (i=0; i<ctrl.Rows; i++)
//		{
//			idGrid_Item.SetRowStatus(i, 0x40);
//		}
//		dso_upd_acc_entry.StatusDelete();
//		Insert   = 'F';
//	    Modify   = 'F';
//	    Delelete = 'T';
//        dso_upd_acc_entry.Call("");
//    }
}

function OnCheckDup()
{
//    if (CheckData() && OnCheck_Upper_Child() && OnCheck_Item() && OnCheck_Item_Dup()) 
//    {
//       Modify   = 'T';
//       dso_upd_acc_entry.Call("");
//    }
}

function OnCheck_Item_Dup()
{
//    var ctrl 	= idGrid_Item.GetGridControl();
//	var rows 	= ctrl.Rows;
//	
//	for (i=1; i<ctrl.Rows - 1; i++)
//	{
//		for (j= i + 1; j<ctrl.Rows; j++)
//		{
//			var data1 = idGrid_Item.GetGridData(i, 2);
//			var data2 = idGrid_Item.GetGridData(j, 2);
//			if(Number(data1) == Number(data2))
//			{
//				alert(' Item in row '+ j + ' is exists!!! Please check again.'+'\n'+'Dữ liệu dòng '+ j + ' đã tồn tại. Yêu cầu kiễm tra lại.');
//				return false;
//			}
//		}
//	}
//	return true;
//}


//function OnCheck_Item()
//{
//    var ctrl 	= idGrid_Item.GetGridControl();
//	var rows 	= ctrl.Rows;
//	
//	for (i=1; i<ctrl.Rows; i++)
//	{
//		for (j=3; j< 7; j++)
//		{
//			var data = idGrid_Item.GetGridData(i, j);
//			if(data.length < 1)
//			{
//				alert('    Item in row '+ i + ' col ' + (j-2) + ' is not null'+'\n'+'Dữ liệu dòng '+ i + ' cột ' + (j-2) + ' không được rỗng');
//				return false;
//			}
//		}
//	}
//	return true;
//}

//function CheckData()
//{
//	if(txt_PAC_CD.GetData() == '')
//	{
//		alert('Please select upper account code ...'+'\n'+'Yêu cầu chọn chọn tài khoản ...');
//		return false;
//	}
//	if(txt_PAC_NM.GetData() == '')
//	{
//		alert('Please select upper account code ...'+'\n'+'Yêu cầu chọn tài khoản cấp cha ...');
//		return false;
//	}
//	if(txt_AC_GRP.GetData() == '')
//	{
//		//alert('Please input account group ...'+'\n'+'Yêu cầu nhập loại tài khoản ...');
//		//return false;
//	    txt_AC_GRP.SetDataText('VIE');
//	}
//	if(txt_ACCD.GetData() == '')
//	{
//		alert('Please input account code ...'+'\n'+'Yêu cầu nhập số hiệu tài khoản ...');
//		txt_ACCD.GetControl().focus();
//		return false;
//	}
//	if(rb_AC_LEVEL.GetData() == '')
//	{
//		alert('Please input level ...'+'\n'+'Yêu cầu nhập cấp tài khoản ...');
//		return false;
//	}
//	if(txt_ACNM.GetData() == '')
//	{
//		alert('Please input account name ...'+'\n'+'Yêu cầu nhập tên tài khoản ...');
//		txt_ACNM.GetControl().focus();
//		return false;
//	}
//	if(txt_ACSNM.GetData() == '')
//	{
//		alert('Please input short account name ...'+'\n'+'Yêu cầu nhập tên rút gọn tài khoản ...');
//		txt_ACSNM.GetControl().focus();
//		return false;
//	}
//	if(rb_DRCR_TYPE.GetData() == '')
//	{
//		alert('Please input debit and credit type ...'+'\n'+'Yêu cầu chọn loại tài khoản(Nợ/Có)');
//		return false;
//	}
//	if (Insert == 'T')
//	{
//	    if (Number(txt_Duplicate.GetData()) > 0)
//	    {
//	        alert('Account code is exists!!! Please select Account code again'+'\n'+'Tài khoản này đã tồn tại!!! Yêu cầu chọn lại tài khoản.');
//		    return false;
//	    }
//	}
//	return true;
//}

//function CheckLength()
//{
//    var ctrl 	= idGrid_Item.GetGridControl();
//	var rows 	= ctrl.Rows;
//	for (i=1; i<ctrl.Rows; i++)
//	{
//		for (j=5; j< 7; j++)
//		{
//			var data = idGrid_Item.GetGridData(i, j);
//			if(data.length > 30)
//			{
//				alert('Data too large for column'+'\n'+'   Dữ liệu quá lớn!!!');
//				return false;
//			}
//		}
//	}
//	return true;
}

function OnAddItem()
{
//    if (rb_LEAF_YN.GetData() == 'N')
//    {
//        alert('Account code have Summary. You must choose Posting and then Add New Item Code!!!'+'\n'+'             Tài khoản này là tài khoản cấp tổng. Bạn không được thêm Item!!!');
//        return;
//    }
//    else if (rb_LEAF_YN.GetData() == 'Y')
//    {
//        idGrid_Item.AddRow();
//	    var ctrl= idGrid_Item.GetGridControl();          
//	    var row =  ctrl.Rows - 1;   
//	    idGrid_Item.SetGridText(row, 1, txt_PK.GetData());
//	    idGrid_Item.SetRowStatus(row, 0x20);
//    }
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
//	var ctrl 	= idGrid_Item.GetGridControl();
//	var rownum 	= ctrl.Row;
//	if(rownum > 0)
//	{
//		if(ctrl.Col == 8)
//		{
//		    if (idGrid_Item.GetGridData( ctrl.Row, 8) == '0')
//		    {
//		        idGrid_Item.SetGridText(ctrl.Row, 9, '0');
//		    }
//		}
//		if(ctrl.Col == 9)
//		{
//			idGrid_Item.SetGridText(ctrl.Row, 8, idGrid_Item.GetGridData( ctrl.Row, 9));
//            idGrid_Item.SetGridText(ctrl.Row, 7, 'A');
//		}
//		if(idGrid_Item.GetRowStatus(ctrl.Row) >= 64)
//		{
//			btn_DeleteItem.SetEnable(false);
//			//btn_UnDeleteItem.SetEnable(true);
//		}
//		else
//		{
//			btn_DeleteItem.SetEnable(true);
//			//btn_UnDeleteItem.SetEnable(false);
//		}
//	}
}
function Control_Item_Menu(p_check)
{
//    if (p_check == 1)
//    {
//        btn_DeleteItem.SetEnable(false);
//        //btn_UnDeleteItem.SetEnable(false);
//    }
//    else if (p_check == 2)
//    {
//        btn_DeleteItem.SetEnable(true);
//        //btn_UnDeleteItem.SetEnable(true);
//    }
}
function Ac_CodeEnter()
{
//    onPress();
//	txt_accd_tmp.SetDataText( txt_ACCD.GetData() + ';' + lst_TCO_EOCOMPANY_PK.GetData());
//	dso_sel_abacctitem.Call("SELECT");
}

function Popup_Search()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_SUM_PARENT";
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

function Popup_SearchIFRS()
{
//    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.sp_sel_gfac00010_1";
//    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
//	if (o != null)
//	{
//		if(o[0] != 0)
//		{
//			txt_AC_CD_ifrs.SetDataText( o[0] );
//			txt_AC_NM_ifrs.SetDataText( o[1] );
//			txt_AC_CD_ifrs_pk.SetDataText( o[3] );
//		}
//	}
}

function Popup_Search_Child()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
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
//    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
//    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
//	if (o != null)
//	{
//		if(o[0] != 0)
//		{
//			txt_COM_AC_PK.SetDataText( o[2] );
//			txt_COM_AC_CD.SetDataText( o[0] );
//			txt_COM_AC_NM.SetDataText( o[1] );
//		}
//	}
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
    txt_ACCD1.SetDataText('');
    txt_ACCD2.SetDataText('');
    txt_ACCD3.SetDataText('');
    txt_ACCD4.SetDataText('');
    txt_ACCD5.SetDataText('');
    txt_ACCD6.SetDataText('');
    txt_ACCD7.SetDataText('');
    txt_ACCD8.SetDataText('');
    txt_ACCD9.SetDataText('');
    txt_ACCD10.SetDataText('');
}

function OnCheck_Upper_Child()
{
//    var ls_upper_accd;
//    var ls_child_accd;
//    ls_upper_accd = txt_PAC_CD.GetData();
//    ls_child_accd = txt_ACCD.GetData();

//    ls_upper_accd = ls_upper_accd.substr(0,3);
//    ls_child_accd = ls_child_accd.substr(0,3);
//    
//    var level_upper = txt_level.GetData();
//    var level_child = rb_AC_LEVEL.GetData();
//    
//    if (Number(level_child) <= Number(level_upper))
//    {
//        alert('Level Child Account is not less than Upper Account. Please Choose Again!!!'+'\n'+'    Cấp độ của tài khoản cấp con không được nhỏ hơn cấp cấp cha!!!');
//        return false;
//    }
//    else
//    {
//        if ((Number(rb_AC_LEVEL.GetData()) == 1) || (Number(rb_AC_LEVEL.GetData()) == 2))
//        {
//            return true;
//        }
//        if (Number(ls_upper_accd) != Number(ls_child_accd))
//        {
//	        alert('Child Account different to Upper Account. Please Choose Again!!!'+'\n'+'     Tài khoản cấp cha và cấp con không tương thích!!!');
//	        return false;
//        }
//    }
//	return true;
}

function CheckKey() 
{
//	 var c = String.fromCharCode (event.keyCode); 
//	 var x = c.toUpperCase().charCodeAt(0) ; 
//	 event.keyCode = x; 
}

function OnChange_Rem()
{
//	if(chk_CUST_YN.GetData() == "N")
//	{
//		chk_CUST_REMYN.SetDataText("N");
//	}
}

function OnChange_PL()
{
//    if (chk_PL_YN.GetData() == 'N')
//    {
//        ls_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','02','') FROM DUAL")%>";
//    }
//    else
//    {
//        ls_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0160','01','') FROM DUAL")%>";
//    }
//    lst_PL_TYPE.SetDataText(ls_data);
//	Set_PL_TYPE();
}

/*-------------------------------------------------Acc_Inquiry----------------------------------------------------*/
function Popup_Search_Inquiry()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_SUM_PARENT";
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

/*-------------------------------------------------Acc_Inquiry----------------------------------------------------*/
function Popup_Search_ifrs()
{
//    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_SUM_PARENT";
//	o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
//	if (o != null)
//	{
//		if(o[0] != 0)
//		{
//			txtAcc_pk_ifrs.SetDataText(o[3]);
//		    txtAcc_nm_ifrs.SetDataText(o[1]);
//		    txtAcc_cd_ifrs.SetDataText(o[0]);
//		}
//		else
//		{
//		    if(o[0].length == 6)
//		    {
//			    txtAcc_pk_ifrs.SetDataText(o[3]);
//			    txtAcc_nm_ifrs.SetDataText(o[1]);
//			    txtAcc_cd_ifrs.SetDataText(o[0]);
//		    }
//		}
//	}
}

function Reset_Acc_Inquiry()
{
//    txtAcc_pk.SetDataText('');
//    txtAcc_nm.SetDataText('');
//    txtAcc_cd.SetDataText('');
}

function OnSearchInquiry()
{
   dso_upd_acc_code_inquiry.Call("SELECT");
}

function On_Change_Color()
{
        var ctrl 	= idGrid.GetGridControl();
        for (i=1; i<ctrl.Rows; i++)
        {
            if((idGrid.GetGridData(i,8)== "0") || (idGrid.GetGridData(i,8)== "1") || (idGrid.GetGridData(i,8)== "2"))
            {
                idGrid.SetCellBold(i,1,i,34,true);
            }
            else
            {   
                idGrid.SetCellBold(i,1,i,34,false);
            }
            
            if (idGrid.GetGridData(i,8)== "1")
            {
                idGrid.SetCellBgColor(i,0,i,34, Number('0X99CCFF'));
            }
            else if (idGrid.GetGridData(i,8)== "2")
            {
                idGrid.SetCellBgColor(i,0,i,34, Number('0XCCFFCC'));
            }
            else if (idGrid.GetGridData(i,8)== "3")
            {
                idGrid.SetCellBgColor(i,0,i,34, Number('0XEFFFFF'));
            }
            else if (idGrid.GetGridData(i,8)== "0")
            {
                idGrid.SetCellBgColor(i,0,i,34, Number('0XF4E6E0'));
            }
       }
}

function checkValue()
{
//    var i = idTab.GetCurrentPageNo();
//    switch(i)
//    {
//        case 0:
//            txtAcc_nm.SetDataText('');
//            txtAcc_cd.SetDataText('');
//            idGrid.ClearData();
//        break;
//        
//        case 1:
//            dso_upd_acc_entry.StatusInsert();
//            idGrid_Item.ClearData();
//            dt_STD_DT.SetDataText('');
//            dt_END_DT.SetDataText('');
//            chk_CUST_YN.SetDataText('');
//            chk_CUST_REMYN.SetDataText('');
//            chk_PL_YN.SetDataText('');
//            chk_BUDGET_YN.SetDataText('');
//            chk_BGCON_YN.SetDataText('');
//            chk_Emp_YN.SetDataText('');
//            chk_Bank_YN.SetDataText('');
//            txt_COM_AC_CD.SetDataText('');
//            txt_COM_AC_NM.SetDataText('');
//            txt_COM_AC_PK.SetDataText('');
//            txt_REMARK.SetDataText('');
//            dt_STD_DT.SetDataText('');
//            dt_END_DT.SetDataText('');
//            txt_BAL.SetDataText('0');
//            idGrid_Item.ClearData();
//        break;
//    }
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
//    var ctrl 	= idGrid.GetGridControl();
//	var i;
//	var j;
//	var codei;
//	
//	i = 1;
//	while (i < ctrl.Rows)
//    {
//        if(Trim(idGrid.GetGridData(i, 0)) != "")  return true;
//        
//        codei = idGrid.GetGridData(i, 1);
//        if (codei == '')
//        {
//            alert('   Upper Account Code in row '+ i +' is not null. Please check again!!!'+'\n'+'Tài khoản cấp cha ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
//	        return false;
//        }
//        codei = idGrid.GetGridData(i, 2);
//        if (codei == '')
//        {
//            alert('   Account Code in row '+ i +' is not null. Please check again!!!'+'\n'+'Account Code ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
//	        return false;
//        }
//        codei = idGrid.GetGridData(i, 3);
//        if (codei == '')
//        {
//            alert('     Account name in row '+ i +' is not null. Please check again!!!'+'\n'+'Account name ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
//	        return false;
//        }
//        codei = idGrid.GetGridData(i, 6);
//        if (codei == '')
//        {
//            alert('     Balance Type(Dr/CR) in row '+ i +' is not null. Please check again!!!'+'\n'+'Loại tài khoản (Nợ/Có) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
//	        return false;
//        }
//        codei = idGrid.GetGridData(i, 7);
//        if (codei == '')
//        {
//            alert('      Posting/Summary in row '+ i +' is not null. Please check again!!!'+'\n'+'Cấp độ(nút lá/gốc) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
//	        return false;
//        }
//        codei = idGrid.GetGridData(i, 8);
//        if (codei == '')
//        {
//            alert('                   Report Type(Profit & Loss) in row '+ i +' is not null. Please check again!!!'+'\n'+'Loại tài khoản dùng cho báo cáo(Balance/Profit & Loss) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
//	        return false;
//        }
//        codei = idGrid.GetGridData(i, 9);
//        if (codei == '')
//        {
//            alert('      Level in row '+ i +' is not null. Please check again!!!'+'\n'+'Cấp tài khoản ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
//	        return false;
//        }
//        i = i + 1;
//    }
//    
//	i = 1;
//	if (ctrl.Rows > 2)
//	{
//	    while (i < ctrl.Rows - 1)
//	    {
//	        j = i + 1;
//	        var codej;
//	        codei = idGrid.GetGridData(i, 2);
//	        while (j < ctrl.Rows)
//	        {
//	            codej = idGrid.GetGridData(j, 2);
//	            if (codei == codej)
//	            {
//	                alert('  Account Code in row '+ j +' exists. Please check again!!!'+'\n'+'Account Code ở dòng '+ j +' đã tồn tại. Bạn hãy kiểm tra lại!!!')
//	                return false;
//	            }
//	            j = j + 1;
//	        }
//	        i = i + 1;
//        }
//    }
//	return true;
}

function OnSaveInquiry()
{
   var ctrl 	= idGrid.GetGridControl();
//    if (!OnCheckInquiry())
//    {
//        return;
//    }
    for (i=1; i < ctrl.Rows; i++ )
	{
	    if (idGrid.GetGridData(i, 15) == '')
	    {
	        idGrid.SetGridText(i, 15, lstCompany.GetData());
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
					        dso_upd_acc_code_inquiry.Call("");
			            }
		            }
		        }
            }
        }
	}
}


function OnChangPosSum()
{
//    if (rb_LEAF_YN.GetData() == 'N')
//    {
//        if (idGrid_Item.rows > 1)
//        {
//            alert('           You must del all Item code first then change Posting to Summary!!!'+'\n'+'Bạn hãy xóa hết các Item Code trước sau đó chuyển từ Posting sang Summary!!!');
//            rb_LEAF_YN.SetDataText('Y');
//            return;
//        }
//    }
//    else if(rb_LEAF_YN.GetData() == 'Y')
//    {
//        dso_pro_possum.Call('');
//    }
//}

//function On_Check_Summary()
//{
//    if (Number(txt_possum.GetData()) > 0)
//    {
//        alert('               You must delete all child account then change Posting!!!' + '\n' + 'Bạn phải xóa hết tất cả tài khoản con trước, sau đó bạn mới thay đổi được Posting!!!')
//        rb_LEAF_YN.SetDataText('N');
//        return;
//    }
}

function CheckNumeric()
{
//   var key = window.event.keyCode;
//   if ( key > 47 && key < 58 )
//      return; // if so, do nothing
//   else
//      window.event.returnValue = null; // otherwise
}

function OnSearchAcc(index)
{
//    switch(index)
//    {
//        case 0:
//            dso_pro_sel_acc.Call();
//        break;
//        case 1:
//            dso_pro_sel_acc1.Call();
//        break;
//    }        
}

function OnPrint()
{
//    var url = '/reports/gf/ac/gfac00010.aspx?company_pk='+lstCompany.value;
//	System.OpenTargetPage( System.RootURL+url , "newform" );
}

function onReportInquiry()
{
//	var url = '/reports/gf/ac/gfac00010_1.aspx?company_pk='+lstCompany.value;
//	System.OpenTargetPage( System.RootURL+url , "newform" );
}
function Acc_Entry_onkeypress() {

}
//--------------------------------------------------------------
function onPress()
{
   //CheckKey();
  // txt_ACCD.text =  txt_ACCD1.GetData() + txt_ACCD2.GetData() + txt_ACCD3.GetData() + txt_ACCD4.GetData() + txt_ACCD5.GetData() + txt_ACCD6.GetData() + txt_ACCD7.GetData() + txt_ACCD8.GetData() + txt_ACCD9.GetData() + txt_ACCD10.GetData() + txt_ACCD11.GetData();
}
function Ac_CodeEnter1()
{
//    onPress();
//	txt_accd_tmp.SetDataText( txt_ACCD.GetData() + ';' + lst_TCO_EOCOMPANY_PK.GetData());
	//dso_sel_abacctitem.Call("SELECT");
}
var gSave = false;
 function OnToggle()
 {
//    var left  = document.all("left");    
//    var right = document.all("right");   
//    var imgArrow = document.all("imgArrow");   
//    
//    if(imgArrow.status == "expand")
//    {
//        left.style.display="none";       
//        imgArrow.status = "collapse";
//        right.style.width="100%";
//        imgArrow.src = "../../../system/images/button/next.gif";
//    }
//    else
//    {
//        left.style.display="";
//        imgArrow.status = "expand";
//        right.style.width="75%";
//        imgArrow.src = "../../../system/images/button/previous.gif";
//    }
//    
 }  
//--------------------------------------------------------------
function MergeHeader()
{
//		var fg=idGrid_ifrs.GetGridControl();
//		if(fg.Rows < 2)
//		{
//		   idGrid_ifrs.AddRow();     
//		}
//        fg.FixedRows = 2
//        fg.MergeCells = 5
//		fg.MergeRow(0) = true

//        fg.Cell(0, 0, 1, 0, 3) = "Account(V.A.S)"
//        fg.Cell(0, 1, 1, 1, 1) = "Upper Account Code" 
//        fg.Cell(0, 1, 2, 1, 2) = "Account Code"  
//		fg.Cell(0, 1, 3, 1, 3) = "Account Name" 
//		
//		fg.Cell(0, 0, 4, 0, 5) = "Account(IFRS)"
//        fg.Cell(0, 1, 4, 1, 4) = "Account Code" 
//        fg.Cell(0, 1, 5, 1, 5) = "Account Name"  
//		fg.MergeCol(6) = true
//		fg.Cell(0, 0, 6, 1, 6) = "Description"
//	
//	    //fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4;
//		//fg.Cell(5, 1, 1, 1,fg.Cols - 1) = true; 
//		//fg.SetCellBold(1,1,1,fg.Cols - 1,true);
//		fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4;
//		fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; 
//		fg.ColWidth(0)=1200;
//		fg.ColWidth(1)=2000;
//		fg.ColWidth(2)=1500;
//		fg.ColWidth(3)=2800;
//		fg.ColWidth(4)=1500;
//		fg.ColWidth(5)=2500;
//		fg.ColWidth(6)=2500;
//		fg.ColWidth(7)=0;
}
function Ac_CodeEnter1()
{
    onPress();
	txt_accd_tmp.SetDataText( txt_ACCD.GetData() + ';' + lst_TCO_EOCOMPANY_PK.GetData());
	//dso_sel_abacctitem.Call("SELECT");
}
function onPress()
{
   CheckKey();
   txt_ACCD.text =  txt_ACCD1.GetData() + txt_ACCD2.GetData() + txt_ACCD3.GetData() + txt_ACCD4.GetData() + txt_ACCD5.GetData() + txt_ACCD6.GetData() + txt_ACCD7.GetData() + txt_ACCD8.GetData() + txt_ACCD9.GetData() + txt_ACCD10.GetData() + txt_ACCD11.GetData();
}
function Ac_CodeEnter()
{
    onPress();
	txt_accd_tmp.SetDataText( txt_ACCD.GetData() + ';' + lst_TCO_EOCOMPANY_PK.GetData());
	//dso_sel_abacctitem.Call("SELECT");
}
//--------------------------------------------------------------
</script>

<body style="margin: 0; padding: 0;">
    <gw:data id="dso_sel_tree_account" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="tree" parameter="0,1" function="ACNT.sp_sel_acc_tree_local">
                <input bind="oTreeAcCODE" >
                    <input bind="lst_TCO_EOCOMPANY_PK"/>
                    <input bind="idUSE_DT"/>
                </input>
                <output bind="oTreeAcCODE" />
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_upd_acc_entry" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36" function="acnt.sp_sel_gfnt00050" procedure = "acnt.sp_upd_gfnt00050">
              <inout> 
                <inout bind="txt_PK"/>
                <inout bind="txt_Parent_pk_hide" />
                <inout bind="rb_AC_LEVEL" />
                <inout bind="txt_ACCD" />
                <inout bind="txt_ACNM" />
                <inout bind="txt_ACSNM" />
                <inout bind="txt_ACLNM" />
                <inout bind="txt_ACKNM" />
                <inout bind="rb_CARRY_YN" />
                <inout bind="rb_DRCR_TYPE" />
                <inout bind="rb_LEAF_YN" />
                <inout bind="rb_USE_YN" />
                <inout bind="txt_Description" />
                <inout bind="txt_LDescription" />
                <inout bind="txt_KDescription" />
                <inout bind="lstccy" />
                <inout bind="idEnd_DT" />
                <inout bind="lst_TCO_EOCOMPANY_PK" />
                <inout bind="txt_ACCD1" />
                <inout bind="txt_ACCD2" />
                <inout bind="txt_ACCD3" />
                <inout bind="txt_ACCD4" />
                <inout bind="txt_ACCD5" />
                <inout bind="txt_ACCD6" />
                <inout bind="txt_ACCD7" />
                <inout bind="txt_ACCD8" />
                <inout bind="txt_ACCD9" />
                <inout bind="txt_ACCD10" />
                <inout bind="txt_ACCD11" />
                <inout bind="chk_CUST_YN" />
                <inout bind="chk_CUST_REMYN" />
                <inout bind="chk_PL_YN" />
                <inout bind="chk_BUDGET_YN" />
                <inout bind="chk_BGCON_YN" />  
                <inout bind="chk_Emp_YN" />
                <inout bind="chk_Bank_YN" />
                <inout bind="chk_off_YN" />
              </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------------------->
    <gw:data id="datAccCode_Name" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="3" type="process" procedure="ACNT.sp_sel_get_acc_codename_entry" >
            <input>
                <input  bind="txt_PK" />
            </input>
            <output>
                <output  bind="txt_PAC_PK" />
                <output  bind="txt_PAC_CD" />
                <output  bind="txt_PAC_NM" />                              
            </output>
        </dso>                    
    </xml>
</gw:data>
    <!---------------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_upd_acc_code_inquiry" onreceive="On_Change_Color()">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34" function="acnt.sp_sel_gfnt00050_1" procedure = "acnt.sp_upd_gfnt00050_1">
                <input bind="idGrid" >
                    <input bind="lstCompany"/>
                    <input bind="txtAcc_cd"/>
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------------------------------------------->
    <gw:tab id="idTab" onclick="return checkValue(this)">
<form name="Account Code Entry" id="Acc_Entry" type="hidden" onkeypress="return Acc_Entry_onkeypress()">
<table border="1" cellpadding=0 cellspacing=0 width="100%" id="table2" >
	<tr>
		<td id="left" width="30%" valign=top>
		    <table border="0" cellpadding=0 cellspacing=0 width="100%">
		    <tr>
			    <td colspan="3">
				    <fieldset style="padding: 2">
				     <table border="0" cellpadding=0 cellspacing=0 width="100%">
					    <tr>
					       <td width="20%">Company</td>
					       <td width="80%" colspan=2><gw:list id="lst_TCO_EOCOMPANY_PK" styles="width:100%" onchange="OnSearch()"></gw:list ></td>
					    </tr>
					    <tr>
						    <td width="20%" align="center">Date</td>
					        <td width="75%"><gw:datebox id="idUSE_DT" maxlen="10"   styles='width:100%'  lang="<%=Session("Lang")%>"/> </td>
						    <td width="5%"><gw:imgBtn   id="idSearch" img="search"  alt="search"        onclick="OnSearch()"/> </td>
				       </tr>
				    </table>
			       </fieldset>
			    </td>
		    </tr>
		    <tr>
		        <td  width="100%" colspan=3><gw:tree id="oTreeAcCODE" align="top" style="width:100%; height:427; overflow:auto;" onclicknode="OnTreeClick()" ></gw:tree> </td>
	        </tr>
	    </table>	
      </td>
	  <td id="right" width="70%"  valign=top>
		<table border="0" cellpadding=0 cellspacing=0 width="100%" id="table3">
			<tr>
				<td width="20%"><a title="Click here to select Upper account code" onclick="Popup_Search()" href="#tips"
                                                        style="text-decoration: none; color=#0000ff"><b>Upper account code</b></a></td>
				<td width="20%"><gw:textbox id="txt_PAC_CD"  text="" 		maxlen = "11" styles='width:100%'/></td>
				<td width="45%"><gw:textbox id="txt_PAC_NM"  text=""  	    maxlen = "100" 	styles='width:100%'/> </td>
				<td width="1%"><gw:imgBtn id="bt_ResetUpper"      img="reset"     alt="Reset"     onclick="Reset_Upper()" /> </td>
				<td><gw:imgBtn img="new"     alt="New"     id="idBtnAdd" 		styles='width:100%' onclick="OnAdd()" /> </td>					
		        <td><gw:imgBtn img="save"    alt="Save"    id="idBtnUpdate" 	styles='width:100%' onclick="OnSave()" /> </td>
		        <td><gw:imgBtn img="delete"  alt="Delete"  id="idBtnDelete" 	styles='width:100%' onclick="OnDelete()" /> </td>  
		        <td><gw:imgBtn img="printer" alt="Print"   id="ibtnPrint" 		styles='width:100%'	onclick="OnPrint()" /> </td>
				    
			</tr>
			<tr>
			    <td   width="20%"><a title="Click here to select Account Code" onclick="Popup_Search_Child()" href="#tips"  style="text-decoration: none; color=#0000ff"><b>Account Code</b></a></td>
				<td width="40%" colspan=2>
                    <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
                        <tr>
	                        <td width="45%" colspan=3><gw:textbox id="txt_ACCD"   text="" styles='width:100%' onkeypress="CheckKey()" onenterkey="Ac_CodeEnter()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD1"  text="" styles='width:100%' onblur="Ac_CodeEnter1()" onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD2"  text="" styles='width:100%' onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onblur="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD3"  text="" styles='width:100%' onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onblur="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                       <td width="15%" colspan=2><gw:textbox id="txt_ACCD4"  text="" styles='width:100%' onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onblur="Ac_CodeEnter1()" csstype="mandatory"/> </td>
    	                  
                        </tr>
                        <tr>
                            
	                        <td width="15%"><gw:textbox id="txt_ACCD5"  text="" styles='width:100%' onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onblur="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD6"  text="" styles='width:100%' onkeypress="CheckKey()" onenterkey="Ac_CodeEnter()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD7"  text="" styles='width:100%' onblur="Ac_CodeEnter1()" onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD8"  text="" styles='width:100%' onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onblur="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD9"  text="" styles='width:100%' onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onblur="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD10"  text="" styles='width:100%' onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onblur="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                        <td width="15%"><gw:textbox id="txt_ACCD11"  text="" styles='width:100%' onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onblur="Ac_CodeEnter1()" csstype="mandatory"/> </td>
	                        <td width="5%" align=right><gw:imgBtn id="ibtnResetClient"  img="reset" alt="Reset"     onclick="Reset_Upper_Acc()"/> </td>
    	                  
                        </tr>
                    </table>
			    </td>
			     <td colspan=2 align=right >Level</td>
			    <td colspan=3 ><gw:list id="rb_AC_LEVEL" /></td>
		    </tr>
		    <tr>
				<td  width="25%">Account Name</td>
				<td width="40%" colspan=2>
                    <gw:textbox id="txt_ACNM"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/>
				</td>
				<td colspan=3 align=right ><gw:checkbox id="rb_USE_YN" onchange="OnChange_rb_USE_YN()"  value="Y" defaultvalue="Y|N"/></td>
				<td  align="right"  colspan="2">Active</td>
			</tr>
			<tr>
				<td  width="25%">Shorted Account Name</td>
				<td width="40%" colspan=2>
					<gw:textbox id="txt_ACSNM"  maxlen = "100" text="" styles='width:100%'  onkeypress="CheckKey()" csstype="mandatory"/> 
				</td>
				<td colspan=5  rowspan=2 >
			             <fieldset style="padding: 2;">
	                     <legend>Currency</legend>
                        <gw:list id="lstccy"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/> 
                        </fieldset>
                </td>
			</tr>
			<tr>
				<td  width="25%">Local Account Name</td>
				<td width="40%" colspan=2>
				<gw:textbox id="txt_ACLNM" maxlen = "100" text="" styles='width:100%'  onkeypress="CheckKey()" type = ''/>
				</td>
				<td colspan=5 align=right ></td>
			</tr>
			<tr>
				<td width="25%">Korean Account Name</td>
				<td width="40%" colspan=2>
					<gw:textbox id="txt_ACKNM" maxlen = "100" text="" styles='width:100%' type = ''/> 
				</td>
			
                <td colspan=5  rowspan=2 >
			       <fieldset style="padding: 2;">
	                     <legend>Balance Type</legend>
                        <gw:list id="rb_DRCR_TYPE"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/> 
                         </fieldset>
                </td>
			</tr>
			<tr>
				<td width="25%">Description</td>
				<td width="40%" colspan=2>
					<gw:textarea id="txt_Description" row=2  text="" styles='width:100%' type = ''/> 
				</td>
				<td colspan=5 align=right >
				</td>
			</tr>
			<tr>
				<td width="25%">Local Description</td>
				<td width="40%" colspan=2>
					<gw:textarea id="txt_LDescription" row=2  text="" styles='width:100%' type = ''/> 
				</td>
				<td colspan=5>
				      <fieldset style="padding: 2;">
	                     <legend>Posting/ Summary</legend>
                        <gw:list id="rb_LEAF_YN"   styles='width:100%' onchange="OnChangPosSum()"  csstype="mandatory" /> 
                       </fieldset>
				</td>
			</tr>
			<tr>
				<td width="25%">Korea Description</td>
				<td width="40%" colspan=2>
					<gw:textarea id="txt_KDescription" row=2  text="" styles='width:100%' type = ''/> 
				</td>
				<td colspan=5 >
				    <fieldset style="padding: 2;">
	                     <legend>Report Type</legend>
                        <gw:list id="rb_CARRY_YN"   styles='width:100%'   csstype="mandatory"/> 
                      </fieldset>
				</td>
			</tr>
			<!--<tr valign="top">
		                    <td colspan="8">
		                    <fieldset>
		                        <table width="100%" cellpadding = "0" cellspacing = "0" border = "0" >
		                            <tr>
		                                <td width="5%"><gw:checkbox id="chk_CUST_YN"  value="Y" defaultvalue="Y|N" onclick="OnChange_Rem()"/></td>
							            <td width="20%" align="left">Customer</td>
							            <td width="40%" colspan="3"></td>
							            <td width="30%" align="right" colspan="2"><gw:checkbox id="chk_CUST_REMYN"  value="Y" defaultvalue="Y|N" onclick="OnChange_Rem()"/> Customer Bal</td>
		                            </tr>
		                            <tr>
		                                <td width="5%"><gw:checkbox id="chk_PL_YN"  value="Y" defaultvalue="Y|N" onclick="OnChange_PL()"/></td>
							            <td width="7%" align="left" colspan="2">Profit/Cost Center</td>
							            <td width="53%" colspan="2"></td>
							            <td width="30%" align="right" colspan="2"><gw:checkbox id="chk_BUDGET_YN"  value="Y" defaultvalue="Y|N"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Budget</td>
		                            </tr>
		                            <tr>
		                                <td width="5%"><gw:checkbox id="chk_BGCON_YN"  value="Y" defaultvalue="Y|N"/> </td>
							            <td width="20%" align="left">Budget Control</td>
							            <td width="40%" colspan="3"></td>
							            <td width="20%" align="right"><gw:checkbox id="chk_Emp_YN"  value="Y" defaultvalue="Y|N"/>&nbsp;&nbsp;&nbsp;Emp Control</td>
		                            </tr>
		                            <tr>
		                                <td width="5%"><gw:checkbox id="chk_Bank_YN"  value="Y" defaultvalue="Y|N"/> </td>
							            <td width="20%" align="left">Bank Control</td>
							            <td width="40%" colspan="2"></td>
							            <td width="20%" align="right" colspan="3"><gw:checkbox id="chk_off_YN"  value="I" defaultvalue="O|I"/> Off Balance sheet account </td>
		                            </tr>
		                        </table>
		                        </fieldset>
		                   </td>
		                </tr>-->
		</table>
		</td>
	</tr>
</table>   
 <!---------------------------------------------------------------------------------------------------------------->

    </form>

    <form name="Account Code Inquiry"   id="Acc_Inquiry"    type="hidden">
        
        <table width = "100%" border = "1" cellpadding = "1" cellspacing = "0">
            <tr>
                <td>
                    <table width = "100%" border = "0" cellpadding = "0" cellspacing = "0">
                        <tr>
                            <td align="center" width="5%"> Company</td>
                            <td width="20%"><gw:list id="lstCompany" styles='width:100%'></gw:list> </td>
                            <td width="5%" align="center"> Account</td> 
                            <td width="25%">
                                <table width = "100%" border = "0" cellpadding = "0" cellspacing = "0">
                                    <tr>
                                        <td width="25%"><gw:textbox id="txtAcc_cd" styles='width:100%' onkeypress="CheckNumeric()" onenterkey="OnSearchAcc(0)"/> </td>
                                        <td width="65%"><gw:textbox id="txtAcc_nm" styles='width:100%'/> </td>
                                        <td width="0%"><gw:textbox  id="txtAcc_pk" styles='display:none'/> </td>
                                        <td width="5%"><gw:imgBtn img="popup"	id="idSearchP" alt="Popup" onclick="Popup_Search_Inquiry()"/> </td> 
                                        <td width="5%"><gw:imgBtn img="reset"	id="idReset"  alt="Reset"  onclick="Reset_Acc_Inquiry()"/> </td>
                                    </tr>
                                </table>   
                           </td>       
                            <td width="15%">
                                <table width = "100%" border = "0" cellpadding = "0" cellspacing = "0">
                                    <tr>
                                        <td width="70%"> </td>
                                        <td width="5%"><gw:imgBtn img="refresh"     id="idBtnRefresh"	    alt="Refresh"       onclick="OnRefressInquiry()" /> </td>
                                        <td width="5%"><gw:imgBtn img="search"		id="idSearchInq"  		alt="Search" 		onclick="OnSearchInquiry()"/> </td>
                                        <td width="5%"><gw:imgBtn img="new"    		id="idBtnAddInq" 		alt="New"    		onclick="OnNewInquiry()" /> </td>
                                        <td width="5%"><gw:imgBtn img="save"    	id="idBtnUpdateInq" 	alt="Save"   		onclick="OnSaveInquiry()" /> </td>
                                        <td width="5%"><gw:imgBtn img="delete"  	id="idBtnDeleteInq" 	alt="Delete"  		onclick="OnDelInquiry()" /> </td>
                                        <td width="5%"><gw:imgBtn img="printer"  	id="idBtnPrintInq" 	    alt="Report"  		onclick="onReportInquiry()" /> </td>
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
                            header  ="_PK|UpperAc.Code|Ac.Code|Account Name|Short Account Name|Local Account Name|Korean Account Name|AC_Type|AC_Level|Balance Type(Dr/CR)|Leaf_YN|Description|Description1|Description2|Ccy|_TCO_COMPANY_PK|AC_CD1|AC_CD2|AC_CD3|AC_CD4|AC_CD5|AC_CD6|AC_CD7|AC_CD8|AC_CD9|AC_CD10|AC_CD11|_Cust_YN|_Cust_RemYN|_PL_YN|_Budget_YN|_Bgcon_YN|_Emp_YN|_Bank_YN|_AC_Table_IO"
                            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|3"
                            aligns  ="0|1|1|0|0|0|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                            defaults="||||||||||||||||||||||||||||||||||"
                            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"
                            widths  ="0|1600|1600|4000|4500|2500|2500|1000|1000|2000|800|2500|2500|2500|1000|500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
                            styles  ="width:100%; height:445" />
                       </td>
                    </tr>                
                </table>
           </td>            
        </tr>
    </table> 

    </form>
</gw:tab>
    <!--img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif" style="cursor: hand;
        position: absolute; left: 1; top: 20;" onclick="OnToggle('')" /-->
    <gw:textbox id="txt_PK" style="display: none" />
    <gw:textbox id="txt_AC_GRP" style="display: none" />
    <gw:textbox id="txt_PAC_PK" style="display: none" />
    <gw:textbox id="txt_AC_LEVEL_TMP" style="display: none" />
    <gw:textbox id="txt_LEAF_YN_TMP" style="display: none" />
    <gw:textbox id="txt_DRCR_TYPE_TMP" style="display: none" />
    <gw:textbox id="txt_CARRY_YN_TMP" style="display: none" />
    <gw:textbox id="txt_CUST_YN_TMP" style="display: none" />
    <gw:textbox id="txt_CUST_REMYN_TMP" style="display: none" />
    <gw:textbox id="txt_PL_YN_TMP" style="display: none" />
    <gw:textbox id="txt_PL_TYPE_TMP" style="display: none" />
    <gw:textbox id="txt_BUDGET_YN_TMP" style="display: none" />
    <gw:textbox id="txt_BUDGET_TYPE_TMP" style="display: none" />
    <gw:textbox id="txt_BGCON_YN_TMP" style="display: none" />
    <gw:textbox id="txt_AC_TYPE_TMP" style="display: none" />
    <gw:textbox id="txt_AC_GRP_TMP" style="display: none" />
    <gw:textbox id="txt_Duplicate" style="display: none" />
    <gw:textbox id="txt_accd_tmp" style="display: none" />
    <gw:textbox id="txt_Child" style="display: none" />
    <gw:textbox id="txt_Parent_PK" style="display: none" />
    <gw:textbox id="txt_level" style="display: none" />
    <gw:textbox id="txt_possum" style="display: none" />
    <gw:textbox id="txt_lang" maxlen="100" styles='width:100%;display:none' />
    <gw:datebox id="idEnd_DT" mode="01" nullaccept="T" style="display: none" />
    <gw:datebox id="idEnd_GetDT" style="display: none" />
    <gw:textbox id="txt_Company_PK" style="display:none"/>
    <gw:textbox id="txt_ComPK1" style="display:none"/>
    <gw:textbox id="txt_Parent_pk_hide" style="display:none"/>
    
    <gw:checkbox id="chk_CUST_YN"  value="Y" defaultvalue="Y|N" onclick="OnChange_Rem()" style="display: none"/>
    <gw:checkbox id="chk_CUST_REMYN"  value="Y" defaultvalue="Y|N" onclick="OnChange_Rem()"style="display: none"/>
    <gw:checkbox id="chk_PL_YN"  value="Y" defaultvalue="Y|N" onclick="OnChange_PL()" style="display: none"/>
    <gw:checkbox id="chk_BUDGET_YN"  value="Y" defaultvalue="Y|N" style="display: none"/>
    <gw:checkbox id="chk_BGCON_YN"  value="Y" defaultvalue="Y|N" style="display: none"/>
    <gw:checkbox id="chk_Emp_YN"  value="Y" defaultvalue="Y|N" style="display: none"/>
    <gw:checkbox id="chk_Bank_YN"  value="Y" defaultvalue="Y|N" style="display: none"/>
    <gw:checkbox id="chk_off_YN"  value="I" defaultvalue="O|I" style="display: none"/>
</body>
</html>