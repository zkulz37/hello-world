<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Member Fee Collection</title>
     <%  ESysLib.SetUser("crm")%>

<script>

var emp_pk = "<%=Session("EMPLOYEE_PK")%>";
var employee = "<%=Session("USER_NAME")%>";
var row_member_fee = 0;
var update = false;

var COL_MEMBER_PK			= 0,
	COL_MEMBER_ID			= 1,
	COL_MEMBER_NAME			= 2,
	COL_MEMBER_MEMBER_TYPE	= 3,
	COL_MEMBER_GENDER		= 4,
	COL_MEMBER_PHONE		= 5,
	COL_MEMBER_ADDRESS		= 6;

var COL_FEE_NO					= 0,
	COL_FEE_PK					= 1,
	COL_FEE_TYPE				= 2,
	COL_FEE_AMT					= 3,
	COL_FEE_AMT_USD				= 4,
	COL_FEE_FROM				= 5,
	COL_FEE_TO					= 6,
	COL_FEE_RECEIVED_AMT		= 7,
	COL_FEE_TCM_MEMBER_PK		= 8,
	COL_FEE_TGM_CUS_GRPPRICE_PK	= 9;

var COL_COLLE_NO				= 0,
	COL_COLLE_PK				= 1,
	COL_COLLE_DATE				= 2,
	COL_COLLE_AMT				= 3,
	COL_COLLE_RECEIVER			= 4,
	COL_COLLE_TCM_MEMBER_FEE_PK = 5,
	COL_COLLE_RECEIVER_PK		= 6;

function BodyInit()
{
	OnSearch(1);
	Binding();
}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			dsoGrdMember.Call('SELECT');
		break;
		case 2:
			dsoGrdMemberFee.Call('SELECT');
		break;
		case 3:
			dsoGrdMemberColle.Call('SELECT');
		break;
	}
}

function Binding()
{
    var dataMemberType;
    dataMemberType    = "<%=ESysLib.SetListDataSQL("SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0 and id in('001','002','003','004')")%>|ALL|Select All";
    lstMemberType.SetDataText(dataMemberType);
    lstMemberType.value='ALL';
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dsoGrdMember':
			if (grdMember.rows > 1)
			{				
				txtMemberPK.text = grdMember.GetGridData(1, COL_MEMBER_PK);
				dsoGrdMemberFee.Call('SELECT');
			}
		break;
		case 'dsoGrdMemberFee':			
			if (grdMemberFee.rows <= 1)
			{
				grdMemberColle.ClearData();
			}
			else
			{			
				grdMemberFee.SelectRow(row_member_fee);
			}
		break;
		case 'dsoGrdMemberColle':
			if (update == true)
			{
				update = false;
				dsoGrdMemberFee.Call('SELECT');	
			}
		break;
		case 'dsoGrdMemberColle':
		break;
	}
}

function onClick(n)
{
	switch(n)
	{
		case 1:
			if (grdMember.rows > 1)
			{
				txtMemberPK.text = grdMember.GetGridData(grdMember.row, COL_MEMBER_PK);
				dsoGrdMemberFee.Call('SELECT');
			}
			
		break;
		case 2:
			if (grdMemberFee.rows > 1)
			{
				row_member_fee = grdMemberFee.row;
				txtMemberFeePK.text = grdMemberFee.GetGridData(grdMemberFee.row, COL_FEE_PK);				
				dsoGrdMemberColle.Call('SELECT');
			}
		break;
	}
}

function OnNew(n)
{
	switch(n)
	{
		case 1:
			if (grdMember.rows > 1)
			{
				var path   = System.RootURL + "/form/ja/ms/jams0060_1.aspx?MemberTypePK="+grdMember.GetGridData(grdMember.row,0);
				var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
				var temp;

				if ( object != null )
				{
					for(i = 0; i < object.length; i++)
					{
						temp = object[i];
						grdMemberFee.AddRow();
						grdMemberFee.SetGridText(grdMemberFee.rows-1, COL_FEE_TYPE, temp[2]);
						grdMemberFee.SetGridText(grdMemberFee.rows-1, COL_FEE_AMT, temp[3]);
						grdMemberFee.SetGridText(grdMemberFee.rows-1, COL_FEE_AMT_USD, temp[4]);
						grdMemberFee.SetGridText(grdMemberFee.rows-1, COL_FEE_FROM, temp[5]);
						grdMemberFee.SetGridText(grdMemberFee.rows-1, COL_FEE_TO, temp[6]);
						grdMemberFee.SetGridText(grdMemberFee.rows-1, COL_FEE_RECEIVED_AMT, '0');
						grdMemberFee.SetGridText(grdMemberFee.rows-1, COL_FEE_TCM_MEMBER_PK, grdMember.GetGridData(grdMember.row, COL_MEMBER_PK));
						grdMemberFee.SetGridText(grdMemberFee.rows-1, COL_FEE_TGM_CUS_GRPPRICE_PK, temp[0]);
					}
				}			
			}
		break;
		case 2:
			if (grdMemberFee.rows > 1)
			{
				if (grdMemberFee.row > 0)
				{
					if (grdMemberFee.GetGridData(grdMemberFee.row, COL_FEE_PK) != '')
					{
						txtMemberFeePK.text = grdMemberFee.GetGridData(grdMemberFee.row, COL_FEE_PK);
						grdMemberColle.AddRow();
						
						grdMemberColle.SetGridText(grdMemberColle.rows-1, COL_COLLE_AMT, '0');
						grdMemberColle.SetGridText(grdMemberColle.rows-1, COL_COLLE_RECEIVER, employee);
						grdMemberColle.SetGridText(grdMemberColle.rows-1, COL_COLLE_RECEIVER_PK, emp_pk);
						grdMemberColle.SetGridText(grdMemberColle.rows-1, COL_COLLE_TCM_MEMBER_FEE_PK, txtMemberFeePK.text);				
					}
				}
			}			
		break;
	}
}

function OnSave(n)
{
	switch(n)
	{
		case 1:
			dsoGrdMemberFee.Call();
		break;
		case 2:
			if (grdMemberColle.rows > 1)
			{
				for(row = 1; row < grdMemberColle.rows; row++)
				{
					if (grdMemberColle.GetGridData(row, COL_COLLE_AMT) == '0')
					{
						alert('Please, input column Received Amt at row ' + row);
						return;
					}
					
					if (Number(grdMemberColle.GetGridData(row, COL_COLLE_AMT)) < 0)
					{
						alert('Error data at row ' + row);
						grdMemberColle.SetGridText(row, COL_COLLE_AMT, '0');
						return;
					}
				}
			}
			
			update = true;
			dsoGrdMemberColle.Call();
		break;
	}
}

function OnDelete(n)
{
	switch(n)
	{
		case 1:
			if (grdMemberFee.rows > 1)
			{
				grdMemberFee.DeleteRow();
			}
		break;
		case 2:
			if (grdMemberColle.rows > 1)
			{
				grdMemberColle.DeleteRow();
			}
		break;
	}
}

function OnUnDelete(n)
{
	switch(n)
	{
		case 1:			
			if (grdMemberFee.rows > 1)
			{
				grdMemberFee.UnDeleteRow();
			}
		break;
		case 2:
			if (grdMemberColle.rows > 1)
			{
				grdMemberColle.UnDeleteRow();
			}
		break;
	}
}

function AfterEdit(n)
{
	switch(n)
	{
		case 1:			
			switch(event.col)
			{
				case COL_FEE_AMT:
				case COL_FEE_AMT_USD:
					if (isNaN(grdMemberFee.GetGridData(grdMemberFee.row, event.col)))
					{
						grdMemberFee.SetGridText(grdMemberFee.row, event.col, '0');
					}
				break;
				case COL_FEE_FROM:
				case COL_FEE_TO:
					valid_form = grdMemberFee.GetGridData(grdMemberFee.row, COL_FEE_FROM);
					valid_to   = grdMemberFee.GetGridData(grdMemberFee.row, COL_FEE_TO);
					
					if (valid_to - valid_form < 0)
					{
						alert('Invalid date.');
						grdMemberFee.SetGridText(grdMemberFee.row, event.col, '');
					}
				break;
			}
		break;
		case 2:
			if (event.col == COL_COLLE_AMT)
			{
				if (isNaN(grdMemberColle.GetGridData(grdMemberColle.row, event.col)))
				{
					grdMemberColle.SetGridText(grdMemberColle.row, event.col, '0');
				}
				else
				{
					if (Number(grdMemberColle.GetGridData(grdMemberColle.row, event.col)) < 0)
					{
						grdMemberColle.SetGridText(grdMemberColle.row, event.col, '0');
					}
				}
			}
		break;
	}
}

function OnGetEmp()
{
	if (event.col == COL_COLLE_RECEIVER)
	{
		var path   = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx";
		var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

		if (object != null)
		{
			grdMemberColle.SetGridText(grdMemberColle.row, COL_COLLE_RECEIVER, object[2]);
			grdMemberColle.SetGridText(grdMemberColle.row, COL_COLLE_RECEIVER_PK, object[0]);
		}
	}
}

</script>
</head>
<body>
<gw:data id="dsoGrdMember" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid" function="crm.sp_sel_jams0060" >  
			<input bind="grdMember" >  
				<input bind="txtMember" />	
				<input bind="lstMemberType" /> 															
			</input> 
			<output bind="grdMember" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dsoGrdMemberFee" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid" parameter="1,3,4,5,6,8,9" function="crm.sp_sel_jams0060_1" procedure="crm.sp_upd_jams0060_1" >  
			<input bind="grdMemberFee" >  
				<input bind="txtMemberPK" />	 															
			</input> 
			<output bind="grdMemberFee" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dsoGrdMemberColle" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid" parameter="1,2,3,5,6" function="crm.sp_sel_jams0060_2" procedure="crm.sp_upd_jams0060_2">
			<input bind="grdMemberColle" >  
				<input bind="txtMemberFeePK" />	 															
			</input> 
			<output bind="grdMemberColle" /> 
		</dso> 
	</xml> 
</gw:data>
<table style="background: #BDE9FF; height: 100%; width: 100%">
	<tr>
		<td style="background: white; width: 35%">
			<table style="height: 100%; width: 100%">
				<tr style="height: 1%">
					<td style="width: 20%" align="center" >Member</td> 
					<td style="width: 80%" colspan="2"><gw:textbox id="txtMember" styles="width: 100%" onenterkey="OnSearch(1)" /></td>
				</tr>
				<tr style="height: 1%">
					<td style="width: 20%" align="center" >Member Type</td> 
					<td style="width: 77%"><gw:list id="lstMemberType" styles='width:100%' onchange="OnSearch(1)" /></td>
					<td style="width: 3%"><gw:imgbtn img="search" alt="Search" onclick="OnSearch(1)" /></td>
				</tr>
				<tr style="height: 99%">
					<td colspan="6">
						<gw:grid id="grdMember" header='_membertype_pk|_member_pk|ID|Name|Member Type|Gender|Phone|Address'
							format='0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0' defaults='|||||||'
							editcol='0|0|0|0|0|0|0|0' widths='0|0|0|0|1500|0|0|0'
							sorting='T'  autosize='T' styles="width:100%;height:100%" 
							oncellclick="onClick(1)" />
					</td>
				</tr>
			</table>
		</td>
		<td style="background: white; width: 65%">
			<table style="height: 100%; width: 100%" >
				<tr style="height: 1%" width="100%">
					<td style="width: 88%">
					</td>
					<td style="width: 3%">
						<gw:imgbtn id="btnNewFee" img="new" alt="New" onclick="OnNew(1)" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn id="btnDelFee" img="delete" alt="Delete" onclick="OnDelete(1)" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn id="btnUnDelFee" img="udelete" alt="UnDelete" onclick="OnUnDelete(1)" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn id="btnSaveFee" img="save" alt="Save" onclick="OnSave(1)" />
					</td>
				</tr>
				<tr style="height: 59%" width="100%">
					<td style="width: 100%" colspan="5">
						<gw:grid id="grdMemberFee" header='No|_PK|Fee Name|_Fee AMT|Fee AMT(USD)|Form|To|Received AMT|_TCM_MEMBER_PK|_TGM_CUS_GRPPRICE_PK'
						format ='0|0|0|1|1|4|4|1|0|0' aligns='3|0|0|3|3|0|0|3|0|0' defaults='|||||||||'
						editcol='0|0|0|1|1|1|1|0|0|0' widths='0|1500|1500|1500|2000|2000|2000|0|0|0'
						sorting='T' autosize='T' oncellclick="onClick(2)" onafteredit='AfterEdit(1)' styles="width:100%;height:100%" />  
					</td>
				</tr>
				<tr style="height: 1%" width="100%">
					<td style="width: 88%">
					</td>
					<td style="width: 3%">
						<gw:imgbtn id="btnNewColl" img="new" alt="New" onclick="OnNew(2)" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn id="btnDelColl" img="delete" alt="Delete" onclick="OnDelete(2)" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn id="btnUnDelColl" img="udelete" alt="UnDelete" onclick="OnUnDelete(2)" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn id="btnSaveColl" img="save" alt="Save" onclick="OnSave(2)" />
					</td>
				</tr>
				<tr style="height: 40%" width="100%">
					<td style="width: 100%" colspan="5">
						<gw:grid id="grdMemberColle" header='No|_PK|Received Date|Received AMT(USD)|Receiver|_TCM_MEMBER_FEE_PK|_RECEIVER_PK'
						format='0|0|4|1|0|0|0' aligns='3|0|0|3|0|0|0' defaults='||||||'
						editcol='0|1|1|1|0|0|0' widths='0|1500|1500|1500|2000|0|0'
						sorting='T' autosize="T" oncelldblclick="OnGetEmp()" onafteredit='AfterEdit(2)' styles="width:100%;height:100%" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
<gw:textbox id="txtMemberPK" style="display:none"/>
<gw:textbox id="txtMemberFeePK" style="display:none"/>
</html>
