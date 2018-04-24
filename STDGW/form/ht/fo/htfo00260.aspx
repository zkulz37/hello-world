<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Line Result Incoming</title>
</head>

<script>

    var  user_pk   = "<%=Session("EMPLOYEE_PK")%>";
    var  user_name = "<%=Session("USER_NAME")%>"  ;
//-----------------------------------------------------
var flag = '' ;

//-----------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display      = "none";       
        imgArrow.status         = "collapse";
        right.style.width       = "100%";
        imgArrow.src            = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display      = "";
        imgArrow.status         = "expand";
        right.style.width       = "80%";
        imgArrow.src            = "../../../system/images/prev_orange.gif";
    }
 }
 
//==========================================================================

function BodyInit()
{
	chkConfirm.value = '-1';
    OnAddNew();
    left.style.display="none";
    OnToggle();
	txtGuestQty.text = 1;
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
    data ="DATA|USD|USD|VND|VND|EUR|EUR|KRW|KRW"; 
	lstCurrency.SetDataText(data);
	lstCurrency.value = "VND";
	lstCurrency.SetEnable(false);
	
	var temp = '<%=Request.QueryString("point") %>';
	
	data = "<%=ESysLib.SetListDataSQL("Select CODE, NAME from tco_commcode where code in ('POINT-11','POINT-19') ORDER BY ORD ") %>";
	lstPOINT.SetDataText(data);
	lstPOINT.value = 'POINT-11';
	if(temp.length > 0){
		lstPOINT.value = temp;
	}
	
	switch(lstPOINT.value){
		case "POINT-19":
			lstCurrency.value = "USD";
		break;
	}
	
	data = "<%=ESysLib.SetListDataSQL("SELECT num1, NAME FROM  TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='VAT'" )%>"; 
	lstVat.SetDataText(data);
	lstVat.value = 10;
	lstVat.SetEnable(false);
	
	EnableButton(true);
	OnChangePoint();
	
}
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch' :        
            dso_htfo00260_searchM.Call("SELECT")
        break;
        case 'grdSearchItem' :        
            dso_htfo00260.Call("SELECT")            
        break;
        case 'Master' :
            if ( grdSearch.row > 0 )
            {
                txtMasterPK.text = grdSearch.GetGridData( event.row, 0);                
            }
            else
            {
                txtMasterPK.text = '' ;
            }
            
            dso_htfo00261.Call("SELECT");
        break;
    }
}
function CheckDataExist(p_oGrid,p_value)
{
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, 2) == p_value)
              {
                 return true;
              }
       }
       return false;
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == 'grdMenu' && event.row > 0)
      {
           var col_val = oGrid.GetGridData(event.row, 0 );
            
            if(event.row > 0 && ( !CheckDataExist(grdItem,col_val)) )
            {
                //SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		        grdItem.AddRow();
		        for(var i=0;i<oGrid.cols-1;i++)
		        {
		          grdItem.SetGridText(grdItem.rows-1,i+2,oGrid.GetGridData(event.row,i));
		        }
            }
      }
      SumAmount();
}
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, 0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//==========================================================================
function EnableButton(obj)
{
	btnDelete.SetEnable(obj);
	btnConfirm.SetEnable(obj);
	btnSendBill.SetEnable(obj);
	btnDelete_1.SetEnable(obj);	
	btnUpdate.SetEnable(obj);
}

function OnDataReceive(obj)
{
  switch (obj.id)
    {
        case "dso_htfo00261" :
			if (CONFIRM_YN.text == 'Y')
				EnableButton(false);
			else
				EnableButton(true);
				
			if(txtRoomPK.text != '' && txtRoomPK.text != '0'){
				lstPOINT.SetEnable(false);}

            if ( flag == 'save'|| flag == 'delete')
            {
               if(flag == 'save')
               {
                   for(var i=0; i < grdItem.rows;i++)
                    {
                        if ( grdItem.GetGridData( i, 1) == '' )
                        {
                            grdItem.SetGridText( i, 1, txtMasterPK.text);
                        }    
                    }
                    flag = 'save';
                   dso_htfo00262.Call(); 
                } 
                else
                {
                    OnSearch('grdSearch');
                    flag = 'select';
                    //OnAddNew();
                }              
            }
            else
            {
                //grdMenu.ClearData();
                dso_htfo00262.Call("SELECT"); 
            }             
        break;
        case "dso_htfo00262" :
            SumAmount();
            if(flag == 'save' || flag == 'Delete')
            {
                if(flag == 'save')
                {
                    OnSearch('grdSearch'); 
                    flag = 'select';
                }
                else
                {
                    dso_htfo00261.Call();
                    flag = 'break OnDataReceive';
                }
            }
            if(CONFIRM_YN.text == 'Y'){
                EnableButton(false);
                btnUpdate.SetEnable(false);
            }else btnUpdate.SetEnable(true);
        break;
        case "dso_htfo00260":
            OnSearch('grdSearch');
        break;
		case "dso_htfo00263":
			dso_htfo00260.Call("SELECT");
		break;
     }
}
//==========================================================================
function OnAddNew()
{
	EnableButton(true);
	lstPOINT.SetEnable(true);
    dso_htfo00261.StatusInsert();
    lstVat.value = 10;
    CONFIRM_YN.text = 'N';
    PAYED_YN.text = 'N';
	txtGuestQty.text = 1;
    grdItem.ClearData();
}
//==========================================================================
function OnChangePoint(){
	switch(lstPOINT.value){
		case "POINT-19":
			lstCurrency.value = "USD";
		break;
		case "POINT-11":
			lstCurrency.value = "VND";
		break;
	}
	
	dso_htfo00263.Call();
}
//==========================================================================
function OnSend(obj){
     CONFIRM_YN.text = 'Y';
    if(obj=='1')
	{
		if ( confirm( "Are you sure to collector this Invoice ?"))
		{
			PAYED_YN.text = 'Y';
			flag = 'save';
			OnSave();
		}
	}
	if(obj=='2')
	{
		if ( confirm( "Are you sure to send bill this Invoice ?"))
		{
			if(Number(txtRoomPK.text) < 0){
				alert("Only guest hotel can using this function!"); return false;
			}
			flag = 'save';
			OnSave();
		}
	}
}
//==========================================================================

function OnSave()
{
	flag = 'save';
	SumAmount();
	if(txtRoomPK.text == '' || txtRoomPK.text == '0'){
	    alert('Please select Room!');return false;
	}
	dso_htfo00261.Call();
}

function OnConfirm()
{
	flag = 'save';
	CONFIRM_YN.text = '20';
	dso_htfo00261.Call();
}

function AmountSum()
{
    if(event.col == 9)
    {
        var price_Qty;        
        price_Qty=(grdItem.GetGridData(grdItem.row, 7)*(grdItem.GetGridData(grdItem.row, 9)));
        grdItem.SetGridText(grdItem.row, 10,price_Qty)
    }
}
function OnDelete(index)
 {
    switch(index)
    {
        case'Master':
			if (txtMasterPK.text != '')
			{
				if ( confirm( "Do you want to delete this Invoice " + txtSlipNo.text + " ?" ) ) 
				{
					flag = 'delete';
					dso_htfo00261.StatusDelete();
					dso_htfo00261.Call(); 
				}
			}        
        break;
        
        case 'Detail':
			if (grdItem.rows > 1 && grdItem.GetGridData(grdItem.row, 0)!="")
			{
				flag ='Delete';
				grdItem.DeleteRow();
				dso_htfo00262.Call();
			}
			else
			{
			    dso_htfo00262.Call("SELECT");
			    flag ='end';
			}
        break;
    }         
 }
function OnUnDelete() 
{
    grdItem.UnDeleteRow();
}
function OnPopUp(pos)
{
      switch (pos)         
      {		        
            case 'RoomSearch' :
               var path = System.RootURL + '/form/ht/fo/htfo00260_popup.aspx';
               var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtRoomSearch.text = obj[2];
                    txtRoomSearchPK.text = obj[0]; 
               }	
            break;
            case 'RoomM' :
               var path = System.RootURL + '/form/ht/fo/htfo00260_popup.aspx';
               var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtRoomPK.text = obj[0];
                    txtRoomM.text = obj[2]; 
                    txtCustName.text = obj[4]; 
               }
           break;   	
      }
}
function SumAmount()
{
   var toatal=0,TotalPayment=0,AmountNotVat=0,vat_amt=0,service_charge=0,discount_amt=0;
    for(var i=1; i < grdItem.rows;i++)
			{
				if(isNaN(grdItem.GetGridData(i, 9))){i = grdItem.rows; alert("Quantity require is number!");return false;}
				grdItem.SetGridText(i, 10,(grdItem.GetGridData(i, 7)*(grdItem.GetGridData(i, 9))));
				if ( grdItem.GetGridData( i, 10) != '' )
				{
					toatal=System.Round(toatal+Number(grdItem.GetGridData(i, 10)),2);
				}
			}
			
			service_charge	=	System.Round((Number(toatal)*0.05),2);

			AmountNotVat	=	System.Round((Number(toatal)*0.105),2);

			discount_amt	= 	System.Round((((toatal+service_charge+AmountNotVat)*Number(txtDiscount.text))/100),2);//text discount
			

            TotalPayment=(System.Round((Number(toatal) +Number(service_charge)+ Number(AmountNotVat)),2)-discount_amt); 
			
			txtServiceCharge.SetDataText(""+ service_charge);
			txtDiscountAmt.SetDataText(""+ discount_amt);
            txtTotal.SetDataText(""+ toatal);
            txtPayment.SetDataText(""+ TotalPayment);
            txtVatAmt.SetDataText(""+ AmountNotVat);
}
function ChangeCurrency()
{
    SumAmount();
}
function OnDiscount()
{
	SumAmount();
}

function OnReportClick()
{
    if ( txtMasterPK.text != ''  )
	{
		var url =System.RootURL + '/reports/ht/fo/rpt_htfo00260.aspx?tcm_invoice_pk='+ txtMasterPK.text ;
		window.open(url);    
	}
}

</script>

<body>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htfo00260_searchM" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="ht_sel_htfo00260_searchM" > 
                <input bind="grdSearch" > 
                     <input bind="dtFromDate" /> 
                     <input bind="dtToDate" /> 
                     <input bind="txtInvoiceNo" /> 
                     <input bind="txtRoomSearchPK" /> 
                     <inout bind="lstPOINT"/>
                     <input bind="chkConfirm" /> 
                 </input> 
                <output bind="grdSearch" />   
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htfo00261" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="crm.sp_sel_htfo00261" procedure="crm.sp_upd_htfo00260" > 
                <inout> 
                     <inout bind="txtMasterPK" /> 
                     <inout bind="txtSlipNo" /> 
                     <inout bind="dtDate" />
                     <inout bind="txtRoomPK" />
                     <inout bind="txtTotal"/>
                     <inout bind="txtPayment"/>
                     <inout bind="lstVat"/>
                     <inout bind="txtVatAmt"/>
                     <inout bind="PAYED_YN"/>
                     <inout bind="CONFIRM_YN"/>
                     <inout bind="lstPOINT"/>
                     <inout bind="txtDescription" />
					 <inout bind="txtServiceCharge" />
                     <inout bind="txtDiscount"/>
					 <inout bind="txtDiscountAmt"/>
					 <inout bind="txtCustName" />
					 <inout bind="txtGuestQty"/>
                     <inout bind="txtCreatorVotes" />
                     <inout bind="lstCurrency"/>
                     <inout bind="txtTotal"/>
                     <inout bind="txtRoomM"/>
                </inout> 
             </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htfo00260" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_htfo00260"> 
                <input bind="grdMenu" > 
                     <input bind="lstItemGroup" /> 
                     <input bind="txtItem" />
                </input> 
                <output bind="grdMenu" />  
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htfo00262" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="CRM.sp_sel_htfo00262"  procedure="crm.sp_upd_htfo00262" > 
                <input> 
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
	<gw:data id="dso_htfo00263" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso type="list" procedure="crm.sp_sel_htfo00263" > 
				<input>
					 <input bind="lstPOINT" /> 
				</input> 
				<output> 
					<output bind="lstItemGroup"/>
				</output>
			</dso> 
		</xml> 
	</gw:data>
	<!---------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 15%" valign="top">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Date
                        </td>
                        <td style="width: 90%; white-space: nowrap">
                            <gw:datebox id="dtFromDate" lang="1" />
                            ~
                            <gw:datebox id="dtToDate" lang="1" />
                        </td>
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnSearch1" img="search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 25%; white-space: nowrap">
                            Invoice No
                        </td>
                        <td colspan="2">
                            <gw:textbox id="txtInvoiceNo" styles="width:100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%" nowrap>
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('RoomSearch')">Room</b>
                        </td>
                        <td style="width: 90%; white-space: nowrap" colspan="2">
                            <gw:textbox id="txtRoomSearch" styles="width:100%" readonly="true" />
                            <!--<gw:list id="lstLineGroup" styles="width: 100%" onchange="OnSearch('grdSearch')" />-->
                        </td>
                    </tr>
					<tr style="height: 1%">
                        <td align="right" style="width: 10%" nowrap>Confirm Y/N</b>
                        </td>
                        <td style="width: 90%; white-space: nowrap" colspan="2">
							<gw:checkbox id="chkConfirm" mode="01" value='-1' onchange="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Date|Invoice No|Room" format="0|4|0|0" aligns="0|0|0|0"
                                defaults="||||" editcol="0|0|0|0" widths="0|1500|1200|1000" styles="width:100%; height:100%"
                                autosize="T" sorting="T" acceptnulldate="true" oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 85%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 7%; white-space: nowrap" align="right"><b>Invoice No</b></td>
                        <td style="width: 17%"><gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%" readonly="true" /></td>
                        <td style="width: 5%" align="center"><b>Date</b></td>
                        <td style="width: 10%"><gw:datebox id="dtDate" lang="1" /></td>
                        <td style="width: 10%" align="right" nowrap>Creator votes</td>
                        <td style="width: 25%"><gw:textbox id="txtCreatorVotes" styles='width:100%' readonly="true" /></td>
                        <td style="width: 5%"></td>
                        <td style="width: 1%" align="right"><gw:imgbtn id="btnNew" img="new" alt="New Take Out Goods" text="Add" onclick="OnAddNew()" /></td>
                        <td style="width: 1%" align="right"><gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" /></td>
                        <td style="width: 1%" align="right"><gw:imgbtn id="btnUpdate" img="save" alt="Save" text="Save" onclick="OnSave()" /></td>
                        <td style="width: 1%" align="right"><gw:imgbtn id="btnReport" img="excel" alt="Print" text="Print" onclick="OnReportClick()" /></td>
						<td style="width: 1%" align="right"><gw:icon id="btnConfirm" alt="Collector" text="Collector" onclick="OnSend('1');" /></td>
						<td style="width: 1%" align="right"><gw:icon id="btnSendBill" alt="SendBill" text="Send" onclick="OnSend('2');" /></td>
                    </tr>
                    <tr style="height: 1%">                        
                        <td align="right"><b>Point</b></td>
                        <td colspan="3"><gw:list id="lstPOINT" styles='width:100%' onchange="OnChangePoint();" /></td>
                        <td align="right">Total</td>
                        <td colspan="1"><gw:textbox id="txtTotal" styles='width:100%' type="number" format="###,###,###,###.##" readonly="true" /></td>
                        <td colspan="3" align="right">Currency</td>
                        <td colspan="4"><gw:list id="lstCurrency" styles='width:100%' /></td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right"><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('RoomM')">Room</b></td>
                        <td colspan="1"><gw:textbox id="txtRoomM" styles="width:100%" readonly="true" /></td>
						<td nowrap>Guest Qty</td>
						<td colspan="1"><gw:textbox id="txtGuestQty" styles="width:100%"  type="number" format="###"/></td>
						<td align="right"><b>SVC(5%)</b></td>
                        <td align="left"><gw:textbox id="txtServiceCharge" styles='width:100%' type="number" format="###,###,###,###.##" readonly="true" /></td>
                        <td colspan="3" align="right">VAT</td>
                        <td colspan="4"><gw:list id="lstVat" styles='width:100%' onchange="ChangeCurrency()" /></td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">Customer</td>
                        <td colspan="3"><gw:textbox id="txtCustName" styles='width:100%' /></td>
                         <td align="right">VAT.Amt</td>
                        <td><gw:textbox id="txtVatAmt" type="number" format="###,###,###,###.##" styles='width:100%' readonly="true" /></td>
                        <td colspan="3" align="right"><b>Discount</b></td>
                        <td colspan="4" align="left"><gw:textbox id="txtDiscount" styles='width:90%' type="number" format="###" onenterkey="OnDiscount()" /><gw:textbox id="txtPercent" readonly="true" text="%" styles='width:10%' /></td>
                    </tr>
					<tr style="height: 1%">
                        <td align="right">Description</td>
                        <td colspan="5"><gw:textbox id="txtDescription" styles='width:100%'  /></td>
						<td></td>
						<td></td>
                        <td align="right"><b>Payment</b></td>
                        <td align="left" colspan="5"><gw:textbox id="txtPayment" type="number" format="###,###,###,###.##" styles='width:100%' readonly="true" /></td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="14">
                            <fieldset>
                                <table style="width: 100%; height: 100%">
                                    <tr style="height: 1%">
                                        <td style="width: 10%; white-space: nowrap" align="left">
                                            <!--<img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                            style="cursor: hand" onclick="OnToggleGrid()" />-->
                                        </td>
                                        <td style="width: 30%">
                                        </td>
                                        <td style="width: 10%" align="right">
                                        </td>
                                        <td style="width: 20%">
                                        </td>
                                        <td style="width: 20%">
                                        </td>
                                        <td style="width: 5%">
                                        </td>
                                        <td style="width: 1%" align="left">
                                        </td>
                                        <td style="width: 1%" align="right">
                                        </td>
                                        <td style="width: 1%" align="right">
                                        </td>
                                        <td style="width: 1%" align="right">
                                            <gw:imgbtn id="btnDelete_1" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                        </td>
                                        <td style="width: 1%" align="right">
                                            <!--<gw:imgbtn id="btnUnDelete_1" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />-->
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 42%">
                        <td colspan="14">
                            <gw:grid 	id='grdItem' 
										header='_PK|_THT_INVOICE_PK|_TCO_ITEM_PK|Item Code|Item Name|Item Group|Unit|Price|Currency|Quantity|Amount|Description'
										format='0|0|0|0|0|0|0|-2|0|-2|-2|0' 
										aligns='0|0|0|0|0|0|0|3|0|3|3|0' 
										defaults='|||||||||||'
										editcol='0|0|0|0|0|0|0|0|0|1|0|1' 
										widths='1000|1000|1000|1000|1000|1100|1000|1000|1000|1000|1000|1000'
										autosize="T" 
										sorting='F' 
										acceptnulldate="T" 
										check="|||||||||0-||" 
										styles="width:100%;height:100%" 
										onKeyPressEdit="AmountSum()"  
							/>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="14">
                            <fieldset>
                                <table style="width: 100%; height: 100%">
                                    <tr style="height: 1%">
                                        <td style="width: 18%">
                                            Item Group
                                        </td>
                                        <td style="width: 30%">
                                            <gw:list id="lstItemGroup" styles="width: 100%" onchange="OnSearch('grdSearchItem')" />
                                        </td>
                                        <td style="width: 3%" align="right">
                                            Item
                                        </td>
                                        <td style="width: 30%" align="right">
                                            <gw:textbox id="txtItem" onenterkey="OnSearch('grdSearchItem')" styles='width:100%' />
                                        </td>
                                        <td style="width: 3%" align="right">
                                        </td>
                                        <td style="width: 3%" align="right">
                                        </td>
                                        <td style="width: 3%" align="right">
                                            <gw:imgbtn id="btnSearchItem" img="search" onclick="OnSearch('grdSearchItem')" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 43%">
                        <td colspan="14">
                            <gw:grid 	id				='grdMenu' 
										header			='_PK|Item Code|Item Name|Item Group|Unit|Price|Currency|_Quantity|_Amount|Description'
										format			='0|0|0|0|0|-2|0|0|0|0' 
										aligns			='0|0|0|0|0|3|0|3|3|0' 
										defaults		='|||||||||' 
										editcol			='0|0|0|0|0|0|0|0|0|0'
										widths			='1000|1000|1000|1000|1000|1100|1000|1000|1000|1000' autosize="T" sorting='T' acceptnulldate="T"
										styles			="width:100%;height:100%" 
										oncelldblclick	="OnGridCellDoubleClick(this)" 
							/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!-------------------------------------------------------------->
    <gw:textbox id="txtDiscountAmt" styles='width:100%;display:none' />
	<gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtRoomSearchPK" styles='width:100%;display:none' />
    <gw:textbox id="txtRoomPK" styles='width:100%;display:none' />
    <gw:textbox id="CONFIRM_YN" styles='width:100%;display:none' text='N' />
    <gw:textbox id="PAYED_YN" styles='width:100%;display:none' text='N'/>
    <!-------------------------------------------------------------->
</body>
</html>
