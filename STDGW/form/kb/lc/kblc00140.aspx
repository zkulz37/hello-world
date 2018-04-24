<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>선적 사항 입력</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;
var G_PK                = 0,
    G_ISSUE_BANK        = 1,
    G_LC_NO             = 2,
    G_AMOUT             = 3,
    G_CCY               = 4;
    
var G2_PK                           = 0,
    G2_TLG_KB_SUB_SHIPMENT_M_PK     = 1,
    G2_TLG_IT_ITEM_PK               = 2,
    G2_ITEM_CODE                    = 3,
    G2_ITEM_NAME                    = 4,
    G2_UOM                          = 5,
    G2_UNIT_PRICE                   = 6,
    G2_CCY                          = 7,
    G2_LC_QTY                       = 8,      
    G2_SHIPMENT_QTY                 = 9,
    G2_DOC_AMT                     = 10,
    G2_SHIPMENT_AMT                 = 11,
    G2_TARE_WT                      = 12,
    G2_NET_WT                       = 13,
    G2_GROSS_WT                     = 14;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    
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
	
	    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0140' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstPortShip.SetDataText(data1);
    lstPortShip.value = '' ;
    
    data2 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0150' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstPortArr.SetDataText(data2);
    lstPortArr.value = '' ;
      
    		 
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
            case 'PORT_SHIP':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0140";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0140';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab0070_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstPortShip.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'PORT_ARR':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0150";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0150';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab0070_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstPortArr.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'LCNO':
                 var path = System.RootURL + "/form/kb/lc/kblc00141.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
          	                   
                 if ( object != null )
                 {	         
                    txtLCNoPK.text   = object[0];
                    txtLCNo.text   = object[2];
                                                        
                 }          
	       break;  
            
       }
 }
 //======================================================================
function InputProcess( col, row )
{
    var dDocAmount = 0; var dShipAmount = 0 ;var dGrossWt = 0 ;    
    
    if ( col == G2_SHIPMENT_QTY || col == G2_LC_QTY || col == G2_DOC_AMT|| col == G2_SHIPMENT_AMT|| col == G2_TARE_WT || col == G2_NET_WT|| col == G2_GROSS_WT)
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
  
    if ( col == G2_SHIPMENT_QTY || col == G2_LC_QTY  )
    {                 
        dDocAmount = Number(grdDetail.GetGridData( row, G2_LC_QTY )) * Number(grdDetail.GetGridData( row,G2_UNIT_PRICE)) ;                            			               
        grdDetail.SetGridText( row, G2_DOC_AMT, System.Round( dDocAmount, G2_DOC_AMT )) ;
        
        dShipAmount = Number(grdDetail.GetGridData( row,G2_SHIPMENT_QTY)) * Number(grdDetail.GetGridData( row,G2_UNIT_PRICE)) ;                            			               
        grdDetail.SetGridText( row, G2_SHIPMENT_AMT, System.Round( dShipAmount, G2_SHIPMENT_AMT )) ;
		
    }
   if ( col == G2_TARE_WT || col == G2_NET_WT || G2_GROSS_WT )
    {                 
        dGrossWt = Number(grdDetail.GetGridData( row, G2_TARE_WT )) + Number(grdDetail.GetGridData( row,G2_NET_WT)) ;                            			               
        grdDetail.SetGridText( row, G2_GROSS_WT, System.Round( dGrossWt, G2_GROSS_WT )) ;
		
    }
   
    
     	
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
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G2_ITEM_CODE || event_col == G2_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/kb/lc/kblc00142.aspx?lc_pk='+ txtLCNoPK.text;
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_IT_ITEM_PK , object[9]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE, object[2]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME, object[3]);//item_name	    			
                            grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT_PRICE,object[4]);//unit price 
							grdDetail.SetGridText( grdDetail.rows-1, G2_UOM ,object[6]);//unit					
							grdDetail.SetGridText( grdDetail.rows-1, G2_CCY,object[8]);//ccy   
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
            data_kblc00140_search.Call("SELECT");
        break;
    
        case 'grdMaster':
            if ( data_kblc00140_master.GetStatus() == 20 && grdDetail.rows > 1 )
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
                    data_kblc00140_master.Call("SELECT");
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
                data_kblc00140_master.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_kblc00140_detail.Call("SELECT");
        break;
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      
      case "data_kblc00140_master": 
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G2_TLG_KB_SUB_SHIPMENT_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i,G2_TLG_KB_SUB_SHIPMENT_M_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }

        break;

        case "data_kblc00140_detail":
            if ( grdDetail.rows > 1 )
            {
                lblRecord.text = grdDetail.rows - 1 + ' row(s)';
                grdDetail.SetCellBold( 1, G2_ITEM_NAME, grdDetail.rows - 1, G2_ITEM_NAME,  true);
                
	            grdDetail.SetCellBold( 1, G2_DOC_AMT, grdDetail.rows - 1, G2_DOC_AMT,  true);
	            grdDetail.SetCellBold( 1, G2_SHIPMENT_AMT, grdDetail.rows - 1, G2_SHIPMENT_AMT,  true);
	            grdDetail.SetCellBgColor( 1, G2_DOC_AMT,grdDetail.rows - 1, G2_DOC_AMT, 0x99FFFF);   
                grdDetail.SetCellBgColor( 1, G2_SHIPMENT_AMT, grdDetail.rows - 1, G2_SHIPMENT_AMT, 0x99FFFF ); 
                 
                grdDetail.SetCellBold( 1, G2_GROSS_WT, grdDetail.rows - 1, G2_GROSS_WT,  true);
	            grdDetail.SetCellBgColor( 1, G2_GROSS_WT,grdDetail.rows - 1, G2_GROSS_WT, 0x99FFFF);            
            }
             else
	        lblRecord.text =  '0 row(s)';          
        break;
        
    }
}
//====================================================================================

function Validate()
{       
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
                data_kblc00140_master.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_kblc00140_detail.Call();
        break;
    }

}
function OnAddNew(pos)
{
     switch (pos)
    {
       case 'Master':              
                data_kblc00140_master.StatusInsert();
                
                txtSlipNo.text   = '***New Voucher***';
                //txtBLSeq.text   = '***New Voucher***';
                //-------------------------------------------         
                grdDetail.ClearData();
                flag = "view";        
      break; 
      case 'LCItem':              
               var path = System.RootURL + '/form/kb/lc/kblc00142.aspx?lc_pk='+ txtLCNoPK.text;
                var object = System.OpenModal( path ,800 , 600 ,'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp                    
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                             grdDetail.AddRow();                 
                                                        
                             grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_KB_SUB_SHIPMENT_M_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_IT_ITEM_PK , arrTemp[9]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE, arrTemp[2]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME, arrTemp[3]);//item_name	    			
                            grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT_PRICE,arrTemp[4]);//unit price 
							grdDetail.SetGridText( grdDetail.rows-1, G2_UOM ,arrTemp[6]);//unit					
							grdDetail.SetGridText( grdDetail.rows-1, G2_CCY,arrTemp[8]);//ccy   

                           
                
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
                    data_kblc00140_master.StatusDelete();
                    data_kblc00140_master.Call();
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
    <gw:data id="data_kblc00140_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3,4"	function="<%=l_user%>lg_sel_kblc00140"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>
					<input	bind="txtFileNoSearch"	/>
					<input	bind="txtLCNoSearch"	/>
					<input	bind="txtBLNoSearch"	/>								
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00140_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,5,6,7,8,9,10"	function="<%=l_user%>lg_sel_kblc00140_1"	procedure="<%=l_user%>lg_upd_kblc00140_1">	
				<inout>	
					<inout	bind="txtMasterPK"	/>
					<inout	bind="txtBLNo"	/>			
					<inout	bind="txtSlipNo"	/>
					<inout	bind="txtLCNoPK"	/>
					<inout	bind="txtLCNo"	/>	
					<inout	bind="txtInvoNo"	/>
					<inout	bind="txtRefNo"	/>		
					<inout	bind="lstPortShip"	/>			
					<inout	bind="lstPortArr"	/>
					<inout	bind="dtShipment"	/>
					<inout	bind="dtArrival"	/>	
																						
				</inout>
			</dso>	
		</xml>	
	</gw:data>
	  <!--============================================= Detail =====================================-->
    <gw:data id="data_kblc00140_detail" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,6,7,8,9,10,11" function="<%=l_user%>lg_sel_kblc00140_2" procedure="<%=l_user%>lg_upd_kblc00140_2">
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
            <td id="t-left" style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 85%">
                            <gw:datebox id="dtFromSearch" lang="1" />
                            ~
                            <gw:datebox id="dtToSearch" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space: nowrap;width: 10%" align="right">
                           Slip No
                        </td>
                        <td style="white-space: nowrap; width: 85%">
                            <gw:textbox id="txtFileNoSearch"  styles="width:100%;"/>
                        </td>
                        <td style="width: 1%"></td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space: nowrap;width: 10%" align="right">
                           L/C No
                        </td>
                        <td style="white-space: nowrap; width: 85%">
                            <gw:textbox id="txtLCNoSearch"  styles="width:100%;"/>
                        </td>
                        <td style="width: 1%"></td>
                        
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space: nowrap;width: 10%" align="right">
                           B/L No
                        </td>
                        <td style="white-space: nowrap; width: 85%">
                            <gw:textbox id="txtBLNoSearch"  styles="width:100%;"/>
                        </td>
                        <td style="width: 1%"></td>               
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|_BL Seq|Slip No|BL No|L/C No|Ref No|Ship Date'
                                format='1|1|0|0|0|0|4'
                                aligns='0|0|1|1|1|1|1'
                                check='||||||'
                                editcol='0|0|0|0|0|0|0'
                                widths='0|1200|1300|1300|1300|1300|1300'
                                sorting='T'
                                styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />                                                  
                             
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                 <tr style="height: 1%">			
                        <td align="right" style="width: 5%; white-space: nowrap"></td>
                        <td style="width: 30%"></td>
                        <td align="right" style="width: 5%; white-space: nowrap"></td>
						<td style="width: 30%"> </td>
						<td align="right" style="width: 5%; white-space: nowrap"></td>
                        <td style="width: 22%" align="right"></td>                 
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
                         B/L No
                        </td>
                        <td style="width: 30%">
                             <gw:textbox id="txtBLNo" styles="width:100%;"/>
                        </td>
						<td align="right" style="width: 5%; white-space: nowrap">
                           Slip No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtSlipNo" styles="width:100%;"/>
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap"><a onclick="OnPopUp('LCNO')" href="#tips" style="color: #0000ff">                    
                            L/C No</a>
                        </td>
						 <td colspan="4" style="width: 25%" align="left">
						    <gw:textbox id="txtLCNoPK" csstype="mandatory" styles="width:100%;display:none"/>
                            <gw:textbox id="txtLCNo" csstype="mandatory" styles="width:100%;" readonly="true" />
                        </td>          
                    </tr>
                    <tr style="height: 1%">
                       <td align="right" style="width: 5%; white-space: nowrap">
                           Invo No
                        </td>
                         <td style="width: 30%">
                            <gw:textbox id="txtInvoNo" styles="width:100%;"/>
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                              Ref No  
                        </td>
                        <td style="width: 30%">
                           <gw:textbox id="txtRefNo" styles="width:100%;"/>
                        </td>
                        <td align="right" style="width: 5%;white-space: nowrap">
                            Shipment DT
                        </td>
                         <td colspan="4" style="width: 25%" align="left">
                             <gw:datebox id="dtShipment" lang="1" width="20%" />
                        </td>                    
                       
                    </tr>
                     <tr>
                        <td align="right" style="width: 5%; white-space: nowrap"> <a onclick="OnPopUp('PORT_SHIP')" href="#tips" style="color: #0000ff">                    
                                Port of shipment</a>
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstPortShip" styles="width:100%;" />                        
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap"> <a onclick="OnPopUp('PORT_ARR')" href="#tips" style="color: #0000ff">
                           Port of Arrival</a>
                        </td>                         
                       <td style="width: 30%">
                           <gw:list id="lstPortArr" styles="width:100%;" />     
                        </td>
                        <td align="right" style="width: 5%;white-space: nowrap">
                            Arrival DT
                        </td>
                         <td colspan="4" style="width: 25%" align="left">
                              <gw:datebox id="dtArrival" lang="1" width="20%" nullaccept/>
                        </td>  
                    </tr>    
                  
                    <tr style="height: 1%">
                        <td colspan="16">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                       
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
                                     <gw:icon id="idBtnP01" img="2" text="P/01" styles='width:100%' onclick="" />
                                    </td>
                                    <td style="width: 1%" align="right">                                  
                                        <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNew('LCItem')" />
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
                                header='_PK|_TLG_KB_SUB_SHIPMENT_M_PK|_TLG_IT_ITEM_PK|Item Code|Item Name|UOM|Unit Price|CCY|L/C Qty|Shipment Qty|Doc AMT|Shipment AMT'
                                format='1|1|1|0|0|0|1|0|1|1|1|1'
                                aligns='0|0|0|1|1|1|0|1|0|0|0|0'
                                check='||||||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1'
                                widths='0|0|0|1500|3000|800|1300|800|1300|1300|1500|1500'
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
