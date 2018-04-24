<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Packing List Entry</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>
var user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var flag;

var G1_PackList_PK  = 0,
    G1_Packing_No   = 1,
    G1_Packing_Date = 2,
    G1_PO_No        = 3;
    
var G2_PackWI_PK    = 0,
    G2_WI_No        = 1,
    G2_PO_No        = 2,
    G2_Style_Spec   = 3,
    G2_Packages_PK  = 4,
    G2_Label_ID     = 5,
    G2_Array_SO_PK  = 6,
    G2_Style_PK     = 7,
    G2_Seq          = 8;

var G3_Detail_PK        = 0,
    G3_PackList_PK      = 1,
    G3_PACKING_WI_PK    = 2,
    G3_WI_No            = 3,
    G3_PO_No            = 4,
    G3_Style            = 5,
    G3_Seq              = 6,
    G3_PACKAGES_PK      = 7,
    G3_BC               = 8,
    G3_Att01            = 9,
    G3_Att02            = 10,
    G3_Att03            = 11,
    G3_Att04            = 12,
    G3_Att05            = 13;
     
var rtnLGCode = '' ;
 //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="65%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }              
//--------------------------------------------------------------------- 

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //---------------------------------- 
    txtChargerID.SetEnable(false);
    txtChargerName.SetEnable(false);
    txtBusParter01_ID.SetEnable(false);
    txtBusParter02_ID.SetEnable(false);
    txtBusParter03_ID.SetEnable(false);
    txtBusParter01_Name.SetEnable(false);
    txtBusParter02_Name.SetEnable(false);
    txtBusParter03_Name.SetEnable(false);
    txtStyleID.SetEnable(false);
    txtStyleName.SetEnable(false);
    txtPONo.SetEnable(false);
    
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
    dtWIFrom.SetDataText(System.AddDate(dtWITo.GetData(),-7));
    //----------------------------------
    SetGridFormat();    
    OnChangePage();
    OnChangeTab(); 
    //----------------------------------
    OnAddNew();
    //----------------------------------  
          
}

 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
     grdWIList.GetGridControl().MergeCells  = 2 ;	
     grdWIList.GetGridControl().MergeCol(0) = true ;	
     grdWIList.GetGridControl().MergeCol(1) = true ;   	
     grdWIList.GetGridControl().MergeCol(2) = true ;
     grdWIList.GetGridControl().MergeCol(3) = true ;
            
     var data ;
          
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0230') FROM DUAL")%>"; 
     lstExPort.SetDataText(data); 
    
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0240') FROM DUAL")%>"; 
     lstDestPort.SetDataText(data);
     
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0210') FROM DUAL")%>"; 
     lstExNation.SetDataText(data); 
    
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0220') FROM DUAL")%>"; 
     lstDestNation.SetDataText(data);
     
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0250') FROM DUAL")%>"; 
     lstDeliMethod.SetDataText(data);

     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0270') FROM DUAL")%>"; 
     lstDeliCarrier.SetDataText(data);                         

	 //---------------------------------------
     data = "DATA|WI|W/I Date|IO|I/O Date";     
     idList.SetDataText(data);
     idList.value = 'IO';    
 }

//--------------------------------------------------------------------------------------------------

 function OnPopUp(pos)
 {
      switch (pos)         
      {	
      
            case 'PO':
                var path = System.RootURL + '/form/fp/ab/fpab00330.aspx';
                var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

                if ( obj != null )
                {
                    txtArraySOPK.text = obj[0];
                    txtPONo.text      = obj[1];
                }
            break; 
                  
            case 'Charger':
                var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
                var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

                if ( obj != null )
                {
                    txtChargerName.text = obj[2];
                    txtChargerPK.text   = obj[0];
                }
            break;   
            
            case 'BusParter01'  :
                 var path = System.RootURL + '/form/fp/ab/fpab00120.aspx?partner_type=AR';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {       
	                txtBusParter01_PK.text   = object[0];
                    txtBusParter01_ID.text   = object[1];
                    txtBusParter01_Name.text = object[2];            
	             }
	        break;

            case 'BusParter02'  :
                 var path = System.RootURL + '/form/fp/ab/fpab00120.aspx?partner_type=AR';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {       
	                txtBusParter02_PK.text   = object[0];
                    txtBusParter02_ID.text   = object[1];
                    txtBusParter02_Name.text = object[2];            
	             }
	        break;

            case 'BusParter03'  :
                 var path = System.RootURL + '/form/fp/ab/fpab00120.aspx?partner_type=AR';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {       
	                txtBusParter03_PK.text   = object[0];
                    txtBusParter03_ID.text   = object[1];
                    txtBusParter03_Name.text = object[2];            
	             }
	        break;
    	    	                   
            case 'ExPort':
                 var path = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGCM0230';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

	             if ( object != null )
	             {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGCM0230';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstExPort.value = object[1];        
	                    }    
	             }                
    	        
            break;
            
            case 'DestPort':
                 var path = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGCM0240';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

	             if ( object != null )
	             {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGCM0240';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstDestPort.value = object[1];        
	                    }    
	             }                
    	        
            break;
            
            case 'DeliMethod':
                 var path = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGCM0250';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

	             if ( object != null )
	             {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGCM0250';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstDeliMethod.value = object[1];        
	                    }    
	             }                    	        
            break;  
            
            case 'DeliCarrier':
                 var path = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGCM0270';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

	             if ( object != null )
	             {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGCM0270';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstDeliCarrier.value = object[1];        
	                    }    
	             }                    	        
            break;    
            
            case 'ExNation':
                 var path = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGCM0210';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

	             if ( object != null )
	             {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGCM0210';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstExNation.value = object[1];        
	                    }    
	             }                    	        
            break;  
            
            case 'DestNation':
                 var path = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGCM0220';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

	             if ( object != null )
	             {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGCM0220';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstDestNation.value = object[1];        
	                    }    
	             }                    	        
            break;  
            
            case 'Style':
                 var path = System.RootURL + '/form/fp/ab/fpab00080.aspx?group_type=Y|Y||||';
	             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( obj != null )
	             {
	                txtStylePK.text   = obj[0];
	                txtStyleID.text   = obj[1];
                    txtStyleName.text = obj[2];
                 }	            
            break;                                      
       }
 }

//---------------------------------------------------------------------------------------------------
  
function OnAddNew()
{
    data_dsep00030_2.StatusInsert();
    
    txtPackingNo.text = "*** New ***";
    
    txtChargerName.text = "<%=Session("USER_NAME")%>";    
    txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";       
            
    grdDetail.ClearData();
    flag='';
}  
//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch(pos)
    {
        case'Master':
            if ( grdPackingList.row > 0 )
            {
                txtMasterPK.text = grdPackingList.GetGridData( grdPackingList.row, 0);
            }
            else
            {
                txtMasterPK.text = '' ;
            } 
            
            data_dsep00030_2.Call('SELECT');   
        break;
//        
        case'grdPackingList':
            data_dsep00030.Call('SELECT');
        break;
//        
        case'grdWIList':
            data_dsep00030_1.Call('SELECT');
        break;
//        
        case'grdDetail':
            data_dsep00030_3.Call('SELECT');
        break;
//        
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
         case "data_fpab00220_2":
            if ( txtLGGroupCodeID.text == 'LGCM0230' )
            {
                lstExPort.SetDataText(txtLGCodeList.text);  
                lstExPort.value = rtnLGCode;                      
            }        
            else if ( txtLGGroupCodeID.text =='LGCM0240' )
            {
                lstDestPort.SetDataText(txtLGCodeList.text);  
                lstDestPort.value = rtnLGCode;  
            }
            else if ( txtLGGroupCodeID.text =='LGCM0220' )
            {
                lstDestNation.SetDataText(txtLGCodeList.text);  
                lstDestNation.value = rtnLGCode;  
            } 
            else if ( txtLGGroupCodeID.text =='LGCM0210' )
            {
                lstExNation.SetDataText(txtLGCodeList.text);  
                lstExNation.value = rtnLGCode;  
            }                       
            else if ( txtLGGroupCodeID.text =='LGCM0250' )
            {
                lstDeliMethod.SetDataText(txtLGCodeList.text);  
                lstDeliMethod.value = rtnLGCode;             
            }
            else if ( txtLGGroupCodeID.text =='LGCM0270' )
            {
                lstDeliCarrier.SetDataText(txtLGCodeList.text);  
                lstDeliCarrier.value = rtnLGCode;             
            }            
        break;
        
        case 'data_dsep00030_2':            
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G3_PackList_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G3_PackList_PK, txtMasterPK.text);
                    }    
                }
                
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }               
        break; 
        
        case 'data_dsep00030_1':
            if (grdWIList.rows > 1)            
            {
                lblRecord.text = (grdWIList.rows-1) + ' (s)';
            }
        break;  
    }
}

//=============================================================================

 function OnDelete(index)
 {
    switch(index)
    {
        case'Master':
            if ( confirm( "Do you want to delete this Packing No ?" ) ) 
		    {
		        flag = 'delete';
		        data_dsep00030_2.StatusDelete();
                data_dsep00030_2.Call();
	        }        
        break;
        
        case'Detail':
            if ( grdDetail.GetGridData( grdDetail.row, G3_Detail_PK ) == "" ) 
		    {						            				
		        grdDetail.RemoveRow();					
		    }        			
		    else 
	        {  
		        grdDetail.DeleteRow();
	        }
        break;
    }        
    
    
 }
//=============================================================================
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}
//=============================================================================
function OnSave(pos)
{
    switch(pos)
    {
        case 'Master':   
            data_dsep00030_2.Call();
            flag = 'save';    
        break;
       
        case 'Detail':
            data_dsep00030_3.Call();
        break;
    } 
}
//=============================================================================
function OnAddItem()
{
    if(flag== 'delete')
    {
        alert("Please press New button first!!!");
        return;
    }
    
    var d_po_no = '' ;
    var old_po_no = '' ;
    var d_array_so_pk = '' ;
    var d_style_pk = '' ;
    var d_style_name = '' ;
    var d_link = '';
    //--------------------------
    var code_data = new Array();
	var ctrl = grdWIList.GetGridControl();
	var index, rowNo;
    	
    index = 0;
    rowNo = 0 ;
	
    if ( ctrl.SelectedRows == 0 )
    {
           return ;
    }
    else
    {
        for(var i=0; i < ctrl.SelectedRows; i++)
	    {	  
            rowNo = ctrl.SelectedRow(i);	            
            
            if ( !CheckDataExist( grdDetail, grdWIList.GetGridData( rowNo, G2_Packages_PK) ) )
            {
                grdDetail.AddRow();
                
                grdDetail.SetGridText( grdDetail.rows-1, G3_Seq, grdDetail.rows-1 );                                           	                                                                         
                
                grdDetail.SetGridText( grdDetail.rows-1, G3_PackList_PK,   txtMasterPK.text );                                           	                                                                         
                grdDetail.SetGridText( grdDetail.rows-1, G3_PACKING_WI_PK, grdWIList.GetGridData( rowNo, G2_PackWI_PK)   );	    
                grdDetail.SetGridText( grdDetail.rows-1, G3_WI_No,         grdWIList.GetGridData( rowNo, G2_WI_No)       );	    
                grdDetail.SetGridText( grdDetail.rows-1, G3_PO_No,         grdWIList.GetGridData( rowNo, G2_PO_No)       );	    
                grdDetail.SetGridText( grdDetail.rows-1, G3_Style,         grdWIList.GetGridData( rowNo, G2_Style_Spec)  );
                grdDetail.SetGridText( grdDetail.rows-1, G3_PACKAGES_PK,   grdWIList.GetGridData( rowNo, G2_Packages_PK) );   
                grdDetail.SetGridText( grdDetail.rows-1, G3_BC,            grdWIList.GetGridData( rowNo, G2_Label_ID)    );
                
                grdWIList.GetGridControl().Cell( 7, rowNo, 0, rowNo, grdWIList.cols-1 ) = 0x3300cc;
                
                //-----------
                if ( grdWIList.GetGridData( rowNo, G2_PO_No) != old_po_no )
                {
                    old_po_no = grdWIList.GetGridData( rowNo, G2_PO_No );
                    //------------
                    d_array_so_pk = d_array_so_pk + d_link + grdWIList.GetGridData( rowNo, G2_Array_SO_PK );
                    d_po_no      = d_po_no + d_link + grdWIList.GetGridData( rowNo, G2_PO_No );
                    d_style_pk   = grdWIList.GetGridData( rowNo, G2_Style_PK );
                    d_style_name = grdWIList.GetGridData( rowNo, G2_Style_Spec );
                     
                    d_link = ',';           
                }                                     
            }    
	    }
        txtPONo.text      = d_po_no ;
        txtArraySOPK.text = d_array_so_pk ;
        txtStylePK.text   = d_style_pk ;
        txtStyleName.text = d_style_name ;		
    }    
}
//=============================================================================
function CheckDataExist(p_oGrid,p_value)
{
   
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, G3_PACKAGES_PK) == p_value)
              {
                 return true;
              }
       }
       return false;
}
//=============================================================================
function OnReportClick(pos)
{
    switch (pos)
    {
        case '01' :
             if (txtMasterPK.text!="")
             { 
                  //var url =System.RootURL + '/reports/ds/cd/dscd00030.xls?sopk=' + txtMasterPK.text  ;
                  //var url =System.RootURL + '/reports/ds/cd/dscd00030_YC.aspx?sopk=' + txtMasterPK.text  ;
                  var url =System.RootURL + '/reports/ds/ep/dsep00030_HC.aspx?sopk='+ txtMasterPK.text +'&delimethod='+lstDeliMethod.value ;
                  //var url =System.RootURL + '/reports/ds/ep/rpt_dsep00030_cotton.aspx?sopk='+ txtMasterPK.text ;
                  window.open(url); 
             }       
             else    
             {
                 alert("Pls, select one packing list !");
             } 
        break;
        
        case '02':
             if (txtMasterPK.text!="")
             { 
                  var url =System.RootURL + '/reports/ds/ep/rpt_dsep00030_st.aspx?master_pk='+ txtMasterPK.text ;
                  window.open(url); 
             }       
             else    
             {
                 alert("Pls, select one packing list !");
             }         
        break;        
    }             
}
//=============================================================================
 function OnChangePage()
 {
 
    var strRad = radPage.GetData();
             
	switch (strRad)
	{
		case '1':
		    page1.style.color = "cc0000"; 
		    page2.style.color = ""; 
		    
		    Packing_List.style.display = "";
		    WI_List.style.display      = "none";   
        break;
        
        case '2':
		    page1.style.color = ""; 
		    page2.style.color = "cc0000";
		    
		    Packing_List.style.display = "none";
		    WI_List.style.display      = "";		    		    		    
        break;	
    } 
 } 
//=============================================================================
 function OnChangeTab()
 {
 
    var strRad = radSearchPacking.GetData();
             
	switch (strRad)
	{
		case '1':
		    rdAll.style.color       = "cc0000"; 
		    rdIn.style.color        = "";
		    rdOut.style.color       = "";	    
        break;
        
        case '2':
		    rdAll.style.color       = ""; 
		    rdIn.style.color        = "cc0000";
		    rdOut.style.color       = "";		    		    
        break;
        
        case '3':
		    rdAll.style.color       = ""; 
		    rdIn.style.color        = "";
		    rdOut.style.color       = "cc0000";		    		    
        break;		
    } 
 }
 //=======================================================================

</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_dsep00030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00030" > 
                <input bind="grdPackingList" > 
                     <input bind="txtSearchNo" /> 
                     <input bind="dtFrom" /> 
                     <input bind="dtTo" />
                 </input> 
                <output bind="grdPackingList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_dsep00030_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="control"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36"  function="<%=l_user%>lg_sel_dsep00030_2" procedure="<%=l_user%>lg_upd_dsep00030_2" > 
                <inout > 
                     <inout bind="txtMasterPK" /> 
                     <inout bind="txtPackingNo" /> 
                     <inout bind="dtPack" /> 
                     <inout bind="txtArraySOPK" />
                     <inout bind="txtPONo" />
                     <inout bind="txtStylePK" />
                     <inout bind="txtStyleID" />
                     <inout bind="txtStyleName" />
                     <inout bind="txtContractNo" /> 
                     <inout bind="txtContractDate"/>
                     <inout bind="txtLCNo"/>
                     <inout bind="txtContainerNo"/>
                     <inout bind="txtBusParter01_PK"/>
                     <inout bind="txtBusParter01_ID"/>
                     <inout bind="txtBusParter01_Name"/>
                     <inout bind="txtBusParter02_PK"/>
                     <inout bind="txtBusParter02_ID"/>
                     <inout bind="txtBusParter02_Name"/>
                     <inout bind="txtBusParter03_PK"/>
                     <inout bind="txtBusParter03_ID"/>
                     <inout bind="txtBusParter03_Name"/>                                          
                     <inout bind="lstExNation"/>
                     <inout bind="lstDestNation"/>
                     <inout bind="lstDeliMethod"/>
                     <inout bind="lstDeliCarrier"/>
                     <inout bind="lstDestPort"/>
                     <inout bind="lstExPort"/>   
                     
                     <inout bind="txtChargerPK"/>   
                     <inout bind="txtChargerID"/>   
                     <inout bind="txtChargerName"/>
                     
                     <inout bind="txtAtt01"/>   
                     <inout bind="txtAtt02"/>   
                     <inout bind="txtAtt03"/>
                     <inout bind="txtAtt04"/>   
                     <inout bind="txtAtt05"/>   
                     <inout bind="txtAtt06"/>                                          
                     
                     <inout bind="txtDescription"/>                    
                </inout> 
             </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_dsep00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00030_1" > 
                <input bind="grdWIList" > 
                     <input bind="idList" />
                     <input bind="dtWIFrom" /> 
                     <input bind="dtWITo" /> 
                     <input bind="txtSearchPOStyle" />
                     <input bind="radSearchPacking" />  
                 </input> 
                <output bind="grdWIList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_dsep00030_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" function="<%=l_user%>lg_sel_dsep00030_3" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" procedure="<%=l_user%>lg_upd_dsep00030_3"> 
                <input bind="grdDetail" > 
                     <input bind="txtMasterPK" />  
                 </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="txtLGCodeList" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td id="left" style="width: 35%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="background-color: CCFFFF; white-space: nowrap">
                            <gw:radio id="radPage" value="1" styles="width:100%" onchange="OnChangePage()">                      
                                <span value="1" id="page1">Packing List</span>                       
                                <span value="2" id="page2">W/I List</span>		                                
		                    </gw:radio>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%; height: 100%">
                            <table style="width: 100%; height: 100%" id="Packing_List" name="Packing_List">
                                <tr style="height: 2%">
                                    <td style="width: 10%" align="right">
                                        Date
                                    </td>
                                    <td style="width: 89%">
                                        <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />
                                        ~
                                        <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSearch2" img="search" alt="Search" text="Search" onclick="OnSearch('grdPackingList')" />
                                    </td>
                                </tr>
                                <tr style="height: 5%">
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Packing No
                                    </td>
                                    <td colspan="2" align="left">
                                        <gw:textbox id="txtSearchNo" styles="width: 100%" onenterkey="OnSearch('grdPackingList')" />
                                    </td>
                                </tr>
                                <tr style="height: 97%">
                                    <td colspan="3" style="width: 100%">
                                        <gw:grid id='grdPackingList' header='_PK|Packing No|Packing Date|P/O No' format='0|0|4|0'
                                            aligns='0|0|1|0' defaults='|||' editcol='0|0|0|0' widths='1000|1500|1200|1000'
                                            sorting='T' styles='width:100%; height:100%' onclick="OnSearch('Master')" />
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%; height: 100%" id="WI_List" name="WI_List">
                                <tr style="height: 1%">
                                    <td style="width: 10%" align="right">
                                        <gw:list id="idList" styles="color:blue;width:80" value="IO" />
                                    </td>
                                    <td style="width: 88%; white-space: nowrap">
                                        <gw:datebox id="dtWIFrom" lang="<%=Application("Lang")%>" mode="01" />
                                        ~
                                        <gw:datebox id="dtWITo" lang="<%=Application("Lang")%>" mode="01" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="idAddNew" img="new" alt="Add New" onclick="OnAddItem()" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnSearch01" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('grdWIList')" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        PO/Style
                                    </td>
                                    <td colspan="3" style="width: 90%; white-space: nowrap">
                                        <gw:textbox id="txtSearchPOStyle" styles='width:100%' onenterkey="OnSearch('grdWIList')" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td colspan="2" align="center">
                                        <gw:radio id="radSearchPacking" value="1" styles="width:100%" onchange="OnChangeTab()">                      
			                                <span value="1" id="rdAll">All</span>                       
			                                <span value="2" id="rdIn">Incoming</span>
			                                <span value="3" id="rdOut">Outgoing</span>    			                                
        			                    </gw:radio>
                                    </td>
                                    <td colspan="2">
                                        <gw:label id="lblRecord" styles='width:100%;color:cc0000;font:9pt' text='(s)' />
                                    </td>
                                </tr>
                                <tr style="height: 97%">
                                    <td colspan="4">
                                        <gw:grid id='grdWIList' header='_PK|_W/I No|P/O No|Style Spec|_packages_pk|Label ID|_array_so_pk|_style_pk|Seq'
                                            format='0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|1|0|0|1' defaults='||||||||' editcol='0|0|0|0|0|0|0|0|0'
                                            widths='1000|1500|1500|2000|0|1200|0|0|0' sorting='T' styles='width:100%; height:100%'
                                            oncelldblclick="OnAddItem()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 65%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 1%">
                            <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand"
                                onclick="OnToggle()" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Packing No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtPackingNo" styles="width: 100%" csstype="mandatory" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('PO')">P/O No</b>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtPONo" styles="width: 100%" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtPack" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnReport02" img="excel" alt="Packing List 02" text="Packing List 02"
                                onclick="OnReportClick('02')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnReport01" img="excel" alt="Packing List 01" text="Packing List 01"
                                onclick="OnReportClick('01')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnAddNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="12">
                            <!-- <gw:tab id="tab01"> -->
                            <gw:tab id="tab01">
                            <table style="width: 100%; height: 100%" name="Tab 01">
                                <tr style="height: 1%">
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Charger')">Charger </b>
                                    </td>
                                    <td style="white-space: nowrap" colspan="3">
                                        <gw:textbox id="txtChargerPK" styles='width:100%; display:none' />
                                        <gw:textbox id="txtChargerID" styles='width:30%' />
                                        <gw:textbox id="txtChargerName" styles='width:70%' />
                                    </td>
                                    <td style="width: 10%" align=right>
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Style')">Style</b>
                                    </td>
                                    <td style="width: 15%; white-space:nowrap" colspan=3>
                                        <gw:textbox id="txtStylePK" styles='width:100%; display:none' />                                    
                                        <gw:textbox id="txtStyleID" styles='width:30%' />
                                        <gw:textbox id="txtStyleName" styles='width:70%'  />
                                        
                                    </td>                                   
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('ExNation')">Ex Nation</b>
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:list id="lstExNation" styles="width: 100%" />
                                    </td>
                                    <td style="width: 10%; white-space:nowrap" align="right">
                                         <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DestNation')">Dest Nation</b>
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:list id="lstDestNation" styles="width: 100%" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Att01
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:textbox id="txtAtt01" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Att02
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:textbox id="txtAtt02" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('ExPort')">Ex Port</b>
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:list id="lstExPort" styles="width: 100%" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DestPort')">Dest Port</b>
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:list id="lstDestPort" styles="width: 100%" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Att03
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:textbox id="txtAtt03" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Att04
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:textbox id="txtAtt04" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%; white-space:nowrap" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DeliMethod')">Deli Method</b>                                   
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:list id="lstDeliMethod" styles="width: 100%" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DeliCarrier')">Deli Carrier</b>                                   
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:list id="lstDeliCarrier" styles="width: 100%" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Att05
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:textbox id="txtAtt05" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Att06
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <gw:textbox id="txtAtt06" styles='width:100%' />
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%; height: 100%" name="Tab 02">
                                <tr style="height: 1%">
                                    <td style="width: 10%; white-space:nowrap" align="right">
                                        Contract No
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtContractNo" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Contract Date</td>
                                    <td style="width: 15%">
                                        <gw:datebox id="txtContractDate" lang="<%=Application("Lang")%>" mode="01" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        L/C No</td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtLCNo" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Container</td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtContainerNo" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%" align=right>
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('BusParter01')">Cust 01</b>
                                    </td>
                                    <td style="white-space: nowrap" colspan="7">
                                        <gw:textbox id="txtBusParter01_PK" styles='width:100%; display:none' />
                                        <gw:textbox id="txtBusParter01_ID" styles='width:30%' />
                                        <gw:textbox id="txtBusParter01_Name" styles='width:70%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%" align=right>
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('BusParter02')">Cust 02</b>
                                    </td>
                                    <td style="white-space: nowrap" colspan="7">
                                        <gw:textbox id="txtBusParter02_PK" styles='width:100%; display:none' />
                                        <gw:textbox id="txtBusParter02_ID" styles='width:30%' />
                                        <gw:textbox id="txtBusParter02_Name" styles='width:70%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%" align=right>
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('BusParter03')">Cust 03</b>
                                    </td>
                                    <td style="white-space: nowrap" colspan="7">
                                        <gw:textbox id="txtBusParter03_PK" styles='width:100%; display:none' />
                                        <gw:textbox id="txtBusParter03_ID" styles='width:30%' />
                                        <gw:textbox id="txtBusParter03_Name" styles='width:70%' />
                                    </td>
                                </tr>
                            </table>
                            </gw:tab>
                            <!-- </gw:tab> -->
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right" colspan="2">
                            Description
                        </td>
                        <td colspan="5">
                            <gw:textbox id="txtDescription" styles="width: 100%" />
                        </td>
                        <td style="width: 6%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDeleteDTL" img="delete" alt="Delete" onclick="OnDelete('Detail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUnDeleteDTL" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 93%">
                        <td colspan="12">
                            <gw:grid id='grdDetail' header='_PK|_PA_PACKING_LIST_PK|_PACKING_WI_PK|W/I No|P/O No|Style|Seq|_PA_PACKAGES_PK|B/C|Att01|Att02|Att03|Att04|Att05'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|1|0|1|0|0|0|0|0' defaults='|||||||||||||'
                                editcol='0|0|0|0|0|0|1|0|0|1|1|1|1|1' widths='0|0|0|1500|1500|2500|1000|0|1500|1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
    <gw:textbox id="txtEmpPK" styles="width: 100%;display:none" />
    <gw:textbox id="txtArraySOPK" styles="width: 100%;display:none" />
    <!------------------------------------------------------------------------------->
    <gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
    <gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
    <!------------------------------------------------------------------------------->
</body>
</html>
