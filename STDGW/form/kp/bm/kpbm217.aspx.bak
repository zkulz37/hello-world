<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Project</title>
</head>
<%  ESysLib.SetUser("EC111")%>
<script>
function BodyInit()
{
        System.Translate(document);
	    BindingDataList();
		FormatGrid();
}  
//============================================================================================
function OnCaculator()
{
			var Net = Grid_Detail.GetGridData(Grid_Detail.row, 4);
			var Total = Grid_Detail.GetGridData(Grid_Detail.row, 5);
			var BCWS = 0;
			BCWS = Number(Net) + Number(Total);
			Grid_Detail.SetGridText(Grid_Detail.row, 3, BCWS);
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
//====================================================================================================================
function BindingDataList()
{
	
	var ls_Budget_No = "<%=ESysLib.SetListDataSQL("select pk, seq from TECPS_PERFORMBUDGETBASC where del_if = 0 order by BUDGETDOCNUM")%>||";
	//lstBudgetNo.SetDataText(ls_Budget_No);
//	lstBudgetNo.value = '';
	//ccy
	//<%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 2,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 
}
//====================================================================================================================
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
                            var path = System.RootURL + "/form/kp/bm/kpbm00070_popup_Inquiry.aspx?BCWS=" + Grid_Detail.GetGridData(Grid_Detail.row, 3) + '&NetContract=' + Grid_Detail.GetGridData(Grid_Detail.row, 4) + '&Expense=' + Grid_Detail.GetGridData(Grid_Detail.row, 5) + '&Project_pk=' + Grid_Detail.GetGridData(Grid_Detail.row, 12) ;
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
                                    Grid_Detail.SetGridText(Grid_Detail.row, 11,   aValue[0]);
									Grid_Detail.SetGridText(Grid_Detail.row, 0, aValue[1]);
									Grid_Detail.SetGridText(Grid_Detail.row, 1, aValue[2]);
									Grid_Detail.SetGridText(Grid_Detail.row, 2, aValue[3]);
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
		dso_search.Call('SELECT');
	}
	else
	{
		alert('Please select Project to search !!');
	}
}
//====================================================================================================================
function OnClick()
{
			txtPk.SetDataText(Grid_Detail.GetGridData(Grid_Detail.row, 10));
			
}
//====================================================================================================================
/*function OnNew()
{
		if(txtProject_Pk.text !='')
		{
			Grid_Detail.AddRow();
			Grid_Detail.SetGridText(Grid_Detail.rows -1, 12, txtProject_Pk.text);
			Grid_Detail.SetGridText(Grid_Detail.rows -1, 13, lstBudgetNo.value);
		}
		else
		{
			alert('Please select a project !!');	
		}
}*/
//====================================================================================================================
function OnSave()
{
			dso_update.Call();
}
//====================================================================================================================
function OnDelete()  
{
		if(confirm('Are you sure you want to delete !!'))
		{
			Grid_Detail.DeleteRow();
			dso_update.Call();
		}
}
//====================================================================================================================
function FormatGrid()
{ 
	var ctrl = Grid_Detail.GetGridControl();
	ctrl.ColFormat(3) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(4) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(5) = "#,###,###,###,###,###,###,###,###.##R";
}
function OnDataReceive(obj)
{
         switch(obj.id)
         {
                case "dso_create":
						//FormatGrid();
						alert(txtReturn_Mess.text);
						dso_search.Call("SELECT");
				break;
				case "dso_budget_no":
						dso_search.Call("SELECT");
				break;
		 }
}
</script>
<body>
 <gw:data id="dso_update" onreceive="OnDataReceive(this)">
    <xml>
        <dso id="1" type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="ec111.sp_sel_kpbm00070_1"    procedure="ec111.sp_upd_kpbm00070_1">
            <input bind="Grid_Detail">
                <input bind="txtProject_Pk"/>
                <input bind="lstBudgetNo"/>
            </input>
            <output bind="Grid_Detail"/>
        </dso>
    </xml>
</gw:data>

<gw:data id="dso_budget_no" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="ec111.SP_PRO_SEL_kpbp00070" > 
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
        <dso type="process" procedure="ec111.sp_pro_kpbm00070" > 
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

 <gw:data id="dso_search" onreceive="OnDataReceive(this)">
    <xml>
        <dso id="1" type="grid"  function="ec111.sp_sel_kpbm00070"    >
            <input bind="Grid_Detail">
                <input bind="txtProject_Pk"/>
                <input bind="lstBudgetNo"/>
            </input>
            <output bind="Grid_Detail"/>
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
                                                        <td ><gw:imgbtn id="btSve2" img="create" alt="Create"  onclick="OnCreate()" /></td>
                                                        <td ><gw:imgbtn id="btSve2" img="search" alt="Search"  onclick="OnSearch()" /></td>
                                                        <td style="display:none"><gw:imgbtn id="btSve2" img="new" alt="New"  onclick="OnNew()" /></td>
                                                        <td  style="display:none"><gw:imgbtn id="btSve2" img="save" alt="Save"  onclick="OnSave()" /></td>
                                                        <td  style="display:none"><gw:imgbtn id="btSve2" img="delete" alt="Delete"  onclick="OnDelete()" /></td>
                                            </tr>           
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 99%;width:100%">
                       <td width="100%">
								                    			<gw:grid 
													            id="Grid_Detail"  
													            header="_Project_pk|_tecps_orderingconttype_pk|Code|Order Work Division Name|Currency|BCWS|Net Construction Cost Total|Total Expenses|Safety Control Cost|Insurance Premium etc.|Others|Overhead Cost and Profit|_pk|_OrderWork_pk|_Project_pk|_Budget_pk"   
													            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
													            aligns   ="0|0|0|0|1|3|3|3|0|0|0|0|0|0|0|0"  
													            defaults="|||||||||||||||"  
													            editcol ="0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1"  
													            widths  ="0|0|1500|2500|900|2000|2500|2000|2000|2200|2000|2000|0|0|0|0"  
													            styles="width:100%; height:100%"   
													            sorting="T"
                                                                oncellclick="OnClick()"   
                                                                oncelldblclick="OnPopUp('New');OnPopUp('Create')"
                                                                onafteredit="OnCaculator()"
													            /> 
										        </td>
                    </tr>
                </table>
        <gw:textbox id="txtPk" styles='width:100%;display:none' />      
		 <gw:textbox id="txtReturn_Mess" styles='width:100%;display:none' />      
</body>
</html>
