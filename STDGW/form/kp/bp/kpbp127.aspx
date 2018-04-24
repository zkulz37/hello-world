<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>1.2.7 Main Contract Progress</title>
</head>
<%ESysLib.SetUser("EC111")%>
<script>
function BodyInit()
{
      System.Translate(document);
	  MerGrid();
	  BindingDataList();
     dso_upd_master.StatusInsert();
}
//================================================================================================
function BindingDataList()
{
    
	data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
    Grid_Detail.SetComboFormat(3,data);
}
//================================================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/next_orange.gif";

    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/prev_orange.gif";

    }
}
//================================================================================================
function OnPopUp(obj)
{
        switch(obj)
        {
			case 'Level':
				var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown.aspx?Project_Pk=' + txtProject_Pk.text;
				var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
				if ( obj != null )
				{
						txtLevel_Pk.text = obj[2];
						txtLevel_Nm.text = obj[1];
						txtLevel_Cd.text = obj[0];
						dso_detail.Call('SELECT');
				}
			break;
			case 'project':
				var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
				var obj = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
				if ( obj != null )
				{
					txtProject_Pk.text = obj[0];
					txtProject_Cd.text = obj[1];
					txtProject_Nm.text = obj[2]; 
					dso_version.Call();
				}
			break;
		}
}
//================================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'dso_version':
		
		break;
		case 'dso_upd_master':
			if(txtStatus.text==2)
			{
				btnNew.SetEnable(true);
				btnSave.SetEnable(false);
				btnDelete.SetEnable(false);
				btnConfirm.SetEnable(false);
				btnCancel.SetEnable(true);	
				
				btnNew_dt.SetEnable(false);	
				btnDelete_dt.SetEnable(false);	
			}
			else if(txtStatus.text == 3)
			{
				btnCancel.SetEnable(false);	
				btnSave.SetEnable(false);
				btnDelete.SetEnable(false);
				btnConfirm.SetEnable(false);
				
				btnNew_dt.SetEnable(false);	
				btnDelete_dt.SetEnable(false);	
			}
			else
			{
				btnNew.SetEnable(true);
				btnSave.SetEnable(true);
				btnDelete.SetEnable(true);
				btnConfirm.SetEnable(true);
				btnCancel.SetEnable(false);	
				
				btnNew_dt.SetEnable(true);	
				btnDelete_dt.SetEnable(true);	
			}
			if(flag!='search')
			{
				Grid_Detail.SetRowStatus(1, 'Search');
				flag='save'
				dso_detail.Call();
			}
			else
			{
                Grid_Detail.SetRowStatus(1, 'Search');
				dso_detail.Call('SELECT');
			}
			
		break;
		case 'dso_detail':
        MerGrid();
            var fg = Grid_Detail.GetGridControl();
			 fg.MergeCells  = 4
			fg.MergeCol(0) = true;
            Grid_Detail.SetGridText(1,2,'');
            Grid_Detail.SetGridText(1,3,'');
            Grid_Detail.SetGridText(1,4,'');
			if(flag!='search')
			{
				dso_search_master.Call('SELECT');	
			}
		break;
	}
}
//================================================================================================
function MerGrid()
{
        if (Grid_Detail.rows < 2)
		{
			Grid_Detail.AddRow();
		}
		var fg=Grid_Detail.GetGridControl();
		fg.FixedRows = 2
		fg.MergeCells = 5

		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Group"
		
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Item"
		
		fg.MergeCol(3) = true
		fg.Cell(0, 0, 3, 1, 3) = "Unit"
		
		fg.MergeCol(4) = true
		fg.Cell(0, 0, 4, 1, 4) = "Plan Q'ty"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 5, 0, 7) = "Result Q'ty" 
		fg.Cell(0, 1, 5, 1 ) 	= "Unit Yesterday"
		fg.Cell(0, 1, 6, 1 ) 	= "Today"
		fg.Cell(0, 1, 7, 1 ) 	= "Accum."
		
		fg.Cell(0, 0, 8, 0, 10) = "Result Rate" 
		fg.Cell(0, 1, 8, 1 ) 	= "Unit Yesterday"
		fg.Cell(0, 1, 9, 1 ) 	= "Today"
		fg.Cell(0, 1, 10, 1 ) 	= "Accum."
}
//================================================================================================
function OnNew(obj)
{
	switch (obj)
	{
		case 'Master':
			dso_upd_master.StatusInsert();
            Grid_Detail.GridRefresh();
            MerGrid();
		break;
		case 'Detail':
			if(txtMasterPK.text!='')
			{
				var path = System.RootURL + '/form/kp/bp/kpbp127_popup_level.aspx?Project_Pk=' + txtProject_Pk.text ;
				var aValue = System.OpenModal( path ,900 , 500 , 'resizable:yes;status:yes');
				if(aValue != null)
				{
					var tmp = new Array();
                    for(var i=0; i<aValue.length; i++)
					{ 	
						tmp = aValue[i];
					    Grid_Detail.AddRow();
					    Grid_Detail.SetGridText(Grid_Detail.rows-1, 11, txtMasterPK.text);
					    Grid_Detail.SetGridText(Grid_Detail.rows-1, 13, dtDate.value);
					    Grid_Detail.SetGridText(Grid_Detail.rows-1, 2, tmp[1]);
					    Grid_Detail.SetGridText(Grid_Detail.rows-1, 12, tmp[2]);
                        Grid_Detail.SetGridText(Grid_Detail.rows-1, 14, tmp[3]);
                    }
				}
				
			}
			else
			{
				alert('Please select a row master !!');	
			}
		break;
	}
}

function OnEditDetail()
{
	if(event.col==0 || event.col==2)
	{
		var path = System.RootURL + '/form/kp/bp/kpbp127_popup_level1.aspx?Project_Pk=' + txtProject_Pk.text ;
		var aValue = System.OpenModal( path ,600 , 500 , 'resizable:yes;status:yes');
		if(aValue != null)
		{
				Grid_Detail.SetGridText(Grid_Detail.row, 2, aValue[1]);
				Grid_Detail.SetGridText(Grid_Detail.row, 12, aValue[2]);
                Grid_Detail.SetGridText(Grid_Detail.row, 14, aValue[3]);
		}
	}
}
//================================================================================================
function OnDelete(obj)
{
	switch (obj)
	{
		case 'Master':
			if(confirm('Are you sure you want to delete ?'))
		{
			dso_upd_master.StatusDelete();
			flag='delete';
			dso_upd_master.Call();
		}
		break;	
		case 'Detail':
			if(Grid_Detail.row>0)
			{
				if(confirm('Are you sure you want to delete ?'))
				{
					Grid_Detail.DeleteRow();
					flag='delete';
                    Grid_Detail.SetRowStatus(1, 'Search');
					dso_detail.Call();
				}
			}
			else
			{
				alert('Please select a row to delete !!')	
			}
		break;
	}
}

function OnPrint()
{
    if(txtMasterPK.text != '')
	{
		var url = System.RootURL + "/reports/kp/bp/kpbp127.aspx?Pk=" +txtMasterPK.text;
			System.OpenTargetPage(url);       
	}
	else
	{
			alert('Please select Date to print report !!');	
	}
}
//================================================================================================
function CellClick()
{
	txtMasterPK.text = grdSearch.GetGridData(grdSearch.row,0);	
	flag='search';
	dso_upd_master.Call('SELECT');
}
//================================================================================================
function OnSearch()
{
	dso_search_master.Call('SELECT');
}
var flag="";
//================================================================================================
function OnSave()
{
	if(txtProject_Pk.text != '')
	{	
		flag='save';
		dso_upd_master.Call();
	}
	else
	{
		alert('Please select Project !!');	
	}
}

function OnConfirm()
{
	if(txtMasterPK.text!='')
	{
		if(confirm('Are you sure you want to confirm ?'))
		{
			txtStatus.text = 'Confirm';
			dso_upd_master.Call();	
		}
	}
	else
	{
		alert('Please select grid master to confirm !!');	
	}
}

function OnCancel()
{
	if(txtMasterPK.text!='')
	{
		if(confirm('Are you sure you want to cancel ?'))
		{
			txtStatus.text = 'Cancel';
			dso_upd_master.Call();	
		}
	}
	else
	{
		alert('Please select grid master to cancel !!');	
	}
}
</script>
<body>
<gw:data id="dso_search_master" onreceive="OnDataReceive(this)"> 
			<xml> 
				<dso id="1" type="grid"    function="ec111.sp_sel_kpbp127_search"    > 
					<input bind="grdSearch">                    
						<input bind="dtFrom" /> 
						<input bind="dtTo" /> 
						<input bind="txtProject_M" />
					</input> 
					<output bind="grdSearch" /> 
				</dso> 
			</xml> 
     </gw:data>
<gw:data id="dso_upd_master" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9" function="ec111.sp_sel_kpbp127" procedure="ec111.sp_upd_kpbp127">
                <input>
                     <inout bind="txtMasterPK"  />
                     <inout bind="txtProject_Pk"  />
                     <inout bind="txtProject_Cd"  />
                     <inout bind="txtProject_Nm"  />
                     <inout bind="txtVersion_Pk"  />
                     <inout bind="lstVersion"  />
                     <inout bind="dtDate"  />
                     <inout bind="txtDescription"  />
                     <inout bind="txtLocal_Description"  />
                     <inout bind="txtStatus"  />
                </input>
            </dso>
        </xml>
    </gw:data>
    
<gw:data id="dso_version" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="ec111.SP_PRO_SEL_kpbp127" > 
            <input> 
                <input bind="txtProject_Pk" />
            </input>
	       <output>
           		<output bind="txtVersion_Pk" /> 
	            <output bind="lstVersion" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_detail" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14"  function="ec111.sp_sel_kpbp127_dt"  procedure="ec111.sp_upd_kpbp127_dt">
          <input bind="Grid_Detail" >
          <input bind="txtMasterPK" />
          <input bind="dtDate" />
          <input bind="txtLevel_Pk" />
          <input bind="txtProject_Pk" />
          </input>
          <output bind="Grid_Detail" />
        </dso>
      </xml>
    </gw:data>    
    
<table style="width: 100%; height: 100%;border-collapse: collapse" bordercolor="#00CCFF"  border="1" cellpadding="0" cellspacing="0">
        <tr style="height:100%" valign="top">
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height:4%">
                        <td>
                            <fieldset style="padding:0">
                                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                     <tr style="height:">
                                            <td style="width: 10%" align="right">Date&nbsp;</td>
                                            <td style="width: 89%; white-space: nowrap"><gw:datebox id="dtFrom" lang="1" />~<gw:datebox id="dtTo" lang="1" /></td>
                                            <td style="width: 1%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" /></td>
                                        </tr>
                                        <tr style="height: " >
                                            <td style="width: 10%" align="right">Project&nbsp;</td>
                                            <td colspan="2"><gw:textbox id="txtProject_M" styles="width: 100%" onenterkey="OnSearch('grdSearch')" /></td>
                                        </tr>
                                </table>
                              </fieldset>  
                        </td>
                    </tr>
                    <tr style="height: 96%" valign="top">
                        <td colspan="">
                            <gw:grid id='grdSearch' 
                            header='_PK|Date' 
                            format='0|0'
                            aligns='0|0' 
                            check='|' 
                            editcol='1|1' 
                            widths='0|1000' 
                            sorting='T'
                            styles='width:100%; height:100%' 
                            oncellclick="CellClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" width="75%" valign="top" style="background:white">
            	<table cellpadding="1" cellspacing="0" bordercolor="#00CCFF" style="border-collapse:collapse;width:100%;height:100%" border="1">
                    <tr style="background:#C5EFF1;height:2%">
                        <td align="right" width="20%"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">Project&nbsp;</a></td>
                        <td width="80%">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="30%"><gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' /></td>
                                    <td width="70%"><gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' /></td>
                                    <td width=""><gw:textbox id="txtProject_Pk" readonly="true" styles='width:100%;display:none' /></td>
                                    <td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="2" width="">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="20%"><gw:imgbtn id="btnNew" img="new" alt="New" onclick="OnNew('Master')" /></td>
                                    <td width="20%"><gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" /></td>
                                    <td width="20%"><gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete('Master')" /></td>
                                    <td width="20%"><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" onclick="OnConfirm()" /></td>
                                    <td width="20"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" /></td>
                                    <td style="display:none" width=""><gw:imgbtn id="btn" img="excel" alt="Print Report" onclick="OnPrint()" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background:#C5EFF1;height:2%">
                        <td align="right" ><a title="Click here to show Level" href="#" style="text-decoration: none" onClick="OnPopUp('Level')">Level</a></td>
                        <td  colspan="">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="30%"><gw:textbox id="txtLevel_Cd" styles='width:100%' readonly="T" /></td>
                                    <td width="70%" ><gw:textbox id="txtLevel_Nm" styles='width:100%' readonly="T" /></td>
                                    <td width=""><gw:textbox id="txtLevel_Pk" styles='width:0%;display:none' /></td>
                                    <td><gw:imgbtn id="btnnfim" img="reset" alt="Reset" onclick="txtLevel_Cd.text='';txtLevel_Nm.text='';txtLevel_Pk.text='';dso_detail.Call('SELECT');" /></td>
                                </tr>
                            </table>
                        </td> 
                        <td align="right" width="">Version&nbsp;</td>
                        <td width=""><gw:textbox id="lstVersion" styles='width:100%' /></td>
                    </tr>
                    <tr style="background:#C5EFF1;height:2%">
                        <td align="right"><a title="Description" style="color:#333">Descrip.&nbsp;</a></td>
                        <td colspan=""><gw:textbox id="txtDescription" styles='width:100%' /></td>
                        <td align="right">Date&nbsp;</td>
                        <td><gw:datebox id="dtDate" styles='width:100%' lang="1" /></td>
                    </tr>
                    <tr style="background:#C5EFF1;height:2%">
                        <td align="right"><a title="Local Description" style="color:#333">L. Descrip.&nbsp;</a></td>
                        <td colspan="3"><gw:textbox id="txtLocal_Description" styles='width:100%' /></td>
                        
                    </tr>
                    <tr height="2%">
                    	<td colspan="4">
                        	<table cellpadding="0" cellspacing="0" width="100%">
                            	<tr>
                                	<td width="100%"></td>
                                    <td width=""><gw:imgbtn id="btnNew_dt" img="new" alt="New" onclick="OnNew('Detail')" /></td>
                                    <td width=""><gw:imgbtn id="btnDelete_dt" img="delete" alt="Delete" onclick="OnDelete('Detail')" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                   
                    <tr height="88%">
                    	<td colspan="4">
                            <gw:grid id='Grid_Detail' 
                            	header='Group|_0._PK|2.Item|3.Unit|4.Plan Qty|5.Unit Yesterday|6.Today|7.Accum|8.Unit Yesterday|9.Today|10.Accum|_11.Master_pk|_12.level_pk|_13.result date|_14.TECPS_UNDERTAKECTRTRMRK_pk' 
							    format='0|0|0|0|1|1|1|1|1|1|1|0|0|0|0'
                                aligns='0|0|0|1|0|0|0|0|0|0|0|0|0|0|0' 
								check='||||||||||||||' 
							   editcol='0|0|0|1|1|0|1|0|0|1|0|0|0|0|0' 
								widths='3000|0|3000|1500|1500|2000|2000|2000|2000|2000|2000|0|0|0|0' 
                                sorting='T'
                                styles='width:100%; height:100%' 
                                onafteredit=""
                                oncelldblclick="OnEditDetail()" />
                        </td>
                    </tr>
                   
                </table>
            </td>
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;position: absolute; left: 1; top: 0;" onClick="OnToggle()" />
  
<gw:textbox id="txtMasterPK" styles='width:100%;display:none' />  
<gw:textbox id="txtVersion_Pk" styles='width:100%;display:none' />         
<gw:textbox id="txtStatus" styles='width:100%;display:none' />         
       
 
</body>
</html>
