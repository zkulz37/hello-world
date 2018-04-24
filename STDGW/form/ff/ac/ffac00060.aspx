<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<% ESysLib.SetUser("acnt")%>

<script>
var aValue = new Array()

var User_log;
var AdminYN;

AdminYN  ="Y";

function BodyInit()
{
    BindingDataList();
    Search();
    btnDelete.SetEnable(false);
    btnUndelete.SetEnable(false);
    btnUpdate.SetEnable(false);
    btnAdd.SetEnable(false);
}

function BindingDataList()
{ 
    var ls_data     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0070','','') FROM DUAL")%>";
    var ls_data2    = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstAPP_GRP.SetDataText(ls_data);
    lstCompany.SetDataText(ls_data2);
    
}

function Search()
{
    grdAccount.ClearData();
    dsoAccountGroup.Call("SELECT")
}

function RowClick()
{
   txtCode.SetDataText("");
   txtAccCode.SetDataText("");
   txtNameEng.SetDataText("");
   txtNameLocal.SetDataText("");
   txtInput_PK.text = grdAGCode.GetGridData( grdAGCode.selrow , 0 );	
   dsoAccounGroupDetail.Call("SELECT");
}

function checkItemLength() 
{
	var ctrl = grdAccount.GetGridControl();
	var n    = ctrl.rows;	
	
	if ( n == 1) 
	{
   		return false;
	}	
	for ( i=1; i<n; i++ ) {
		var data = grdAccount.GetGridData( i, 2 );
		if ( data.length > 10 ) 
		{			
			alert("'" + data + "' too large for column");
			return false;
		}		
	}
	return true;
}

function checkGrid() 
{
	checkItemLength();
	checkDupItem();
}

function SetControl(n)
{
    if (n>1) 
    { 
        btnDelete.SetEnable(true)
        btnUndelete.SetEnable(false)
        btnUpdate.SetEnable(true)
    }
    else
    {
        btnDelete.SetEnable(false)
        btnUndelete.SetEnable(false)
        btnUpdate.SetEnable(false)
    }
}

function OnDataReceive(obj)
{
    var ctrl = grdAccount.GetGridControl();
	var n    = ctrl.Rows;
	if (obj.id=="dsoAccounGroupDetail")
	{
        btnAdd.SetEnable(true);
        SetControl(n);
 	}
 	else if (obj.id=="AccounGroupAdmin")
 	{
 	    SetControl(n);
 	    for (i=1; i < n; i++)
 	    {
 	        grdAccount.SetRowStatus(i, 0x20);
 	    }
 	}
}

function AccountRowClick()
{
    var ctrl1 = grdAccount.GetGridControl();
    
    if (grdAccount.GetGridData(ctrl1.row, 0) != "")
    {
        return;
    }
    if( event.col == 3 || event.col == 4 || event.col == 5)
	{
	    
	    var ctrl    = grdAGCode.GetGridControl();
	    var sNm ;
	    if (AdminYN == "Y")
        {
	        if (lstAPP_GRP.GetData() == 'Y')
            {
	            sNm  = grdAGCode.GetGridData(ctrl.row, 2);
	        }
	        else
	        {
	            sNm = "";
	        }
	    }
	    else
	    {
	        sNm     = "";
	    }
	    var fpath   = System.RootURL + "/form/ff/co/ffco002001.aspx?comm_code="+sNm+"&val1="+txtInput_PK.GetData()+"&dsqlid=ACNT.SP_SEL_POPUP_ACCOUNT";
	    aValue      =   System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	
	    if ( aValue != null ) 
	    {
	        if (aValue.length > 0)
	        {
	            grdAccount.RemoveRowAt(grdAccount.rows - 1);
	            for(i=0; i<aValue.length; i++)
	            {
	                var tmp = aValue[i];
	                if (tmp[0] != 0)
	                {
	                    grdAccount.AddRow();
	                    grdAccount.SetGridText(grdAccount.rows - 1, 1, txtInput_PK.GetData());
	                    grdAccount.SetGridText(grdAccount.rows - 1, 6, tmp[3]);
	                    grdAccount.SetGridText(grdAccount.rows - 1, 2, tmp[0]);
	                    grdAccount.SetGridText(grdAccount.rows - 1, 3, tmp[0]);
	                    grdAccount.SetGridText(grdAccount.rows - 1, 4, tmp[1]);
	                    grdAccount.SetGridText(grdAccount.rows - 1, 5, tmp[4]);
	                }
	            }
	        }
	    }
	}		
}

function checkNullData()
{
	var ctrl = grdAccount.GetGridControl();
	var n    = ctrl.rows;	
	
	if ( n == 1) 
	{
   		return false;
	}	
	for ( i=1; i<n; i++ ) 
	{		
		var data = grdAccount.GetGridData( i, 2 );
	
		if ( data == "" ) 
		{
			alert('Code is not null!'+'\n'+'Mã code không được rỗng!');
			return false;		
		}
	    data = grdAccount.GetGridData( i, 6 );
		if ( data == "" ) 
		{
			alert('Please select a Account Code!'+'\n'+'Bạn hãy chọn Account Code');
			return false;
		}		
	}	
	return true;
}

function checkDupItem() 
{
	var ctrl = grdAccount.GetGridControl();
	var n    = ctrl.rows;
	var row  = ctrl.row;
	
	if (n < 2) 
	{
        return false;
	}	
	else
	{
	    for (i=1; i< n -1; i++ ) 
	    {	   
		    for (j=i+1; j< n; j++)
		    {
		        var data_1 = grdAccount.GetGridData( i, 2 );
			    var data_2 = grdAccount.GetGridData( j, 2 );			
			    if ((data_1 != "") && ( data_1.toUpperCase() == data_2.toUpperCase()))
			    {
				    alert("'" + data_1 + "' Code already in use, please re-enter");				
				    return false;		
			    }
				data_1 = grdAccount.GetGridData( i, 6 );
			    data_2 = grdAccount.GetGridData( j, 6 );			
			    if ((data_1 != "") && (data_1 == data_2)) 
			    {
				    alert("'" + grdAccount.GetGridData( j, 3 ) + "' Account Code already in use, please re-select");
				    return false;		
			    }
		    }
	    }
	}
	return true;
}

function UpdateOnClick() 
{
	var ctrl = grdAccount.GetGridControl();
	var n    = ctrl.rows;	
	var row  = ctrl.row;
	
    if (n > 1)
    {	
	    if (checkNullData() && checkItemLength() && checkDupItem())
		{		
		    for ( i=1; i<ctrl.rows; i++ ) 
			{
			    var data = grdAccount.GetGridData( i, 3 );
				if ( data.length == 0 ) 
				{
				    grdAccount.SetRowStatus(i, 64);
				}
			}
			if (confirm(' Are you sure want to save?'+'\n'+'Bạn có muốn lưu lại không?')) 
			{
				dsoAccounGroupDetail.Call("");
			}
		}
	}
}

function CheckBeforeAdd() 
{
	var agcode = '' + txtInput_PK.text;
	if (agcode != '') 
	{
		return true;
	}
	else 
	{
		alert('Please select a Account Group Code frist!'+'\n'+'Bạn hãy chọn Account Group Code trước!');
		return false;
	}
}

function checkData() 
{
	var ctrl = grdAccount.GetGridControl();
	var n    = ctrl.rows;
	var row  = ctrl.row;	
	
	if ( n > 1 ) 
	{	
		if ( row < 0 ) 
		{
		}
		else 
		{			
			if (grdAccount.GetRowStatus( ctrl.row ) >= 64) 
			{
				btnDelete.SetEnable(false);
				btnUndelete.SetEnable(true);
			}
			else {
				btnDelete.SetEnable(true);
				btnUndelete.SetEnable(false);
			}
		}	
	}	
}

function OnAdd_New_Admin()
{
    if (txtInput_PK.GetData() == "")
    {
        alert('You must choose A/C group code frist!!!'+'Bạn hãy chọn A/C group code trước!!!');
        return;
    }
    else
    {
        var ctrl = grdAccount.GetGridControl();
	    var n    = ctrl.rows;	
	    if (n > 1)
	    {
            grdAccount.AddRow();
            grdAccount.SetGridText(ctrl.rows - 1, 1, txtInput_PK.GetData());
        }
        else
        {
            txtACCD.text = grdAGCode.GetGridData(grdAGCode.selrow, 2);
            AccounGroupAdmin.Call("SELECT");
        }
    }
}

function OnAdd_New_User()
{
    grdAccount.AddRow();
    var ctrl = grdAccount.GetGridControl();
    var n = ctrl.Rows -1;
    grdAccount.SetGridText(n, 1,txtInput_PK.text );
    btnUpdate.SetEnable(true)
}

function AddOnClick()
{
    if (AdminYN == 'Y')
    {
        if (lstAPP_GRP.GetData() == 'Y')
        {
            OnAdd_New_Admin();
        }
        else
        {
            OnAdd_New_User();
        }
    }
    else
    {
        OnAdd_New_User();
    }
}

function DeleteOnClick() 
{
	var ctrl = grdAccount.GetGridControl();
	var n    = ctrl.rows;
	var row  = ctrl.row;
	
	if ( n > 1 )
	{		
		if ( row < 0 ) 
		{
		    alert('Please select a Code to delete!'+'\n'+'Bạn hãy chọn dòng đễ xóa!');
		}			
		else
		{
			if (confirm('Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa Code này?'))
			{
				for ( i=0; i < ctrl.rows; i++ )
			    {
				    if (ctrl.isSelected(i) == true)
				    {
				        grdAccount.DeleteRow();
				    }
				}
				checkData();
				dsoAccounGroupDetail.Call("");	
			}
		}
	}
	else 
	{
		alert('Please select a Code to delete!'+'\n'+'Bạn hãy chọn dòng đễ xóa!');
	}		
}

function SearchonClick()
{
    if (txtInput_PK.GetData() == '') 
    {
        alert("Please select a Code!")
    }
    else
    {
        dsoAccounSearchDetailS.Call('SELECT')
    }
}

</script>
<body>
    
    <gw:data id="dsoAccountGroup" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso type="grid" function="ACNT.SP_SEL_ACCOUNT_GROUP_MASTER" > 
                <input bind="grdAGCode" >
                    <input bind="lstCompany" /> 
                    <input bind="lstAPP_GRP" /> 
                   </input> 
                <output bind="grdAGCode" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dsoAccounGroupDetail" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso type="grid" parameter="0,1,2,6" function="ACNT.SP_SEL_ACCOUNT_GROUP_DETAI" procedure="ACNT.SP_UDP_ACCOUNT_GROUP_D" > 
                <input bind="grdAccount" >
                    <input bind="txtInput_PK" /> 
                </input> 
                <output bind="grdAccount" /> 
            </dso> 
        </xml> 
    </gw:data>

    <gw:data id="AccounGroupAdmin" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso type="grid" parameter="0,1" function="ACNT.SP_SEL_ACCOUNT_GROUP_ADMIN"> 
                <input bind="grdAccount" >
                    <input bind="txtInput_PK" /> 
                    <input bind="txtACCD" /> 
                </input> 
                <output bind="grdAccount" /> 
            </dso> 
        </xml> 
    </gw:data>

    <gw:data id="dsoAccounSearchDetailS" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso type="grid" function="ACNT.SP_SEL_ACCOUNT_GROUP_DETAI_S"  > 
                <input bind="grdAccount" >
                    <input bind="txtInput_PK" /> 
                    <input bind="txtCode" /> 
                    <input bind="txtAccCode" /> 
                    <input bind="txtNameEng" /> 
                    <input bind="txtNameLocal" /> 
                </input> 
                <output bind="grdAccount" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <form id="form1" runat="server">
        <table width="100%" cellpadding="0" cellspacing="0" border="1">
            <tr>
                <td width="35%">
                    <table id="LeftTopTB" border="0" cellpadding="0" cellspacing="8" width="100%">
                        <tr>
                            <td width="30%" align="right"><font color="black"><b>Company</b></font></td>
                            <td width="1%"></td>
                            <td width="50%"><gw:list id="lstCompany" styles="width:100%;" value="" onchange="Search()"></gw:list></td>
                            <td width="0%"></td>
                        </tr>
                        <tr>
                            <td width="30%" align="right"><font color="black"><b>Transaction Group</b></font></td>
                            <td width="1%"></td>
                            <td width="50%"><gw:list id="lstAPP_GRP" styles="width:100%;" value="" onchange="Search()"></gw:list></td>
                            <td width="0%"></td>
                        </tr>
                    </table>
                </td>
                <td width="65%">
                    <table id="RightTopTB" border="0" cellpadding="0" cellspacing="4" width="100%">
                        <tr>
                            <td width="15%" align="center"><strong>Code</strong></td>
                            <td width="25%"><gw:textbox id="txtCode" styles='width:100%'  onenterkey="SearchonClick()" /></td>
                            <td width="15%" align="center"><strong>Account Code</strong></td>
                            <td width="25%"><gw:textbox id="txtAccCode" styles='width:100%' onenterkey="SearchonClick()" /></td>
                            <td width="2%"><gw:imgbtn img="new"     alt="New"       id="btnAdd"      onclick="AddOnClick()" /></td>
                            <td width="2%"><gw:imgbtn img="save"    alt="Save"      id="btnUpdate"   onclick="UpdateOnClick()" /></td>
                            <td width="2%"><gw:imgbtn img="delete"  alt="Delete"    id="btnDelete"   onclick="DeleteOnClick()" /></td>
                            <td width="2%"><gw:imgbtn img="printer" alt="Print"  id="btnUndelete" onclick="" /></td>
                        </tr>
                        <tr>
                            <td width="15%" align="center"><strong>Account Name(Eng)</strong></td>
                            <td width="25%"><gw:textbox id="txtNameEng" styles='width:100%' onenterkey="SearchonClick()" /></td>
                            <td width="15%" align="center"><strong>Account Name(Local)</strong></td>
                            <td width="25%"><gw:textbox id="txtNameLocal" styles='width:100%' onenterkey="SearchonClick()" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="35%">
                    <table id="LeftBottomTB" border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <gw:grid 
                                        id="grdAGCode" 
                                    header="_PK|A/C Group Code|A/C Group Name" 
                                    format="0|0|0"
                                    aligns="0|0|0" 
                                  defaults="||" 
                                   editcol="0|0|0" 
                                    widths="0|2000|2500" 
                                    styles="width:100%; height:420;"
                                   sorting="T" 
                                     param="0,1,2" 
                               oncellclick="RowClick()" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="65%">
                    <table id="RightBottomTB" border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <gw:grid 
                                    id="grdAccount" 
                                    header  ="_PK|_TAC_ABTRACGRP_PK|Code|Account Code|Account Name (Eng)|Account Name (Local)|_TAC_ABACCTCODE_PK"
                                    format  ="0|0|0|0|0|0|0" 
                                    aligns  ="0|0|1|1|2|2|0" 
                                    defaults="||||||" 
                                    editcol ="0|0|1|0|0|0|0"
                                    widths  ="0|0|1500|2000|3000|3000|0"
                                    styles  ="width:100%; height:420" 
                                    sorting ="T"
                                    param   ="0,1,2,3,4,5,6"
                                    oncellclick     ="checkData()"
                                    oncelldblclick  ="AccountRowClick()"
                                    onafteredit     ="checkGrid()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
 
 <gw:textbox id="txtInput_PK"   text="" style="display: none" />
 <gw:textbox id="txtACCD"       text="" style="display: none" />
 
 
</body>
</html>
