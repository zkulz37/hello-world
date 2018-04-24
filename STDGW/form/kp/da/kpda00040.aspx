<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Adjust Legal O/H ...</title>
</head>
<%  ESysLib.SetUser("EC111")%>
<script>

var COL_CODE				= 0, 
	COL_ORDER_W_NAME		= 1, 
	COL_CURRENCY			= 2, 
	COL_BCWS				= 3, 
	COL_NET_CONS_COST_TOTAL = 4, 
	COL_TOTAL_EXP			= 5, 
	COL_SAF_CONTROL_COST	= 6, 
	COL_INS_PRE_ETC			= 7, 
	COL_OTHERS				= 8, 
	COL_OVH_CNP				= 9, 
	COL_PK					= 10, 
	COL_ORDER_PK			= 11, 
	COL_PROJECT_PK			= 12, 
	COL_BUDGET_PK			= 13;

function BodyInit()
{
	System.Translate(document);
	FormatGrid();
}  

function OnCaculator()
{
	if (!IsNum(grdData.GetGridData(grdData.row, COL_SAF_CONTROL_COST)) 
	|| !IsNum(grdData.GetGridData(grdData.row, COL_INS_PRE_ETC)) 
	|| !IsNum(grdData.GetGridData(grdData.row, COL_OTHERS)) 
	|| !IsNum(grdData.GetGridData(grdData.row, COL_OVH_CNP)))
	{
		grdData.SetGridText(grdData.row, grdData.col, 0);
	}

	var Net			= grdData.GetGridData(grdData.row, COL_NET_CONS_COST_TOTAL);
	var Safe_7		= grdData.GetGridData(grdData.row, COL_SAF_CONTROL_COST);
	var Insurance_8 = grdData.GetGridData(grdData.row, COL_INS_PRE_ETC);
	var Other_9		= grdData.GetGridData(grdData.row, COL_OTHERS);
	var Overhead_10 = grdData.GetGridData(grdData.row, COL_OVH_CNP);

	var BCWS, Total_Exp_6;

	Total_Exp_6 = Number(Safe_7) + Number(Insurance_8) + Number(Other_9) + Number(Overhead_10);
	BCWS		= Number(Net) + Number(Total_Exp_6);

	grdData.SetGridText(grdData.row, COL_TOTAL_EXP, Total_Exp_6);
	grdData.SetGridText(grdData.row, COL_BCWS, BCWS);
}

function IsNum(num)
{
	if (isNaN(num))
		return false;
	else
		return true;
}
//============================================================================================
function OnCreate()
{
	if(txtProject_Pk.text == '')
	{
		alert('Please select project !!');
	}
	else
	{
		dso_create.Call();
	}
}

function OnPopUp(obj)
{
	switch(obj)
	{
		case 'Project':
			var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
			var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
			if(aValue != null)
			{
				txtProject_Pk.text = aValue[0];
				txtProject_Cd.text = aValue[1];
				txtProject_Nm.text = aValue[2]; 
				dso_budget_no.Call();
					//OnSearch();
			} 
		break;
		case 'Create':
			if(event.col == 3 || event.col == 4 || event.col == 5)
			{
				var path = System.RootURL + "/form/kp/bm/kpbm00070_popup_Inquiry.aspx?BCWS=" + grdData.GetGridData(grdData.row, 3) + '&NetContract=' + grdData.GetGridData(grdData.row, 4) + '&Expense=' + grdData.GetGridData(grdData.row, 5) + '&Project_pk=' + grdData.GetGridData(grdData.row, 12) ;
				var aValue = System.OpenModal( path , 1000 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
				if(aValue != null)
				{
					   
				} 
			}
		break;
		case 'New':
			if(event.col == 0 || event.col == 1)
			{
				var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx";
				var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
				if(aValue != null)
				{
					grdData.SetGridText(grdData.row, 11,   aValue[0]);
					grdData.SetGridText(grdData.row, 0, aValue[1]);
					grdData.SetGridText(grdData.row, 1, aValue[2]);
					grdData.SetGridText(grdData.row, 2, aValue[3]);
				}
			}
		break;
	}
}
//====================================================================================================================
function OnSearch()
{
	if(txtProject_Pk.text != '')
	{
		dso_grdData.Call('SELECT');
	}
	else
	{
		alert('Please select Project to search !!');
	}
}

function OnClick()
{
	txtPk.SetDataText(grdData.GetGridData(grdData.row, 10));			
}

function OnSave()
{
	grdData.SetAllRowStatusModify();
	dso_grdData.Call();
}

function OnDelete()  
{
	if(confirm('Are you sure you want to delete !!'))
	{
		grdData.DeleteRow();
		dso_grdData.Call();
	}
}

function FormatGrid()
{ 
	var ctrl = grdData.GetGridControl();
	ctrl.ColFormat(3) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(4) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(5) = "#,###,###,###,###,###,###,###,###.##R";
}

function OnDataReceive(obj)
{         
	switch(obj.id)
	{
		case "dso_create":
			alert(txtReturn_Mess.text);
			dso_grdData.Call("SELECT");
		break;
		case "dso_budget_no":
			dso_grdData.Call("SELECT");
		break;
	}
}
</script>
<body>
<gw:data id="dso_budget_no" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="ec111.sp_pro_sel_kpda00040" > 
            <input> 
                <input bind="txtProject_Pk" />
            </input>
	       <output>
	            <output bind="lstBudgetNo" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_create" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="ec111.sp_pro_kpda00040" > 
            <input> 
                <input bind="txtProject_Pk" />
                <input bind="lstBudgetNo" />
            </input>
	       <output>
	            <output bind="txtReturn_Mess" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>
 <gw:data id="dso_grdData" onreceive="OnDataReceive(this)">
    <xml>
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="ec111.sp_sel_kpda00040"  procedure="ec111.sp_upd_kpda00040">
            <input bind="grdData">
                <input bind="txtProject_Pk"/>
                <input bind="lstBudgetNo"/>
            </input>
            <output bind="grdData"/>
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_search" onreceive="OnDataReceive(this)">
    <xml>
        <dso id="1" type="grid"  function="ec111.sp_sel_kpda00040"    >
            <input bind="grdData">
                <input bind="txtProject_Pk"/>
                <input bind="lstBudgetNo"/>
            </input>
            <output bind="grdData"/>
        </dso>
    </xml>
</gw:data>
    <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
		<tr style="height:1%;width:100%">
			<td>
				<fieldset style="width:100%;padding:0">
					<table  style="width: 100%" cellpadding="0" cellspacing="0">
						<tr>
							<td align="right" width="7%">
								<a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">
									Project&nbsp;</a></td>
							<td width="43%">
								<table cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td width="40%">
											<gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
										</td>
										<td width="60%">
											<gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
										</td>
										<td width="">
											<gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
										</td>
										<td>
											<gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
										</td>
									</tr>
								</table>
							</td>
							<td width="25%" align="right">Budget Statement No.&nbsp;</td>
							<td width="20%"><gw:list id="lstBudgetNo" onchange="OnSearch()" styles='width:100%' /></td>
						   
							<td width="5%"></td>
							<td style="display:"><gw:imgbtn id="btSve2" img="create" alt="Create"  onclick="OnCreate()" /></td>
							<td ><gw:imgbtn id="btSve2" img="search" alt="Search"  onclick="OnSearch()" /></td>
							<td style="display:none"><gw:imgbtn id="btSve2" img="new" alt="New"  onclick="OnNew()" /></td>
							<td  style="display:"><gw:imgbtn id="btSve2" img="save" alt="Save"  onclick="OnSave()" /></td>
							<td  style="display:none"><gw:imgbtn id="btSve2" img="delete" alt="Delete"  onclick="OnDelete()" /></td>
						</tr>           
					</table>
				</fieldset>
			</td>
		</tr>
		<tr style="height: 99%;width:100%">
		   <td width="100%">
				<gw:grid 
				id="grdData"  
				header="Code|Order Work Division Name|Currency|BCWS|Net Construction Cost Total|Total Expenses|Safety Control Cost|Insurance Premium etc.|Others|Overhead Cost and Profit|_pk|_OrderWork_pk|_Project_pk|_Budget_pk"   
				format  ="0|0|0|1|1|1|1|1|1|1|0|0|0|0"  
				aligns    ="0|0|0|3|3|3|3|3|3|3|0|0|0|0"  
				defaults="|||||||||||||"  
				editcol ="0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1"  
				widths  ="1500|2500|900|2000|2500|2000|2000|2200|2000|2000|0|0|0|0"  
				styles="width:100%; height:100%"   
				sorting="T"
				oncellclick=""   
				oncelldblclick=""
				onafteredit="OnCaculator()"
				debug="true"
				/> 
		   </td>
		</tr>
	</table>

<gw:textbox id="txtPk" styles='width:100%;display:none' />      
<gw:textbox id="txtReturn_Mess" styles='width:100%;display:none' />      
</body>
</html>
