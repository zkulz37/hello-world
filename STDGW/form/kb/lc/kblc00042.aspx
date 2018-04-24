<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%    
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>L/C OPEN</title>
</head>
<script type="text/javascript" language="javascript">

var flag;
var G_LC_pk = 0;
var rtnLGCode = '' ;

var G2_PK                   = 0,
    G2_TLG_KB_RAW_LC_M_PK   = 1,
    G2_PO_NO                = 2,
    G2_ITEM_CODE            = 3,
    G2_ITEM_NAME            = 4,
    G2_QUANTITY             = 5,
    G2_UNIT                 = 6,
    G2_UNIT_PRICE           = 7,  
    G2_AMOUNT               = 8,
    G2_REF_QTY              = 9,
    G2_REF_UOM              = 10,
    G2_REMARK               = 11,
    G2_CCY                  = 12,      
    G2_TLG_IT_ITEM_PK       = 13;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
     //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = (ldate.substr(0,4)-1) + '01' + '01' ;
    dtFromSearch.value=ldate ;  
   //---------------------------- 
    txtFileNo.SetEnable(false);
    txtLCNo.SetEnable(false);
    dtIssusing.SetEnable(false);
    lstSupplier.SetEnable(false);
    lstCountry.SetEnable(false);
    lstPrice.SetEnable(false);
    lstPayment.SetEnable(false);
    lstShipper.SetEnable(false);
    lstCheck.SetEnable(false);
    dtStartDate.SetEnable(false);
    dtEndDate.SetEnable(false);
    txtQty.SetEnable(false);
    txtAmount.SetEnable(false);
    lstClass.SetEnable(false);
    txtRemark.SetEnable(false);
    txtBankNM.SetEnable(false);

    BindingDataList(); 
    data_kblc00042_search.Call('SELECT');
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";                 
	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0070' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstShipper.SetDataText(data); 
    lstShipper.value = '' ;
    
    lstSupplier.SetDataText(data);
    lstSupplier.value = '10';
    	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0120' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstPayment.SetDataText(data); 
    lstPayment.value = '10' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0130' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstPrice.SetDataText(data); 
    lstPrice.value = '10' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstClass.SetDataText(data); 
    lstClass.value = 'USD' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0220' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCountry.SetDataText(data); 
    lstCountry.value = '01' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0120' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstCheck.SetDataText(data);
    lstCheck.value = '' ;
    		 
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
            case 'SHIPPER':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0070";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'IEBS0070';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstShipper.value = object[1];      
	                }    	                
	             }                              
            break;
             case 'SUPPLIER':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0070";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'IEBS0070';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstSupplier.value = object[1];      
	                }    	                
	             }                              
            break;        
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
            case 'PAYMENT':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0120";
                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
                 if ( object != null )
                 {	        	                   
                    if ( object[0] == 1 )
                    {
                        txtLGGroupCodeID.text = 'LGCM0120';
                        rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
                    }
                    else
                    {
                        lstPayment.value = object[1];      
                    }    	                
                 }                              
            break;
             case 'PRICE':
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
	                    lstPrice.value = object[1];      
	                }    	                
	             }                              
            break;  
             case 'CLASSIFICATION':
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
	                    lstClass.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'COUNTRY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0220";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
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
	                    lstCountry.value = object[1];      
	                }    	                
	             }                              
            break; 
            case 'PRODUCT':
                var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=|Y|||Y|Y';
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {
                                              
                         txtProdPK.text = object[0];            
                         txtProdName.text = object[1]+ ' - ' +object[2]; 							                    
                                 
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
	                    lstCheck.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'Detail' :
	         var row  = event.row;
	         var col  = event.col; 
             if ( col == G2_REF_UOM && row != 0 )
             {
                   var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	               var obj = System.OpenModal( path, 550, 500, 'resizable:yes;status:yes');
	               
	               if ( obj != null && obj[1] != grdDetail.GetGridData(row,col))
	               {
	                    grdDetail.SetGridText(row,col,obj[1]);
	                    //ChangeUOM(row,G2_ST_UOM);
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
            data_kblc00042_search.Call("SELECT");
        break;
        case 'Master':
            txtMasterPK.text  = grdSearch.GetGridData(grdSearch.row,G_LC_pk);
            data_kblc00042_master.Call("SELECT");
        break;  
        case 'grdDetail':            
            data_kblc00042_detail.Call("SELECT");
        break;  
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'IEBS0070')
             {
                lstShipper.SetDataText(txtLGCodeList.text);
                lstShipper.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'IEBS0010')
             {
                lstBank.SetDataText(txtLGCodeList.text);  
                lstBank.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0120')
             {
                lstPayment.SetDataText(txtLGCodeList.text);  
                lstPayment.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'LGCM0130')
             {
                lstPrice.SetDataText(txtLGCodeList.text);  
                lstPrice.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'LGCM0100')
             {
                lstClass.SetDataText(txtLGCodeList.text);  
                lstClass.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'LGCM0220')
             {
                lstCountry.SetDataText(txtLGCodeList.text);  
                lstCountry.value = rtnLGCode;                      
             }
        break;
        case 'data_kblc00042_search':
            lblRecord.text  = ( grdSearch.rows -1 )+ " record(s)."
        break;     
        case "data_kblc00042_master": 
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G2_TLG_KB_RAW_LC_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i,G2_TLG_KB_RAW_LC_M_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }

        break;
    }
}
//====================================================================================

function Validate()
{   
   if(txtLCNo.text =="")
    {
        alert("Please, input L/C No!")
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
                data_kblc00042_master.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_kblc00042_detail.Call();
        break;
    }

}
//====================================================================================

function OnAddNew(pos)
{
     switch (pos)
    {   
         case 'Master':              
                data_kblc00042_master.StatusInsert();
                
                txtFileNo.text   = '***New Voucher***';
                //-------------------------------------------         
                grdDetail.ClearData();
                flag = "view";        
          break;
          case 'PO':
                 var path = System.RootURL + "/form/kb/lc/kblc00121.aspx";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');   	         
	             if ( object != null )
	             {  
    	           
	                for(var i =0; i< object.length; i++)
	                { 
	                    //txtCustomerPK.text   = object[0][0];
                        //txtCustomerCode.text = object[0][1];
                        //txtCustomerName.text = object[0][2];               
                        //txtPONoPK.text = object[0][3];
                        //txtPONo.text = object[0][4];
                            
                        grdDetail.AddRow();  
                        grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_KB_RAW_LC_M_PK, txtMasterPK.text); //master_pk	    	                                               
                        grdDetail.SetGridText( grdDetail.rows-1, G2_PO_NO , object[i][4]);//po_no        
                        grdDetail.SetGridText( grdDetail.rows-1, G2_TLG_IT_ITEM_PK , object[i][9]);//item_pk	    
                        grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE, object[i][10]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME, object[i][11]);//item_name	    			
                        grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT_PRICE, object[i][14]);//unit price
                        grdDetail.SetGridText( grdDetail.rows-1, G2_QUANTITY,object[i][13]);//quanity
                        grdDetail.SetGridText( grdDetail.rows-1, G2_AMOUNT,object[i][15]);//amount   
                        grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT ,object[i][12]);//uint    
					    grdDetail.SetGridText( grdDetail.rows-1, G2_CCY ,object[i][19]);//ccy 					
    					grdDetail.SetGridText( grdDetail.rows-1, G2_REMARK ,object[i][20]);//remark 		  	           
                    }
                    TotalAmount();
	             }               
            break;
    }
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT--QTY---------------- 
    var sumTotalAmount = 0 ;
    var sumTotalQty = 0;

    for (var i=1; i<grdDetail.rows; i++ )
    {    
        sumTotalAmount = sumTotalAmount + Number(grdDetail.GetGridData( i, G2_AMOUNT));
        sumTotalQty = sumTotalQty + Number(grdDetail.GetGridData( i, G2_QUANTITY));
    }
  
    txtAmount.text = System.Round( sumTotalAmount,2);
    txtQty.text = System.Round( sumTotalQty,2);
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
                    data_kblc00042_master.StatusDelete();
                    data_kblc00042_master.Call();
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
                        var QtyAfterDelRow =0;
                        AmtAfterDelRow = Number(txtAmount.text)- Number(grdDetail.GetGridData(grdDetail.row, G2_AMOUNT));
                        QtyAfterDelRow = Number(txtQty.text)- Number(grdDetail.GetGridData(grdDetail.row, G2_QUANTITY));
                        txtAmount.text = System.Round( AmtAfterDelRow,2);
                        txtAmount.text = System.Round( QtyAfterDelRow,2);
                    }    
                }  
            }          
        break;            

    }     
}
//====================================================================================
function OnSelect()
{try{
    var arr_data = new Array();

    if ( arr_data != null )
    {
        var callerWindowObj = dialogArguments;  
        
        callerWindowObj.txtLCNo.text        = txtLCNo.text; 
        callerWindowObj.lstCCY.value        = lstClass.value;

        callerWindowObj.txtBankPK.text        = txtBankPK.text;
        callerWindowObj.txtBankNM.text        = txtBankNM.text;
        callerWindowObj.txtTacAbdepomtPK.text  = txtTacAbdepomtPK.text;
    }
    window.returnValue =  arr_data;
    window.close();	
    }catch(err)
    {alert(err.Message)};
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
    <!--============================================= Search =====================================-->
    <gw:data id="data_kblc00042_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kblc00042"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtFileNoSearch"	/>	
					<input	bind="txtSearchBy"	/>	
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kblc00042_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"	function="<%=l_user%>lg_sel_kblc00042_1"	procedure="<%=l_user%>lg_upd_kblc00042_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtFileNo"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="dtIssusing"	/>
						<inout	bind="lstSupplier"	/>
						<inout	bind="txtBankPK"	/>
                        <inout	bind="txtBankNM"	/>
						<inout	bind="lstCountry"	/>	
						<inout	bind="lstPrice"	/>
						<inout	bind="lstPayment"	/>
						<inout	bind="lstShipper"	/>
						<inout	bind="lstCheck"	/>  
						<inout	bind="dtStartDate"	/>
						<inout	bind="dtEndDate"	/>				
						<inout	bind="txtQty"	/>
						<inout	bind="txtAmount"	/>
						<inout	bind="lstClass"	/>	
						<inout	bind="txtRemark"	/>
                        <inout	bind="txtTacAbdepomtPK"	/>								
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_kblc00042_detail" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="<%=l_user%>lg_sel_kblc00042_2" procedure="<%=l_user%>lg_upd_kblc00042_2">
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 20%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 12%">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 15%">
                        </td>
                        <td style="width: 17%">
                        </td>
                        <td style="width: 12%">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Slip No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtFileNo" styles="width:100%;" csstype="mandatory" readonly="true" />
                        </td>
                        <td align="right" style="width: 15%;">
                            L/C No
                        </td>
                        <td style="width: 17%">
                            <gw:textbox id="txtLCNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Issuing Date
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:datebox id="dtIssusing" lang="1" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Supplier
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstSupplier" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            Issue Bank
                        </td>
                        <td style="width: 17%">
                            <gw:textbox id="txtBankPK" styles="width:100%;display:none" readonly="true" />
                            <gw:textbox id="txtBankNM" csstype="mandatory" styles="width:100%;" readonly="true" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Quantity
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtQty" styles="width:100%;" type="number" format="###,###.#R" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Origin
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstCountry" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            S/D
                        </td>
                        <td style="width: 17%">
                            <gw:datebox id="dtStartDate" lang="1" />
                        </td>
                        <td align="right" style="width: 12%; white-space: nowrap">
                            L/C Open Amount
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtAmount" styles="width:100%;" type="number" format="###,###.#R" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Price terms
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstPrice" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            E/D
                        </td>
                        <td style="width: 17%">
                            <gw:datebox id="dtEndDate" lang="1" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Currency
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:list id="lstClass" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%; white-space: nowrap">
                            Payment Terms
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstPayment" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            Shipper
                        </td>
                        <td style="width: 17%">
                            <gw:list id="lstShipper" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            L/C Check
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:list id="lstCheck" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Remark
                        </td>
                        <td colspan="9" style="width: 88%">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 30%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 5%">
                        <td style="width: 96%;">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%">
                        </td>
                    </tr>
                    <tr style="height: 95%;">
                        <td colspan="4" style="width: 100%;">
                            <gw:grid id='grdDetail' header='_PK|_TLG_KB_RAW_LC_M_PK|P/O No|_Item Code|Item Name|Qty|Uom|Unit Price|Amount|Ref Qty|Ref Uom|Remark|_CCY|_TLG_IT_ITEM_PK'
                                format='1|1|0|0|0|1|0|1|1|1|2|0|0|1' aligns='0|0|1|1|1|0|1|0|0|0|1|0|1|0' check='|||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|1|1|1|0|0' widths='0|0|1300|1300|3000|1200|1000|1500|1500|1200|1200|1300|1000|0'
                                sorting='T' autosize='T' styles='width:100%; height:100%'/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 10%;">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 10%">
                            <gw:datebox id="dtFromSearch" lang="1" />
                            ~
                            <gw:datebox id="dtToSearch" lang="1" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No/LC No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtFileNoSearch" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Search by
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearchBy" styles="width:100%;" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            <gw:label id="lblRecord" text="" styles="color:red" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                        <td align="right">
                        </td>
                        <td align="right">
                            <gw:icon id="idBtnSelectAll" img="2" text="Select" styles='width:5%' onclick="OnSelect()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 45%">
            <td colspan="8">
                <gw:grid id='grdSearch' header='_PK|Slip No|L/C No|Issue Date|Supplier|P/O No|Qty|Open AMT|CCY|S/D|E/D|Issue Bank|Price Term|Payment Term|Shipper|Origin Country|Remark'
                    format='0|0|0|4|0|0|1|1|0|4|4|0|0|0|0|0|0' aligns='0|1|1|1|1|1|0|0|1|1|1|1|1|1|1|1|0'
                    check='||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|1200|1200|1300|1300|1300|1300|2000|1000|1200|1200|1200|1200|1200|1200|1200|1200'
                    sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<gw:textbox id="txtTacAbdepomtPK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
</html>
