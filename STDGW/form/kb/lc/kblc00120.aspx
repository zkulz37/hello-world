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
var G_PK                = 0,
    G_ISSUE_BANK        = 1,
    G_LC_NO             = 2,
    G_AMOUT             = 3,
    G_CCY               = 4;

var G1_PK               = 0,
    G1_SLIP_NO          = 1,
    G1_LC_NO            = 2,
    G1_ISSUE_DATE       = 3,
    G1_ISSUE_BANK       = 4,
    G1_REF_NO           = 5,
    G1_START_DATE       = 6,
    G1_CUSTOMER_PK      = 7,
    G1_LC_CHECK         = 8,
    G1_END_DATE         = 9,
    G1_AMOUT            = 10,
    G1_PRICE_TERM       = 11,
    G1_CCY              = 12; 
    
var G2_PK                   = 0,
    G2_TLG_KB_SUB_LC_M_PK   = 1,
    G2_ITEM_CODE            = 2,
    G2_ITEM_NAME            = 3,
    G2_UNIT_PRICE           = 4,
    G2_QUANTITY             = 5,
    G2_UNIT                 = 6,
    G2_AMOUNT               = 7,
    G2_CCY                  = 8,      
    G2_TLG_IT_ITEM_PK       = 9,
    G2_TLG_PO_PO_D_PK       = 10;
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
    OnChangeCCY();
}
 //==================================================================================
 
 function BindingDataList()
 {                
	 var data1= ""; 
	 var data2= "";    
	 var data3= ""; 
	 var data4= ""; 
	    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0010' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstBank.SetDataText(data1);
    lstBank.value = '10' ;
    
    data2 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0120' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstLCCheck.SetDataText(data2);
    lstLCCheck.value = '' ;
    
    data3 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0130' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstPriceTerms.SetDataText(data3);
    lstPriceTerms.value = '' ;
    	
     data4 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstCCY.SetDataText(data4);
    lstCCY.value = '' ;
    
    
    		 
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
            case 'BANK':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0010";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'IEBS0010';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstBank.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'LCCHECK':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0120";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0120';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstLCCheck.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'PRICE_TERMS':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0130";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGCM0130';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstPriceTerms.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'CURRENCY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0100";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGCM0100';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstCCY.value = object[1];      
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
                	           
                //data_dsbs00200_4.Call("SELECT");
	         }               
            break;
            
            case 'PONO':
                  var path = System.RootURL + "/form/kb/lc/kblc00121.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {  
	           
	            for(var i =0; i< object.length; i++)
	            { 
	                txtCustomerPK.text   = object[0][0];
                    txtCustomerCode.text = object[0][1];
                    txtCustomerName.text = object[0][2];               
                    txtPONoPK.text = object[0][3];
                    txtPONo.text = object[0][4];
                        
                    grdDetail.AddRow();  
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_KB_SUB_LC_M_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_IT_ITEM_PK , object[i][9]);//item_pk	    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE, object[i][10]);//item_code	    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME, object[i][11]);//item_name	    			
                    grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT_PRICE, object[i][14]);//unit price
                    grdDetail.SetGridText( grdDetail.rows-1, G2_QUANTITY,object[i][13]);//quanity
                    grdDetail.SetGridText( grdDetail.rows-1, G2_AMOUNT,object[i][15]);//amount   
                    grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT ,object[i][12]);//uint    
					grdDetail.SetGridText( grdDetail.rows-1, G2_CCY ,object[i][19]);//ccy 					
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_PO_PO_D_PK ,object[i][7]);//ccy
					  	           
                }
                TotalAmount();
	         }               
            break;
       }
 }
 //======================================================================
function InputProcess( col, row )
{
    var dAmount = 0; var dTotalAmount = 0 ;var dAmount = 0 ;    
    
    if ( col == G2_UNIT_PRICE || col == G2_QUANTITY  || col == G2_AMOUNT)
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
  
    if ( col == G2_UNIT_PRICE || col == G2_QUANTITY  )
    {                 
        dAmount = Number(grdDetail.GetGridData( row, G2_QUANTITY )) * Number(grdDetail.GetGridData( row,G2_UNIT_PRICE)) ;                            			               
        grdDetail.SetGridText( row, G2_AMOUNT, System.Round( dAmount, G2_AMOUNT )) ;
		
    }
   
    //--------------   
    TotalAmount();
     	
}
//====================================================

function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var sumTotalAmount = 0 ;

    for (var i=1; i<grdDetail.rows; i++ )
    {
     
        sumTotalAmount = sumTotalAmount + Number(grdDetail.GetGridData( i, G2_AMOUNT));
    }
  
    txtAmout.text = System.Round( sumTotalAmount,2);
} 

 //=========================================================================
function CheckInput()
{       
    InputProcess(  event.col, event.row  );
}
//==========================================================================
function OnChangeCCY()
{
    for (var i=1; i<grdDetail.rows; i++ )
    {
        grdDetail.SetGridText(i,G2_CCY,listCCY.value );
     }
}
//==========================================================================
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G2_ITEM_CODE || event_col == G2_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=|Y|||Y|Y';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G2_TLG_IT_ITEM_PK,   object[0] );
                            grdDetail.SetGridText( event_row, G2_ITEM_CODE, object[1] );
                            grdDetail.SetGridText( event_row, G2_ITEM_NAME , object[2] );
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
            data_kblc00120_search.Call("SELECT");
        break;
    
        case 'grdMaster':
            if ( data_kblc00120_master.GetStatus() == 20 && grdDetail.rows > 1 )
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
                    data_kblc00120_master.Call("SELECT");
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
                data_kblc00120_master.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_kblc00120_detail.Call("SELECT");
        break;
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      
      case "data_kblc00120_master": 
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G2_TLG_KB_SUB_LC_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i,G2_TLG_KB_SUB_LC_M_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }

        break;

        case "data_kblc00120_detail":
            if ( grdDetail.rows > 1 )
            {
                lblRecord.text = grdDetail.rows - 1 + ' row(s)';
                grdDetail.SetCellBold( 1, G2_ITEM_NAME, grdDetail.rows - 1, G2_ITEM_NAME,  true);
	            //grdDetail.SetCellBold( 1, G2_QUANTITY, grdDetail.rows - 1, G2_QUANTITY,  true);
	             grdDetail.SetCellBold( 1, G2_AMOUNT,grdDetail.rows - 1, G2_AMOUNT,   true);   
                //grdDetail.SetCellBgColor( 1, G2_AMOUNT, grdDetail.rows - 1, G2_AMOUNT, 0x99FFFF );           
            }
             else
	        lblRecord.text =  '0 row(s)';          
        break;
        
    }
}
//====================================================================================

function Validate()
{ 
    if(txtLCNo.text =="")
    {
        alert("Please, input L/C No!");
        return false;
    }  
    else if(txtCustomerPK.text =="")
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
                data_kblc00120_master.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_kblc00120_detail.Call();
        break;
    }

}
function OnAddNew(pos)
{
     switch (pos)
    {
       case 'Master':              
                data_kblc00120_master.StatusInsert();
                
                txtSlipNo.text   = '***New Voucher***';
                //-------------------------------------------         
                grdDetail.ClearData();
                flag = "view";        
      break; 
      case 'FreeItem' :
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=|Y|||Y|Y';
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                                                        
                            grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_KB_SUB_LC_M_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_IT_ITEM_PK , arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME, arrTemp[2]);//item_name	    			
                            grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT_PRICE,arrTemp[7]);//unit price   
							grdDetail.SetGridText( grdDetail.rows-1, G2_CCY ,lstCCY.value);//ccy 					
							grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT ,arrTemp[5]);//uint                    
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
                    data_kblc00120_master.StatusDelete();
                    data_kblc00120_master.Call();
                } 
            }  
        break;

        case 'Detail':
            if ( grdDetail.row > 0 )
            {
                if(confirm('Do you want to delete this Item?'))
                {
                    if ( grdDetail.GetGridData( grdDetail.row, G2_PK) == '' )
                    {
                        grdDetail.RemoveRow();
                         TotalAmount();
                    }
                    else
                    {   
                        grdDetail.DeleteRow();
                        var AmtAfterDelRow =0;
                        AmtAfterDelRow = Number(txtAmout.text)- Number(grdDetail.GetGridData(grdDetail.row, G2_AMOUNT));
                        txtAmout.text = System.Round( AmtAfterDelRow,2);
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
            var AmtAfterDelRow =0;
            AmtAfterUnDelRow = Number(txtAmout.text)+ Number(grdDetail.GetGridData(grdDetail.row, G2_AMOUNT));
            txtAmout.text = System.Round( AmtAfterUnDelRow,2);
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
    <gw:data id="data_kblc00120_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1"	function="<%=l_user%>lg_sel_kblc00120"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>								
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00120_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,10,11,12,13,14"	function="<%=l_user%>lg_sel_kblc00120_1"	procedure="<%=l_user%>lg_upd_kblc00120_1">	
				<inout>	
					<inout	bind="txtMasterPK"	/>
					<inout	bind="txtSlipNo"	/>
					<inout	bind="txtLCNo"	/>
					<inout	bind="dtIssuing"	/>
					
					<inout	bind="lstBank"	/>		
					<inout	bind="txtPONo"	/>					
					<inout	bind="dtStarDT"	/>
					
					<inout	bind="txtCustomerPK"	/>
					<inout	bind="txtCustomerCode"	/>
					<inout	bind="txtCustomerName"	/>			
					<inout	bind="lstLCCheck"	/>
					<inout	bind="dtEndDT"	/>
					
					<inout	bind="txtAmout"	/>
					<inout	bind="lstPriceTerms"	/>
					<inout	bind="lstCCY"	/>
												
				</inout>
			</dso>	
		</xml>	
	</gw:data>
	  <!--============================================= Detail =====================================-->
    <gw:data id="data_kblc00120_detail" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,4,5,6,7,8,9,10" function="<%=l_user%>lg_sel_kblc00120_2" procedure="<%=l_user%>lg_upd_kblc00120_2">
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
            <td id="left" style="width: 25%">
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
                    
                    
                    <tr style="height: 97%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Issue Bank|L/C No|Amount|CCY'
                                format='1|0|0|1|0'
                                aligns='0|1|1|0|1'
                                check='||||'
                                editcol='0|0|0|0|0'
                                widths='0|1500|1200|1200|1000'
                                sorting='T'
                                styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />                            
                                
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                 <tr style="height: 1%">
						<td align="right" style="width: 10%; white-space: nowrap"></td>
                        <td style="width: 30%"></td>
                        <td align="right" style="width: 10%; white-space: nowrap"></td>
						<td style="width: 25%"> </td>
						<td align="right" style="width: 10%; white-space: nowrap"></td>
                        <td style="width: 17%" align="right"></td>                 
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
						<td align="right" style="width: 5%; white-space: nowrap">
                           Slip No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtSlipNo" styles="width:100%;"/>
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            L/C No
                        </td>
						 <td style="width: 25%">
                            <gw:textbox id="txtLCNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Issuing DT
                        </td>                         
                        <td colspan="4" style="width: 20%" align="left">
                            <gw:datebox id="dtIssuing" lang="1" width="15%" />
                        </td>
                      
                    </tr>
                    <tr style="height: 1%">
                       <td align="right" style="width: 10%; white-space: nowrap"><a onclick="OnPopUp('BANK')" href="#tips" style="color: #0000ff">
                            Issuing bank</a>
                        </td>
                        <td style="width: 30%;">
                            <gw:list id="lstBank" styles="width:100%;" />
                        </td>
                       
                        <td align="right" style="width: 10%"><a onclick="OnPopUp('PONO')" href="#tips" style="color: #0000ff">
                            PO No
                        </td>
                         <td style="width: 25%">
                             <gw:textbox id="txtPONoPK" text="" style="display: none" />  
                             <gw:textbox id="txtPONo" csstype="mandatory" styles="width:100%;" readonly="true" />                     
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            S/D
                        </td>                         
                        <td colspan="4" style="width: 20%" align="left">
                            <gw:datebox id="dtStarDT" lang="1" width="15%" />                   
                        </td>
                        
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 15%; white-space: nowrap">
                         <a title="Customer" onclick="OnPopUp('CUSTOMER')" href="#tips" style="color: #0000ff">
                            Customer</a>
                        </td>
                       <td style="width: 40%;">
                            <gw:textbox id="txtCustomerPK" styles="display:none" />
                            <gw:textbox id="txtCustomerCode" csstype="mandatory" styles="width:30%" />
                            <gw:textbox id="txtCustomerName" csstype="mandatory" styles="width:70%" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            <a onclick="OnPopUp('LCCHECK')" href="#tips" style="color: #0000ff">
                                L/C Check</a>
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstLCCheck" styles="width:100%;" />                        
                        </td>
                        <td align="right" style="width:10%; white-space: nowrap">
                            E/D
                        </td>                         
                        <td colspan="4" style="width: 20%" align="left">
                            <gw:datebox id="dtEndDT" lang="1" width="15%" />
                        </td>
                       
                    </tr>
                     <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">               
                           Amount
                        </td>
                       <td style="width: 30%;">
                          <gw:textbox id="txtAmout" styles="width:100%;color: red" type="number" format="###,###,###,###.#R"/>
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            <a onclick="OnPopUp('CURRENCY')" href="#tips" style="color: #0000ff">
                            Currency</a>
                                
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstCCY" styles="width:100%;" onchange="OnChangeCCY()"/>      
                                                    
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap"><a onclick="OnPopUp('PRICE_TERMS')" href="#tips" style="color: #0000ff">
                            Price terms</a>
                        </td>                         
                        <td colspan="4" style="width: 20%" align="left">
                              <gw:list id="lstPriceTerms" styles="width:75%;" />                
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
                                    <td style="width: 64%" align="right">
                                    </td>
                                    <td style="width: 19%; white-space: nowrap" align="center">
                                      <gw:label id="lblRecord" styles="color: red">row(s)</gw:label>
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td style="width: 1%" align="right">                                  
                                        <gw:imgbtn img="new" alt="New" id="btnNew1" style="display: none" onclick="OnAddNew('FreeItem')" />
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
                                header='_PK|_TLG_KB_SUB_LC_M_PK|Item Code|Item Name|Unit Price|Quantity|Unit|Amout|CCY|_TLG_IT_ITEM_PK|_TLG_PO_PO_D_PK'
                                format='1|1|0|0|1|1|0|1|0|1|0'
                                aligns='0|0|1|1|0|0|1|0|1|0|0'
                                check='||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1'
                                widths='0|1000|1500|3000|1500|1500|1500|1500|1000|1000|0'
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
