<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Payment Request Entry</title>
</head>

<script>

var G2_DETAIL_PK    = 0,
    G2_MASTER_PK    = 1,
    G2_SEQ          = 2,
    G2_ITEM_DESC    = 3,
	G2_PAYMENT_QTY  = 4,
    G2_UNIT_PRICE   = 5,
    G2_ITEM_AMOUNT  = 6,
    G2_VAT_AMOUNT   = 7,
    G2_TOTAL_AMOUNT = 8,
	G2_REMARK		= 9;  
   
 //============================================================================================== 
var callerWindowObj = dialogArguments;

var arr_FormatNumber = new Array();	
var p_update = "";

 //============================================================================================== 
function BodyInit()
{     
    System.Translate(document); 
    txtChargerName.SetEnable(false);		            			
    txtReqEmpName.SetEnable(false);	
	
	txtSupplierID.SetEnable(false);
    txtSupplierName.SetEnable(false);
    //-------------- 
	OnBindingData();
	
    GetDataFromMain();        
}
//============================================================================================== 
function OnBindingData()
{   
	var data =""
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>"; 
    lstCurr.SetDataText(data)
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGIN0301') FROM DUAL")%>||";  //payment form
    lstInType.SetDataText(data);
	
	data = "data|0|0 %|5|5 %|10|10 %|15|15 %||";
    lstVATRate.SetDataText(data);     
    lstVATRate.value = '';
	
	data = "<%=ESysLib.SetListDataSQL("select pk,DEPT_ID || ' * '|| DEPT_NAME from tlg_PO_DEPT a where  del_if=0 order by DEPT_ID")%>||"; 
    lstDept.SetDataText(data);  
    lstDept.value = '' ;
    //-----------------------

    var ctrl = grdDetail.GetGridControl();

    ctrl.ColFormat(G2_PAYMENT_QTY)  = "###,###,###,###.##";
    ctrl.ColFormat(G2_UNIT_PRICE)   = "###,###,###,###.##";	
    ctrl.ColFormat(G2_ITEM_AMOUNT)  = "###,###,###,###.##";
	ctrl.ColFormat(G2_VAT_AMOUNT)   = "###,###,###,###.##";
	ctrl.ColFormat(G2_TOTAL_AMOUNT) = "###,###,###,###.##";
		
    arr_FormatNumber[G2_PAYMENT_QTY] = 2;
    arr_FormatNumber[G2_UNIT_PRICE]  = 2;
     
    arr_FormatNumber[G2_ITEM_AMOUNT]  = 2;
    arr_FormatNumber[G2_VAT_AMOUNT]   = 2;
    arr_FormatNumber[G2_TOTAL_AMOUNT] = 2;	
}

 //============================================================================================== 
function GetDataFromMain()
{
	txtChargerName.text = "<%=Session("USER_NAME")%>";
    txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
		
	txtReqEmpName.text = callerWindowObj.txtRequesterName.text;
	txtReqEmpPK.text   = callerWindowObj.txtRequesterPK.text;
	
	txtArrayRefPK.text = callerWindowObj.txtArrayRefPK.text;
	txtRefNo.text      = callerWindowObj.txtArrayRefNo.text;
	
	txtSupplierPK.text   = callerWindowObj.txtPartnerPK.text;
	txtSupplierID.text   = callerWindowObj.txtPartnerID.text;
	txtSupplierName.text = callerWindowObj.txtPartnerName.text;
	
	lstCurr.value  = callerWindowObj.txtTrCCY.text ;
	txtExRate.text = callerWindowObj.txtExRate.text;
			
    OnSearch('DETAIL');    
}
 //============================================================================================== 
function OnSearch(pos)
{
    switch(pos)
    {         
        case 'DETAIL':
            data_dsap00011_1.Call("SELECT");
        break;     
    }
}

//============================================================================================== 

function OnDataReceive(obj)
{
    switch(obj.id)
    {       
        case 'data_dsap00011_2':			 
            	window.returnValue = 1; 
            	this.close();   			 
        break; 
        
        case 'pro_dsap00011':
            for ( var i=1 ; i<grdDetail.rows; i++)
            {
                grdDetail.SetGridText( i, G2_MASTER_PK, txtMasterPK.text );                
            }
               
            data_dsap00011_2.Call();   
        break;
        
        case 'data_dsap00011_1':
            
                if ( grdDetail.rows > 1 )
                {
					grdDetail.SetCellBold( 1, G2_ITEM_DESC,    grdDetail.rows - 1, G2_ITEM_DESC,  true);
                    grdDetail.SetCellBold( 1, G2_TOTAL_AMOUNT, grdDetail.rows - 1, G2_TOTAL_AMOUNT, true);
					grdDetail.SetCellBold( 1, G2_PAYMENT_QTY,  grdDetail.rows - 1, G2_PAYMENT_QTY,  true);
					
                    grdDetail.SetCellBgColor( 1, G2_ITEM_AMOUNT, grdDetail.rows - 1, G2_TOTAL_AMOUNT, 0xCCFFFF );
					grdDetail.SetCellBgColor( 1, G2_ITEM_DESC,   grdDetail.rows - 1, G2_ITEM_DESC,    0xCCFFFF );
                }
				
            	//---------------------------------------------          
                TotalAmount();
        break;        
    }
} 
 
//=======================================================================
function CheckData()
{   
	if ( lstCurr.value == '' )
	{
		alert("PLS SELECT CURRENCY BEFORE SAVE.");
		return false;
	}
	
    return true;
}

 //============================================================================================== 
function OnSave(pos)
{
    switch (pos)
    {
        case 'MASTER':
            if ( CheckData() )
            {
                if ( confirm("Do you want to make payment request for " + txtRefNo.text + " ? ") )
                {
					 
                    pro_dsap00011.Call();
                }    
            }    
        break;
    }    
}
  
 //============================================================================================== 
 function CheckInput()
 {   
    var  row, col 
        
    row = event.row ;
    col = event.col ;    
    
    if ( col == G2_PAYMENT_QTY || col == G2_UNIT_PRICE || col == G2_ITEM_AMOUNT || col == G2_VAT_AMOUNT || col == G2_TOTAL_AMOUNT )
    {
        var dQuantiy;
        
        dQuantiy =  grdDetail.GetGridData(row,col)
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText(row,col, System.Round( dQuantiy, arr_FormatNumber[col] ) );
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"")
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"")
        }
		//---------------------	
        if ( col == G2_PAYMENT_QTY || col == G2_UNIT_PRICE || col == G2_ITEM_AMOUNT )
        {
			var dItemAmt, dVatAmt, dTotalAmt; 
			
			if ( col == G2_PAYMENT_QTY || col == G2_UNIT_PRICE )
			{
				dItemAmt = Number(grdDetail.GetGridData( row, G2_PAYMENT_QTY )) * Number(grdDetail.GetGridData( row, G2_UNIT_PRICE ));
				
				grdDetail.SetGridText( row, G2_ITEM_AMOUNT, System.Round( dItemAmt, arr_FormatNumber[G2_ITEM_AMOUNT] ) );
			}
			//----------------
         	dVatAmt = Number(grdDetail.GetGridData( row, G2_ITEM_AMOUNT )) * Number(lstVATRate.value)/100;
			grdDetail.SetGridText( row, G2_VAT_AMOUNT, System.Round( dVatAmt, arr_FormatNumber[G2_VAT_AMOUNT] ) );
			//----------------
			dTotalAmt = Number(grdDetail.GetGridData( row, G2_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( row, G2_VAT_AMOUNT )) ;
			grdDetail.SetGridText( row, G2_TOTAL_AMOUNT, System.Round( dTotalAmt, arr_FormatNumber[G2_TOTAL_AMOUNT] ) );
		}
		else if ( col == G2_VAT_AMOUNT )
		{	
			dTotalAmt = Number(grdDetail.GetGridData( row, G2_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( row, G2_VAT_AMOUNT )) ;
			grdDetail.SetGridText( row, G2_TOTAL_AMOUNT, System.Round( dTotalAmt, arr_FormatNumber[G2_TOTAL_AMOUNT] ) );
        }			
		
		TotalAmount();                          
    } 
 }
 
 //===============================================================================================
function TotalAmount()
{
	   var vItemAmt = 0,vVatAmt = 0,vTotalAmt = 0;
	
       for (var i = 1; i<grdDetail.rows  ; i++)
       {
			//-----------------------------	   
            vItemAmt  =  vItemAmt  + Number(grdDetail.GetGridData(i, G2_ITEM_AMOUNT ));
            vVatAmt   =  vVatAmt   + Number(grdDetail.GetGridData(i, G2_VAT_AMOUNT  ));
            vTotalAmt =  vTotalAmt + Number(grdDetail.GetGridData(i, G2_TOTAL_AMOUNT));                       
       }       
	   
       txtItemAmt.text  = vItemAmt  ;
       txtVatAmt.text   = vVatAmt   ;
       txtTotalAmt.text = vTotalAmt ; 
} 
 //============================================================================================== 
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
			var obj = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:50;dialogHeight:30');		 

            if ( obj != null )
            {
                txtChargerName.text = obj[2];
                txtChargerPK.text   = obj[0];
            }
        break;   
		
        case 'ReqEmp':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
			var obj = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:50;dialogHeight:30');		 

            if ( obj != null )
            {
                txtReqEmpName.text = obj[2];
                txtReqEmpPK.text   = obj[0];
            }
        break;   
		
		case 'PARTNER':
		     var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var obj = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:50;dialogHeight:30');
			 
	         if ( obj != null )
	         {	         
	            txtSupplierPK.text   = obj[0];
                txtSupplierID.text   = obj[1];
                txtSupplierName.text = obj[2];                                              
	         }
        break; 
    }
} 

//============================================================================================== 
function OnCancel()
{
    window.returnValue = null; 
    this.close();   
}
  
 //============================================================================================== 
function OnChangeRate()
{
	var vItemAmt = 0,vVatAmt = 0,vTotalAmt = 0;
	
       for (var i = 1; i<grdDetail.rows  ; i++)
       {
         	dVatAmt = Number(grdDetail.GetGridData( i, G2_ITEM_AMOUNT )) * Number(lstVATRate.value)/100;
			grdDetail.SetGridText( i, G2_VAT_AMOUNT, System.Round( dVatAmt, arr_FormatNumber[G2_VAT_AMOUNT] ) );
			//-----------------------------
			dTotalAmt = Number(grdDetail.GetGridData( i, G2_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( i, G2_VAT_AMOUNT )) ;
			grdDetail.SetGridText( i, G2_TOTAL_AMOUNT, System.Round( dTotalAmt, arr_FormatNumber[G2_TOTAL_AMOUNT] ) );
			//-----------------------------	   
            vItemAmt  =  vItemAmt  + Number(grdDetail.GetGridData(i, G2_ITEM_AMOUNT ));
            vVatAmt   =  vVatAmt   + Number(grdDetail.GetGridData(i, G2_VAT_AMOUNT  ));
            vTotalAmt =  vTotalAmt + Number(grdDetail.GetGridData(i, G2_TOTAL_AMOUNT));                       
       }       
	   
       txtItemAmt.text  = vItemAmt  ;
       txtVatAmt.text   = vVatAmt   ;
       txtTotalAmt.text = vTotalAmt ; 
} 
 
 //============================================================================================== 
 
 function AddNew(pos)
 {
 	switch(pos)
	{
		case 'ITEM':
		     var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';
	         var object = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:50;dialogHeight:30');
	         if ( object != null )
             {
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];                                
                            grdDetail.AddRow();                                                          
                            grdDetail.SetGridText( grdDetail.rows-1, G2_SEQ ,grdDetail.rows-1);//seq	   
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_DESC ,arrTemp[2]);//item_name	   
                          
                    }		            
             }    
		break;
	}
 }
function OnDelete()
{
    if ( grdDetail.GetGridData( grdDetail.row, G2_DETAIL_PK ) == '' )
        {
            grdDetail.RemoveRow();
        }
        else
        {   
            grdDetail.DeleteRow();
        }    
}
function OnUnDelete()
{
       grdDetail.UnDeleteRow();
   
}
 //============================================================================================== 
</script>

<body>	  
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsap00011_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="<%=l_user%>lg_SEL_dsap00011_1" procedure="<%=l_user%>lg_upd_dsap00011_1" >
                <input bind="grdDetail" >			      
			        <input bind="txtArrayRefPK" />
			    </input>
                <output bind="grdDetail" />
            </dso>
        </xml>
    </gw:data>
	<!-------------------------------------------------------------------->
    <gw:data id="pro_dsap00011" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsap00011" > 
                <input>
                    <input bind="dtReqDate" />
                    <input bind="txtChargerPK" />
                    <input bind="txtChargerName" />
                    <input bind="txtSupplierPK" />
                    <input bind="txtSupplierID" />
                    <input bind="txtSupplierName" />
                    <input bind="txtReqEmpPK" />
                    <input bind="txtReqEmpName" />
					
					<input bind="txtArrayRefPK" />
					<input bind="txtRefNo" />
					
					<input bind="txtPaymentDesc" />
					<input bind="lstInType" />
					
					<input bind="lstCurr" />
					<input bind="txtExRate" />
					<input bind="lstVATRate" />
					
					<input bind="txtItemAmt" />
					<input bind="txtVatAmt" />
					<input bind="txtTotalAmt" />
					
					<input bind="lstDept" />
                </input>                                  
                <output> 
                    <output bind="txtMasterPK" />                   
                </output>
            </dso> 
        </xml> 
    </gw:data>
	<!--------------------------------------------------------------------->
    <gw:data id="data_dsap00011_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid"  parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_dsap00011_2" procedure="<%=l_user%>lg_upd_dsap00011_2" > 
                  <input bind="grdDetail" > 
                    <input bind="txtMasterPK" />																							
                  </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" >          
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Ref No</td>
            <td style="width: 35%">
				<gw:textbox id="txtArrayRefPK" maxlen="100" styles='width:100%;display:none' />
                <gw:textbox id="txtRefNo" maxlen="100" styles='width:100%' />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Req Date</td>
            <td style="width: 15%; white-space: nowrap">
                <gw:datebox id="dtReqDate" lang="<%=Application("Lang")%>" mode="01" />                
            </td>            
			<td style="width: 5%; white-space: nowrap" align="right">
               <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">
                  	Charger</a> 
			</td>
            <td style="width: 35%">
                <gw:textbox id="txtChargerPK" styles='width:100%; display:none' />
                <gw:textbox id="txtChargerName" maxlen="100" styles='width:100%' />
            </td>
        </tr>
        <tr style="height: 1%">
			<td style="width: 5%; white-space: nowrap" align="right">
				<a title="Supplier" onclick="OnPopUp('PARTNER')" href="#tips" style="color: #0000ff">
                  	Supplier</a>					               	
			</td>
            <td style="width: 55%; white-space: nowrap" align="right" colspan=3>
                <gw:textbox id="txtSupplierPK" styles="display:none" />
                <gw:textbox id="txtSupplierID" styles="width:30%" csstype="mandatory" />
                <gw:textbox id="txtSupplierName" styles="width:70%" csstype="mandatory" />
            </td>			
			<td style="width: 5%; white-space: nowrap" align="right">
                <a title="Requester" onclick="OnPopUp('ReqEmp')" href="#tips" style="color: #0000ff">
                    Requester</a>
            </td>
            <td style="width: 35%" >
                <gw:textbox id="txtReqEmpPK" styles='width:100%; display:none' />
                <gw:textbox id="txtReqEmpName" maxlen="100" styles='width:100%' />
            </td>			                
        </tr>
		<tr style="height: 1%">	
			<td style="width: 5%; white-space: nowrap" align="right">
                Desc</td>
            <td style="width: 55%" colspan=3>
                <gw:textbox id="txtPaymentDesc" maxlen="100" styles='width:100%' />
            </td>
			<td style="width: 5%; white-space: nowrap" align="right">
                Dept
            </td>
            <td style="width: 35%" >
                <gw:list id="lstDept" styles='width:100%;' />                 
            </td>	   	                                    
		</tr>		
        <tr style="height:1%">
			<td colspan=10>
				<table style="width:100%;height:100%; background-color: #CCFFFF" >
					<tr>			
						<td style="width: 5%; white-space: nowrap" align="right">
			               Ex Rate 
						</td>
			            <td style="width: 20%">
			               <gw:list id="lstCurr" styles='width:100%'  />  
			            </td>  
						<td style="width: 25%; white-space: nowrap" colspan=2>				
							<gw:textbox id="txtExRate" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							In Type  
						</td>	
			            <td style="width: 45%" colspan=3>                
							<gw:list id="lstInType" styles='width:100%'  />
			            </td>   			             
					</tr>      				
                    <tr style="height:1%">
                        <td style="width:5%;white-space:nowrap">
                            Item Amt
                        </td>
                        <td style="width:20%">
                            <gw:textbox id="txtItemAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" csstype="mandatory"/>
                        </td>
                        <td style="width:5%;white-space:nowrap">
                            Tax Amt
                        </td>
                        <td style="width:20%">
                            <gw:textbox id="txtVatAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" csstype="mandatory"/>
                        </td>
                        <td style="width:5%;white-space:nowrap">
                            Total Amt
                        </td>
                        <td style="width:20%">
                            <gw:textbox id="txtTotalAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" csstype="mandatory"/>
                        </td>
						<td style="width: 5%; white-space: nowrap" align="right">
                			Tax(%)
            			</td>
            			<td style="width: 20%">
							<gw:list id="lstVATRate" styles='width:100%' onchange="OnChangeRate()" />			               
            			</td>
                    </tr>						
                </table>
			</td>            
        </tr>
		<tr  style="height: 1%">
        	<td colspan=8 align="right" style="width: 100%; white-space: nowrap" >
				<table>
					<tr>
						<td style="width: 96%">
						</td> 
						<td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="Add Item" id="btnAddDetail" onclick="AddNew('ITEM')" />
                        </td>						 
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="delete" alt="Add Item" id="btnDelete" onclick="OnDelete()" />
                        </td>
						<td style="width: 1%">
							<gw:icon id="btnSearch" img="2" text="Search" onclick="OnSearch('DETAIL')" />
						</td>						
						<td style="width: 1%">
							<gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnCancel()" />
						</td>						
						<td style="width: 1%">
							<gw:icon id="btnSave" img="1" text="Save" onclick="OnSave('MASTER')" />   
						</td>
					</tr>
				</table>								          			
   			</td>
		</tr>			  		     
        <tr style="height: 95%">
            <td colspan="8">
                    <gw:grid id='grdDetail'
                    header='_REQ_D_PK|_REQ_M_PK|Seq|Item Desc|Payment Qty|U/Price|Item Amt|Tax Amt|Total Amt|Remark'
                    format='0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|1|0|3|3|3|3|3|0'
                    check='|||||||||'
                    editcol='0|0|1|1|1|1|1|1|1|1'
                    widths='0|0|800|3500|1500|1500|1500|1500|1500|1000'
                    sorting='T'
                    styles='width:100%; height:100%' onafteredit="CheckInput()" 
                    />            
             </td>
        </tr>
    </table>
    <!--------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" maxlen="100" styles='width:100%;display:none' />        
</body>
</html>
