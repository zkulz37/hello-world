<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Line W/I Entry</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script>
//-----------------------------------------------------
var flag;

var G_PK        = 0,
    G_Status    = 1,
    G_SLip_No   = 2,
    G_Date      = 3,
    G_PARTNER   = 4;		 

//===============================================================================================
/*PROD*/
var G1_DETAIL_PK        = 0,
    G1_MASTER_PK        = 1,
    G1_SEQ 				= 2,
    G1_ITEM_PK      	= 3,
    G1_ITEM_CODE    	= 4,
    G1_ITEM_NAME    	= 5,
	G1_UOM				= 6,
	G1_LOTNO             = 7,
    G1_INS_QTY          = 8,    
    G1_INS_REMARK       = 9;
   /*WIP*/      
    var G3_DETAIL_PK        = 0,
    G3_DETAIL_PK        = 1,
    G3_MASTER_PK        = 2,
    G3_ITEM_PK      	= 3,
    G3_ITEM_CODE    	= 4,
    G3_ITEM_NAME    	= 5,
	G3_UOM				= 6,G3_WIP_QTY
	G3_WIP_QTY          = 7,    
    G3_INS_REMARK       = 8;
   /*cons*/     
    var G2_pk   = 0,
    G2_WI_M_PK  = 1,
    G2_LINE_SIDE = 2,
    G2_SEQ      = 3,
    G2_ITEM_PK  = 4,
    G2_ITEM_CD  = 5,
    G2_ITEM_NM  = 6,
    G2_UOM      = 7,
    G2_LOT_NO   = 8,
    G2_BALE     = 9, 
    G2_ATT01    = 10,
    G2_KG       = 11, 
    G2_RATIO    = 12,
    G2_WH_PK    = 13,   
    G2_REMARK   = 14;   
    
var arr_FormatNumber = new Array();    
 //===============================================================================================

function OnToggleLR()
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");
    var imgArrow  = document.all("imgArrow");  
    
    if ( imgArrow.status == "expand" )
    {
        left.style.display     = "none";
        right.style.display    = "";                              
                
        imgArrow.status = "collapse";  
        imgArrow.src = "../../../system/images/button/next.gif";                              
    }
    else 
    {
        left.style.display     = "";
        right.style.display    = "";
        
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
function OnToggleUD()
{ 
    var up  = document.all("id_midle");    
    var down = document.all("id_bottom");
    var imgArrow  = document.all("img2");  
    
    if ( imgArrow.status == "collapse" )
    {
        up.style.display     = "";
        up.style.height      = '79%'
        down.style.display    = "none";                              
                
        imgArrow.status = "expand";  
        imgArrow.src = "../../../system/images/up.gif";                              
    }
    else 
    {
        up.style.display     = "";
        down.style.display    = "";
        up.style.height      = '45%'
        down.style.height      = '39%'
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/down.gif";
    }
}
 //===============================================================================================
function BodyInit()
 {
 	
    System.Translate(document);  // Translate to language session    
    
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
    txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    OnToggleLR();
	OnToggleUD();	
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------- 
    
    BindingDataList();    
    //----------------------------
	txtMasterPK.text = "<%=Request.querystring("outgo_m_pk")%>";
	
	if ( Number(txtMasterPK.text) > 0 )
	{
		flag = 'view' ;
        data_kbpr00020_1.Call("SELECT");
	}
	else
	{	
    	OnAddNew('Master');
	}	
	grdConsL.GetGridControl().FrozenCols = 7;
	
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
     //----------------------------
     data = "<%=ESysLib.SetListDataSQL("SELECT pk ,line_id || ' - ' || line_name  FROM tlg_pb_line  WHERE del_if = 0  ORDER BY line_id" )%>";    
     lstLine.SetDataText(data);
     //----------------------------
	 data = "<%=ESysLib.SetListDataSQL("SELECT pk ,line_id || ' - ' || line_name  FROM tlg_pb_line  WHERE del_if = 0  ORDER BY line_id" )%>||";    
     lstLine1.SetDataText(data);	 
	 lstLine1.value="";
	 
	 data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.code ||' - '||a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGGS0202' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>||";
	 lstShift.SetDataText(data);
	 lstShift.value ="";
	 	 
	 var ctr = grdProd.GetGridControl(); 
     ctr.ColFormat(G1_INS_QTY) = "#,###,###,###,###,###.##";	 
	    
     arr_FormatNumber[G1_INS_QTY] = 2;                  
 }

 //==================================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_kbpr00020_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdProd.ClearData();
            grdConsL.ClearData();
            grdConsS.ClearData();
            grdWIP.ClearData();
            flag = "view";        
        break;  
        
        case 'FreeItem':
            if (txtMasterPK.text !="")
	        {
                 var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];   
                                grdProd.AddRow();    
                               
                                grdProd.SetGridText( grdProd.rows-1, G1_SEQ,       grdProd.rows-1 );                        
                                grdProd.SetGridText( grdProd.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	
    							
    							grdProd.SetGridText( grdProd.rows-1, G1_LOTNO, txtSlipNo.text +"-"+ (grdProd.rows-1)   ); 
    							    	                                               
                                grdProd.SetGridText( grdProd.rows-1, G1_ITEM_PK,   arrTemp[0]);//item_pk	    
                                grdProd.SetGridText( grdProd.rows-1, G1_ITEM_CODE, arrTemp[1]);//item_code	    
                                grdProd.SetGridText( grdProd.rows-1, G1_ITEM_NAME, arrTemp[2]);//item_name
							    grdProd.SetGridText( grdProd.rows-1, G1_UOM,       arrTemp[5]);//item_name	      
                        }	
                 }     
            }   else
            {
                alert("Please, select an instruction!")
	            return ;
            } 
        break;  
	    case 'STOCK_LINE':
             var path = System.RootURL + "/form/kb/pr/kbpr00021.aspx?group_type=Y|Y|Y|Y|Y|Y";
			 var object = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:50;dialogHeight:40');             
			 
 			 if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdConsL.AddRow();
                        
                        grdConsL.SetGridText( grdConsL.rows-1, G2_SEQ,       grdConsL.rows-1 );
                        grdConsL.SetGridText( grdConsL.rows-1, G2_LINE_SIDE,  'LINE');
                        grdConsL.SetGridText( grdConsL.rows-1, G2_WI_M_PK,txtMasterPK.text ); //master_pk9999999
  
						grdConsL.SetGridText( grdConsL.rows-1, G2_ITEM_PK,   arrTemp[3]);//item_pk
                        grdConsL.SetGridText( grdConsL.rows-1, G2_ITEM_CD, arrTemp[4]);//item_code	    
                        grdConsL.SetGridText( grdConsL.rows-1, G2_ITEM_NM, arrTemp[5]);//item_name
						grdConsL.SetGridText( grdConsL.rows-1, G2_UOM,       arrTemp[6]); 
						grdConsL.SetGridText( grdConsL.rows-1, G2_WH_PK,       arrTemp[1]);
                        
                        grdConsL.SetGridText( grdConsL.rows-1, G2_LOT_NO,  arrTemp[8]); 												
                        grdConsL.SetGridText( grdConsL.rows-1, G2_KG, arrTemp[7]);   
                        grdConsL.SetGridText( grdConsL.rows-1, G2_ATT01, arrTemp[9]);   							                                                                                                                                               
                       
                    }                                 
             }    
              SumConsumption();    			 
	    break;
	    
	      case 'STOCK_SIDE':
             var path = System.RootURL + "/form/kb/pr/kbpr00021.aspx?group_type=Y|Y|Y|Y|Y|Y";
			 var object = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:50;dialogHeight:40');             
			 
 			 if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdConsS.AddRow();
                        
                        grdConsS.SetGridText( grdConsS.rows-1, G2_SEQ,       grdConsS.rows-1 );
                        grdConsS.SetGridText( grdConsS.rows-1, G2_LINE_SIDE,  'SIDE');
                        grdConsS.SetGridText( grdConsS.rows-1, G2_WI_M_PK,txtMasterPK.text ); //master_pk9999999
  
						grdConsS.SetGridText( grdConsS.rows-1, G2_ITEM_PK,   arrTemp[3]);//item_pk
                        grdConsS.SetGridText( grdConsS.rows-1, G2_ITEM_CD, arrTemp[4]);//item_code	    
                        grdConsS.SetGridText( grdConsS.rows-1, G2_ITEM_NM, arrTemp[5]);//item_name
						grdConsS.SetGridText( grdConsS.rows-1, G2_UOM,       arrTemp[6]); 
						grdConsS.SetGridText( grdConsS.rows-1, G2_WH_PK,       arrTemp[1]);
                        
                        grdConsS.SetGridText( grdConsS.rows-1, G2_LOT_NO,  arrTemp[8]); 												
                        grdConsS.SetGridText( grdConsS.rows-1, G2_KG, arrTemp[7]);   
                        grdConsS.SetGridText( grdConsS.rows-1, G2_ATT01, arrTemp[9]);   							                                                                                                                                               
                       
                    }                                 
             }    
                SumConsumption();    			 
	    break;			
	
    }
}  

//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_kbpr00020.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_kbpr00020_1.GetStatus() == 20 && grdProd.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                    }
                    flag = 'view' ;
                    data_kbpr00020_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                }
                
                flag = 'view' ;
                data_kbpr00020_1.Call("SELECT");
            }                               
        break;
        case 'ConsL':
            data_kbpr00020_3_LINE.Call("SELECT");
        break;
        case 'ConsS':
             data_kbpr00020_3_SIDE.Call("SELECT");
        break;
        case 'grdProd':            
            data_kbpr00020_2.Call("SELECT");
        break;
        case 'WIP':            
            data_kbpr00020_4.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
         case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGGS0202')
             {
                lstShift.SetDataText(txtLGCodeList.text);
                lstShift.value = rtnLGCode;                      
             }
            
      break;
      
        case "data_kbpr00020_1": 
            if ( flag == 'save')
            {
              //----------------------------
                OnSave('ConsL');                
            }
            else
            {
                //---------------------------- 
                OnSearch('ConsL');   
            }           
        break;

        case "data_kbpr00020_2":
           
            if ( grdProd.rows > 1 )
            {
	            grdProd.SetCellBold( 1, G1_ITEM_CODE, grdProd.rows - 1, G1_ITEM_CODE, true);
                grdProd.SetCellBold( 1, G1_INS_QTY,   grdProd.rows - 1, G1_INS_QTY,   true);

                grdProd.SetCellBgColor( 1, G1_ITEM_CODE , grdProd.rows - 1, G1_ITEM_NAME , 0xCCFFFF );        
            }   
            lblProd.text = "Total: " + CalTotal(grdProd,G1_INS_QTY);
            OnSearch("WIP");      
        break;

        case 'pro_kbpr00020':
            alert(txtReturnValue.text);
            OnSearch("WIP");
        break;   
        
        case 'pro_kbpr00020_1':
            alert(txtReturnValue.text);
        break; 		
        
        case 'data_kbpr00020_3_LINE':
            if ( flag == 'save')
            {
              //----------------------------
                flag = 'search' ;
                OnSave('ConsS');                              
            }
            else
            {
                //---------------------------- 
                OnSearch('ConsS');   
            }    
        break;
        case 'data_kbpr00020_3_SIDE':
             OnSearch('grdProd');
             SumConsumption(); 
        break;
        case 'data_kbpr00020_4':
			if ( grdWIP.rows > 1 )
            {
	            grdWIP.SetCellBold( 1, G3_WIP_QTY,   grdWIP.rows - 1, G3_WIP_QTY,   true);      
            }   
            lblTotalWIP.text = "Total: " + CalTotal(grdWIP,G3_WIP_QTY);
        break;
        case 'pro_kbpr00020_prod':
             alert(txtReturnValue.text);
             OnSearch('grdProd');
        break;  
   }            
}

//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'PROD':
            var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=Y|N|Y|N|N|N';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtProdID.text = obj[1];
                txtProdNM.text = obj[2];
                txtProdPK.text   = obj[0];
            }
        break;            
        
        case 'Line':
            var path = System.RootURL + '/form/fp/ab/fpab00200.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');            
        break;   
        case 'Shift':
            var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGGS0202";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGGS0202';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstShift.value = object[1];      
	                }    	                
	             }      
        break;            				 	                	 
    }	       
}
//======================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'WIP' :
            if ( txtMasterPK.text != '' )
            {        
                 pro_kbpr00020.Call();
            }                          
        break;  
     
       case 'Submit' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to submit this Slip?'))
                {
                    pro_kbpr00020_1.Call();
                } 
            }                          
        break;  
        case 'PROD' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to general product for this WI?'))
                {
                    pro_kbpr00020_prod.Call();
                } 
            }                          
        break;            
           
    }
}
//=================================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_kbpr00020_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':  
            if(Validate())
            {
                for(var i=1; i < grdProd.rows;i++)
                    {
                        if ( grdProd.GetGridData( i, G1_MASTER_PK) == '' )
                        {
                            grdProd.SetGridText( i, G1_MASTER_PK, txtMasterPK.text);
                        } 
                    }     
                data_kbpr00020_2.Call();
            }
        break;
        
        case 'ConsL': 
              
                for(var i=1; i < grdConsL.rows;i++)
                {
                    if ( grdConsL.GetGridData( i, G2_WI_M_PK) == '' )
                    {
                        grdConsL.SetGridText( i, G2_WI_M_PK, txtMasterPK.text);
                    } 
                }      
            data_kbpr00020_3_LINE.Call();
        break;
        
       case 'ConsS': 
              
                for(var i=1; i < grdConsS.rows;i++)
                {
                    if ( grdConsS.GetGridData( i, G2_WI_M_PK) == '' )
                    {
                        grdConsS.SetGridText( i, G2_WI_M_PK, txtMasterPK.text);
                    } 
                }      
            data_kbpr00020_3_SIDE.Call();
        break;
    }
}

//=================================================================================

function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdProd" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G1_REQ_UOM || event_col == G1_OUT_UOM )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdProd.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }
                 else if ( event_col == G1_OUT_ITEM_CODE || event_col == G1_OUT_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdProd.SetGridText( event_row, G1_OUT_ITEM_PK, object[0] );
                            grdProd.SetGridText( event_row, G1_OUT_ITEM_CODE,   object[1] );
                            grdProd.SetGridText( event_row, G1_OUT_ITEM_NAME,   object[2] );
                       }                       
                 }
            break;             
      }         
}   

//=================================================================================

function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_kbpr00020_1.StatusDelete();
                data_kbpr00020_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdProd.GetGridData( grdProd.row, G1_DETAIL_PK ) == '' )
                {
                    grdProd.RemoveRow();
                }
                else
                {   
                    grdProd.DeleteRow();
                }    
            }            
        break;     
        
        case 'ConsL':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdConsL.GetGridData( grdConsL.row, G2_pk ) == '' )
                {
                    grdConsL.RemoveRow();
                }
                else
                {   
                    grdConsL.DeleteRow();
                }    
            }            
        break;     
        case 'ConsS':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdConsS.GetGridData( grdConsS.row, G2_pk ) == '' )
                {
                    grdConsS.RemoveRow();
                }
                else
                {   
                    grdConsS.DeleteRow();
                }    
            }            
        break;            

    }     
}
//=================================================================================
 
function OnUnDelete(obj)
{          
    switch(obj)
    {
        case 'Detail':
            grdProd.UnDeleteRow();
        break;
        
        case 'ConsL':
            grdConsL.UnDeleteRow();
        break;
        
        case 'ConsS':
            grdConsS.UnDeleteRow();
        break;
    }    
     
}

//=================================================================================
function Validate()
{   
    //---------------
    for( var i = 1; i < grdProd.rows; i++)
    {
        //---------------
        if ( Number(grdProd.GetGridData( i, G1_INS_QTY)) == 0 )
        {
            alert("Input out qty. at " + i + ",pls!")
            return false;
        }
        //---------------
        if ( grdProd.GetGridData( i, G1_LOTNO)=="" )
        {
            alert("Input LOT NO at " + i + ",pls!")
            return false;
        }
    }
    //----------------
    return true;
}

//=================================================================================

function CheckInput(p_obj)
{   
    var col, row
    
    col = event.col
    row = event.row  
    var dQuantiy ;
	if(p_obj =='PROD')
	{
		if ( col == G1_INS_QTY )
		{
				
			dQuantiy =  grdProd.GetGridData(row,col) ;
			
			if (Number(dQuantiy))
			{   
				if (dQuantiy >0)
				{
					grdProd.SetGridText( row, col, System.Round( dQuantiy, 2 ));
					lblProd.text = "Total: " + CalTotal(grdProd,G1_INS_QTY);
				}
				else
				{
					alert(" Value must greater than zero !!");
					grdProd.SetGridText( row, col, "");
				}
			}
			else
			{
				grdProd.SetGridText(row,col,"") ;
			}                      
		}
	}
	if(p_obj =='LINE')
	{
			
			 if ( col == G2_BALE || col== G2_KG || col == G2_ATT01)
			 {
				dQuantiy =  grdConsL.GetGridData(row,col) ;
				if (Number(dQuantiy))
				{   
					if (dQuantiy >0)
					{
						grdConsL.SetGridText( row, col, System.Round( dQuantiy, 2 ));						
					}
					else
					{
						alert(" Value must greater than zero !!");
						grdConsL.SetGridText( row, col, "");
					}
				}
				else
				{
					grdConsL.SetGridText(row,col,"") ;
				} 
				if ( col == G2_BALE || col == G2_ATT01)
				{
					var dKG_QTY;
					dKG_QTY = Number(grdConsL.GetGridData( row, G2_BALE )) * Number(grdConsL.GetGridData( row, G2_ATT01 )) ;
					grdConsL.SetGridText( row, G2_KG, parseFloat(dKG_QTY+"").toFixed(2) ) ;
				}
					SumConsumption(); 
			 }
	}
	if(p_obj =='SIDE')
	{
			
			 if ( col == G2_BALE || col== G2_KG || col == G2_ATT01)
			 {
				dQuantiy =  grdConsS.GetGridData(row,col) ;
				if (Number(dQuantiy))
				{   
					if (dQuantiy >0)
					{
						grdConsS.SetGridText( row, col, System.Round( dQuantiy, 2 ));						
					}
					else
					{
						alert(" Value must greater than zero !!");
						grdConsS.SetGridText( row, col, "");
					}
				}
				else
				{
					grdConsS.SetGridText(row,col,"") ;
				} 
				if ( col == G2_BALE || col == G2_ATT01)
				{
					var dKG_QTY;
					dKG_QTY = Number(grdConsS.GetGridData( row, G2_BALE )) * Number(grdConsS.GetGridData( row, G2_ATT01 )) ;
					grdConsS.SetGridText( row, G2_KG, parseFloat(dKG_QTY+"").toFixed(2) ) ;
				}
					 SumConsumption(); 
			 }
	
	}
	
}

//=================================================================================
function OnPrint()
{      
	if( txtMasterPK.text != "" )
	{
		 var url =System.RootURL + '/reports/kb/pr/rpt_kbpr00020.aspx?master_pk='+ txtMasterPK.text;			 
          window.open(url); 
 	}
	else
	{
		alert("Please, select one delivery voucher to print!");
	}	
}
//=================================================================================
function OnChangeDate()
{
    for(var i=1;i<grdProd.rows;i++)
    {
        grdProd.SetGridText(i,G1_START_DT,dtVoucherDate.value)
    }
}
//=================================================================================
 
 function CalTotal(p_grid,p_col)
 {
	   var vQty = 0 ;
	
       for (var i = 1; i<p_grid.rows; i++)
       {	
			vQty      =  vQty      + Number(p_grid.GetGridData(i, p_col));                   
       }       	 
	 return vQty;
 }
 //------------------------------------------
 function SumConsumption()
 {  
    var total_material = CalTotal(grdConsL,G2_KG) + CalTotal(grdConsS,G2_KG) ;
    var total_bales = CalTotal(grdConsL,G2_BALE) + CalTotal(grdConsS,G2_BALE) ;  
    if (Number(txtMixTime.text) > 0 )
    {
      txtMATQTY.text = total_material * Number(txtMixTime.text);
      txtBales.text = total_bales * Number(txtMixTime.text);
    }else
    {
      txtMATQTY.text = total_material ;
      txtBales.text = total_bales ;
    }
 }
</script>

<body>
     <!-----------------------------LOGISTIC CODE------------------------------------->
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
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_kbpr00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3" function="<%=l_user%>lg_sel_kbpr00020" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
					<input bind="txtSearchNo" />
					<input bind="txtItem" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />
					<input bind="lstLine1" />					
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_kbpr00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_kbpr00020_1"  procedure="<%=l_user%>lg_upd_kbpr00020_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtVoucherDate" />
					 <inout  bind="lblStatus" />				
					 <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="lstLine" />
                     <inout  bind="lstShift" />
                     <inout  bind="txtRemark" />  
                     <inout  bind="txtMixTime" />   
                     <inout  bind="lblMaterialRate" />  
                     <inout  bind="txtMATQTY" />                        
					 <inout  bind="txtBales" />   
					                                                                            
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00020_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_kbpr00020_2"   procedure="<%=l_user%>lg_upd_kbpr00020_2"> 
                <input bind="grdProd">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdProd" /> 
            </dso> 
        </xml> 
    </gw:data>
     <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00020_3_LINE" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="<%=l_user%>lg_sel_kbpr00020_3"   procedure="<%=l_user%>lg_upd_kbpr00020_3"> 
                <input bind="grdConsL">                    
                    <input bind="txtMasterPK" /> 
                    <input bind="txtLINE" /> 
                </input> 
                <output bind="grdConsL" /> 
            </dso> 
        </xml> 
    </gw:data>
     <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00020_3_SIDE" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="<%=l_user%>lg_sel_kbpr00020_3"   procedure="<%=l_user%>lg_upd_kbpr00020_3"> 
                <input bind="grdConsS">                    
                    <input bind="txtMasterPK" /> 
                    <input bind="txtSIDE" /> 
                </input> 
                <output bind="grdConsS" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00020_4" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8" function="<%=l_user%>lg_sel_kbpr00020_4"   procedure="<%=l_user%>lg_upd_kbpr00020_4"> 
                <input bind="grdWIP">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdWIP" /> 
            </dso> 
        </xml> 
    </gw:data>
      <!--------------------------process- wip------------------------------------->
    <gw:data id="pro_kbpr00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbpr00020" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------Out REQ-------------------------------->
    <gw:data id="pro_kbpr00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbpr00020_1_kb" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
     <!-------------------------------LOAD Product------------------------------------->
    <gw:data id="pro_kbpr00020_prod" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbpr00020_product" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 85%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 5%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Ins. No
                        </td>
                        <td style="width: 85%" colspan="1">
                            <gw:textbox id="txtSearchNo" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Line
                        </td>
                        <td style="width: 85%" colspan="1">
                            <gw:list id="lstLine1" styles="width: 100%" onchange="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Item
                        </td>
                        <td style="width: 85%" colspan="1">
                            <gw:textbox id="txtItem" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td style="width: 5%">
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Status|Slip|Ins. Date|Line" format="0|0|0|4|0"
                                aligns="0|1|0|1|1" defaults="||||" editcol="0|0|0|0|0" widths="0|1000|1200|1200|1500"
                                styles="width:100%; height:100%" sorting="T" param="0,1,2,3" oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 5%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td style="width: 5%">
                            Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtVoucherDate" lang="1" onchange="OnChangeDate()" />
                        </td>                       
                        <td style="width: 50%" align="center" colspan=3>
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>
                       
                        <td style="width: 1%" align="right">
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Submit')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                        </td>
                    </tr>
                     <tr style="height: 5%">
                        <td align="right" style="width: 10%">
                            <a onclick="OnPopUp('Shift')" href="#tips" style="color: #0000ff">Shift</a>
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:list id="lstShift" styles="width: 100%"  />
                        </td>
                        <td style="width: 10%" align="right">
                             <a title="Charger" onclick="OnPopUp('Line')" href="#tips" style="color:#0000ff"> Line </a>
                        </td>
                        <td colspan="8">
                             <gw:list id="lstLine" styles="width: 100%" onchange="OnSearch('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 10%" align="right">
                           <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color:#0000ff"><b>
                                Charger</b></a>
                        </td>
                        <td style="width: 35%" colspan="3">
                           <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                        <td align="right" style="width: 10%">
                            Remark
                        </td>
                        <td colspan="8" >
                             <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                   
                    <tr style="height: 5%">
                        <td style="width: 10%" align="right">
                            Sum Mat.
                        </td>
                        <td   style="width: 20%">
                           <gw:textbox id="txtMATQTY" styles="width:100%;" type="number" format="###,###.###"  readonly="true"/>
                        </td>
                        <td align="right" style="width: 5%">
                            Bales
                        </td>
                        <td  style="width:10%">
                             <gw:textbox id="txtBales" styles="width:100%;"  type="number" format="###,###.###" readonly="true" />
                        </td>
                        <td style="width: 10%">Time</td>
                        <td  style="width:30%" >
                             <gw:textbox id="txtMixTime" styles="width:100%;"  type="number" format="###,###" onenterkey="SumConsumption()" />
                        </td>
                        <td colspan="6">
                            <gw:label id="lblMaterialRate" styles='width:100%;color:cc0000;font:9pt;align:left' text='' />
                        </td>
                    </tr>   
                     <tr style="height: 45%" id="id_midle">
                           <td colspan="4">
                            <table style="width: 100%; height: 100%">
                                <tr  style="height: 10%">
                                    <td style="width: 1%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggleLR()" />
                                    </td>
                                    <td style="width: 45%">
                                        LINE
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnStock1" img="2" text="Stock" styles='width:100%' onclick="OnAddNew('STOCK_LINE')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteM1" img="delete" alt="Delete" text="Delete" onclick="OnDelete('ConsL')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDeleteM1" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete('ConsL')" />
                                    </td>
                                </tr>
                                <tr  style="height: 90%">
                                     <td colspan="14">
                                        <gw:grid id='grdConsL' header='_PK|_WI_WORKINS_M_PK|_Line/SIDE|Seq|_Item_pk|Mat. Code|_Mat Name|_UOM|Lot No|Bale|Kg/BL|Qty Kg|_Ratio|_warehouse_pk|Remark'
                                            format= '0|0|0|0|0|0|0|0|0|0|1|1|1|1|0' aligns='0|0|0|1|0|0|0|1|3|1|0|0|0|0|0' check='||||||||||||||'
                                            editcol='0|0|0|0|1|0|0|0|0|1|1|1|1|0|1' widths='0|0|1200|800|0|1500|2000|800|1000|1200|1200|01200|1200|0|1200'
                                            sorting='T' styles='width:100%; height:100%' 
                                            autosize ='Y'
                                            onafteredit="CheckInput('LINE')" acceptnulldate='T' />
                                        
                                    </td>
                                </tr>
                            </table>
                            
                        </td>
                        <td  colspan="8">
                            <table style="width: 100%; height: 100%">
                                <tr  style="height: 10%">
                                   <td style="width: 45%">
                                        SIDE
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnStock2" img="2" text="Stock" styles='width:100%' onclick="OnAddNew('STOCK_SIDE')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteM2" img="delete" alt="Delete" text="Delete" onclick="OnDelete('ConsS')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDeleteM2" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete('ConsS')" />
                                    </td>
                                </tr>
                                <tr  style="height: 90%">
                                    <td colspan ="4">
                                       <gw:grid id='grdConsS' header='_PK|_WI_WORKINS_M_PK|_Line/SIDE|Seq|_Item_pk|Mat. Code|_Mat Name|_UOM|Lot No|Bale|Kg/BL|Qty Kg|_Ratio|_warehouse_pk|Remark'
                                            format= '0|0|0|0|0|0|0|0|0|0|1|1|1|1|0' aligns='0|0|0|1|0|0|0|1|3|1|0|0|0|0|0' check='||||||||||||||'
                                            editcol='0|0|0|0|1|0|0|0|0|1|1|1|1|0|1' widths='0|0|1200|800|0|1500|2000|800|1000|1200|1200|01200|1200|0|1200'
                                            sorting='T' styles='width:100%; height:100%' 
                                            autosize ='Y'
                                            onafteredit="CheckInput('SIDE')" acceptnulldate='T' />
                                        />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr> 
                    <tr style="height: 1%; ">
                        <td >
                             <img status="collapse" id="img2" src="../../../system/images/down.gif"
                                            style="cursor: hand" onclick="OnToggleUD()" />
                        </td>
                        <td  align="left" style=" color:Gray">Product & WIP</td>
                         <td align="left" style="width: 1%" >
                            <gw:icon id="idBtnProd" img="2" text=" Load Prod WI" styles='width:100%' onclick="OnProcess('PROD')" />
                        </td>
                        <td style="width: 90%" colspan="7"> </td>
                    </tr>                              
                    <tr style="height: 34%" id="id_bottom">
                        <td colspan="5">
                            <table style="width: 100%; height: 100%">
                                <tr  style="height: 10%">
                                    
                                    <td style="width: 50%">
                                        <gw:label id="lblProd" styles='width:100%;color:cc0000;font:9pt;align:left' text='' />
                                    </td>
                                     <td style="width: 1%">
                                        <gw:imgbtn id="btnSearchP" img="search" alt="Search" text="Search" onclick="OnSearch('grdProd')" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:imgbtn id="btnGetProd" img="new" alt="Get Product" text="Popup"  onclick="OnAddNew('FreeItem')" />
                                    </td>
                                     <td style="width: 1%">
                                        <gw:imgbtn id="btnSaveD" img="save" alt="Save" text="Save" onclick="OnSave('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnProcess" img="process" alt="Generate WIP WI" text="Delete" onclick="OnProcess('WIP')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete('Detail')" />
                                    </td>
                                </tr>
                                <tr  style="height: 90%">
                                     <td colspan="14">
                                        <gw:grid id='grdProd' header='_PK|_WI_WORKINS_M_PK|Seq|_Item_pk|Item Code|_Item Name|_UOM|LOT NO|Ins Qty|Remark'
                                            format= '0|0|0|0|0|0|0|0|1|0' aligns='0|0|0|1|0|0|0|0|0|1|' check='|||||||||'
                                            editcol='0|0|1|0|1|0|0|1|1|1' widths='0|0|800|0|1000|1500|800|1500|1500|2000'
                                            sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput('PROD')" acceptnulldate='T' 
                                            />
                                        
                                    </td>
                                </tr>
                            </table>
                            
                        </td>
                        <td  colspan="6">
                            <table style="width: 100%; height: 100%">
                                <tr  style="height: 10%">
                                    <td style="width: 50%" colspan="3">
                                    </td>
                                   
                                     <td align="right" style="width: 50%">
                                        <gw:label id="lblTotalWIP" styles='width:100%;color:cc0000;font:9pt;align:left' text='Total:' />
                                    </td>                                   
                                   
                                </tr>
                                <tr  style="height: 90%">
                                    <td colspan ="4">
                                        <gw:grid id='grdWIP' header='_PK|_WI_WORKINS_M_PK|_WI_WORKINS_D_PK|_Item_pk|Item Code|_Item Name|_UOM|Ins Qty|Remark'
                                        format= '0|0|0|0|0|0|0|1|0' aligns='0|0|0|0|0|0|0|0|0' check='||||||||'
                                        editcol='0|0|1|0|1|0|0|1|1' widths='0|0|800|0|1500|2000|800|1500|1500'
                                        sorting='T' styles='width:100%; height:100%'  acceptnulldate='T' 
                                        />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtWI_D_PK" styles="display:none;" />
<gw:textbox id="txtLINE" styles="display:none;" text="LINE"/>
<gw:textbox id="txtSIDE" styles="display:none;" text="SIDE" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />

<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<!---------------------------------------------------------------------------------->
</html>
