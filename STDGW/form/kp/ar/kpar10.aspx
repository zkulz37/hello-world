<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Daily Report</title>
</head>
<%  ESysLib.SetUser("ec111")%>
<script language="javascript">
//===========Manpower=====================
var Mp_Job = 0,
      Mp_Type = 1,
      Mp_Unit = 2,
      Mp_KLastDay = 3,
      Mp_KToday = 4,
      Mp_KCumm = 5,
      Mp_KTomorrow = 6,     
      Mp_VLastDay = 7,
      Mp_VToday = 8,
      Mp_VCumm = 9,
      Mp_VTomorrow = 10,      
      Mp_OLastDay = 11,
      Mp_OToday = 12,
      Mp_OCumm = 13,
      Mp_OTomorrow = 14,
     Mp_Project_pk = 15,
      Mp_Master_pk = 16,
     Mp_Popup_pk = 17,
     Mp_Pk = 18,
     Mp_Date = 19;
//==========Material====================================================     
    var Mt_Pk = 0,
  Mt_Item_Pk = 1,  
Mt_Master_Pk = 2,
Mt_Vendor_Pk = 3,
Mt_Level_Cd = 4,
Mt_Level_Nm = 5,  
    Mt_ItemCd = 6,
    Mt_ItemNm = 7,
    Mt_Voucher_No = 8,
  Mt_PO_No = 9,
Mt_Vendor_Cd = 10,
Mt_Vendor_Nm = 11,
Mt_Spec = 12,
    Mt_Type = 13,
  Mt_Unit = 14,
   Mt_BOQ = 15,
  Mt_Yesterday = 16,
Mt_Today = 17,
Mt_Accum = 18,
Mt_Descrip = 19,
Mt_Level_pk = 20;
//==========Equipment====================================================     
var Eq_Pk = 0,
Eq_Item_Pk = 1,
Eq_Cd = 2,
Eq_Nm = 3,
Eq_Type = 4,
Eq_Unit = 5,
Eq_LastDay = 6,
Eq_Today = 7,
Eq_Cumm = 8,
Eq_tomorrow = 9,
Eq_Remark = 10,
Eq_Master_Pk = 11;
//============================================================================================
function BodyInit()
{
	System.Translate(document);
	BindingDataList();
	OnAddNew();
	//MergeHeaderQuantity();
	MergeHeaderManpower();
	//OnSearch();

}
//============================================================================================
function BindingDataList()
{    
	var Weather = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('J06') FROM DUAL")%>";
	lstWeather.SetDataText(Weather);	
	<%=ESysLib.SetGridColumnComboFormat("Grid_Manpower", 1,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0039' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
	//National
	<%=ESysLib.SetGridColumnComboFormat("Grid_Quantity", 3,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0040' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
	//Type
	<%=ESysLib.SetGridColumnComboFormat("Grid_Quantity", 2,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0039' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
	//Type
	<%=ESysLib.SetGridColumnComboFormat("Grid_Material", 13,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0039' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
	<%=ESysLib.SetGridColumnComboFormat("Grid_Equipment", 4,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0039' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
    idTab.HideTab(5);
}
//============================================================================================
function MergeHeaderQuantity()
{
        var fg=Grid_Quantity.GetGridControl(); 	
        if(fg.Rows < 2)
		{
		   Grid_Quantity.AddRow();     
		}    
        fg.FixedRows = 2
        fg.MergeCells =5	
        
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 6, 0, 8)  = "A. Rslt Q'ty"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 6, 1, 6) = "Prev. Date Cum."
	    fg.Cell(0, 1, 7, 1, 7) = "Today" 
		fg.Cell(0, 1, 8, 1, 8) = "Cum." 
		
		fg.Cell(0, 0, 9, 0, 11)  = "Prog. Rate"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 9, 1, 9) = "Prev. Date Cum."
	    fg.Cell(0, 1, 10, 1, 10) = "Today" 
		fg.Cell(0, 1, 11, 1, 11) = "Cum." 
	    
	    fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "Large Division"	
		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "M. Class."	
	    fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Detail Item"	
		fg.MergeCol(3) = true
		fg.Cell(0, 0, 3, 1, 3) = "Unit"	
		fg.MergeCol(4) = true
		fg.Cell(0, 0, 4, 1, 4) = "Wgt Factor"	
		fg.MergeCol(5) = true
		fg.Cell(0, 0, 5, 1, 5) = "Total Plan Q'ty"	
		fg.MergeCol(12) = true
		fg.Cell(0, 0, 12, 1, 12) = "Cumulative Progress Rate"	
		
}
//============================================================================================
function MergeHeaderManpower()
{
        var fg=Grid_Manpower.GetGridControl(); 	
        if(fg.Rows < 2)
		{
		   Grid_Manpower.AddRow();     
		}    
        fg.FixedRows = 2
        fg.MergeCells =5	
        
		fg.MergeRow(0) = true
		fg.Cell(0, 0, Mp_KLastDay, 0, Mp_KTomorrow)  = "Korea"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, Mp_KLastDay, 1, Mp_KLastDay) = "Last Day"
	    fg.Cell(0, 1, Mp_KToday, 1, Mp_KToday) = "Today" 
		fg.Cell(0, 1, Mp_KCumm, 1, Mp_KCumm) = "Cummulation" 
		fg.Cell(0, 1, Mp_KTomorrow, 1, Mp_KTomorrow) = "Tomorrow" 
		
		fg.Cell(0, 0, Mp_VLastDay, 0, Mp_VTomorrow)  = "Vietnam"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, Mp_VLastDay, 1, Mp_VLastDay) = "Last Day"
	    fg.Cell(0, 1, Mp_VToday, 1, Mp_VToday) = "Today" 
		fg.Cell(0, 1, Mp_VCumm, 1, Mp_VCumm) = "Cummulation" 
		fg.Cell(0, 1, Mp_VTomorrow, 1, Mp_VTomorrow) = "Tomorrow" 
		
		fg.Cell(0, 0, Mp_OLastDay, 0, Mp_OTomorrow)  = "Other"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, Mp_OLastDay, 1, Mp_OLastDay) = "Last Day"
	    fg.Cell(0, 1, Mp_OToday, 1, Mp_OToday) = "Today" 
		fg.Cell(0, 1, Mp_OCumm, 1, Mp_OCumm) = "Cummulation" 
		fg.Cell(0, 1, Mp_OTomorrow, 1, Mp_OTomorrow) = "Tomorrow" 
	    
	    fg.MergeCol(Mp_Job) = true
		fg.Cell(0, 0, Mp_Job, 1, Mp_Job) = "Job"	
		fg.MergeCol(Mp_Type) = true
		fg.Cell(0, 0, Mp_Type, 1, Mp_Type) = "Type"	
		fg.MergeCol(Mp_Unit) = true
		fg.Cell(0, 0, Mp_Unit, 1, Mp_Unit) = "Unit"	
}
//============================================================================================
function OnSearch(pos)
{
    switch(pos)
    {
        case'List':
            dso_kpsh00020.Call("SELECT");
        break;
        case'Master':
            txtMasterPK.text=Grid_Mst.GetGridData(Grid_Mst.row,0);
            flag="search";
            dso_kpsh00020_1.Call("SELECT");
        break;
		case 'Tab':
		    switch(idTab.GetCurrentPageNo())
             {
                case 0:
                        dso_kpsh00020_2.Call('SELECT');
                break;
                case 5:
                        dso_Quantity.Call('SELECT');
                break;
                case 1:
                        dso_Manpower.Call('SELECT');
                break;
                 case 2:
                            dso_kpsh00020_5.Call('SELECT');
                break;
                 case 3:
                            dso_kpsh00020_6.Call('SELECT');
                break;
                 case 4:
                            DSO_ATTACH_FILE.Call("SELECT");
                break;
             }
		break;
    }
	
}
//============================================================================================
function OnAddNew()
{
	    dso_kpsh00020_1.StatusInsert();
		dso_kpsh00020_2.StatusInsert();
		Grid_Equipment.ClearData();
		Grid_Material.ClearData();
		Grid_Attached.ClearData();
}
//============================================================================================
function onValidate()
{
    if(txtProject_Pk.GetData()=="")
    {
        alert('Please select  Project !!');
        return true;
    }
    else if(txtTodayResult.GetData()=="")
    {
        alert('Please input Today Result !!');
        return true;
    }
    else if(txtTomorrowPlan.GetData()=="")
    {
        alert('Please input Plan for Tomorrow !!');
        return true;
    }
	
    return false;
}
//============================================================================================
var flag="";
function OnSave ()
{
	if(!onValidate())
	{
        dso_kpsh00020_1.Call();
        flag='update'; 
    }
}
//============================================================================================
function OnSaveFile()
{
	DSO_ATTACH_FILE.Call();
}
//============================================================================================
function DeleteAtt()
{
    if(confirm('Do you want to delete selected file ?'))
			{
			     Grid_Attached.DeleteRow();
			     DSO_ATTACH_FILE.Call();
			}
}
//============================================================================================
function OnDelete()
{
    if(txtMasterPK.text!="")
    {
        if(confirm("Are you sure to Delete ? "))
        {
            dso_kpsh00020_1.StatusDelete();
            dso_kpsh00020_1.Call();
        }
    }
}

//============================================================================================
function OnDeleteGrid(obj)
{
    switch(obj)
    {
        case'Grid_Equipment':
            if(Grid_Equipment.row>0)
            {
                if(Grid_Equipment.GetGridData(Grid_Equipment.row, Eq_Pk)!="")
                {
                    Grid_Equipment.DeleteRow();
                }
                else
                {
                    Grid_Equipment.RemoveRow();
                }
            }
        break;
        case'Grid_Material':
            if(Grid_Material.row>0)
            {
                if(Grid_Material.GetGridData(Grid_Material.row,Mt_Pk)!="")
                {
                    Grid_Material.DeleteRow();
                }
                else
                {
                    Grid_Material.RemoveRow();
                }
            }
        break;
    }
}
//============================================================================================
function OnUnDeleteGrid(pos)
{
    switch(pos)
    {
        case'Grid_Equipment':
            Grid_Equipment.UnDeleteRow();
        break;
        case'Grid_Material':
            Grid_Material.UnDeleteRow();
        break;
    }
}
//============================================================================================
function OnPrint()
{
			var url =System.RootURL + '/reports/kp/ar/kpar10.aspx?Master_pk=' + txtMasterPK.text + '&Project_pk=' + txtProject_Pk.text + '&Base_dt=' + dtDateOfResult.value;
	    System.OpenTargetPage( url , 'newform' );
}
//============================================================================================
function OnDblClick_PopUp(obj)
{
        switch(obj)
       {
                case 'Material':
                        if(event.col == Mt_ItemCd || event.col == Mt_ItemNm)
                       {   
                            var path = System.RootURL + "/form/kp/ar/kpar10_popup_Material.aspx?Project_Pk=" + txtProject_Pk.text;
                             var object = System.OpenModal( path , 800 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
	                         if ( object != null )
	                         {
                                var arrTemp
                                for( var i=0; i < object.length; i++)	  
                                {	
                                    arrTemp = object[i];
                                    Grid_Material.SetGridText( Grid_Material.row,Mt_Master_Pk ,txtMasterPK.text) ;//master_pk	    	                   
                                    Grid_Material.SetGridText( Grid_Material.row, Mt_Item_Pk,arrTemp[0]);//item_pk	    
                                    Grid_Material.SetGridText( Grid_Material.row, Mt_ItemCd,arrTemp[1]);//item_code	    
                                    Grid_Material.SetGridText( Grid_Material.row, Mt_ItemNm,arrTemp[2]);//item_name	    
                                    Grid_Material.SetGridText( Grid_Material.row, Mt_Unit,arrTemp[3]);//uom
                               }  	            
	                         }	
	                    } 
	                   else if(event.col== Mt_Level_Cd || event.col== Mt_Level_Nm)
	                        {
		                        var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown.aspx?Project_Pk=' + txtProject_Pk.text;
					                         var aValue = System.OpenModal( path ,900 , 500 , 'resizable:yes;status:yes');
					                         if(aValue != null)
					                         {
		                                            txtLevel_pk.text = aValue[2]; 
		                                            if(!CheckDuplicateLevel())
		                                            {                                       
		                                                return;
		                                            } 
		                                            else
		                                            {
											                        //Grid_Detail.SetGridText(Grid_Detail.row, 2, aValue[3]);  //level
											                        Grid_Material.SetGridText(Grid_Material.row, Mt_Level_Cd, aValue[0]); //code
											                        Grid_Material.SetGridText(Grid_Material.row, Mt_Level_Nm, aValue[1]); //name
											                        Grid_Material.SetGridText(Grid_Material.row, Mt_Level_pk, aValue[2]); //pk 
						                            }  
					                         }
	                                }
                            else if(event.col== Mt_Vendor_Cd || event.col== Mt_Vendor_Nm)
	                        {
	                                var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		                        var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		                        if ( object != null )
		                        {
		                            if (object[0] != 0)
                                    {
                                        Grid_Material.SetGridText(Grid_Material.row, Mt_Vendor_Pk, object[0]);  
                                        Grid_Material.SetGridText(Grid_Material.row, Mt_Vendor_Cd, object[1]);  
                                        Grid_Material.SetGridText(Grid_Material.row, Mt_Vendor_Nm, object[2]);  
      	                            }
		                         }       
	                        }
              break;  
              case 'Equipment':
                        if(event.col == 2 || event.col == 3)
						{
                             var path = System.RootURL + "/form/kp/ar/kpar10_popup_Equipment.aspx?Project_Pk=" + txtProject_Pk.text;
                             var object = System.OpenModal( path , 800 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
	                         if ( object != null )
	                         {
                                var arrTemp
                                for( var i=0; i < object.length; i++)	  
                                {	
                                    arrTemp = object[i];
                                    Grid_Equipment.SetGridText( Grid_Equipment.row,Eq_Master_Pk,txtMasterPK.text) ;//master_pk	    	                   
                                    Grid_Equipment.SetGridText( Grid_Equipment.row, Eq_Item_Pk,arrTemp[0]);//item_pk	    
                                    Grid_Equipment.SetGridText( Grid_Equipment.row, Eq_Cd,arrTemp[1]);//item_code	    
                                    Grid_Equipment.SetGridText( Grid_Equipment.row, Eq_Nm,arrTemp[2]);//item_name	    
                                    Grid_Equipment.SetGridText( Grid_Equipment.row, Eq_Unit,arrTemp[3]);//uom
                               }  	            
	                         }	
						}
              break;
             
       } 
}
//============================================================================================
function OnPopUp(obj)
{
        switch(obj)
        {
                case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx" ;
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {
                                    txtProject_Pk.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2];
                            } 
                break;

                case 'Item' :
						if(txtMasterPK.text !='')
						{
                             var path = System.RootURL + "/form/kp/ar/kpar10_popup_Equipment.aspx?Project_Pk=" + txtProject_Pk.text;
                             var object = System.OpenModal( path , 800 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
	                         if ( object != null )
	                         {
                                var arrTemp
                                for( var i=0; i < object.length; i++)	  
                                {	
                                    arrTemp = object[i];
                                    Grid_Equipment.AddRow();
                                    Grid_Equipment.SetGridText( Grid_Equipment.rows-1,Eq_Master_Pk,txtMasterPK.text) ;//master_pk	    	                   
                                    Grid_Equipment.SetGridText( Grid_Equipment.rows-1, Eq_Item_Pk,arrTemp[0]);//item_pk	    
                                    Grid_Equipment.SetGridText( Grid_Equipment.rows-1, Eq_Cd,arrTemp[1]);//item_code	    
                                    Grid_Equipment.SetGridText( Grid_Equipment.rows-1, Eq_Nm,arrTemp[2]);//item_name	    
                                    Grid_Equipment.SetGridText( Grid_Equipment.rows-1, Eq_Unit,arrTemp[3]);//uom
                               }  	            
	                         }	
						}
						else
						{
							alert('Please select Master row !!');
						}
                break;
                
                case 'Item2' :
						if(txtMasterPK.text !='' && txtPartner_PK.text != '')
						{
                             var path = System.RootURL + "/form/kp/ar/kpar10_popup_Material.aspx?Project_Pk=" + txtProject_Pk.text;
                             var object = System.OpenModal( path , 800 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
	                         if ( object != null )
	                         {
                                var arrTemp
                                for( var i=0; i < object.length; i++)	  
                                {	
                                    arrTemp = object[i];
                                    Grid_Material.AddRow();
                                    Grid_Material.SetGridText( Grid_Material.rows-1,Mt_Master_Pk ,txtMasterPK.text) ;//master_pk	    	                   
                                    Grid_Material.SetGridText( Grid_Material.rows-1, Mt_Item_Pk,arrTemp[0]);//item_pk	    
                                    Grid_Material.SetGridText( Grid_Material.rows-1, Mt_ItemCd,arrTemp[1]);//item_code	    
                                    Grid_Material.SetGridText( Grid_Material.rows-1, Mt_ItemNm,arrTemp[2]);//item_name	    
                                    Grid_Material.SetGridText( Grid_Material.rows-1, Mt_Unit,arrTemp[3]);//uom
                                   Grid_Material.SetGridText( Grid_Material.rows-1, Mt_Vendor_Pk, txtPartner_PK.text);//vendor pk
                                   Grid_Material.SetGridText( Grid_Material.rows-1, Mt_Vendor_Cd, txtPartnerID.text);//vendor code
                                   Grid_Material.SetGridText( Grid_Material.rows-1, Mt_Vendor_Nm, txtPartnerNm.text);//vendor name
                               }  	            
	                         }	
						}
						else
						{
							alert('Please select Master row and vendor !!');
						}
                break;
				case 'Weather':
							var path = System.RootURL + '/form/gf/os/gfos00070_popup_1.aspx?code=J06';
							var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
							 if (object != null )
							 {
								 lstWeather.SetDataText(object[1]);
							 }
				break;
				case 'Manpower':
					if(txtProject_Pk.text != '' && txtMasterPK.text !='')
					{
						var path = System.RootURL + '/form/kp/ar/kpar10_popup_Manpower.aspx?Project_Pk=' + txtProject_Pk.text;
						var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
						if ( object != null )
	                         {
                                var arrTemp
                                for( var i=0; i < object.length; i++)	  
                                {	
                                    arrTemp = object[i];
                                    Grid_Manpower.AddRow();
                                    Grid_Manpower.SetGridText( Grid_Manpower.rows-1,Mp_Project_pk,txtProject_Pk.text) ;//	   
									//Grid_Manpower.SetGridText( Grid_Manpower.rows-1,15,txtMasterPK.text) ;//	 
									Grid_Manpower.SetGridText( Grid_Manpower.rows-1,Mp_Popup_pk,arrTemp[0]) ;//	 
                                    Grid_Manpower.SetGridText( Grid_Manpower.rows-1,Mp_Job,arrTemp[2]);//item_pk	    
                                    Grid_Manpower.SetGridText( Grid_Manpower.rows-1,Mp_Unit,arrTemp[3]);//item_code	
                               }  	            
	                         }	 	       
					}
					else
					{
						alert('Please select Project and master row  !!');
					}
				break;
				case 'vendor':
				                var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		                        var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		                        if ( object != null )
		                        {
		                            if (object[0] != 0)
                                    {
                                        txtPartnerID.SetDataText(object[1]);//customer id
                                        txtPartnerNm.SetDataText(object[2]);//customer name
                                        txtPartner_PK.SetDataText(object[0]);//customer pk
      	                            }
		                         }       
				break;
		}
}
//============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
		case 'dso_search':
		        dso_kpsh00020_1.Call('SELECT');
		break;
        case 'dso_kpsh00020_1':
             switch(idTab.GetCurrentPageNo())
             {
                case 0:
                    if(flag=='search')
                    {
                        dso_kpsh00020_2.Call('SELECT');
                    }
                    else
                    {
                        dso_kpsh00020_2.Call();
                    }
                break;
                case 5:
//                     if(flag=='search')
//                    {  
//                            dso_Quantity.Call('SELECT');
//                    }
//                   else
//                   {
                      
                            for(var i=1;i<Grid_Quantity.rows;i++)
				            {
                                       // Grid_Quantity.SetGridText(i, 12, txtMasterPK.text);
                                        //Grid_Quantity.SetGridText(i, 14, dtDateOfResult.value);
                                       //Grid_Quantity.SetRowStatus(i, 0x20); 
                                     //alert(Grid_Quantity.GetRowStatus(i));   
                            } 
                            dso_Quantity.Call();
//                   } 
                break;
                case 1:
//                    if(flag=='search')
//                    {
//                        dso_Manpower.Call('SELECT');
//                    }
//                    else
//                    {
                        for(var i=2;i<Grid_Manpower.rows;i++)
				        {
						        Grid_Manpower.SetGridText(i,Mp_Master_pk,txtMasterPK.text);
						        Grid_Manpower.SetGridText(i,Mp_Date,dtDateOfResult.value);
				        }
				        Grid_Manpower.SetRowStatus(1, 'Search');
				        dso_Manpower.Call();
//                    }
                break;
                 case 2:
//                        if(flag=='search')
//                        {
//                            dso_kpsh00020_5.Call('SELECT');
//                        }
//                        else
//                        { 
                            for(var i=1;i<Grid_Equipment.rows;i++)
				            {
					            Grid_Equipment.SetGridText(i,Eq_Master_Pk,txtMasterPK.text);
				            }
				            dso_kpsh00020_5.Call();
//				        }
                break;
                 case 3:
//                        if(flag=='search')
//                        {
//                            dso_kpsh00020_6.Call('SELECT');
//                        }
//                        else
//                        {  
                                dso_kpsh00020_6.Call();
//                        }  
                break;
                 case 4:
                                DSO_ATTACH_FILE.Call("SELECT");
                break;
             }
        break;
        case 'dso_Manpower':
            MergeHeaderManpower();
        break;
       case 'dso_Quantity':
            var fg = Grid_Quantity.GetGridControl();
			 fg.MergeCells  = 4
			fg.MergeCol(0) = true;
        break;
    }
}
//============================================================================================
function AttachFiles()
    {
            if(txtMasterPK.text != '')
           { 
		
                    imgFile.MasterPK=txtMasterPK.text;
                    imgFile.ChangeImage();
		   
                    if( imgFile.oid == 0 )
                    {
                        return false;
                    }
                    else
                    {
						Grid_Attached.SetGridText( Grid_Attached.rows - 1, 4, txtMasterPK.text);   		
                        DSO_ATTACH_FILE.Call();
                    }
                    imgFile.oid= "";     
            } 
        else
        {
                alert('Please save data first!!');
        }     
}
//============================================================================================
function OnOpenFile()
{
        var img_pk = Grid_Attached.GetGridData(Grid_Attached.GetGridControl().row,4)	;
        var url = System.RootURL + "/system/binary/viewfile.aspx?img_pk=" + img_pk + "&table_name=tecps_subcontappdfile";	
        window.open(url);
}
//============================================================================================
function OnToggle()
 {
    var left  = document.all("idLEFT");    
    var right = document.all("idRIGHT");   
    var imgArrow = document.all("imgArrow");   
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/right1.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/left1.gif";
    }
 }
//============================================================================================
function OnCalculator()
{
	var LastDay_kor = Number(Grid_Manpower.row, 2);
	var LastDay_vie = Number(Grid_Manpower.row, 2);
	var LastDay_other = Number(Grid_Manpower.row, 2);
	var ToDay_kor = Number(Grid_Manpower.row, 3);
	var Cumm = 0;
	Cumm = Match.round(LastDay_kor + ToDay_kor);
	Grid_Manpower.SetGridText(Grid_Manpower.row, 4, Cumm);
}

function CheckDuplicateLevel()
{
    for(var i = 1; i < Grid_Material.rows; i++)
    {
        if(Grid_Material.GetGridData(i, Mt_Level_pk) == txtLevel_pk.text)
        {
             alert("Duplicated Level Code!! ");
             return false ;
        }
    }
    return true;
}
</script>

<body>
    <!------------------------------------------------------------------------------------------------------------------>
    <!------------------------------------------------------------------------------------------------------------------>
    <gw:data id="DSO_ATTACH_FILE" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid" parameter="0,1,2,3,4,5"  function="ec111.sp_sel_kpsh00020_7"  procedure="ec111.sp_upd_kpsh00020_7">
          <input bind="Grid_Attached" >
          <input bind="txtMasterPK" />
          </input>
          <output bind="Grid_Attached" />
        </dso>
      </xml>
    </gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
    <gw:data id="dso_kpsh00020_6" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="ec111.sp_sel_kpsh00020_6" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" procedure="EC111.sp_upd_kpsh00020_6" > 
            <input bind="Grid_Material">    
                <input bind="txtMasterPK" />      
            </input> 
            <output bind="Grid_Material" /> 
        </dso> 
    </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
    <gw:data id="dso_kpsh00020_5" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="ec111.sp_sel_kpsh00020_5" parameter="0,1,2,3,4,5,6,7,8,9,10,11" procedure="ec111.sp_upd_kpsh00020_5"> 
            <input bind="Grid_Equipment">    
                <input bind="txtMasterPK" />      
            </input> 
            <output bind="Grid_Equipment" /> 
        </dso> 
    </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
       <gw:data id="dso_Quantity" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="ec111.sp_sel_kpsh00020_qty" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" procedure="ec111.sp_upd_kpsh00020_qty" > 
            <input bind="Grid_Quantity">    
                <input bind="txtMasterPK" />      
                <input bind="txtProject_Pk" />      
              <input  bind="dtDateOfResult" />  
            </input> 
            <output bind="Grid_Quantity" /> 
        </dso> 
    </xml> 
    </gw:data>
    
    <gw:data id="dso_kpsh00020_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" function="ec111.sp_sel_kpsh00020_2" parameter="0,1,2,3,4,5" procedure="ec111.sp_upd_kpsh00020_2"> 
                <inout> 
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtTab1PK" />
                     <inout  bind="lstWeather" />
                     <inout  bind="txtTodayResult" />
                     <inout  bind="txtTomorrowPlan" />
                     <inout  bind="txtRemark" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
    <gw:data id="dso_kpsh00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" function="ec111.sp_sel_kpsh00020_1" parameter="0,1,2,3,4" procedure="ec111.sp_upd_kpsh00020_1" > 
                <inout> 
                     <inout  bind="txtMasterPK" />
                      <inout  bind="txtProject_Pk" />
                     <inout  bind="txtProject_Cd" />
                     <inout  bind="txtProject_Nm" /> 
                      <inout  bind="dtDateOfResult" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
    <gw:data id="dso_kpsh00020" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="ec111.sp_sel_kpsh00020" > 
            <input bind="Grid_Mst">    
                <input bind="txtProject" />      
                <input bind="dtFrom" />  
                <input bind="dtTo" />           
            </input> 
            <output bind="Grid_Mst" /> 
        </dso> 
    </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
<gw:data id="dso_Manpower" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="ec111.sp_sel_kpar10_Manpower" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" procedure="ec111.sp_upd_kpar10_Manpower"> 
            <input bind="Grid_Manpower">    
                <input bind="txtMasterPK" /> 
				<input bind="dtDateOfResult" /> 
                <input bind="txtProject_Pk" /> 
            </input> 
            <output bind="Grid_Manpower" /> 
        </dso> 
    </xml> 
    </gw:data>
	
<gw:data id="dso_search" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ec111.sp_sel_kpsh00020_3" > 
                <input> 
                     <input  bind="txtProject_Pk" />
                     <input  bind="dtDateOfResult" />
                </input>
                <output>
                     <output  bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>	
    <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr>
            <td style="background: white; width: 30%;" id="idLEFT" valign="top">
                <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 1%; width: 100%">
                        <td>
                            <fieldset style="width: 100%; padding: 0">
                                <table style="width: 100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="35%" align="right">
                                            Project&nbsp;</td>
                                        <td width="65%">
                                            <gw:textbox id="txtProject" onenterkey="OnSearch('List')" styles='width:100%' />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="btSve2" img="search" alt="Search" onclick="OnSearch('List')" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Date&nbsp;</td>
                                        <td>
                                            <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="49%" align="left">
                                                        <gw:datebox id="dtFrom" lang="1" />
                                                    </td>
                                                    <td width="2%" align="center">
                                                        ~</td>
                                                    <td width="49%" align="right">
                                                        <gw:datebox id="dtTo" lang="1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 99%; width: 100%">
                        <td width="100%">
                            <gw:grid id="Grid_Mst" 
							header="_PK|_Project Code|_Project Name|Result Date" 
							format="0|0|0|0"
							aligns="0|0|0|0" 
							defaults="|||" 
							editcol="0|0|0|0" 
							widths="0|1500|2000|1500" 
							styles="width:100%; height:100%"
							sorting="T" 
							oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="background: white; width: 70%" id="idRIGHT">
                <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0">
                    <tr style="height: 4%">
                        <td>
                            <fieldset style="padding: 0; background-color: #CCFFFF">
                                <table width="100%" cellpadding="1" cellspacing="1">
                                    <tr>
                                        <td width="15%" align="right">
                                            <a href="#" title="Click here to show Project" style="text-decoration: none" onClick="OnPopUp('Project')">
                                                Project&nbsp;</a></td>
                                        <td width="85%">
                                            <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="40%">
                                                        <gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
                                                    </td>
                                                    <td width="60%">
                                                        <gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
                                                    </td>
                                                    <td>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <gw:imgbtn id="bve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnUpdte" img="search" alt="Search" onclick="OnSearch('Tab')" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnNew" img="new" alt="Add New" onclick="OnAddNew()" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibConfirm" img="confirm" alt="Confim" onclick="OnConfim()" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibCancelConfirm" img="cancel" alt="Cancel Confim" onclick="OnCancel()" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibDelete" img="delete" alt="Delete" onclick="OnDelete()" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnUpdate" img="save" alt="save" onclick="OnSave()" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnUpdate" img="excel" alt="Print" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Date of Result&nbsp;</td>
                                        <td>
                                            <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="10%">
                                                        <gw:datebox id="dtDateOfResult" lang="1" />
                                                    </td>
                                                    <td align="right" width="58%">
                                                        Percentage of completed work (Result / Plan)&nbsp;</td>
                                                    <td width="30%">
                                                        <gw:textbox id="txtPercentage" styles='width:100%' />
                                                    </td>
                                                    <td width="2%">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td colspan="5">
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 96%"> 
                        <td width="100%">
                            <gw:tab id="idTab" onpageactivate="OnSearch('Tab')">
                            <table style="width: 100%; height: 100%; overflow: scroll" name="Daily Report" id="Tab1"
                                cellpadding="0" cellspacing="0">
                                <tr height="2%">
                                    <td>
                                        <fieldset style="width: 100%; padding: 0">
                                            <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td align="right" width="10%">
                                                        <a href="#" title="Click here to show Weather" style="text-decoration: none" onClick="OnPopUp('Weather')">
                                                            Weather&nbsp;</a></td>
                                                    <td width="25%">
                                                       <gw:list id="lstWeather" styles='width:100%' />
                                                    </td>
                                                    <td width="65%">
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr height="98%">
                                    <td>
                                        <table border="1" style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                            <tr height="2%" bgcolor="#CCFFFF">
                                                <td align="center" width="50%" height="25">
                                                    Today's Result</td>
                                                <td align="center" width="50%" height="25">
                                                    Plan for Tomorrow</td>
                                            </tr>
                                            <tr height="68%">
                                                <td width="50%">
                                                    <gw:textarea id="txtTodayResult" styles='width:100%;height:100%' />
                                                </td>
                                                <td width="50%">
                                                    <gw:textarea id="txtTomorrowPlan" styles='width:100%;height:100%' />
                                                </td>
                                            </tr>
                                            <tr height="2%" bgcolor="#CCFFFF" bordercolor="#0099FF">
                                                <td align="center" width="50%" height="25" colspan="2">
                                                    Remark</td>
                                            </tr>
                                            <tr height="28%">
                                                <td width="100%" colspan="2">
                                                    <gw:textarea id="txtRemark" styles='width:100%;height:100%' />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                           
                             <table style="width: 100%; height: 100%; overflow: scroll" name="Manpower" id="Tab3"
                                cellpadding="0" cellspacing="0">
								<tr height="2%">
									<td>
										<fieldset style="padding:0">
											<table cellpadding="0" cellspacing="0" width="100%">
												<tr>
														<td width="100%" align="right"><gw:imgbtn id="ibtnNew" img="new" alt="Add New" onclick="OnPopUp('Manpower')" /></td>
												</tr>
											</table>
										</fieldset>	
									</td>
									
								</tr>
                                <tr height="98%">
                                    <td width="100%">
                                        <!--header="0.Job|1.Unit|2.Last Day|3.Today|4.Cummulation|5.Tomorrow|6.Last Day|7.Today|8.Cummulation|9.Tomorrow|10.Last Day|11.Today|12.Cummulation|13.Tomorrow"   -->
                                        <gw:grid id="Grid_Manpower" 
										header="Job|Type|Unit|Last Day|Today|Cummulation|Tomorrow|Last Day|Today|Cummulation|Tomorrow|Last Day|Today|Cummulation|Tomorrow|_Project_pk|_Master_pk|_popup_pk|_pk|_date|Description"
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										aligns="0|1|1|3|3|3|3|3|3|3|3|3|3|3|3|3|0|0|0|0|0" 
										defaults="||||||||||||||||||||"
										editcol="1|1|1|0|1|0|1|0|1|0|1|0|1|0|1|1|1|1|0|0|1" 
										widths="2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|0|0|0|0|0|3000"
										styles="width:100%; height:100%" 
										sorting="T" />
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%; height: 100%; overflow: scroll" name="Equipment" id="Tab4"
                                cellpadding="0" cellspacing="0">
                                <tr height="2%">
                                    <td>
                                        <fieldset style="width: 100%; padding: 0">
                                            <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="100%">
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="ibPopup1" img="popup" alt="Select Item" onclick="OnPopUp('Item')" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="ibDelete1" img="delete" alt="Delete" onclick="OnDeleteGrid('Grid_Equipment')" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="ibUnDelete1" img="udelete" alt="Undelete" onclick="OnUnDeteleGrid('Grid_Equipment')" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr height="98%">
                                    <td>
                                        <gw:grid id='Grid_Equipment' 
                                            header='_PK|_ITEM_PK|Equipment Item Code|Equipment Item Name|Type|Unit|Last Day|Today|Cummulation|Tomorrow|Remark|_master_pk'
                                            format='0|0|0|0|0|0|0|0|0|0|0|0' 
                                            aligns='0|0|0|0|0|0|0|0|0|0|0|0' 
                                            editcol='1|1|0|0|1|1|1|1|1|1|1|1'
                                            widths='0|0|2000|3500|2000|1500|2000|2000|2000|2000|3000|0' 
                                            sorting='T' 
                                            styles='width:100%; height:100%'
                                          oncelldblclick="OnDblClick_PopUp('Equipment')"
                                             />
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%; height: 100%; overflow: scroll" name="Material" id="Tab5"
                                cellpadding="0" cellspacing="0">
                                <tr height="2%">
                                    <td>
                                        <fieldset style="width: 100%; padding: 0">
                                            <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="10%" align="right"><a onclick="OnPopUp('vendor')" title="Click here to select partner" href="#tips" style="text-decoration : none; color:#0000FF">Vendor&nbsp;</a> </td>
		                                            <td width="60%" >
		                                                <table style="width:100%" cellpadding="0" cellspacing="0">
		                                                    <tr>
		                                                            <td width="40%"><gw:textbox id="txtPartnerID" styles ="width:100%"  /></td>
		                                                            <td width="60%" ><gw:textbox id="txtPartnerNm" style="width:100%" text=""/></td>
		                                                            <td ><gw:textbox id="txtPartner_PK" style="width:100%;display:none" /></td>
		                                                            <td ><gw:imgbtn id="reset" img="Reset" alt="Reset" onclick="txtPartnerID.text='';txtPartner_PK.text='';txtPartnerNm.text='';" /></td>
		                                                    </tr>
		                                                </table>
		                                            </td>
		                                           <td width="30%"></td> 
                                                    <td>
                                                        <gw:imgbtn id="ibPopUp2" img="popup" alt="Select Incoming Material" onclick="OnPopUp('Item2')" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="ibDelete2" img="delete" alt="Delete" onclick="OnDeleteGrid('Grid_Material')" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="ibUnDelete2" img="udelete" alt="Undelete" onclick="OnUnDeteleGrid('Grid_Material')" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr height="98%">
                                    <td>
                                        <gw:grid id='Grid_Material' 
                                        header='_PK|_ITEM_PK|_master_pk|_vendor_pk|Level Code|Level Name|Item Code|Item Name|Voucher No|PO No|Vendor Code|Vendor Name|Spec|Type|Unit|_BOQ|Until Yesterday|Today|Accum.|Description|_Level_pk'
                                            format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|0|0' 
                                            aligns ='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                                           editcol='0|0|0|0|0|0|0|0|1|1|0|0|1|1|1|1|1|1|1|1|0'
                                            widths='0|0|0|0|1500|2500|1500|2500|1500|1500|1500|2500|1500|2000|1500|0|1500|1500|1500|3000|0' 
                                            sorting='T' 
                                            styles='width:100%; height:100%' 
                                          oncelldblclick="OnDblClick_PopUp('Material')"
                                          />
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%; height: 100%; overflow: scroll" name="Attached File" id="Tab6"
                                cellpadding="0" cellspacing="0">
                                <tr height="2%">
                                    <td>
                                        <fieldset style="width: 100%; padding: 0">
                                            <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="100%">
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="ibAttFile" img="attach" alt="Attach" onclick="AttachFiles()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="ibDeleteFile" img="delete" alt="Delete" onclick="DeleteAtt()" />
                                                    </td>
                                                    <td style="display:none">
                                                        <gw:imgbtn id="Save" img="save" alt="Update" onclick="OnSaveFile()" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr height="98%">
                                    <td>
                                        <gw:grid id="Grid_Attached" header="_No|Entry Date|File Name|Description|_pk|_master_pk" format="0|4|0|0|0|0"
                                            aligns="1|0|0|0|0|0" defaults="|||||" editcol="1|1|1|1|1|1" widths="600|1500|5000|2000|1000|1000"
                                            styles="width:100%; height:100%" sorting="T" oncelldblclick="OnOpenFile()"/>
                                    </td>
                                </tr>
                            </table>
                              <table style="width: 0%; height: 100%;display:none; overflow: scroll" name="Manpower" id="Tab2"
                                cellpadding="0" cellspacing="0">
                                
                                <tr height="100%">
                                    <td>
                                        <!--header="0.Level 1|1.Level 2|2.Level 3|3.Level 4|4.Level 5|5.UOM|6.Weight|7.Total Plan Quantity|8.Result|9.Cumulation to Last Day|10.Today|11.Cummulation|12.Cumulation to Last Day|13.Today|14.Cummulation|15.Cumulative Progress Rate" -->
                                            <gw:grid id="Grid_Quantity" 
                                            header="Work Item|Major Work|Type|Nationality|Unit|Until Yesterday|Today|Cummulation|Tomorrow|Rate|Description|_pk|_Master_pk|_tecps_conprogplan_pk|_RESULT_DT"
                                            format="0|0|0|0|0|1|1|1|1|1|0|0|0|0" 
                                            aligns ="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            defaults="|||||||||||||" 
                                            editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
                                            widths="3000|3000|1700|1500|1500|2000|2000|2000|2000|2000|2000|0|0|0"
                                            styles="width:100%; height:100%" sorting="T" />
                                    </td>
                                </tr>
                            </table>
                            </gw:tab>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <img status="expand" id="imgArrow" src="../../../system/images/left1.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onClick="OnToggle()" />
</body>
<gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
<gw:textbox id="txtTab1PK" styles='width:100%;display:none' />
<gw:image id="imgFile" table_name="tecps_subcontappdfile" view="/binary/ViewFile.aspx"
    post="/binary/PostFile.aspx" styles="width:100;height:100;display:none" />
    <gw:textbox id="txtProject_Pk" readonly="true" styles='width:100%;display:none' />
  <gw:textbox id="txtLevel_pk" styles='width:100%;display:none' />  
</html>