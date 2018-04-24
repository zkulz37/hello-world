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
    txt_Company_PK.text = "<%=Session("COMPANY_PK")%>";
    txt_PAC_CD.SetEnable(false);
    txt_PAC_NM.SetEnable(false);
    bt_ResetUpper.SetEnable(false);
    txtAcc_nm.SetEnable(false);
    txtLnum.SetEnable(false); 
    txtStandnum.SetEnable(false); 
    txtSubnum.SetEnable(false);
    BindingDataList();
    OnSearch();
    //txtac_cd.onfocus();
}
 var Insert   = 'F';
 var Modify   = 'F';
 var Delete = 'F';
function BindingDataList()
{ 
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
    idGrid.SetComboFormat(14,data);
    data1 ="#D;Debit|#C;Credit"; 
    idGrid.SetComboFormat(15,data1);
    data2 ="#Y;Posting|#N;Summary"; 
    idGrid.SetComboFormat(16,data2);
}

function OnSearch()
{
    dso_sel_tree_account.Call("SELECT");
}
function OnTreeClick()
{
	var obj = event.srcElement.GetCurrentNode();
	txt_PK.text = obj.oid;
	Insert   = 'F';
	Modify   = 'F';
	Delelete = 'F';
	dso_upd_acc_entry_IFRS.Call("SELECT");
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
			
		}
	}
}
function Popup_Search_Child()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txtac_cd.SetDataText( o[0] );
			txtac_nm.SetDataText( o[1] );
			txtac_pk.SetDataText( o[3] );
		}
	}
}
function Popup_Search_Inquiry()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txtAcc_cd.SetDataText( o[0] );
			txtAcc_nm.SetDataText( o[1] );
			//txtac_pk.SetDataText( o[3] );
		}
	}
}
function Popup_Search_StandardCode()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=acnt.sp_sel_acct_popup_gfnt60";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txt_StandACCD.SetDataText( o[0] );
			txt_StandACNM.SetDataText( o[1] );
			txt_StandACPK.SetDataText( o[3] );
			Ac_CodeEnter1();
		}
	}
}
function Popup_Search_LocalCode()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=acnt.sp_sel_acct_popup_gfnt60_1";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txt_LocalACCD.SetDataText( o[0] );
			txt_LocalACNM.SetDataText( o[1] );
			txt_LocalACPK.SetDataText( o[3] );
			txtac_nm.SetDataText( o[1] );//get Acc Code
		}
	}
}
function Popup_Search_SubCode()
{
    /*var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=acnt.sp_sel_acct_popup_gfnt60_2";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txt_SubACCD.SetDataText( o[0] );
			txt_SubACNM.SetDataText( o[1] );
			txt_SubACPK.SetDataText( o[3] );
			Ac_CodeEnter1();
		}
	}*/
	var fpath = System.RootURL + "/form/gf/nt/gfnt00061.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=acnt.sp_sel_acct_popup_gfnt60_2";
    o = System.OpenModal( fpath , 620 , 580 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txt_SubACCD.SetDataText( o[0] );
			txt_SubACNM.SetDataText( o[1] );
			txt_SubACPK.SetDataText( o[3] );
			Ac_CodeEnter1();
		}
	}
}
function Popup_Search_ControlItem()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lst_TCO_EOCOMPANY_PK.GetData() + "&dsqlid=ACNT.sp_sel_acct_popup_gfnt60_3";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
	if (o != null)
	{
		if(o[0] != 0)
		{
			txt_ControlACCD.SetDataText( o[0] );
			txt_ControlACNM.SetDataText( o[1] );
			txt_ControlACPK.SetDataText( o[3] );
			Ac_CodeEnter1();
		}
	}
}
/*function Reset_Upper()
{
    txt_PAC_PK.text="";
    txt_PAC_CD.text="";
    txt_PAC_NM.text="";
}
function Reset_Acc()
{
    txtac_cd.text="";
    txtac_nm.text="";
    txtac_pk.text="";
}*/
function Acc_Entry_onkeypress() {

}
function OnDataReceive(obj)
{
    if(obj.id == 'dso_upd_acc_entry_IFRS')
    {
        if((Insert=='T') || (Delete=='T'))
        {
           
            if(Delete=='T')
            {
                txt_PAC_CD.text = '';
                txt_PAC_NM.text = '';
               
            }
           
                dso_sel_tree_account.Call("SELECT"); 
                Insert = 'F';
                Delete = 'F';
           
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
        txt_PAC_CD.SetDataText(txtac_cd.GetData());
        txt_PAC_NM.SetDataText(txtac_nm.GetData());
        bt_ResetUpper.SetEnable(false);
        ClearData();
        //DT_system.setText("");
        //alert("truoc");
        var p_pk =  txt_PK.GetData();
        var company_pk  =  txt_Company_PK.GetData();
        
        dso_upd_acc_entry_IFRS.StatusInsert();
        
        txt_Parent_pk_hide.text = p_pk;
        txt_ComPK1.text = company_pk ;
        //alert("sau");
        rb_USE_YN.SetDataText("Y");
        rb_LEAF_YN.SetDataText("Y");	
    }
    
    
}
function ClearData()
{
    txtac_cd.text="";
    txtac_nm.text="";
    txt_ACSNM.text="";
    txt_ACLNM.text="";
    txt_ACKNM.text="";
    txt_Description.SetDataText("");
    txt_LDescription.SetDataText("");
    txt_KDescription.SetDataText("");
}
function OnSave()
{
    dso_upd_acc_entry_IFRS.Call();
    Insert   = 'T';
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
	        Delete = 'T';
	        dso_upd_acc_entry_IFRS.StatusDelete();
		    dso_upd_acc_entry_IFRS.Call();
		}
    }
}
function On_Change_Color()
{
    var ctrl 	= idGrid.GetGridControl();
	for (i=1; i<ctrl.Rows; i++)
    {
        if((idGrid.GetGridData(i,8)== "0") || (idGrid.GetGridData(i,8)== "1") || (idGrid.GetGridData(i,8)== "2"))
        {
            idGrid.SetCellBold(i,1,i,15,true);
        }
        else
        {   
            idGrid.SetCellBold(i,1,i,15,false);
        }
        
        if (idGrid.GetGridData(i,8)== "1")
        {
            idGrid.SetCellBgColor(i,0,i,15, Number('0X99CCFF'));
        }
        else if (idGrid.GetGridData(i,8)== "2")
        {
            idGrid.SetCellBgColor(i,0,i,15, Number('0XCCFFCC'));
        }
        else if (idGrid.GetGridData(i,9)== "3")
        {
            idGrid.SetCellBgColor(i,0,i,15, Number('0XEFFFFF'));
        }
        else if (idGrid.GetGridData(i,8)== "0")
        {
            idGrid.SetCellBgColor(i,0,i,15, Number('0XF4E6E0'));
        }
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

/*function OnCheckInquiry()
{
    var ctrl 	= idGrid.GetGridControl();
	var i;
	var j;
	var codei;
	
	i = 1;
	while (i < ctrl.Rows)
    {
        if(Trim(idGrid.GetGridData(i, 0)) != "")  return true;
        
        codei = idGrid.GetGridData(i, 1);
        if (codei == '')
        {
            alert('   Upper Account Code in row '+ i +' is not null. Please check again!!!'+'\n'+'Tài khoản cấp cha ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        return false;
        }
        codei = idGrid.GetGridData(i, 2);
        if (codei == '')
        {
            alert('   Account Code in row '+ i +' is not null. Please check again!!!'+'\n'+'Account Code ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        return false;
        }
        codei = idGrid.GetGridData(i, 3);
        if (codei == '')
        {
            alert('     Account name in row '+ i +' is not null. Please check again!!!'+'\n'+'Account name ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        return false;
        }
        codei = idGrid.GetGridData(i, 6);
        if (codei == '')
        {
            alert('     Balance Type(Dr/CR) in row '+ i +' is not null. Please check again!!!'+'\n'+'Loại tài khoản (Nợ/Có) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        return false;
        }
        codei = idGrid.GetGridData(i, 7);
        if (codei == '')
        {
            alert('      Posting/Summary in row '+ i +' is not null. Please check again!!!'+'\n'+'Cấp độ(nút lá/gốc) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        return false;
        }
        codei = idGrid.GetGridData(i, 8);
        if (codei == '')
        {
            alert('                   Report Type(Profit & Loss) in row '+ i +' is not null. Please check again!!!'+'\n'+'Loại tài khoản dùng cho báo cáo(Balance/Profit & Loss) ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        return false;
        }
        codei = idGrid.GetGridData(i, 9);
        if (codei == '')
        {
            alert('      Level in row '+ i +' is not null. Please check again!!!'+'\n'+'Cấp tài khoản ở dòng '+ i +' không được rỗng. Bạn hãy kiểm tra lại!!!');
	        return false;
        }
        i = i + 1;
    }
    
	i = 1;
	if (ctrl.Rows > 2)
	{
	    while (i < ctrl.Rows - 1)
	    {
	        j = i + 1;
	        var codej;
	        codei = idGrid.GetGridData(i, 2);
	        while (j < ctrl.Rows)
	        {
	            codej = idGrid.GetGridData(j, 2);
	            if (codei == codej)
	            {
	                alert('  Account Code in row '+ j +' exists. Please check again!!!'+'\n'+'Account Code ở dòng '+ j +' đã tồn tại. Bạn hãy kiểm tra lại!!!')
	                return false;
	            }
	            j = j + 1;
	        }
	        i = i + 1;
        }
    }
	return true;
}*/
function OnSaveInquiry()
{
    var ctrl 	= idGrid.GetGridControl();
    /*if (!OnCheckInquiry())
    {
        return;
    }*/
    for (i=1; i < ctrl.Rows; i++ )
	{
	    if (idGrid.GetGridData(i, 15) == '')
	    {
	        idGrid.SetGridText(i, 18, txt_Company_PK.GetData());
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
					        dso_upd_acc_code_inquiry.Call();
			            }
		            }
		        }
            }
        }
	}
}
function OnSearchInquiry()
{
    dso_upd_acc_code_inquiry.Call("SELECT");
}
function checkValue()
{
    //ACNT.sp_sel_acc_tree_local            ACNT.sp_sel_acc_tree_gfnt60
}
function Ac_CodeEnter1()
{
    //txt_StandACCD.focus();
    onPress();
	txt_accd_tmp.SetDataText( txtac_cd.GetData() + ';' + lst_TCO_EOCOMPANY_PK.GetData());
	//dso_sel_abacctitem.Call("SELECT");
}
function onPress()
{
//   CheckKey();
////   if(chkActive1.value=='Y' && chkActive2.value=='Y')
////   {
//        txtac_cd.text =  txt_StandACCD.GetData() + txt_SubACCD.GetData();
////   }
////   else if(chkActive.value=='Y' && chkActive2.value=='Y')
////   {
////        txtac_cd.text =  txt_LocalACCD.GetData() + txt_SubACCD.GetData();
////   }
}
function OnChange_chk_YN()
{
   if(chkActive.value=='N')
   {
       txtLnum.SetEnable(false);
       txtLnum.text=""; 
   }
   else
   {
        txtLnum.SetEnable(true);
   }
   if(chkActive1.value=='N')
   {
         txtStandnum.SetEnable(false); 
         txtStandnum.text="";
   }
   else
   {
        txtStandnum.SetEnable(true);
   }
   if(chkActive2.value=='N')
   {
        txtSubnum.SetEnable(false); 
        txtSubnum.text="";
   }
   else
   {
        txtSubnum.SetEnable(true);
   }
   if(chkActive.value=='Y' && chkActive1.value=='Y')
   {
        txtac_cd.text =  txt_LocalACCD.GetData() + txt_StandACCD.GetData();
   }
   else if(chkActive1.value=='Y' && chkActive2.value=='Y')
   {
        txtac_cd.text =  txt_StandACCD.GetData() + txt_SubACCD.GetData();
   } 
   else if(chkActive.value=='Y' && chkActive2.value=='Y')
   {
        txtac_cd.text =  txt_LocalACCD.GetData() + txt_SubACCD.GetData();
   } 
   
   else if(chkActive.value=='N' && chkActive1.value=='Y')
   {
        txtac_cd.text =   txt_StandACCD.GetData();
   }
   else if(chkActive.value=='Y' && chkActive1.value=='N')
   {
        txtac_cd.text =  txt_LocalACCD.GetData();
   }
   
   else if(chkActive1.value=='N' && chkActive2.value=='Y')
   {
        txtac_cd.text =  txt_SubACCD.GetData();
   }
    else if(chkActive1.value=='Y' && chkActive2.value=='N')
   {
        txtac_cd.text =  txt_StandACCD.GetData();
   }
   
   else if(chkActive.value=='N' && chkActive2.value=='Y')
   {
        txtac_cd.text =  txt_SubACCD.GetData();
   }
   else if(chkActive.value=='Y' && chkActive2.value=='N')
   {
        txtac_cd.text =  txt_LocalACCD.GetData();
   }
   if(chkActive.value=='Y' && chkActive1.value=='Y' && chkActive2.value=='Y')
   {
        txtac_cd.text = txt_LocalACCD.GetData()+ txt_StandACCD.GetData()+ txt_SubACCD.GetData();
   }
   else if(chkActive.value=='N' && chkActive1.value=='N' && chkActive2.value=='N')
   {
        txtac_cd.text = "";
   }
}
function GetTexts()
{
    //txt1 && txt2
    if(txtLnum.GetData() == "1" && txtStandnum.GetData()=="2" && txtSubnum.GetData() == "3")
    {
        txtac_cd.text = txt_LocalACCD.GetData()+ txt_StandACCD.GetData() + txt_SubACCD.GetData();
    }
    else if(txtLnum.GetData() == "1" && txtStandnum.GetData()=="3" && txtSubnum.GetData() == "2")
    {
        txtac_cd.text = txt_LocalACCD.GetData()+ txt_SubACCD.GetData()+ txt_StandACCD.GetData();
    }
     else if(txtLnum.GetData() == "2" && txtStandnum.GetData()=="1" && txtSubnum.GetData() == "3")
    {
       txtac_cd.text = txt_StandACCD.GetData() + txt_LocalACCD.GetData()+  txt_SubACCD.GetData();
    }
    else if(txtLnum.GetData() == "2" && txtStandnum.GetData()=="3" && txtSubnum.GetData() == "1")
    {
       txtac_cd.text = txt_SubACCD.GetData()+ txt_LocalACCD.GetData()+ txt_StandACCD.GetData();
    }
    else if(txtLnum.GetData() == "3" && txtStandnum.GetData()=="1" && txtSubnum.GetData() == "2")
    {
        txtac_cd.text =  txt_StandACCD.GetData()+ txt_SubACCD.GetData() + txt_LocalACCD.GetData();
    }
     else if(txtLnum.GetData() == "3" && txtStandnum.GetData()=="2" && txtSubnum.GetData() == "1")
    {
        txtac_cd.text = txt_SubACCD.GetData()+ txt_StandACCD.GetData() + txt_LocalACCD.GetData();
    }
    // xu ly 2 txt
     else if(txtLnum.GetData() == "1" && txtStandnum.GetData()=="2" )
    {   
        txtac_cd.text = txt_LocalACCD.GetData()+ txt_StandACCD.GetData();
    }
     else if(txtLnum.GetData() == "2" && txtStandnum.GetData()=="1" )
    {
        txtac_cd.text = txt_StandACCD.GetData() + txt_LocalACCD.GetData();
    }
    // xu ly 2 txt
     else if(txtStandnum.GetData()=="1" && txtSubnum.GetData() == "2")
    {
        txtac_cd.text = txt_StandACCD.GetData()+txt_SubACCD.GetData();
    }
     else if(txtLnum.GetData() == "2" && txtStandnum.GetData()=="1")
    {
        txtac_cd.text = xt_StandACCD.GetData()+ txt_LocalACCD.GetData();
    }
    // xu ly 2 txt
     else if(txtLnum.GetData() == "1" && txtSubnum.GetData() == "2")
    {
        txtac_cd.text = txt_LocalACCD.GetData()+ txt_SubACCD.GetData();
    }
     else if(txtLnum.GetData() == "2" && txtSubnum.GetData() == "1")
    {
        txtac_cd.text = txt_SubACCD.GetData() + txt_LocalACCD.GetData();
    }
}
function CheckKey() 
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
function ResetPopup(obj)
{
    switch(obj)
	{
		case '0':
			txt_PAC_CD.text="";
            txt_PAC_NM.text="";
            txt_PAC_PK.text="";
		break ;
		case '1':
			txt_LocalACCD.text = '';
			txt_LocalACNM.text = '';
			txt_LocalACPK.text = '' ;
		break ;
		case '2':
			txt_StandACCD.text = '';
			txt_StandACNM.text = '';
			txt_StandACPK.text = '';
		break ;
		case '3':
			txt_SubACCD.text = "";
			txt_SubACNM.text = "";
			txt_SubACPK.text = "";			
		break ;
		case '4':
			txt_ControlACCD.text = '';
			txt_ControlACNM.text = '';
			txt_ControlACPK.text = '';
		break ;
		case '5':
			txtac_cd.text = '';
			txtac_nm.text = '';
			txtac_pk.text = '';
		break ;
	}
}
function onReportInquiry()
{
     var url = '/reports/gf/nt/gfnt00060.aspx?p_com_pk='+ lstCompany.value ;
	        url =   url + '&p_accd=' + txtAcc_cd.text;
	        System.OpenTargetPage( System.RootURL+url , "newform" );
}
function Reset_Acc_Inquiry()
{
    txtAcc_cd.text="";
}
function OnChange_rb_USE_YN()
{
    if(rb_USE_YN.value=="Y")
    {
        DT_system.value="";
    }
    if(rb_USE_YN.value=="N")
    {
        var a=idEnd_GetDT.GetData();
        DT_system.SetDataText(a);
    }
}
//--------------------------------------------------------------
</script>

<body style="margin: 0; padding: 0;">
    <!--------------------------------------Search Tree----------------------------------------------------------------->
<gw:data id="dso_sel_tree_account" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="tree" parameter="0,1" function="ACNT.sp_sel_acc_tree_gfnt60">
                <input bind="oTreeAcCODE" >
                    <input bind="lst_TCO_EOCOMPANY_PK"/>
                    <input bind="idUSE_DT"/>
                    <input bind="txtLocalCodeSearch"/>
                    <input bind="txtStandardCodeSearch"/>
                    <input bind="txtAccountCodeSearch"/>
                </input>
                <output bind="oTreeAcCODE" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_upd_acc_code_inquiry" onreceive="On_Change_Color()">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="ACNT.sp_sel_gfnt00060" procedure = "ACNT.sp_upd_gfnt00060">
                <input bind="idGrid" >
                    <input bind="lstCompany"/>
                    <input bind="txtAcc_cd"/>
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------------------------------------------->
    <gw:data id="datAccCode_Name" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="3" type="process" procedure="ACNT.sp_sel_get_acc_name60" >
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
<!------------------------------------------------------------------------------------------------------->
    <!------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_upd_acc_entry_IFRS" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29" function="ACNT.sp_sel_gfnt00060_1" procedure = "acnt.sp_upd_gfnt00060_1">
              <inout> 
                <inout bind="txt_PK"/>
                <inout bind="txt_Parent_pk_hide" />
                <inout bind="rb_AC_LEVEL" />
                <inout bind="txtac_cd" />
                <inout bind="txtac_nm" />
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
                <inout bind="DT_system" />
                <inout bind="txt_ComPK1" />
                <inout bind="txt_StandACPK" />
                <inout bind="txt_StandACCD" />
                <inout bind="txt_StandACNM" />
                <inout bind="txt_SubACPK" />
                <inout bind="txt_SubACCD" />
                <inout bind="txt_SubACNM" />
                <inout bind="txt_LocalACPK" />
                <inout bind="txt_LocalACCD" />
                <inout bind="txt_LocalACNM" />
                <inout bind="txt_ControlACPK" />
                <inout bind="txt_ControlACCD" />
                <inout bind="txt_ControlACNM" />
              </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------end_tab1---------->
    <gw:tab id="idTab" onclick="return checkValue(this)">
<form name="Account Code Entry" id="Acc_Entry" type="hidden" onkeypress="return Acc_Entry_onkeypress()">
<table border="1" cellpadding=0 cellspacing=0 width="100%" id="table2" >
	<tr>
		<td id="left" width="20%" valign=top>
		    <table border="0" cellpadding=0 cellspacing=0 width="100%">
		    <tr heigh="4%">
			    <td colspan="3">
				    <!--fieldset style="padding: 2"-->
				     <table border="0" cellpadding=0 cellspacing=0 width="100%">
				        <tr>
						    <td width="20%">Date</td>
					        <td width="75%"><gw:datebox id="idUSE_DT" maxlen="10"   styles='width:100%'  lang="<%=Session("Lang")%>"/> </td>
						    <td width="5%"><gw:imgBtn   id="idSearch" img="search"  alt="search"        onclick="OnSearch()"/> </td>
				       </tr>
					    <tr>
					       <td width="20%">Company</td>
					       <td width="80%" colspan=2><gw:list id="lst_TCO_EOCOMPANY_PK" styles="width:100%" onchange="OnSearch()"></gw:list ></td>
					    </tr>
					   
				       <tr>
				            <td>Local Code</td>
				            <td colspan="2"><gw:textbox id="txtLocalCodeSearch" onenterkey="OnSearch()" styles='width:100%'/></td>
				       </tr>
				       <tr>
				            <td>Standard Code</td>
				            <td colspan="2"><gw:textbox id="txtStandardCodeSearch" onenterkey="OnSearch()" styles='width:100%'/></td>
				       </tr>
				       <tr>
				            <td>Account Code</td>
				            <td colspan="2"><gw:textbox id="txtAccountCodeSearch" onenterkey="OnSearch()" styles='width:100%'/></td>
				       </tr>
				        
				    </table>
			       <!--/fieldset-->
			    </td>
		    </tr>
		    <tr  heigh="96%">
		        <td colspan="3">
		        <table border="0" cellpadding=0 cellspacing=0 width="100%">
		        <tr>
		            <td  width="100%" colspan=3><gw:tree id="oTreeAcCODE" align="top" style="width:100%; height:427; overflow:auto;" onclicknode="OnTreeClick()" ></gw:tree> </td>
		        </tr>
		        </table>
		        </td>
	        </tr>
	    </table>	
      </td>
	  <td id="right" width="80%"  valign=top>
		<table border="0" cellpadding=0 cellspacing=0 width="100%" id="table3">
			<tr>
				<td width="20%"></td>
				<td width="26%"></td>
				<td width="44%" align="right"></td>
				<td width="2%"></td>
				<td width="2%"><gw:imgBtn img="new"     alt="New"     id="idBtnAdd" 		styles='width:100%' onclick="OnAdd()" /> </td>					
		        <td width="2%"><gw:imgBtn img="save"    alt="Save"    id="idBtnUpdate" 	styles='width:100%' onclick="OnSave()" /> </td>
		        <td width="2%"><gw:imgBtn img="delete"  alt="Delete"  id="idBtnDelete" 	styles='width:100%' onclick="OnDelete()" /> </td>  
		        <td width="2%"><gw:imgBtn img="printer" alt="Print"   id="ibtnPrint" 		styles='width:100%'	onclick="OnPrint()" /> </td>
				    
			</tr>
			<tr>
			    <td width="20%"><a title="Click here to select Upper account code" onclick="Popup_Search()" href="#tips"
                                                        style="text-decoration: none"; color="#0000ff"><b>Upper account code</b></a></td>
				<td width="25%" colspan="1"><gw:textbox id="txt_PAC_CD"  text="" maxlen = "11" styles='width:100%'/></td>
				<td width="50%" colspan="5"><gw:textbox id="txt_PAC_NM"  text="" maxlen = "100" 	styles='width:100%'/></td>
				<td width="5%"><gw:imgBtn id="bt_ResetUpper" img="reset"  alt="Reset" onclick="ResetPopup('0')" /> </td>
				
			</tr>
			<tr>
			    <td   width="20%"><a title="Click here to select Local Code" onclick="Popup_Search_LocalCode()" href="#tips"  style="text-decoration: none"; color="#0000ff"><b>Local Code</b></a></td>
	            <td width="25%" colspan="1"><gw:textbox id="txt_LocalACCD"   text="" styles='width:100%' onkeypress="CheckKey()" onenterkey="Ac_CodeEnter()" csstype="mandatory"/></td>
	            <td width="35%" colspan="3"><gw:textbox id="txt_LocalACNM"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
	            <td width="5%"><gw:checkbox id="chkActive" onclick="OnChange_chk_YN()"  value="N" defaultvalue="Y|N"/></td>
	            <td width="10%"><gw:textbox id="txtLnum" onchange="GetTexts()" onenterkey="GetTexts()"  styles='width:100%' /></td>
	            <td width="5%"  align = "right"><gw:imgBtn id="ibtnLocalResetClient"  img="reset" alt="Reset"     onclick="ResetPopup('1')"/> </td>
		    </tr>
		     <tr>
			    <td   width="20%"><a title="Click here to select Standard Code" onclick="Popup_Search_StandardCode()" href="#tips"  style="text-decoration: none"; color="#0000ff"><b>Standard Code</b></a></td>
	            <td width="25%" colspan="1"><gw:textbox id="txt_StandACCD"  styles='width:100%' text=""  onblur="Ac_CodeEnter1()" onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onchange="Ac_CodeEnter1()" csstype="mandatory"/></td>
	            <td width="35%" colspan="3"><gw:textbox id="txt_StandACNM"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
	            <td width="5%"><gw:checkbox id="chkActive1" onclick="OnChange_chk_YN()"  value="N" defaultvalue="Y|N"/></td>
	            <td width="10%"><gw:textbox id="txtStandnum" onchange="GetTexts()"  onenterkey="GetTexts()" styles='width:100%' /></td>
	            <td width="5%"  align = "right"><gw:imgBtn id="ibtnStandResetClient"  img="reset" alt="Reset"     onclick="ResetPopup('2')"/> </td>
		    </tr>
		    <tr>
			    <td   width="20%"><a title="Click here to select Sub Code" onclick="Popup_Search_SubCode()" href="#tips"  style="text-decoration: none"; color="#0000ff"><b>Sub Code</b></a></td>
	            <td width="25%" colspan="1"><gw:textbox id="txt_SubACCD" styles='width:100%'  onblur="Ac_CodeEnter1()" onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onchange="Ac_CodeEnter1()" csstype="mandatory"/></td>
	            <td width="50%" colspan="3"><gw:textbox id="txt_SubACNM"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
	            <td width="5%"><gw:checkbox id="chkActive2" onclick="OnChange_chk_YN()"  value="N" defaultvalue="Y|N"/></td>
	            <td width="10%"><gw:textbox id="txtSubnum" onchange="GetTexts()" onenterkey="GetTexts()" styles='width:100%' /></td>
	            <td width="5%"  align = "right"><gw:imgBtn id="ibtnSubResetClient"  img="reset" alt="Reset"     onclick="ResetPopup('3')"/> </td>
		    </tr>
		    <tr>
			    <td   width="20%"><a title="Click here to select Control Item Code" onclick="Popup_Search_ControlItem()" href="#tips"  style="text-decoration: none"; color="#0000ff"><b>Control Item</b></a></td>
	            <td width="25%" colspan="1"><gw:textbox id="txt_ControlACCD" maxlen = "100" text="" styles='width:100%'  onblur="Ac_CodeEnter1()" onkeypress="onPress()" onenterkey="Ac_CodeEnter1()" onchange="Ac_CodeEnter1()" csstype="mandatory"/></td>
	            <td width="50%" colspan="5"><gw:textbox id="txt_ControlACNM"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
	            <td width="5%"  align = "right"><gw:imgBtn id="ibtnControlResetClient"  img="reset" alt="Reset"     onclick="ResetPopup('4')"/> </td>
		    </tr>
			<tr>
			    <td   width="20%"><a title="Click here to select Account Code" onclick="Popup_Search_Child()" href="#tips"  style="text-decoration: none"; color="#0000ff"><b>Account Code</b></a></td>
	            <td width="25%" colspan="1"><gw:textbox id="txtac_cd" onfocus="false"  text="" styles='width:100%' onkeypress="CheckKey()" onenterkey="Ac_CodeEnter()" csstype="mandatory"/></td>
	            <td width="50%" colspan="5"><gw:textbox id="txtac_nm"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
	            <td width="5%"  align = "right"><gw:imgBtn id="ibtnResetClient"  img="reset" alt="Reset"     onclick="ResetPopup('5')"/> </td>
		    </tr>
			<tr>
				<td  width="20%">Shorted Account Name</td>
				<td width="80%" colspan="7">
					<gw:textbox id="txt_ACSNM"  maxlen = "100" text="" styles='width:100%'  onkeypress="CheckKey()" csstype="mandatory"/> 
				</td>
			</tr>
			<tr>
				<td  width="20%">Local Account Name</td>
				<td width="80%" colspan="7">
				<gw:textbox id="txt_ACLNM" maxlen = "100" text="" styles='width:100%'  onkeypress="CheckKey()" type = ''/>
				</td>
			</tr>
			<tr>
				<td width="20%">Korean Account Name</td>
				<td width="80%" colspan="7">
					<gw:textbox id="txt_ACKNM" maxlen = "100" text="" styles='width:100%' type = ''/> 
				</td>
			</tr>
			<tr>
				<td width="20%">Description</td>
				<td width="80%" colspan="7">
					<gw:textarea id="txt_Description" row=2  text="" styles='width:100%' type = ''/> 
				</td>
			</tr>
			<tr>
				<td width="20%">Local Description</td>
				<td width="80%" colspan="7">
					<gw:textarea id="txt_LDescription" row=2  text="" styles='width:100%' type = ''/> 
				</td>
			</tr>
			<tr>
				<td width="20%">Korea Description</td>
				<td width="80%" colspan="7">
					<gw:textarea id="txt_KDescription" row=2  text="" styles='width:100%' type = ''/> 
				</td>
			</tr>
			<tr>
			    <td>Level</td>
			    <td ><gw:list id="rb_AC_LEVEL" /></td>
			    <td  colspan="4" align="center"><gw:checkbox id="rb_USE_YN" onclick="OnChange_rb_USE_YN()"  value="Y" defaultvalue="Y|N"/>Actice</td>
			    <td colspan="2"></td>
			</tr>
			<tr>
			    <td>Currency</td>
			    <td ><gw:list id="lstccy"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
			    <td colspan="2" align="right">Balance Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			    <td colspan="4"><gw:list id="rb_DRCR_TYPE"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
			</tr>
			<tr>
			    <td>Report Type</td>
			    <td ><gw:list id="rb_CARRY_YN"   styles='width:100%'   csstype="mandatory"/></td>
			    <td colspan="2" align="right">Posting/ Summary&nbsp;&nbsp;</td>
			    <td colspan="4"><gw:list id="rb_LEAF_YN"   styles='width:100%' onchange="OnChangPosSum()"  csstype="mandatory" /></td>
			</tr>
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
                                        <td width="25%"><gw:textbox id="txtAcc_cd" styles='width:100%' onenterkey="OnSearchInquiry()"/> </td>
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
                            header  ="_PK|UpperAc.Code|Ac.Code|Account Name|Standard Code|Standard Name|Sub Code|Sub Name|Local Code|Local Name|Short Account Name|Local Account Name|Korean Account Name|AC_Type|AC_Level|Balance Type(Dr/CR)|Leaf_YN|Description|Description1|Description2|Ccy|_TCO_COMPANY_PK"
                            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                            aligns  ="0|1|1|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|0|0|0"
                            defaults="|||||||||||||||||||||"
                            editcol ="0|1|1|1|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1"
                            widths  ="0|1300|1300|4500|2500|2500|2500|2500|2500|2500|4500|2500|2500|2500|2500|2500|2500|2500|2500|2500|1000|500"
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
   <gw:textbox id="txt_PAC_PK" style="display:none"/>
   <gw:textbox id="txt_Parent_PK" style="display:none"/>
   <gw:textbox id="txt_PK" style="display:none"/>
   <gw:textbox id="txt_Company_PK" style="display:none"/>
   <gw:datebox id="DT_system" mode="01" nullaccept="T" maxlen="10" style="display:none"/>
   <gw:textbox id="txt_ComPK1" style="display:none"/>
   <gw:textbox id="txt_Parent_pk_hide" style="display:none"/>
   <gw:textbox id="txt_StandACPK" style="display:none"/>
   <gw:textbox id="txt_LocalACPK" style="display:none"/>
   <gw:textbox id="txt_SubACPK" style="display:none"/>
   <gw:textbox id="txt_ControlACPK" style="display:none"/>
   <gw:textbox id="txt_accd_tmp" style="display: none" />
   <gw:textbox id="txtac_pk" style="display: none" />
   <gw:datebox id="idEnd_GetDT" style="display: none" />
</body>
</html>