<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Budget detail</title>
</head>
<%  ESysLib.SetUser("ec111")%>
<script>
function BodyInit()
{
    var vendor = document.all("updating_info"); 
    vendor.style.display = "none";
    imgup.src = "../../../system/images/down.gif";
	var ls_company = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if=0")%>";
	lstCOMPANY.SetDataText(ls_company);
	lstCOMPANY.value = "<%=session("company_pk") %>";
    BindingDataList();
	System.Translate(document);
	FormatGrid();
	Grid_Detail.GetGridControl().FrozenCols = 5;
	Grid_Detail.GetGridControl().WordWrap = true;
    Grid_Detail.GetGridControl().RowHeight(0) = 450 ;

}
//-------------------------------------------------------------------------------------------------------------------------------------
function BindingDataList()
{
    //Level
	<%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 2,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'EACAB052' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' order by to_number(code)")%>; 
	//Ccy
	<%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 7,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 

	//Category
	<%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 31,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0018' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	var ls_Level = "<%=ESysLib.SetListDataFUNC("SELECT ACNT.SF_A_GET_COMMONCODE('EACAB052') FROM DUAL")%>|ALL|All Level"; 
	lstLevel.SetDataText(ls_Level); 
	lstLevel.value = "ALL"; 
	//UOM
	data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| '' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
	Grid_Detail.SetComboFormat(6,data);
	var ls_Version = "<%=ESysLib.SetListDataSQL("select pk, UNDERTAKECHANGESEQ from ec111.tecps_undertakectrtbasc where del_if = 0 and CONFIRMYN = 'Y'")%>";
	//lstVersion.SetDataText(ls_Version);
	ls_Category = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('TPS0018') FROM DUAL")%>";
	lstField.SetDataText(ls_Category);
	
	var ls_Filter = "DATA|F|Filter";
	ls_Filter = "DATA|ALL|Select All|1|Code|2|Name|3|Child Node|4|Order W. Code";
	lstSearch.SetDataText(ls_Filter);
   var	data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
   var arr  = data.split("|");
   txtbookccy.SetDataText(arr[1]);

}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnPopUp(obj)
{
        switch(obj)
        {
                case 'Levelcode':
					var path = System.RootURL + '/form/kp/bm/kpbm215_pitem_4update.aspx?Project_Pk=' + txtProject_Pk.text;
					var obj = System.OpenModal( path ,900 , 600 , 'resizable:yes;status:yes');
					if ( obj != null )
					{
							txtLevel_pk_s.SetDataText(obj[3]);
							txtWork_Breakdown_Nm.text = obj[1];
					}
				break;
				case 'Work_Breakdown':
                            var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown.aspx?Project_Pk=' + txtProject_Pk.text;
		                    var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
		                    if ( obj != null )
		                    {
									lstWork_Breakdown.SetDataText(obj[2]);
									txtWork_Breakdown_Nm.text = obj[1];
                            }
                break;
                case 'Project':
					var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
					var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
					if(aValue != null)
					{
							txtProject_Pk.text = aValue[0];
							txtProject_Cd.text = aValue[1];
							txtProject_Nm.text = aValue[2];  
							dso_version.Call();
					} 
                break;
              
                case 'Version':
					var fpath = System.RootURL + "/form/kp/bp/kpbp00020_popup_Version.aspx?Project_Pk=" + txtProject_Pk.text;
					var aValue = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
					if(aValue != null)
					{
							lstVersion.value = aValue[0];
					} 
                break;
				case 'Category':
					var path = System.RootURL + '/form/gf/os/gfos00070_popup_1.aspx?code=TPS0018';
					var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
					 if (object != null )
					 {
						 lstCategory.SetDataText(object[1]);
					 }
				break;
        }
}  
//-------------------------------------------------------------------------------------------------------------------------------------
function OnNew()
{
            if(txtProject_Pk.text == '' )
            {
                    alert('Please select Project !!');
            } 
            else
            {
              
                var _ccy= '';
                  if(Grid_Top.rows==2)
                  {
                       _ccy =  Grid_Top.GetGridData(Grid_Top.rows-1,0);
                  }
                  else if(Grid_Top.rows==1)
                  {
                    _ccy='USD';
                  }
                  else if(Grid_Top.rows>2)
                  {
                    _ccy='USD';//_ccy =  Grid_Top.GetGridData(Grid_Top.row,0);
                  }
					 var path = System.RootURL + '/form/kp/bm/kpbm215_pitem.aspx?Project_Pk=' + txtProject_Pk.text;
					 var aValue = System.OpenModal( path ,900 , 700 , 'resizable:yes;status:yes');
					 if(aValue != null)
					 {
						var tmp = new Array();
						tmp = aValue[0]; 
						txtLevel_pk.text = tmp[2]; 
						//Upper Code|Item code|Item Name|_Levelcode_pk|_item_pk|Level
						for(var i=0; i<aValue.length; i++)
						{ 
							tmp = aValue[i];
							Grid_Detail.AddRow();
							SetBackColor();
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 3, tmp[0]);  //level
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 4, tmp[1]); //code
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 5, tmp[2]); //name
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 32, tmp[3]); //_Levelcode_pk 
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 26, tmp[4]); //_item_pk 
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 2, tmp[5]); //Level 
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 30, txtProject_Pk.text); //pk  
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 1, lstVersion.value); //version pk  
							//Grid_Detail.SetGridText(Grid_Detail.rows - 1, 3, i ); 
							
							Grid_Detail.SetGridText(Grid_Detail.rows - 1, 7, _ccy); //version pk  
						}
					
						if(lstField.value != 'ALL')
						{
									Grid_Detail.SetGridText(Grid_Detail.rows - 1, 6, lstField.value); //version pk  
						}
						else
						{return;}
					
					}
                    
           } 
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnEditLevel()
{
	
	if(event.col=='14' || event.col=='15')
	{
		var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk=" + txtProject_Pk.GetData();
		var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
		 
		if (object != null)
		{
			Grid_Detail.SetGridText(Grid_Detail.row, 28,   object[0]);
			Grid_Detail.SetGridText(Grid_Detail.row, 14, object[1]);
			Grid_Detail.SetGridText(Grid_Detail.row, 15, object[2]);
		}
	}
	if(event.col=='16' || event.col=='17')
	{
		var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Budget.aspx?p_project_pk=" + txtProject_Pk.GetData();
		var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
		if(object != null)
		{
			Grid_Detail.SetGridText(Grid_Detail.row, 27,   object[0]);
			Grid_Detail.SetGridText(Grid_Detail.row, 16, object[1]);
			Grid_Detail.SetGridText(Grid_Detail.row, 17, object[2]);
		}
	}
	if(event.col=='18')
	{
		 var fpath = System.RootURL + "/form/kp/ac/kpac00070.aspx"
		var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
		if (object != null)
		{
			Grid_Detail.SetGridText(Grid_Detail.row, 29,   object[0]);
			Grid_Detail.SetGridText(Grid_Detail.row, 18, object[1]+' - '+object[2]);
		}
	}
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function CheckDuplicateLevel()
{
    for(var i = 1; i < Grid_Detail.rows; i++)
    {
        if(Grid_Detail.GetGridData(i, 20) == txtLevel_pk.text)
        {
             alert("Duplicated Level Code!! ");
             return false ;
        }
    }
    return true;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnSearch()
{
	if(txtProject_Pk.text != '')
	{
		
		dso_Update.Call("SELECT");
	}
	else
	{
			alert('Please select a project to search !!');	
	}
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnCheckSum()
{
    var i=0;
    var j = 0;
    var _total_book_amt = 0;
    var _total_grid_bk = 0;
    var _total_grid_tr = 0;
    
    if(Number(txtBalance.text)<0)
    {
        alert('Contract Amount can not be large than Trans. Amount !!');
        return true;
    }
    return false;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnSave()
{
	for(i=1;i<Grid_Detail.rows;i++)
		{
		    Grid_Detail.SetGridText(i,31,lstField.GetData());
			if( Grid_Detail.GetGridData(i,0) =='' && Grid_Detail.GetGridData(i,33) =='I' )
			{
			   Grid_Detail.SetRowStatus(i, 0x20);
			}
		}
	dso_Update.Call();
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDelete()
{
		if(confirm('Are you sure you want to delete ?'))
        Grid_Detail.DeleteRow();
		OnSave();
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnUnDelete()
{
        Grid_Detail.UnDeleteRow();

}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
function CalcBalane()
{
    var i=0;
    var _Sum_ContAmt = 0;
    var _Trans_Amt = 0;
    var _Balance = 0;
    var _Sum_BookAmt_Top = 0;
    var j=0;                
    
    
    if(Grid_Detail.rows>2)
    {
        for(i=2;i<Grid_Detail.rows;i++)
        {
            _Sum_ContAmt += Math.round(Number(Grid_Detail.GetGridData(i,32)));
        }
    }
    txtContAmt_Total.text = _Sum_ContAmt;
    if(Grid_Top.rows==2)
    {
        _Trans_Amt = Number(Grid_Top.GetGridData(Grid_Top.rows-1, 2));
        _Balance = Math.round(_Trans_Amt - _Sum_ContAmt);
    }
    else if(Grid_Top.rows>2)
    {
        for(j=1;j<Grid_Top.rows;j++)
        {
            _Sum_BookAmt_Top += Math.round(Number(Grid_Top.GetGridData(j,5)));
        }
        _Balance = Math.round(_Sum_BookAmt_Top - _Sum_ContAmt);
    }
    txtBalance.text = _Balance;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
         switch(obj.id)
         {
			case "dso_Update":
			var ctrl     = Grid_Detail.GetGridControl();
            for (i=1; i<ctrl.Rows; i++)
            {
                if(Grid_Detail.GetGridData(i,2) != "")
                {
                    Grid_Detail.SetCellBold(i,0,i,32,true);
                }
                else
                {   
                    Grid_Detail.SetCellBold(i,0,i,32,false);
                }
                
                
                if (Grid_Detail.GetGridData(i,2)== "0" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0XF4E6E0'));
                }
                else if (Grid_Detail.GetGridData(i,2)== "1" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0X99CCFF'));
                }
                else if (Grid_Detail.GetGridData(i,2)== "2" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0XCCFFCC'));
                }
                else if (Grid_Detail.GetGridData(i,2)== "3" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0XCCFF00'));//3 00CCFF
                }
                else if (Grid_Detail.GetGridData(i,2)== "4" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0XFF99CC'));//4
                }
                else if (Grid_Detail.GetGridData(i,2)== "5" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0XCC9999'));//5
                }
                else if (Grid_Detail.GetGridData(i,2)== "6" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0X009933'));//6m
                }
                else if (Grid_Detail.GetGridData(i,2)== "7" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0XCC6633'));//7
                }
                else if (Grid_Detail.GetGridData(i,2)== "8" && Grid_Detail.GetGridData(i,26) == "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0X006666'));//8
                }
                else if (Grid_Detail.GetGridData(i,4) != "")
                {
                    Grid_Detail.SetCellBgColor(i,0,i,32, Number('0XEFFFFF'));
                }
                
            }
			break;
				case "dso_copy":
					dso_Update.Call("SELECT");
					alert(txtReturnValue.text);
				break;
             	case "dso_version":
						dso_top.Call("SELECT");
				break;
                case 'dso_top':
                    var vendor = document.all("updating_info"); 
                    if(Grid_Top.rows>1)
                    {
                        vendor.style.display = "";
                        imgup.src = "../../../system/images/up.gif";
                    }
                    else
                    {
                        vendor.style.display = "none";
                        imgup.src = "../../../system/images/down.gif";
                    }
                    dso_Intergrated_YN.Call();
                break;
				case "dso_Intergrated_YN":
                
						 var fg=Grid_Detail.GetGridControl(); 	
                         	if(txtIntergrated_YN.text == 'Y')
							{
									fg.ColHidden(11) = true; //Labor Unit Cost
									fg.ColHidden(12) = true; //Labor Amt
									fg.ColHidden(13) = true; //Cost Unit Cost
									fg.ColHidden(14) = true; //Cost Amt
									fg.ColHidden(15) = true; //Material Unit Cost
									fg.ColHidden(16) = true; //Material Amt
									fg.ColHidden(17) = true; //Material Unit Cost
									fg.ColHidden(18) = true; //Material Amt
									fg.ColHidden(19) = true; //Material Amt
									//fg.ColHidden(24) = true; //Cost Amt
									fg.ColHidden(25) = true; //Material Unit Cost
									fg.ColHidden(26) = true; //Material Amt
									fg.ColHidden(27) = true; //Material Unit Cost
									fg.ColHidden(28) = true; //Material Amt
									fg.ColHidden(29) = true; //Material Amt
									fg.ColHidden(30) = true; //Material Amt
							}
							else
							{
									fg.ColHidden(10) = false; //Labor Unit Cost
									fg.ColHidden(11) = false; //Labor Unit Cost
									fg.ColHidden(12) = false; //Labor Amt
									fg.ColHidden(13) = false; //Cost Unit Cost
									fg.ColHidden(14) = false; //Cost Amt
									fg.ColHidden(15) = false; //Material Unit Cost
									fg.ColHidden(16) = false; //Material Amt
									fg.ColHidden(17) = false; //Material Unit Cost
									fg.ColHidden(18) = false; //Material Amt
									fg.ColHidden(19) = false; //Material Amt
									//fg.ColHidden(24) = false; //Cost Amt
									fg.ColHidden(25) = false; //Material Unit Cost
									fg.ColHidden(26) = false; //Material Amt
									fg.ColHidden(27) = false; //Material Unit Cost
									fg.ColHidden(28) = false; //Material Amt
									fg.ColHidden(29) = false; //Material Amt
									fg.ColHidden(30) = false; //Material Amt
							}
							SetBackColor();
							dso_get_book_rate.Call();
				break;
				case "dso_Delete":
						dso_Update.Call("SELECT");
						alert(txtReturnValue.text);
				break;
         }
}


//-------------------------------------------------------------------------------------------------------------------------------------
function SetBackColor()
{
		var fg=Grid_Detail.GetGridControl(); 	
		for (i = 2; i < fg.Rows; i++)
		{
					/*Grid_Detail.SetCellBgColor(i,11,i, 19, 0xEDEDED);
					Grid_Detail.SetCellBgColor(i,26,i, 26, 0xEDEDED);
					Grid_Detail.SetCellBgColor(i,28,i, 28, 0xEDEDED);
					Grid_Detail.SetCellBgColor(i,30,i, 30, 0xEDEDED);
					Grid_Detail.SetCellBgColor(i,32,i, 32, 0xEDEDED);
					Grid_Detail.SetCellBgColor(i,33,i, 34, 0xEDEDED);*/
		}
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
 function OnShowHide(obj)
 {
	 		var fg=Grid_Detail.GetGridControl(); 	
	 		switch(obj)
			{
				case 1:
						if(cbLevelCode.value == 'N')
						{
								fg.ColHidden(4) = true; //Level Code
						}
						else
						{
								fg.ColHidden(4) = false; //Level Code
						}
				break;
				case 2:
						if(cbStd.value == 'N')
						{
								fg.ColHidden(8) = true; //Standard
						}
						else
						{
								fg.ColHidden(8) = false; //Standard
						}
				break;
				case 3:
						if(cbUnit.value == 'N')
						{
								fg.ColHidden(9) = true; //Unit
						}
						else
						{
								fg.ColHidden(9) = false; //Unit
						}
				break;
				case 4:
						if(cbRaw.value == 'N')
						{
								fg.ColHidden(13) = true;
								fg.ColHidden(15) = true;
								fg.ColHidden(17) = true;
								fg.ColHidden(26) = true;
								fg.ColHidden(28) = true;
								fg.ColHidden(30) = true;
						}
						else
						{
								fg.ColHidden(13) = false;
								fg.ColHidden(15) = false;
								fg.ColHidden(17) = false;
								fg.ColHidden(26) = false;
								fg.ColHidden(28) = false;
								fg.ColHidden(30) = false;
						}
				break;
				case 5:
						if(cbCompared.value == 'N')
						{
								
								fg.ColHidden(11) = true;
								fg.ColHidden(12) = true;
								fg.ColHidden(13) = true;
								fg.ColHidden(14) = true;
								fg.ColHidden(15) = true;
								fg.ColHidden(16) = true;
								fg.ColHidden(17) = true;
								fg.ColHidden(18) = true;
								fg.ColHidden(19) = true;
								fg.ColHidden(33) = true;
								fg.ColHidden(34) = true;
						}
						else
						{
								
								fg.ColHidden(11) = false;
								fg.ColHidden(12) = false;
								fg.ColHidden(13) = false;
								fg.ColHidden(14) = false;
								fg.ColHidden(15) = false;
								fg.ColHidden(16) = false;
								fg.ColHidden(17) = false;
								fg.ColHidden(18) = false;
								fg.ColHidden(19) = false;
								fg.ColHidden(33) = false;
								fg.ColHidden(34) = false;
						}
				break;
			}
 }
//-------------------------------------------------------------------------------------------------------------------------------------
function OnCalculator()
{
	   
		var c_qty = Number(Grid_Detail.GetGridData(Grid_Detail.row, 8));
        var c_MUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, 9));
        var c_LUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, 10));
        var c_EUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, 11));
		
		var c_UP = Number(Grid_Detail.GetGridData(Grid_Detail.row, 12));
		var c_Material_Amt = 0;
		var _Bk_Material_UP = 0;
		var _Bk_Material_Amt = 0;
		
		var c_Labor_Amt = 0;
		var _Bk_Labor_UP= 0;
		var _Bk_Labor_Amt = 0;
		
		var c_Equipment_Amt = 0;
		var _Bk_Equipment_UP = 0;
		var _Bk_Equipment_Amt = 0;
		
		var c_Sum_UnitPrice = 0;
		var c_Amount = 0;
		var _Amount1 = 0;
		var _Amount_bk = 0;
		var _Amount_bk1 = 0;
		var _Bk_Sum_UnitPrice = 0;
		var _Bk_Sum_UnitPrice1 = 0;
        var _UP=0;
		if (c_qty == '') c_qty = 0;
		if (_Bk_Equipment_UP == '') _Bk_Equipment_UP = 0;			
		
		    c_Material_Amt = Number(c_qty) * Number(c_MUP);
			c_Labor_Amt = Number(c_qty * c_LUP); 
			c_Equipment_Amt = Number(c_qty * c_EUP);
			c_Sum_UnitPrice = Number(c_MUP) + Number(c_LUP) + Number(c_EUP);
			c_Amount = Number( c_Material_Amt + c_Labor_Amt + c_Equipment_Amt);
			_Amount1 = Number(c_qty * c_UP);
	//==========tinh tien book===========================
		var _book_rate = Number(txtBookRate.text);
		var tr_rate = Number(txtTR_RATE.text);
		lstCcy.text = Grid_Detail.GetGridData(event.row, 10);
		if(txtbookccy.text == 'VND' && _book_rate > 0)
		{
				if(Grid_Detail.GetGridData(event.row, 10) == 'USD')
				{
						OnGetRate();
						_Bk_Material_UP = Math.round(c_MUP * tr_rate);
						_Bk_Material_Amt = Math.round(c_Material_Amt * tr_rate);
						_Bk_Labor_UP = Math.round(c_LUP * tr_rate);
						_Bk_Labor_Amt = Math.round(c_Labor_Amt * tr_rate);
						_Bk_Equipment_UP = Math.round(c_EUP * tr_rate);
						_Bk_Equipment_Amt = Math.round(c_Equipment_Amt * tr_rate);
						_Bk_Sum_UnitPrice = Math.round(c_Sum_UnitPrice * tr_rate);
						_Amount_bk1 = Math.round(_Amount1 * tr_rate);
						_Amount_bk = Math.round(c_Amount * tr_rate);
						_UP = Math.round(c_UP * tr_rate);
				}
				else if(lstCcy.text == 'VND')
				{
						_Bk_Material_UP = c_MUP ;
						_Bk_Material_Amt = c_Material_Amt;
						_Bk_Labor_UP = c_LUP ;
						_Bk_Labor_Amt = c_Labor_Amt ;
						_Bk_Equipment_UP = c_EUP ;
						_Bk_Equipment_Amt = c_Equipment_Amt;
						_Bk_Sum_UnitPrice = c_Sum_UnitPrice ;
						_Amount_bk1 = _Amount1 ;
						_Amount_bk = c_Amount;
						_UP = c_UP ;
				}
                else
                {
                        OnGetRate();
                        _Bk_Material_UP = Math.round(c_MUP * tr_rate);
						_Bk_Material_Amt = Math.round(c_Material_Amt * tr_rate);
						_Bk_Labor_UP = Math.round(c_LUP * tr_rate);
						_Bk_Labor_Amt = Math.round(c_Labor_Amt * tr_rate);
						_Bk_Equipment_UP = Math.round(c_EUP * tr_rate);
						_Bk_Equipment_Amt = Math.round(c_Equipment_Amt * tr_rate);
						_Bk_Sum_UnitPrice = Math.round(c_Sum_UnitPrice * tr_rate);
						_Amount_bk1 = Math.round(_Amount1 * tr_rate);
						_Amount_bk = Math.round(c_Amount * tr_rate);
						_UP = Math.round(c_UP * tr_rate);
                }
		}  
		else if(txtbookccy.text == 'USD' && _book_rate > 0)
		{
				if(lstCcy.text == 'USD')
				{
							_Bk_Material_UP = c_MUP ;
						_Bk_Material_Amt = c_Material_Amt;
						_Bk_Labor_UP = c_LUP ;
						_Bk_Labor_Amt = c_Labor_Amt ;
						_Bk_Equipment_UP = c_EUP ;
						_Bk_Equipment_Amt = c_Equipment_Amt;
						_Bk_Sum_UnitPrice = c_Sum_UnitPrice ;
						_Amount_bk1 = _Amount1 ;
						_Amount_bk = c_Amount;
						_UP = c_UP ;
				}
				else if(lstCcy.text == 'VND')
				{
				       
						_Bk_Material_UP = c_MUP / _book_rate ;
						_Bk_Material_Amt = c_Material_Amt / _book_rate ;
						_Bk_Labor_UP = c_LUP  / _book_rate ;
						_Bk_Labor_Amt = c_Labor_Amt  / _book_rate;
						_Bk_Equipment_UP = c_EUP / _book_rate ;
						_Bk_Equipment_Amt = c_Equipment_Amt / _book_rate;
						_Bk_Sum_UnitPrice = c_Sum_UnitPrice / _book_rate;
						_Amount_bk1 = _Amount1 / _book_rate ;
						_Amount_bk = c_Amount / _book_rate ;
						_UP = c_UP  / _book_rate ;
				}
                else
                {
                    OnGetRate();
					_Bk_Material_UP =  c_MUP *  tr_rate / _book_rate ;
						_Bk_Material_Amt = c_Material_Amt  *  tr_rate / _book_rate ;
						_Bk_Labor_UP = c_LUP  *  tr_rate  / _book_rate ;
						_Bk_Labor_Amt = c_Labor_Amt   *  tr_rate / _book_rate ;
						_Bk_Equipment_UP = c_EUP   *  tr_rate / _book_rate;
						_Bk_Equipment_Amt = c_Equipment_Amt  *  tr_rate  / _book_rate ;
						_Bk_Sum_UnitPrice = c_Sum_UnitPrice  *  tr_rate  / _book_rate ;
						_Amount_bk1 = _Amount1  *  tr_rate  / _book_rate;
						_Amount_bk =  c_Amount   *  tr_rate / _book_rate ;
						_UP = c_UP   *  tr_rate  / _book_rate ;
                }
		}

		
        CalcBalane();
}
//-------------------------------------------------------------------------------------------------------------------------------
function FormatGrid()
{ 
	var ctrl = Grid_Detail.GetGridControl();
	
	ctrl.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(10) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(12) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(20) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(21) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(22) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(23) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(24) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(25) = "#,###,###,###,###,###,###,###,###.##R";
}
//-------------------------------------------------------------------------------------------------------------------------------
function OnPrint()
{
		if(txtProject_Pk.text != '')
		{
			var url = System.RootURL + "/reports/kp/bp/kpbp00050.aspx?Project_pk=" +txtProject_Pk.text + "&Work=" + lstWork_Breakdown.text + "&Field=" + lstField.value +  "&Version=" + lstVersion.value + "&Intergrated_YN=" + txtIntergrated_YN.text;
			 System.OpenTargetPage(url);       
		}
		else
		{
				alert('Please select Project !!');	
		}
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnCopy()
{
	dso_copy.Call();
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnGetRate()
{
	dso_get_trans_rate.Call();	
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDeleteAll()
{
		if(confirm("Are you sure you want to delete all data!!"))
		{
				dso_Delete.Call();
		} 
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnOriginal()
{
	if(lstVersion.GetText() == 0)
	{
		Grid_Detail.SetGridText(Grid_Detail.row, 11, Grid_Detail.GetGridData(Grid_Detail.row, 24));
		Grid_Detail.SetGridText(Grid_Detail.row, 12, Grid_Detail.GetGridData(Grid_Detail.row, 25));
		Grid_Detail.SetGridText(Grid_Detail.row, 13, Grid_Detail.GetGridData(Grid_Detail.row, 26));
		Grid_Detail.SetGridText(Grid_Detail.row, 14, Grid_Detail.GetGridData(Grid_Detail.row, 27));
		Grid_Detail.SetGridText(Grid_Detail.row, 15, Grid_Detail.GetGridData(Grid_Detail.row, 28));
		Grid_Detail.SetGridText(Grid_Detail.row, 16, Grid_Detail.GetGridData(Grid_Detail.row, 29));
		Grid_Detail.SetGridText(Grid_Detail.row, 17, Grid_Detail.GetGridData(Grid_Detail.row, 30));
		Grid_Detail.SetGridText(Grid_Detail.row, 18, Grid_Detail.GetGridData(Grid_Detail.row, 31));
		Grid_Detail.SetGridText(Grid_Detail.row, 19, Grid_Detail.GetGridData(Grid_Detail.row, 32));
	}
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnShow() 
{
    var vendor = document.all("updating_info"); 
 
    if ( vendor.style.display == "none" )
    {
        vendor.style.display = "";
        imgup.src = "../../../system/images/up.gif";
    }
    else
    {
        vendor.style.display = "none";
        imgup.src = "../../../system/images/down.gif";
    }
}
//-------------------------------------------------------------------------------------------------------------------------------------

</script>
<body>
    <gw:data id="dso_Update" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,19,20,21,22,23,24,25,26,27,28,29,30,31,32" function="ec111.sp_sel_kpbm215_2" procedure="ec111.sp_upd_kpbm215_1">
                    <input bind="Grid_Detail">
                    <input bind="txtProject_Pk"/>
                    <input bind="txtLevel_pk_s"/>
                    <input bind="lstField"/>
                    <input bind="lstVersion"/> 
                    <input bind="txtSearch"/>
                </input> 
                <output bind="Grid_Detail"/>
            </dso>
        </xml>
    </gw:data>
   
    <gw:data id="dso_get_book_rate" onreceive="">
        <xml> 
            <dso type="process" procedure="ec111.sp_pro_kpbp00050_getrate"> 
                <input> 
                	 <input bind="txtProject_Pk" />
                </input>
                <output>
                     <output bind="txtBookRate"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dso_version" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="ec111.sp_pro_kpbm215_1" > 
            <input> 
                <input bind="txtProject_Pk" />
            </input>
	       <output>
	            <output bind="lstVersion" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_Intergrated_YN" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="ec111.SP_PRO_SEL_kpbp00050_2" > 
            <input> 
                <input bind="txtProject_Pk" />
                <input bind="lstVersion" />
            </input>
	       <output>
	            <output bind="txtIntergrated_YN" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_copy" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="process"   procedure="ec111.sp_Pro_kpbp00050_copy"  > 
                <input> 
                    <input bind="lstVersion" /> 
                    <input bind="txtProject_Pk" />
                 </input>
                 <output>
                    <output bind="txtReturnValue"/>
                 </output>
            </dso> 
        </xml> 
    </gw:data>
    
<gw:data id="dso_get_trans_rate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ec111.sp_pro_kpbp00050_get_transrate" > 
                <input> 
                     <input bind="txtProject_Pk"/>
                     <input bind="lstCcy"/>
                </input>
                <output>
                     <output bind="txtTR_RATE"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>    
    
<gw:data id="dso_Delete" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="process" procedure="ec111.sp_Pro_kpbp00050_Delete" >
                <input> 
					<input bind="txtProject_Pk" />
                    <input bind="lstVersion" />             				 
                </input>  
                <output>
                     <output bind="txtReturnValue" />
				</output> 
            </dso> 
        </xml> 
    </gw:data>
    
<gw:data id="dso_top" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso id="1" type="grid"  function="ec111.sp_sel_kpbp122"    > 
				<input bind="Grid_Top">                    
					<input bind="txtProject_Pk" /> 
				</input> 
				<output bind="Grid_Top" /> 
			</dso> 
		</xml> 
	</gw:data>
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr style="height: 6%">
            <td width="100%">
                <fieldset style="padding: 0">
                    <table cellpadding="1" cellspacing="1" width="100%">
                        <tr>
                            <td width="100%">
                                <table cellpadding="0" cellspacing="2" width="100%">
                                    <tr>
									   <td align="right" width="10%"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">Project</a></td>
                                        <td width="10%"><gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' /></td>
                                        <td width="40%" colspan="2"><gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' /></td>
                                        <td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td>
										<td align="right" width="10%" style="display:">Version</td>
										<td width="10%"><gw:list id="lstVersion" readonly="true" onchange="OnSearch()" styles="width:100%;" /></td> 
									    <td width="1%"><gw:imgbtn id="btnNew" img="new" alt="Select Level Code" text="New" onclick="OnNew()" /></td>						<td width="1%"><gw:imgbtn id="btnNew" img="new" alt="Select item code" text="New" onclick="OnNewFree()" /></td>
										<td width="1%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" /></td>
										<td width="1%"><gw:imgbtn id="btnRemove" img="cancel" alt="Clear" text="Delete" onclick="OnClear()"/></td>
										<td width="1%"><gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()"/></td>
										<td width="1%"><gw:imgbtn id="btnUnDelete" img="udelete" alt="UnDelete" text="UnDelete" onclick="OnUnDelete()"/></td>
										<td width="1%"><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint(1)" /></td>
										<td width="1%"><gw:imgbtn id="btnPrint1" img="excel" alt="Print" text="Print" onclick="onPrint(2)" /></td>
										<td width="1%"><gw:imgbtn id="btnPrint2" img="excel" alt="Total Summary" text="Print" onclick="onPrint(3)" /></td>
                                    </tr>
									<tr>
									   <td align="right" width="10%"><a title="Click here to show Filter" href="#" style="text-decoration: none" onClick="OnPopUp('Category')">Budget field</a></td>
                                         <td width="10%"><gw:list id="lstField" styles="width:100%;" /></td>
                                         <td  width="10%" align="right" ><a title="Click here to show level code" href="#" style="text-decoration: none" onClick="OnPopUp('Levelcode')">Level code</a></td>
                                        <td width="30%"><gw:textbox id="txtWork_Breakdown_Nm" styles="width:100%;display:" /></td>
										<td><gw:imgbtn id="ibtnUpdte" img="reset" alt="Reset" onclick="txtWork_Breakdown_Nm.text='';lstWork_Breakdown.text='';" /></td>
										<td width="10%" align="right">Search by</td>
										<td width="14%" colspan="2"><gw:list id="lstSearch"  onchange="" styles="width:100%;" /></td> 
									    <td width="16%" colspan="7"><gw:textbox id="txtSearch"  onenterkey="OnSearch()"  styles="width:100%;" /></td> 
										<td width="1%"><gw:imgbtn id="btnSearchs" img="search" alt="Search" onclick="OnSearch()" /></td> 
                                    </tr>
                                </table>
                            </td>
                         </tr>
                         
                        <tr>
                        	
                            <td  width="100%" >
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
									       <td align="right"><a title="Column Selection"  style="text-decoration: none; color:#333" >Col. Sel.</a></td>
                                        	<td width="13%"><gw:checkbox id="cbLevelCode" defaultvalue="Y|N" value="Y" onclick="OnShowHide(1)"  /> Level Code</td>
                                            <td width="8%"><gw:checkbox id="cbStd" defaultvalue="Y|N" value="Y"  onclick="OnShowHide(2)" /><a title="Standard" style="color:#333">Std.</a></td>
                                            <td width="8%"><gw:checkbox id="cbUnit" defaultvalue="Y|N" value="Y"  onclick="OnShowHide(3)" /> Unit</td>
                                            <td width="20%"><gw:checkbox id="cbRaw" defaultvalue="Y|N" value="Y"  onclick="OnShowHide(4)" /><a title="Raw Material/Labor/Equipment" style="color:#333">Raw Mtrl/Labor/E</a></td>
                                            <td width="20%"><gw:checkbox id="cbCompared" defaultvalue="Y|N" value="Y"  onclick="OnShowHide(5)" /><a title="Compared with Original" style="color:#333">Compared w/ Ori</a></td>
                                           
                                            
                                          
                                    </tr>
                                </table>           
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr height="2%">
    <td width="100%" align="left"><img status="expand" id="imgup" src="../../../system/images/up.gif" style="cursor: hand;"  onclick="OnShow()" /></td>
</tr>
<tr height="20%" id="updating_info">
    <td width="100%">
        <gw:grid   
        id="Grid_Top"  
        header="Trans Ccy|Ex.Rate|Trans Amt|Book Ccy|Book Ex.Rate|Book Amt"   
        format  ="0|1|1|0|1|1"  
            aligns ="1|3|3|1|3|3"  
        defaults="|||||"  
        editcol ="0|0|0|0|0|0"  
        widths  ="1000|1500|3000|1000|1500|2000"  
        styles="width:100%; height:100%"   
        sorting="T" 
        onafteredit=""  
        oncellclick="" 
        /> 
    </td>        
</tr>
        <tr style="height: 72%" id="top">
            <td colspan="" style="background-color:">
                <!-- header="_0.budget_detail_pk|_1.TECPS_PERFORMBUDGETBASC_pk|2.Level|3.Upper Code|4.Level Code|5.Name|6.Unit(1)|7.CCY(2)|8.Quantity(3)|9.RM U/Price(4)|10.Labor U/P(5)|11.Exp. U/P(6)|12.Unit Price (7)=(4)+(5)+(6)|13.Amount(8)=(3)*(7)|14.Ord. W Code(9)|15.Ord. W. Name|16.Buget code(10)|17.Budget name|18.Standard code(11)|19.Booking CCY|20.Booking Ex.rate(12)|21.Booking RM. U/P.(13)|22.Booking Labor U/P.(14)|23.Booking Exp. U/P(15)|24.Booking U/P(16)|25.Booking Amount(17)|26.tecps_item_pk|27.budget_pk|28.orderwork_pk|29.Standard_pk|30.project_pk|31.Field|32_level_code_pk|33.item"-->
                <gw:grid id="Grid_Detail" 
                header="_0.budget_detail_pk|_1.TECPS_PERFORMBUDGETBASC_pk|Level|Upper Code|Level Code|Name|Unit(1)|CCY(2)|Qty.(3)|RM U/Price(4)|Labor U/P(5)|Exp. U/P(6)|Unit Price (7)=(4)+(5)+(6)|Amount(8)=(3)*(7)|Ord. W Code(9)|Ord. W. Name|Buget code(10)|Budget name|Standard code(11)|Booking CCY|Booking Ex.rate(12)|Booking RM. U/P.(13)|Booking Labor U/P.(14)|Booking Exp. U/P(15)|Booking U/P(16)|Booking Amount(17)|tecps_item_pk|budget_pk|orderwork_pk|Standard_pk|project_pk|Field|level_code_pk|item"
			   format="0|0|0|0|0|0|0|0|-2|-2|-2|-2|-2|-2|0|0|0|0|0|0|-2|-2|-2|-2|-2|-2|0|0|0|0|0|0|0" 
			   aligns="0|0|0|0|0|0|0|0|3|3|3|3|3|3|0|0|0|0|0|0|3|3|3|3|3|3|0|0|0|0|0|0|0"
			   defaults="|||||||||||||||||||||||||||||||C|"
			   editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"
			   widths="0|0|800|1500|1800|2500|1000|1000|1000|1200|1200|1400|1600|2000|1500|2000|1500|2000|2000|1000|1200|1500|1500|1500|1500|1500|0|0|0|0|0|0|0"
			   styles="width:100%; height:100%" sorting="T" 
			   onafteredit="OnCalculator()" 
			   oncelldblclick="OnEditLevel()" />
            </td>
        </tr>
        <tr style="height:2%">
        <td>
                <table width="100%" cellpadding="0" cellspacing="0" bordercolor="#00CCFF" style="border-collapse: collapse" border="1">
                    <tr style="background:#C5EFF1">
                        <td align="right" width="50%">Contract Amount Total&nbsp;</td>
                        <td width="20%"><gw:textbox id="txtContAmt_Total" readonly="true" styles='width:100%' type="number" format="###,###.##R" /></td>
                        <td align="right" width="10%">Balance&nbsp;</td>
                        <td width="20%"><gw:textbox id="txtBalance" readonly="true" styles='width:100%' type="number" format="###,###.##R" /></td>
                    </tr>
                </table>
        </td>
  </tr>
        <tr style="height: 1%; display:none ">
            <td>
                <fieldset style="padding: 0">
                    <table style="width: 100%" cellpadding="0" cellspacing="0">
                        <tr style="background-color: White">
                            <td width="50%">
                            </td>
                            <td>
                                <img status="expand" id="imgArrow" src="../../../system/images/down.gif" style="cursor: hand;"
                                    onclick="OnToggle()" /></td>
                            <td align="right" width="40%">
                                Level&nbsp;</td>
                            <td width="10%">
                                <gw:list id="lstLevel" onchange="OnSearch()" styles="width:100%;" />
                            </td>
                            <td style="display: none">
                                <gw:datebox id="txtUSE_DATE" lang="1" styles='width:100%;display:none' />
                            </td>
                            <td style="display: none">
                                <gw:textbox id="txt_row" styles='display:none' />
                            </td>
                            <td style="display:none ">
                                 
                                
          <gw:textbox id="txtBK_RATE"  styles='width:100%;display:none' />
          <gw:list id="txtccy" onchange="OnGetRate()" styles='width:100%;display:none' />
                            </td>
                            <td style="display: none">
                                <gw:list id="lstCOMPANY" styles='width:100%;display:none' />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
       
    </table>
    <gw:textbox id="txtLevel_pk" styles='width:100%;display:none' />
	<gw:textbox id="txtLevel_pk_s" styles='width:100%;display:' />
    <gw:textbox id="txtbookccy" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <gw:textbox id="txtIntergrated_YN" styles='width:100%;display:none' />
    <gw:textbox id="txtBookRate" styles='width:100%;display:none' />
    <gw:textbox id="txtTR_RATE" styles="width:100%;display:none" />
    <gw:textbox id="lstCcy" styles="width:100%;display:none" /> 
	<gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
    <gw:textbox id="lstWork_Breakdown" styles="width:100%;display:none" />
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   