<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
<script>
function BodyInit()
{
    txt_Company_PK.text = "<%=Session("COMPANY_PK")%>";
    txt_PAC_CD.SetEnable(false);
    txt_PAC_NM.SetEnable(false);
    BindingDataList();
    OnSearch();
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
function Reset_Upper()
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
}
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
    Insert = 'T';
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
		    dso_upd_acc_entry_IFRS.Call();;
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
	        idGrid.SetGridText(i, 15, txt_Company_PK.GetData());
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
</script>
<body >
<!--------------------------------------Search Tree----------------------------------------------------------------->
<gw:data id="dso_sel_tree_account" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="tree" parameter="0,1" function="acnt.SP_SEL_ACC_TREE_IFRS">
                <input bind="oTreeAcCODE" >
                    <input bind="lst_TCO_EOCOMPANY_PK"/>
                    <input bind="idUSE_DT"/>
                </input>
                <output bind="oTreeAcCODE" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_upd_acc_code_inquiry" onreceive="On_Change_Color()">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="ACNT.sp_sel_gfnt00010" procedure = "ACNT.sp_upd_gfnt00010">
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
        <dso id="3" type="process" procedure="acnt.sp_sel_get_acc_code_name" >
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
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="acnt.sp_sel_gfnt00010_1" procedure = "acnt.sp_upd_gfnt00010_1">
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
              </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------end_tab1---------------------------------------------------------------->
    <gw:tab id="idTab">
<form name="Account Code Entry" id="Acc_Entry" type="hidden" onkeypress="return Acc_Entry_onkeypress()">
<table border="1" cellpadding=0 cellspacing=0 width="100%"   id="table2" >
	<tr>
		<td id="left" width="15%" valign=top>
		    <table border="1" cellpadding=0 cellspacing=0 width="100%">
		    <tr>
			    <td colspan="3">
				    <!--fieldset style="padding: 2"-->
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
			       <!--/fieldset-->
			    </td>
		    </tr>
		    <tr>
		         <!--td  width="100%" colspan=3><gw:tree id="oTreeAcCODE" align="top" style="width:190px; height:427; overflow:auto;" onclicknode="OnTreeClick()" /> </td-->
		        <td  width="100%" colspan=3><gw:tree id="oTreeAcCODE" align="top" style="width:100%;  overflow:auto;" onclicknode="OnTreeClick()" /> </td>
	        </tr>
	    </table>	
      </td>
	  <td id="right" width="85%"   valign=top>
		<table border="0" cellpadding=0 cellspacing=0 width="100%" id="table3">
		   
		    <tr>
		        <td width="12%">Level</td>
		        <td width="22%"><gw:list id="rb_AC_LEVEL" /></td>
				<td width="24%" align="right">Balance Type</td>
				<td width="30%"><gw:list id="rb_DRCR_TYPE"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/></td>
			    <td width="3%" colspan="3"><gw:imgBtn img="new"     alt="New"     id="idBtnAdd" 		styles='width:100%' onclick="OnAdd()" /> </td>					
		        <td width="3%" ><gw:imgBtn img="save"    alt="Save"    id="idBtnUpdate" 	styles='width:100%' onclick="OnSave()" /> </td>
		        <td width="3%" ><gw:imgBtn img="delete"  alt="Delete"  id="idBtnDelete" 	styles='width:100%' onclick="OnDelete()" /> </td>  
		        <td width="3%"><gw:imgBtn img="printer" alt="Print"   id="ibtnPrint" 		styles='width:100%'	onclick="OnPrint()" /> </td>
			</tr>
			<tr>
			    <td width="10%">Currency</td>
			    <td width="20%"><gw:list id="lstccy"  maxlen = "100" text="" styles='width:100%' onkeypress="CheckKey()" csstype="mandatory"/> </td>
			    <td width="10%" align="right">Posting/Summary</td>
			    <td width="20%" colspan="3"><gw:list id="rb_LEAF_YN"   styles='width:100%' onchange="OnChangPosSum()"  csstype="mandatory" /> </td>
		        <td align="right"><gw:checkbox id="rb_USE_YN"  onchange="OnChange_rb_USE_YN()"  value="Y" defaultvalue="Y|N"/></td>
		        <td>Active</td>
			    
			</tr>
			<tr>
		        <td>Report Type</td>
		        <td colspan="9"><gw:list id="rb_CARRY_YN"   styles='width:100%'   csstype="mandatory"/> </td>
		        
		    </tr>
		   
			<tr>
				<td ><a title="Click here to select Upper account code" onclick="Popup_Search()" href="#tips" style="text-decoration: none; color=#0000ff"><b>Upper Acccount Code</b></a></td>
				<td colspan="8"><gw:textbox id="txt_PAC_CD"  styles='width:26%'/><gw:textbox id="txt_PAC_NM"  styles='width:74%'/></td>
				<td ><gw:imgBtn id="bt_ResetUpper"      img="reset"     alt="Reset"     onclick="Reset_Upper()" /> </td>
			</tr>
			
			<tr>
			    <td   width="20%"><a title="Click here to select Account Code" onclick="Popup_Search_Child()" href="#tips"  style="text-decoration: none; color=#0000ff"><b>Account Code</b></a></td>
				<td width="40%" colspan="8">
                    <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
                        <tr>
	                        <td width="100%" ><gw:textbox id="txtac_cd" styles='width:26%' onkeypress="CheckNumeric()" onenterkey="onEnter()"/><gw:textbox id="txtac_nm" styles='width:74%'/></td>
	                        <td width="0%"><gw:textbox  id="txtac_pk" styles='display:none'/></td>
                        </tr>
                    </table>
			    </td>
			    <td ><gw:imgBtn   img="reset"	id="idResetAcc"  alt="Reset" onclick="Reset_Acc()"/></td>
			    
		    </tr>
		     <tr>
		        
		        <td>Shorted Account Name</td>
		        <td colspan="9"><gw:textbox id="txt_ACSNM"  maxlen = "100"  styles='width:100%'  onkeypress="CheckKey()" csstype="mandatory"/> </td>
		    </tr>
			<tr>
				<td  width="25%">Local Account Name</td>
				<td width="40%" colspan="9">
				<gw:textbox id="txt_ACLNM" maxlen = "100"  styles='width:100%'  onkeypress="CheckKey()" type = ''/>
				</td>
			</tr>
			<tr>
				<td width="25%">Korean Account Name</td>
				<td width="40%" colspan="9">
					<gw:textbox id="txt_ACKNM" maxlen = "100"  styles='width:100%' type = ''/> 
				</td>
			</tr>
			<tr>
				<td width="25%">Description</td>
				<td width="40%" colspan="9">
					<gw:textarea id="txt_Description" row=8  styles='width:100%' type = ''/> 
				</td>
			</tr>
			<tr>
				<td width="25%">Local Description</td>
				<td width="40%" colspan="9">
					<gw:textarea id="txt_LDescription" row=8  styles='width:100%' type = ''/> 
				</td>
			</tr>
			<tr>
				<td width="25%">Korea Description</td>
				<td width="40%" colspan="9">
					<gw:textarea id="txt_KDescription" row=8  styles='width:100%' type = ''/> 
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
                            header  ="_PK|UpperAc.Code|Ac.Code|Account Name|Short Account Name|Local Account Name|Korean Account Name|AC_Type|AC_Level|Balance Type(Dr/CR)|Leaf_YN|Description|Description1|Description2|Ccy|_TCO_COMPANY_PK"
                            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                            aligns  ="0|1|1|0|0|0|1|1|1|1|1|1|1|0|0|0"
                            defaults="|||||||||||||||"
                            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"
                            widths  ="0|1300|1300|4500|4500|2500|2500|2500|2500|2500|2500|2500|2500|2500|1000|500"
                            styles  ="width:100%; height:445" />
                       </td>
                    </tr>                
                </table>
           </td>            
        </tr>
    </table> 
    </form>
   </gw:tab>
   <gw:textbox id="txt_PAC_PK" style="display:none"/>
   <gw:textbox id="txt_Parent_PK" style="display:none"/>
   <gw:textbox id="txt_PK" style="display:none"/>
   <gw:textbox id="txt_Company_PK" style="display:none"/>
   <gw:datebox id="DT_system" mode="01" nullaccept="T" maxlen="10" style="display:none"/>
   <gw:textbox id="txt_ComPK1" style="display:none"/>
   <gw:textbox id="txt_Parent_pk_hide" style="display:none"/>
   <gw:datebox id="idEnd_GetDT" style="display: none" />
   
</body>
</html>
