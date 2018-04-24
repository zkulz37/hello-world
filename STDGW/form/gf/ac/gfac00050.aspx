<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
  <script>

function BodyInit()
{
System.Translate(document);    
 txtAccGrpID.GetControl().focus();
    BindingDataList();
    Search();
}

function BindingDataList()
{ 
    var ls_data     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0070','','') FROM DUAL")%>";
    var ls_data2    = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data2);
    lstTransGroup.SetDataText(ls_data);
}

function Search()
{
    grdAGCode.ClearData();
    dsoAccountGroupEntry.Call("SELECT")
}

function AddOnClick()
{
    grdAGCode.AddRow();
    btnSave.SetEnable(true)
    var ctrl = grdAGCode.GetGridControl();
	var n = ctrl.Rows;
	grdAGCode.SetGridText( n-1, 1, lstCompany.GetData() );
	grdAGCode.SetGridText( n-1, 2, lstTransGroup.GetData() );
}

function UpdateOnClick()
{
    if (checkItemLength() && checkDupItems())
    {
        dsoAccountGroupEntry.Call();
    }
}

function DeleteOnClick()
{
    var ctrl = grdAGCode.GetGridControl();
	var n    = ctrl.Rows;
	var row  = ctrl.Row;
	
    if ( row < 0 ) 
	{			
	    alert('Please select a code to delete!!!'+'\n'+'Bạn hãy chọn code cần xóa!!!');
	}			
	else
	{
	    if (confirm(' Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa dữ liệu này?')) 
	    {
		    var j = 0;
		    var i = 1;
		    while ((i < ctrl.rows) && (j < 2))
		    {
		        if (ctrl.isSelected(i) == true)
		        {
		            j = j + 1;
		        }
		        i = i + 1;
		    }
		   
            if (j > 1)
            {
                alert('You must one row to delete!!!'+'\n'+'Bạn chỉ chọn 1 dòng để xóa!!!')
                return;
            }		    
		    
		    for ( i=1; i < ctrl.rows; i++ )
			{
			    if (ctrl.isSelected(i) == true)
			    {
				    txtInput_PK.text = grdAGCode.GetGridData( i, 0 );	
			        pro_AccountGroup_Exists.Call();
				}
			}
		}
	}
}

function UnDeleteOnClick()
{
	var ctrl = grdAGCode.GetGridControl();
	var n    = ctrl.Rows;
	var row  = ctrl.Row;

	if ( n > 1 ) 
	{
		if ( row > 0 ) 
		{
			if ( grdAGCode.GetGridData( ctrl.Row, 0) != "" )
			{
				if (confirm('     Do you want to Undelete?'+'\n'+'Bạn muốn phục hồi lại những dòng bị xóa vừa rồi?'))
				{				
					grdAGCode.UnDeleteRow()
				}
				CheckData();
			}
		}
	}
}

function CheckData()
{
	var ctrl = grdAGCode.GetGridControl();
	var n    = ctrl.Rows;
	var row  = ctrl.Row;	
	
	if ( n > 1 ) {
	
		if ( row > 0 ) 
		{			
			if ( grdAGCode.GetRowStatus( ctrl.Row ) >= 64 ) 
			{
				btnDelete.SetEnable(false);
				//btnUndelete.SetEnable(true);
			}
			else {
				btnDelete.SetEnable(true);
				//btnUndelete.SetEnable(false);
			}
		}	
	}	
}

function checkItemLength()
{
	var ctrl = grdAGCode.GetGridControl();
	var n    = ctrl.Rows;	
	
	if ( n == 1)
	{
   		return false;
	}
	for ( i=1; i<n; i++ )
	{
		var data = grdAGCode.GetGridData( i, 3 );
		if ( data.length < 1 )
		{
		    alert('    Account Group Code is not null!!!'+'\n'+'Account Group Code không được rỗng!!!');
			return false;
		}
		if ( data.length > 10 )
		{			
			alert('Account Group Code is too large for column( <= 10 characters)'+'\n'+'   Dữ liệu Account Group Code quá lớn ( <= 10 ký tự)');
			return false;
		}
		
		var data = grdAGCode.GetGridData( i, 4 );
		if ( data.length < 1 )
		{
		    alert('    Account Group Name is not null!!!'+'\n'+'Account Group Name không được rỗng!!!');
			return false;
		}
		if (data.length > 60 ) 
		{			
			alert('Account Group Name is ntoo large for column!'+'\n'+'  Dữ liệu Account Group Name quá lớn!');
			return false;
		}
		
		var data = grdAGCode.GetGridData( i, 5 );
		if ( data.length < 1 )
		{
		    alert('   Description is not null!!!'+'\n'+'Description không được rỗng!!!');
			return false;
		}
		if ( data.length > 100 ) 
		{
			alert('Description is too large for column!'+'\n'+'  Dữ liệu Description quá lớn!');
			return false;
		}
	}
	return true;
}

function checkDupItems()
{
	var ctrl = grdAGCode.GetGridControl();
	var n    = ctrl.Rows;
	var row  = ctrl.Row;
	
	if ( n==1 ) 
	{
   		return false;
	}
	for ( i=1; i<n; i++ ) 
	{
		if ( row != i ) 
		{
			var data_1 = grdAGCode.GetGridData( row, 3 );
			var data_2 = grdAGCode.GetGridData( i, 3 );			
			if ( ( data_1.length != 0 ) && ( data_1.toUpperCase() == data_2.toUpperCase() ) ) 
			{
				alert('   Account Group Code is exist. Please check again!!!'+'\n'+'Account Group Code đã tồn tại. Bạn vui lòng kiểm tra lại!!!');
				return false;		
			}

			var data_1 = grdAGCode.GetGridData( row, 4 );
			var data_2 = grdAGCode.GetGridData( i, 4 );
			if ( ( data_1.length != 0 ) && ( data_1.toUpperCase() == data_2.toUpperCase() ) ) 
			{
                alert('   Account Group Name is exist. Please check again!!!'+'\n'+'Account Group Name đã tồn tại. Bạn vui lòng kiểm tra lại!!!');
				return false;
			}			
		}
	}
	return true;
}

function OnDataReceive(obj)
{
    var ctrl = grdAGCode.GetGridControl();
	var n    = ctrl.Rows;
	if (obj.id=="dsoAccountGroupEntry")
	{
        if (n>1) 
        { 
             btnDelete.SetEnable(true)
             //btnUndelete.SetEnable(false)
             btnSave.SetEnable(true)
        }
        else
        {
             btnDelete.SetEnable(false)
             //btnUndelete.SetEnable(false)
             btnSave.SetEnable(false)
        }
 	}
 	else if (obj.id=="pro_AccountGroup_Exists")
 	{
 	    if (txtCount.GetData() > 0)
 	    {
 	        alert('      Account Group Code is using in form Account Group Code. You must delete code in form Account Group Code!'+'\n'+'Account Group Code đang sử dụng ở form Account Group Code. Bạn hãy xóa Code này ở form Account Group Code trước!');
 	        return;
 	    }
 	    else
 	    {
 	        txtCount.SetDataText("0")
 	        dso_check_dup.Call();
		}
 	}
 	else if (obj.id=="dso_check_dup")
 	{
 	    if (txtCount.GetData() > 0)
 	    {
 	        alert('    Account Group Code is using in form Standard Slip Entry. You must delete code in form Standard Slip Entry first!'+'\n'+'Account Group Code đang sử dụng ở form Standard Slip Entry. Bạn hãy xóa Code này ở form Standard Slip Entry trước!');
 	        return;
 	    }
 	    else
 	    {
 	        CheckData();
 	        grdAGCode.DeleteRow();
 	        dsoAccountGroupEntry.Call();
		}
 	}
}

function checkGrid() 
{
	checkItemLength();
	checkDupItems();
}

function CheckNumeric()
{
   var key = window.event.keyCode;
   if ( key > 47 && key < 58 )
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise
}

function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}

</script>
<body style="margin:0; padding:0;">

    <gw:data id="dsoAccountGroupEntry" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="ACNT.SP_SEL_ACCOUNT_GROUP" parameter="0,1,2,3,4,5,6,6,6" procedure="ACNT.SP_UDP_ACCOUNT_GROUP"> 
                    <input bind="grdAGCode" > 
                    <input bind="lstCompany" /> 
                    <input bind="lstTransGroup" /> 
                    <input bind="txtAccGrpID" /> 
                    <input bind="txtAccGrpName" /> 
                </input> 
                <output bind="grdAGCode" /> 
            </dso> 
        </xml> 
    </gw:data> 
    
    <gw:data id="pro_AccountGroup_Exists"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ACCOUNT_GROUP_EXISTS">
                <input>
                     <input  bind="txtInput_PK"/>
                </input>
                <output>
                     <output  bind="txtCount"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dso_check_dup"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ACCOUNT_TRANS_EXISTS">
                <input>
                     <input  bind="txtInput_PK"/>
                </input>
                <output>
                     <output  bind="txtCount"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    
    

<form id="form1" runat="server">

    <table  border=1 cellpadding=0 cellspacing=0 width="100%" >
	    <tr> 
		<td>
			<table border=0 cellpadding="0" cellspacing="8" width="100%">
				<tr>
					<td width="95%">
						<table border=0 cellpadding="0" cellspacing="0" width="100%">
							<tr>
							    <td width="6%" align="center">Company</td>	
							    <td width="15%"><gw:list id="lstCompany" value="" onchange="Search()" styles='width:100%'></gw:list >
								</td>				
								<td width="10%" align="center">Trans Group</td>					
								<td width="15%">
									<gw:list id="lstTransGroup" value="" onchange="Search()" styles='width:100%'> </gw:list >
								</td>
								<td width="10%" align="center">Acc Grp Code</td>					
								<td width="15%"><gw:textbox id="txtAccGrpID" styles='width:100%' onenterkey="Search()" onkeypress="Upcase()"/> </td>
							    
							    <td width="10%" align="center">Acc Grp Name</td>					
								<td width="15%"><gw:textbox id="txtAccGrpName" styles='width:100%' onenterkey="Search()" onkeypress="Upcase()" /> </td>
																
							</tr>
						</table>
					</td>					
					<td width="5%">
						<table border=0 cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td width="80%"></td>				
								<td width="5%"><gw:imgBtn img="search"  alt="Search"   id="btnSearch"   onclick="Search()"/></td>
								<td width="5%"><gw:imgBtn img="new"     alt="New"      id="btnAdd"      onclick="AddOnClick()"/></td>
								<td width="5%"><gw:imgBtn img="save"    alt="Save"     id="btnSave"     onclick="UpdateOnClick();return false;"/></td>
								<td width="5%"><gw:imgBtn img="delete"  alt="Delete"   id="btnDelete"   onclick="DeleteOnClick()"/></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>   		 
		</td>		
	</tr>
	<tr>
		<td>
			<table border=0 cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td>
						<gw:grid   
						    id="grdAGCode"  
						    header  ="_PK|_COMPANY|_APP_GRP|Account Group Code|Account Group Name|Description|User"   
						    format  ="0|0|0|0|0|0|0"  
						    aligns  ="0|0|0|0|0|0|0"  
						    defaults="|||||||"  
						    editcol ="0|0|0|1|1|1|1"  
						    widths  ="0|0|0|2000|5000|6500|1000"  
						    styles  ="width:100%; height:450"   
						    sorting ="T"   
						    param="0,1,2,3,4,5" 
						    oncellclick="CheckData()" 
						 /> 
					</td>
				</tr>
			</table>		
		</td>	
	</tr>	
</table>
    </form>
    
    <gw:textbox id="txtInput_PK"    text="" style="display:none" />
    <gw:textbox id="txtCount"       text="" style="display:none" />
    
</body>
</html>
