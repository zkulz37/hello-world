<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>L/C INPUT</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;
  
var G_PK                        = 0,
    G_TLG_KB_SALE_DELI_M_PK     = 1,
    G_TLG_IT_ITEM_PK            = 2,
    G_ITEM_GROUP                = 3,
    G_PO_NO                     = 4, 
    G_ITEM_CODE                 = 5,
    G_ITEM_NAME                 = 6,
    G_UNIT                      = 7,
    G_QUANTITY                  = 8,
    G_UNIT_PRICE                = 9,
    G_AMOUNT                    = 10,
    G_LOT_NO                    = 11,
    G_TLG_KB_EXP_SALE_ODER_PK   = 12;     
   
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtCustomerCode.SetEnable(false);
    txtCustomerName.SetEnable(false);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;    
   //---------------------------- 
    BindingDataList(); 
    OnAddNew('Master');
   
}
 //==================================================================================
 
 function BindingDataList()
 {                
	 var data1= ""; 
	 var data2= "";    
	 var data3= ""; 
	 
	    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0220' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstGroup.SetDataText(data1);
    lstGroup.value = '' ;
    
    data2 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0250' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstVariety.SetDataText(data2);
    lstVariety.value = '' ;
    
    data3 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0280' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstDeliType.SetDataText(data3);
    lstDeliType.value = '' ;

    		 
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
            case 'GROUP':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0220";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0220';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstGroup.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'VARIETY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0250";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0250';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstVariety.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'DELI_TYPE':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0280";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0280';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstDeliType.value = object[1];      
	                }    	                
	             }                              
            break;
                       
          
            case 'CUSTOMER':
                  var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {
	                txtCustomerPK.text   = object[0];
                    txtCustomerCode.text = object[1];
                    txtCustomerName.text = object[2];               
                    	           
                    data_dsbs00200_4.Call("SELECT");
	             }               
            break;
             case 'DELI_TO':
                  var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {
	                txtDeliToPK.text   = object[0];
                    txtDeliToCode.text = object[1];
                    txtDeliToName.text = object[2];               
                    	           
                    data_dsbs00200_4.Call("SELECT");
	             }               
            break;
       }
 }
 //======================================================================
function InputProcess( col, row )
{
    var dAmount = 0; var dTotalAmount = 0 ;var dAmount = 0 ;    
    
    if ( col == G_UNIT_PRICE || col == G_QUANTITY  || col == G_AMOUNT)
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData( row, col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {                    
                grdDetail.SetGridText( row, col, System.Round( grdDetail.GetGridData(row, col),col) );                 
            }    
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }                
    }
    //---- CALCULATE AMOUNT -----
     if ( chkAutoCal.value == 'Y' )
    {      
        if ( col == G_UNIT_PRICE || col == G_QUANTITY  )
        {                 
            dAmount = Number(grdDetail.GetGridData( row, G_QUANTITY )) * Number(grdDetail.GetGridData( row,G_UNIT_PRICE)) ;                            			               
            grdDetail.SetGridText( row, G_AMOUNT, System.Round( dAmount, G_AMOUNT )) ;
    		
        }
       
        //--------------   
        TotalAmount();
    }
    //------------------------------
   GetPoNoAndItemName();
}
//====================================================

function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var sumTotalAmount = 0 ;
    var sumReqQty = 0;

    for (var i=1; i<grdDetail.rows; i++ )
    {
     
        sumTotalAmount = sumTotalAmount + Number(grdDetail.GetGridData( i, G_AMOUNT));
        sumReqQty = sumReqQty + Number(grdDetail.GetGridData( i, G_QUANTITY));
    }
  
    txtSumAmt.text = System.Round( sumTotalAmount,2);
    txtQty.text = System.Round( sumReqQty,2);
} 
//====================================================

function GetPoNoAndItemName()
{ 
   
//  if ( grdDetail.rows > 0 )
//  { 
        var strPoNo ="";strProdItem="";  
        var comma = "" ;
        for(var i=1; i <= grdDetail.rows -1;i++)
        {
            strPoNo += comma + grdDetail.GetGridData( i,G_PO_NO) ;
            strProdItem += comma + grdDetail.GetGridData(i,G_ITEM_NAME)  ;
            comma = ",";         
        }
        
        txtPONo.text = strPoNo;
        txtProdItem.text= strProdItem;
        
        if(grdDetail.rows > 1)
        {
            lstGroup.value = grdDetail.GetGridData( 1,G_ITEM_GROUP);  
        }
        else 
            lstGroup.value = "";
            
     //}
    
} 
 //=========================================================================
function CheckInput()
{       
    InputProcess(  event.col, event.row  );
}

//==========================================================================
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G_ITEM_CODE || event_col == G_ITEM_NAME )
                 {
                        var path = System.RootURL + '/form/kb/sa/kbsa00021.aspx?customer_pk='+ txtCustomerPK.text;
                        var object = System.OpenModal( path ,800 , 600 ,'resizable:yes;status:yes');
                     
                     if ( object != null )
                     {                                                                                              
                             grdDetail.SetGridText( grdDetail.rows-1, G_TLG_KB_SALE_DELI_M_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G_TLG_IT_ITEM_PK , object[7]);//item_pk
                            grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_GROUP, object[1]);//item_group
                            grdDetail.SetGridText( grdDetail.rows-1, G_PO_NO, object[2]);//po_no		    	    
                            grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE, object[4]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME, object[5]);//item_name	    			
                            grdDetail.SetGridText( grdDetail.rows-1, G_QUANTITY ,object[6]);//quantity 
				            grdDetail.SetGridText( grdDetail.rows-1, G_UNIT,object[8]);//unit       
                     }                             
                 }
            break;             
      }         
}   
//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_kbsa00020_search.Call("SELECT");
        break;
    
        case 'grdMaster':
            if ( data_kbsa00020_master.GetStatus() == 20 && grdDetail.rows > 1 )
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
                    data_kbsa00020_master.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                }
                else
                {
                    txtMasterPK.text = '' ;
                }
                
                flag = 'view' ;
                data_kbsa00020_master.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_kbsa00020_detail.Call("SELECT");
        break;
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      
      case "data_kbsa00020_master": 
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G_TLG_KB_SALE_DELI_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i,G_TLG_KB_SALE_DELI_M_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }

        break;

        case "data_kbsa00020_detail":
            if ( grdDetail.rows > 0 )
            {
                lblRecord.text = grdDetail.rows - 1 + ' row(s)';
                grdDetail.SetCellBold( 1, G_ITEM_NAME, grdDetail.rows - 1, G_ITEM_NAME,  true);
	            //grdDetail.SetCellBold( 1, G_QUANTITY, grdDetail.rows - 1, G_QUANTITY,  true);
	             grdDetail.SetCellBold( 1, G_AMOUNT,grdDetail.rows - 1, G_AMOUNT,   true);   
                //grdDetail.SetCellBgColor( 1, G_AMOUNT, grdDetail.rows - 1, G_AMOUNT, 0x99FFFF ); 
                                  
            }
             else
	        lblRecord.text =  '0 row(s)';          
        break;
        
    }
}
//====================================================================================

function Validate()
{ 
    
   if(txtCustomerPK.text =="")
    {
        alert("Please, select Customer!");
        return false;
    }
       
   return true;
}

//====================================================================================

function OnSave(pos)
{ 
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_kbsa00020_master.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':
                      
            data_kbsa00020_detail.Call();
            
            
        break;
    }

}
function OnAddNew(pos)
{
     switch (pos)
    {
       case 'Master':              
                data_kbsa00020_master.StatusInsert();
                
                txtSlipNo.text   = '***New Voucher***';
                //-------------------------------------------         
                grdDetail.ClearData();
                flag = "view";        
      break; 
       case 'SALEORDER':              
               var path = System.RootURL + '/form/kb/sa/kbsa00021.aspx?customer_pk='+ txtCustomerPK.text;
                var object = System.OpenModal( path ,800 , 600 ,'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp;
                                       
                    for( var i=0; i < object.length; i++)	  
                    {	
                        arrTemp = object[i];
                                
                        grdDetail.AddRow();                 
                                                    
                        grdDetail.SetGridText( grdDetail.rows-1, G_TLG_KB_SALE_DELI_M_PK, txtMasterPK.text); //master_pk	    	                                                                      
                        grdDetail.SetGridText( grdDetail.rows-1, G_TLG_KB_EXP_SALE_ODER_PK ,arrTemp[0]);//sale_oder_pk            
                        grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_GROUP, arrTemp[1]);//item_group
                        grdDetail.SetGridText( grdDetail.rows-1, G_PO_NO, arrTemp[2]);//po_no		    	    
                        grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE, arrTemp[4]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME, arrTemp[5]);//item_name	    			
                        grdDetail.SetGridText( grdDetail.rows-1, G_QUANTITY ,arrTemp[6]);//quantity 
                        grdDetail.SetGridText( grdDetail.rows-1, G_TLG_IT_ITEM_PK , arrTemp[7]);//item_pk         
					    grdDetail.SetGridText( grdDetail.rows-1, G_UNIT,arrTemp[8]);//unit                              
                        
                       
                  }		            
             }           
      break;
      
      case 'STOCK':
             var path = System.RootURL + '/form/fp/ab/fpab00290.aspx?group_type=|Y|||Y|Y';
             var object = System.OpenModal( path, 800, 600, 'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
     
                            grdDetail.SetGridText( grdDetail.rows-1, G_TLG_KB_SALE_DELI_M_PK, txtMasterPK.text); //master_pk	    	                                               
                                                         
                            grdDetail.SetGridText( grdDetail.rows-1, G_TLG_IT_ITEM_PK , arrTemp[1]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE, arrTemp[2]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME, arrTemp[3]);//item_name
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G_QUANTITY, arrTemp[7]);// quantity	    
                            grdDetail.SetGridText( grdDetail.rows-1, G_UNIT, arrTemp[4]);//  unit                                                                                                                                                                 
                    }		            
             }        
        break;		
    }
}
//====================================================================================
  function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if ( txtMasterPK.text != '' )
            {
                if(confirm('Do you want to delete this Voucher?'))
                {
                    flag='delete';
                    data_kbsa00020_master.StatusDelete();
                    data_kbsa00020_master.Call();
                } 
            }  
        break;

        case 'Detail':
            if ( grdDetail.row > 0 )
            {
                if(confirm('Do you want to delete this Item?'))
                { 
                    if ( grdDetail.GetGridData( grdDetail.row, G_PK) == '' )
                    {     
                        grdDetail.RemoveRow();
                        
                        GetPoNoAndItemName();
                       
                        TotalAmount();
                        
                        
                    }
                    else
                    {   
                        grdDetail.DeleteRow();
                        //Update Qty, SumAmount after delete row
                        var AmtAfterDel =0;QtyAfterDel=0;
                        AmtAfterDel = Number(txtSumAmt.text)- Number(grdDetail.GetGridData(grdDetail.row, G_AMOUNT));
                        
                        QtyAfterDel = Number(txtQty.text)- Number(grdDetail.GetGridData(grdDetail.row, G_QUANTITY));
                        
                        txtSumAmt.text = System.Round( AmtAfterDel,2);
                       
                        txtQty.text = System.Round( QtyAfterDel,2);
                       
                        //Update PoNo, ProdItem after delete row
                        var strPoNo ="";strProdItem="";  
                        var comma = "" ;

                        for(var i=1; i <= grdDetail.rows -1;i++)
                        {
                            if(i != grdDetail.row)
                            {
                                strPoNo += comma + grdDetail.GetGridData( i,G_PO_NO) ;
                                strProdItem += comma + grdDetail.GetGridData(i,G_ITEM_NAME)  ;
                            
                                comma = ",";
                            }
                        }
                        txtPONo.text = strPoNo;
                        txtProdItem.text= strProdItem; 
                          
                     }
                } 
             }         
        break;            

    }     
}
//======================================================================
 
function OnUnDelete()
{   
     if ( grdDetail.row > 0 )
     {      
          if(confirm('Do you want to Undelete this Item?'))
          {     
            grdDetail.UnDeleteRow();
            //Update Qty, SumAmount after undelete row
            var AmtAfterDel =0;QtyAfterDel=0;
            AmtAfterUnDel = Number(txtSumAmt.text)+ Number(grdDetail.GetGridData(grdDetail.row, G_AMOUNT));
            QtyAfterDel = Number(txtQty.text)+ Number(grdDetail.GetGridData(grdDetail.row, G_QUANTITY));
            
            txtSumAmt.text = System.Round( AmtAfterUnDel,2);
            txtQty.text = System.Round( QtyAfterDel,2);
            
            //Update PoNo, ProdItem after undelete row
            GetPoNoAndItemName();
          }
     }
}
//======================================================================

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
//====================================================================================
    
</script>

<body>
    
    <!--============================================= Search =====================================-->
    <gw:data id="data_kbsa00020_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3,4"	function="<%=l_user%>lg_sel_kbsa00020"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>
					<input	bind="txtSlipNoSearch"	/>
					<input	bind="txtCustomerSearch"	/>
					<input	bind="txtItemSearch"	/>								
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kbsa00020_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"	function="<%=l_user%>lg_sel_kbsa00020_1"	procedure="<%=l_user%>lg_upd_kbsa00020_1">	
				<inout>	
					<inout	bind="txtMasterPK"	/>
					<inout	bind="txtSlipNo"	/>
					<inout	bind="dtDeli"	/>
					<inout	bind="txtPONo"	/>
					
					<inout	bind="txtCustomerPK"	/>
					<inout	bind="txtCustomerCode"	/>
					<inout	bind="txtCustomerName"	/>
					
					<inout	bind="txtDeliToPK"	/>
					<inout	bind="txtDeliToCode"	/>
					<inout	bind="txtDeliToName"	/>
								
					<inout	bind="lstGroup"	/>
					<inout	bind="lstVariety"	/>		
					<inout	bind="lstDeliType"	/>
					
					<inout	bind="txtProdItem"	/>
					<inout	bind="txtRefNo"	/>
					<inout	bind="txtQty"	/>
					<inout	bind="txtCharge"	/>
					<inout	bind="txtSumAmt"	/>
					<inout	bind="txtRemark"	/>
												
				</inout>
			</dso>	
		</xml>	
	</gw:data>
	  <!--============================================= Detail =====================================-->
    <gw:data id="data_kbsa00020_detail" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="<%=l_user%>lg_sel_kbsa00020_2" procedure="<%=l_user%>lg_upd_kbsa00020_2">
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!---------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:datebox id="dtFromSearch" lang="1" />
                            ~
                            <gw:datebox id="dtToSearch" lang="1" />
                        </td>              
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Slip No
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:textbox id="txtSlipNoSearch"  />
                            
                        </td>              
                        <td style="width: 1%">
                            
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Customer
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:textbox id="txtCustomerSearch"  />
                            
                        </td>              
                        <td style="width: 1%">
                            
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Item
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:textbox id="txtItemSearch"  />
                            
                        </td>              
                        <td style="width: 1%">
                            
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Status|PO No|Deli Date|Customer'
                                    format='0|0|0|4|0'
                                    aligns='0|1|1|1|0'
                                    check='||||'
                                    editcol='0|0|0|0|0'
                                    widths='0|1000|1200|1300|1500'
                                    sorting='T'
                                styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />                            

                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                 <tr style="height: 1%">
						<td align="right" style="width: 5%; white-space: nowrap"></td>
                        <td style="width: 55%"></td>
                        <td align="right" style="width: 5%; white-space: nowrap"></td>
						<td style="width: 30%"> </td>
						<td align="right" style="width: 1%;" >
						    <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="" /> 
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
                        <td style="width: 1%">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPopUp('Report')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
						<td align="right" style="width: 5%; white-space: nowrap">
                           Slip No
                        </td>
                        <td style="width: 55%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" readonly="true"/>
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
						 <td style="width: 30%">
                            <gw:datebox id="dtDeli" lang="1" width="20%" />
                        </td>
                                               
                        <td colspan="5" style="width: 5%" align="left">
                            </td>
                    </tr>
                    <tr style="height: 1%">
                       <td align="right" style="width: 5%; white-space: nowrap">
                            PO No
                        </td>
                        <td style="width: 55%;">
                                      
                            <gw:textbox id="txtPONo" styles="width:100%;" />
                        </td>
                       
                        <td align="right" style="width: 5%"><a onclick="OnPopUp('GROUP')" href="#tips" style="color: #0000ff">
                            Group
                        </td>
                         <td colspan="6" style="width:35%">
                            <gw:list id="lstGroup" styles="width:30%;" />
                        </td>
                                                    
                    </tr>
                    
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                         <a title="Customer" onclick="OnPopUp('CUSTOMER')" href="#tips" style="color: #0000ff">
                            Customer</a>
                        </td>
                       <td style="width: 55%;">
                            <gw:textbox id="txtCustomerPK" styles="display:none" />
                            <gw:textbox id="txtCustomerCode" csstype="mandatory" styles="width:30%" />
                            <gw:textbox id="txtCustomerName" csstype="mandatory" styles="width:70%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a onclick="OnPopUp('VARIETY')" href="#tips" style="color: #0000ff">
                                Variety</a>
                        </td>
                        <td colspan="6" style="width:35%">
                            <gw:list id="lstVariety" styles="width:30%;" />
                        </td>
                    </tr>
                      <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap"> <a title="DeliTo" onclick="OnPopUp('DELI_TO')" href="#tips" style="color: #0000ff">                  
                            Deli to
                        </td>
                       <td style="width:55%;">
                            <gw:textbox id="txtDeliToPK" styles="display:none" />
                            <gw:textbox id="txtDeliToCode" csstype="mandatory" styles="width:30%" />
                            <gw:textbox id="txtDeliToName" csstype="mandatory" styles="width:70%" />
                            
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a onclick="OnPopUp('DELI_TYPE')" href="#tips" style="color: #0000ff">
                                Deli Type</a>
                        </td>
                        <td colspan="6" style="width: 35%">
                            <gw:list id="lstDeliType" styles="width:30%;" />
                        </td>
                    </tr>
                    
                      <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">                  
                            Prod Item
                        </td>
                       <td style="width: 55%;">
                            <gw:textbox id="txtProdItem" styles="width: 100%;" />
                            
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">      
                                Ref No
                        </td>
                        <td colspan="6" style="width: 35%">
                            <gw:textbox id="txtRefNo" styles="width: 100%;" />
                        </td>
                    </tr>
                     <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap" >                  
                            Deli Req Qty
                        </td>
                       <td style="width: 55%;">
                            <gw:textbox id="txtQty" styles="width: 100%;" type="number" format="###,###,###,###.#R"/>
                            
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">      
                                Charger
                        </td>
                        <td colspan="6" style="width: 35%">
                            <gw:textbox id="txtCharge" styles="width: 100%;" />
                        </td>
                    </tr>
                      <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap;">                  
                            Sum Amount
                        </td>
                       <td style="width: 55%;">
                            <gw:textbox id="txtSumAmt" styles="width: 100%;color: red" type="number" format="###,###,###,###.#R" readonly="true" />
                            
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">      
                                Remark
                        </td>
                        <td colspan="6" style="width: 35%">
                            <gw:textbox id="txtRemark" styles="width: 100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="16">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 355%" align="right">
                                    </td>
                                    <td style="width: 20%; white-space: nowrap" align="center">
                                      <gw:label id="lblRecord" styles="color: red">row(s)</gw:label>
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 20%;white-space: nowrap">
                                        <gw:checkbox id="chkAutoCal" onchange="" defaultvalue="Y|N" value="Y" />
                                         Auto Cal    
                                    </td>
                                    <td align="right" style="width: 1%">
                                    <gw:icon id="idBtnReSULT" img="2" text="RESULT" styles='width:100%' onclick="OnAddNew('RESULT')" />  
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnSaleOrder" img="2" text="S/ORDER" styles='width:100%' onclick="OnAddNew('SALEORDER')" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnStock" img="2" text="STOCK" styles='width:100%' onclick="OnAddNew('STOCK')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                                    </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="16">
                            <gw:grid id='grdDetail'
                                header='_PK|_TLG_KB_SALE_DELIVERY_M_PK|_TLG_IT_ITEM_PK|Item Group|Po No|Item Code|Item Name|Unit|Qty|Unit Price|Amount|Lot No|_TLG_KB_EXP_SALE_ORDER_PK'
                                format='1|1|1|0|0|0|0|0|1|1|1|0|1'
                                
                                aligns='0|0|0|1|1|1|0|1|0|0|0|1|0'
                                check='||||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1|1'
                                widths='0|0|0|1200|1200|1500|2500|1000|1500|1500|1500|1500|0'
                                sorting='T' styles='width:100%; height:100%'onafteredit="CheckInput()" oncelldblclick="OnGridCellDoubleClick(this)"/>
                           

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>

<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
</html>
