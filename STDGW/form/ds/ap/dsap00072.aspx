<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Collection Request Entry</title>
</head>

<script>

var G2_DETAIL_PK    = 0,
    G2_MASTER_PK    = 1,
    G2_SEQ          = 2,
    G2_ITEM_DESC    = 3,
	G2_COLLECT_QTY  = 4,
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
	txtMasterPK.text = "<%=Request.querystring("master_pk")%>" ;
	 
    txtChargerName.SetEnable(false);		            			
    txtReqEmpName.SetEnable(false);	
    txtSlipNo.SetEnable(false);	
	
	txtCustID.SetEnable(false);
	txtCustName.SetEnable(false);	
    //-------------- 
	OnBindingData();
	
	OnSearch('MASTER');     
}
//============================================================================================== 
function OnBindingData()
{   
	var data =""
    data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0100') FROM DUAL" )%>"; 
    lstCurr.SetDataText(data)
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGIN0301') FROM DUAL")%>||";  //payment form
    lstOutType.SetDataText(data);
	
	data = "data|0|0 %|5|5 %|10|10 %|15|15 %||";
    lstVATRate.SetDataText(data);     
    lstVATRate.value = '';

    var ctrl = grdDetail.GetGridControl();

    ctrl.ColFormat(G2_COLLECT_QTY)  = "###,###,###,###.##";
    ctrl.ColFormat(G2_UNIT_PRICE)   = "###,###,###,###.##";	
    ctrl.ColFormat(G2_ITEM_AMOUNT)  = "###,###,###,###.##";
	ctrl.ColFormat(G2_VAT_AMOUNT)   = "###,###,###,###.##";
	ctrl.ColFormat(G2_TOTAL_AMOUNT) = "###,###,###,###.##";
		
    arr_FormatNumber[G2_COLLECT_QTY] = 2;
    arr_FormatNumber[G2_UNIT_PRICE]  = 2;
     
    arr_FormatNumber[G2_ITEM_AMOUNT]  = 2;
    arr_FormatNumber[G2_VAT_AMOUNT]   = 2;
    arr_FormatNumber[G2_TOTAL_AMOUNT] = 2;	
}
 
 //============================================================================================== 
function OnSearch(pos)
{
    switch(pos)
    { 
		case 'MASTER':
			data_dsap00072.Call("SELECT");
		break;
		        
        case 'DETAIL':
            data_dsap00072_1.Call("SELECT");
        break;     
    }
}

//============================================================================================== 

function OnDataReceive(obj)
{
    switch(obj.id)
    {               
        case 'data_dsap00072':
			if (p_update == "delete")
			{
            	window.returnValue = 1; 
            	this.close();   				
			}
			else if (p_update == "update")
			{
				data_dsap00072_1.Call();
			}
			else
			{
            	OnSearch('DETAIL');
			}	
        break;
        
        case 'data_dsap00072_1':
            	p_update = "";
				
                if ( grdDetail.rows > 1 )
                {
					grdDetail.SetCellBold( 1, G2_ITEM_DESC,    grdDetail.rows - 1, G2_ITEM_DESC,  true);
                    grdDetail.SetCellBold( 1, G2_TOTAL_AMOUNT, grdDetail.rows - 1, G2_TOTAL_AMOUNT, true);
					grdDetail.SetCellBold( 1, G2_COLLECT_QTY,  grdDetail.rows - 1, G2_COLLECT_QTY,  true);
					
                    grdDetail.SetCellBgColor( 1, G2_ITEM_AMOUNT, grdDetail.rows - 1, G2_TOTAL_AMOUNT, 0xCCFFFF );
					grdDetail.SetCellBgColor( 1, G2_ITEM_DESC,   grdDetail.rows - 1, G2_ITEM_DESC,    0xCCFFFF );
                }
				
            	//---------------------------------------------          
        break;        
    }
} 
 
//=======================================================================
function CheckData()
{   
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
                if ( confirm("Do you want to save changes of collection request " + txtRefNo.text + " ? ") )
                {					 
                    p_update = "update";
					
					data_dsap00072.Call();
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
    
    if ( col == G2_COLLECT_QTY || col == G2_UNIT_PRICE || col == G2_ITEM_AMOUNT || col == G2_VAT_AMOUNT || col == G2_TOTAL_AMOUNT )
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
        if ( col == G2_COLLECT_QTY || col == G2_UNIT_PRICE || col == G2_ITEM_AMOUNT )
        {
			var dItemAmt, dVatAmt, dTotalAmt; 
			
			if ( col == G2_COLLECT_QTY || col == G2_UNIT_PRICE )
			{
				dItemAmt = Number(grdDetail.GetGridData( row, G2_COLLECT_QTY )) * Number(grdDetail.GetGridData( row, G2_UNIT_PRICE ));
				
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
    }
} 
//============================================================================================== 

function OnDelete()
{
    if ( confirm("Do you want to delete collection request for " + txtSlipNo.text + " ? ") )
    {    
        p_update = "delete"; 
        
        data_dsap00072.StatusDelete();

        data_dsap00072.Call();
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
</script>

<body>	     
	<!-------------------------------------------------------------------->    
    <gw:data id="data_dsap00072" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="<%=l_user%>lg_sel_dsap00072" procedure="<%=l_user%>lg_upd_dsap00072" > 
                <inout>
					<inout bind="txtMasterPK" />
					<inout bind="txtSlipNo" />
                    <inout bind="dtReqDate" />
                    <inout bind="txtChargerPK" />
                    <inout bind="txtChargerName" />
                    <inout bind="txtCustPK" />
                    <inout bind="txtCustID" />
                    <inout bind="txtCustName" />
                    <inout bind="txtReqEmpPK" />
                    <inout bind="txtReqEmpName" />
					
					<inout bind="txtArrayRefPK" />
					<inout bind="txtRefNo" />
					
					<inout bind="txtCollectDesc" />
					<inout bind="lstOutType" />
					
					<inout bind="lstCurr" />
					<inout bind="txtExRate" />
					<inout bind="lstVATRate" />
					
					<inout bind="txtItemAmt" />
					<inout bind="txtVatAmt" />
					<inout bind="txtTotalAmt" />
                </inout>                                                  
            </dso> 
        </xml> 
    </gw:data>
	<!--------------------------------------------------------------------->
    <gw:data id="data_dsap00072_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid"  parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_dsap00072_1" procedure="<%=l_user%>lg_upd_dsap00072_1" > 
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
               	Customer</td>
            <td style="width: 55%; white-space: nowrap" align="right" colspan=3>
                <gw:textbox id="txtCustPK" styles="display:none" />
                <gw:textbox id="txtCustID" styles="width:30%" csstype="mandatory" />
                <gw:textbox id="txtCustName" styles="width:70%" csstype="mandatory" />
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
                Collect Desc</td>
            <td style="width: 95%" colspan=5>
                <gw:textbox id="txtCollectDesc" maxlen="100" styles='width:100%' />
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
							Out Type  
						</td>	
			            <td style="width: 45%" colspan=3>                
							<gw:list id="lstOutType" styles='width:100%'  />
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
                            VAT Amt
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
                			VAT(%)
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
						<td style="width: 5%; white-space: nowrap" align="right">
                			Slip No</td>
            			<td style="width: 25%">							 
                			<gw:textbox id="txtSlipNo" maxlen="100" styles='width:100%' />
            			</td>			
						<td style="width: 67%" ></td>
						<td style="width: 1%" >
							<gw:icon id="btnSearch" img="2" text="Search" onclick="OnSearch('MASTER')" />
						</td>	
						<td style="width: 1%" >
							<gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnCancel()" />
						</td>	
						<td style="width: 1%" >
							<gw:icon id="btnDelete" img="2" text="Delete" onclick="OnDelete()" />
						</td>																
						<td style="width: 1%" >
							<gw:icon id="btnSave" img="1" text="Save" onclick="OnSave('MASTER')" />   
						</td>
					</tr>
				</table>								          			
   			</td>
		</tr>			  		     
        <tr style="height: 95%">
            <td colspan="8">
                    <gw:grid id='grdDetail'
                    header='_REQ_D_PK|_REQ_M_PK|Seq|Item Desc|Collect Qty|U/Price|Item Amt|VAT Amt|Total Amt|Remark'
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
