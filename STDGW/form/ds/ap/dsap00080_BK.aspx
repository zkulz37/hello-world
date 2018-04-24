<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Collection Slip Entry</title>
</head>
<script>

var p_update = 0;
//-------------------REQ--------------------------------------
var G0_PARTNER_PK 	= 0,
    G0_PARTNER_ID   = 1, 
    G0_PARTNER_NAME = 2, 
    G0_TOTAL_AMT   	= 3, 
    G0_PAY_AMT      = 4, 
    G0_BAL_AMT      = 5,     
    G0_CCY          = 6;
	
//-------------------PAY------------grdPayment--------------------------
var G1_Payment_Pk   = 0,
    G1_Pay_Date     = 1,
    G1_BillTo_Pk    = 2,
    G1_BillTo_Nm    = 3,
    G1_Pay_Amt      = 4,
    G1_Deduct_Amt   = 5,
    G1_Total_Amt    = 6,
    G1_CCY          = 7,
    G1_Description  = 8;
    
//-------------------PAY DETAIL-------------------------------
 var 
    G2_Payment_D_Pk    = 0,
    G2_Payment_Pk      = 1,
    G2_Request_M_Pk    = 2,
    G2_Req_DT          = 3,
    G2_Req_No          = 4,
    G2_Req_Desc        = 5,
    G2_Total_Amt       = 6,
    G2_Paid_Amt        = 7,
    G2_UnPaid_Amt      = 8,
    G2_Checked         = 9,
    G2_Deduct_Amt      = 10,
    G2_Pay_Amt         = 11,
    G2_Total_Pay       = 12, 
    G2_Description     = 13; 
 
 var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
 var  user_name  = "<%=Session("USER_NAME")%>" ;
 //=================================================================================
 function BodyInit()
 {
        System.Translate(document); 
     	dtCollectFrom.SetDataText(dtCollectTo.value.substr(0,6)+'01')
    	dtTo.SetDataText(System.AddDate(dtFrom.GetData(),15)); 
		//------------------
    	BindingDataList();
    	OnChgOption();
  		//------------------
  }
 //=================================================================================
function BindingDataList()
{
     var data = "";    
 
	 data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCurrency.SetDataText(data);
     lstCurrency.value = "USD";
		        
     txtCollectReqPara.SetDataText('DATA|2|Total Payable >=|1|Unpaid >=||');
     txtCollectReqPara.value = '0';     
        
}
 //=================================================================================
function OnPopUp(pos, col)
 {
      switch (pos)         
      {		        
        case 'BILLTO' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	         
	            txtBillPK.text   = object[0];
                txtBillTo.text = object[1] +' - ' + object[2];                                                        
	         }
	    break;
	    
	    case 'BILLTO_S' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	         
	            txtCustReq.text = object[2];                                                        
	         }
	    break;
	         
	    case 'EMP' :             
                 var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
	             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( obj != null )
	             {
	                txtChargerPK.text = obj[0];
	                txtChargerName.text = obj[2];
                 }	
	    break;
	         
	   }
}
//--------------------------------------------------------
function OnNewPayment()
{
    if(txt_P_BillPK.text != "")
    {
    data_dsap00080_2.StatusInsert()
    txtSlipNo.text = ("**New Slip No**")
    
    txtBillPK.text = grdCollectReq.GetGridData(grdCollectReq.row,G0_PARTNER_PK);
    txtBillTo.text = grdCollectReq.GetGridData(grdCollectReq.row,G0_PARTNER_NAME);
    txtChargerPK.text = user_pk
    txtChargerName.text = user_name
    
    lstCurrency.value =  grdCollectReq.GetGridData(grdCollectReq.row,G0_CCY);
    chkEdit.value ='Y'
    
    data_dsap00080_3.Call('SELECT')
    
    }else
    {
        alert("Please, select one Supplier to make new payment slip!");
    }
    
}
//---------------------------------------------------------
function OnSaveData(obj)
{
    switch(obj)
    {
        case 'MASTER':
             p_update = 1;
            data_dsap00080_2.Call()
        break;
        
        case 'DETAIL':
            SetParentPKtoGrid()
            data_dsap00080_3.Call()
        break;
    }
}
//---------------------------------------------------------
function OnSearch(obj)
{
    switch(obj)
    {
        case 'COLLECT_REQ':
            data_dsap00080.Call('SELECT');
        break;
        
        case 'PAID':
           if( grdCollectReq.row >0)
           {
            txt_P_BillPK.text = grdCollectReq.GetGridData(grdCollectReq.row,G0_PARTNER_PK);
            if(txt_P_BillPK.text != "")
            {
                data_dsap00080_1.Call('SELECT')
            }else
            {
                alert("Please, select one customer!")
            }
           }else
           {
              alert("Please, select one customer!")
           }
        break; 
        
        case 'MASTER':
            p_update = 0;
            txtPaymentPK.text  = grdPayment.GetGridData(grdPayment.row,G1_Payment_Pk) 
            chkEdit.value ='N'
            data_dsap00080_2.Call('SELECT')            
        break;
        
        case 'DETAIL':
            data_dsap00080_3.Call('SELECT')
        break;       
    }
}
//---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsap00080':
            if(grdCollectReq.rows >1)
            {
            grdCollectReq.SetCellBold( 1, G0_PARTNER_NAME, grdCollectReq.rows - 1, G0_PARTNER_NAME, true);
            grdCollectReq.SetCellBgColor( 1, G0_PARTNER_NAME , grdCollectReq.rows - 1, G0_PARTNER_NAME , 0xCCFFFF );
            
            grdCollectReq.SetCellBold( 1, G0_BAL_AMT, grdCollectReq.rows - 1, G0_PrePaid, true);
            grdCollectReq.SetCellBgColor( 1, G0_BAL_AMT , grdCollectReq.rows - 1, G0_PrePaid , 0xCCFFFF );
            }
        break;
        case 'data_dsap00080_2':
            if(p_update==1)
            {
               chkEdit.value ='N'
               OnSaveData('DETAIL')                
            }else
            {
                data_dsap00080_3.Call('SELECT')
            }
        break;
        case 'data_dsap00080_3':
            OnEditStatus()
        break;
    }
}
//------------------------------------------------------------------
function OnAfterGridInput()
{
      var v_col = event.col
      var v_row = event.row
      
      var pay_amt, deduct_amt

      if(radTab.value==1)
      {
       //---------------------------
        if(v_col==G2_Checked)
        {       
             
            if(grdPayDetail.GetGridData(v_row,G2_Checked)== -1 && Number(grdPayDetail.GetGridData(v_row,G2_Total_Pay))==0 )
            {
                grdPayDetail.SetGridText(v_row,G2_Pay_Amt,grdPayDetail.GetGridData(v_row,G2_UnPaid_Amt))
                grdPayDetail.SetGridText(v_row,G2_Total_Pay,grdPayDetail.GetGridData(v_row,G2_UnPaid_Amt))                
            } else
            {
                if(grdPayDetail.GetGridData(v_row,G2_Checked)== 0)
                {
                      grdPayDetail.SetGridText(v_row,G2_Pay_Amt,"")
                      grdPayDetail.SetGridText(v_row,G2_Total_Pay,"") 
                }
                
            }                      
            
        }   
        //-------------------------------     
        if( v_col== G2_Deduct_Amt || v_col== G2_Pay_Amt )
        {
            pay_amt = Number(grdPayDetail.GetGridData(v_row,G2_Pay_Amt))
            deduct_amt = Number(grdPayDetail.GetGridData(v_row,G2_Deduct_Amt))
            
            grdPayDetail.SetGridText(v_row,G2_Total_Pay, pay_amt + deduct_amt)     
        }
        //----------------------Sum-----------------------------
        pay_amt = 0, deduct_amt = 0, total_amt =0
        for(var i=1 ; i<grdPayDetail.rows; i++ )
            {
                pay_amt = pay_amt + Number(grdPayDetail.GetGridData(i,G2_Pay_Amt))
                deduct_amt = deduct_amt + Number(grdPayDetail.GetGridData(i,G2_Deduct_Amt))                
            }
        
        txtTotalPay.text = deduct_amt + pay_amt
        txtPaymentQty.text = pay_amt
        txtDeduct.text = deduct_amt        
      
        
      }
}
//------------------------------------------------------------------
function OnDataAutoMap()
{
    var set_value = 0, unpaid_amt = 0, next_row = 1
    
    //---------------------Set Deduct----------------------         
       
        set_value = Number(txtDeduct.text);
         
            for(var i=1 ; i<grdPayDetail.rows; i++ )
            {
                 next_row = i;
                unpaid_amt = Number(grdPayDetail.GetGridData(i,G2_UnPaid_Amt))
                if (unpaid_amt < set_value)
                {
                    grdPayDetail.SetGridText(i,G2_Deduct_Amt,unpaid_amt);
                    grdPayDetail.SetGridText(i,G2_Pay_Amt,0);
                    grdPayDetail.SetGridText(i,G2_Total_Pay,unpaid_amt);
                    set_value = set_value - unpaid_amt;
                    
                }else
                {
                    grdPayDetail.SetGridText(i,G2_Deduct_Amt,set_value);
                    grdPayDetail.SetGridText(i,G2_Pay_Amt,0);
                    grdPayDetail.SetGridText(i,G2_Total_Pay,set_value);
                    set_value = 0;
                    break;
                }
               
            }
          //----------------Set Pay--------------------
              set_value = Number(txtPaymentQty.text);
      
              for(var i=next_row ; i<grdPayDetail.rows; i++ )
                {
                    unpaid_amt = Number(grdPayDetail.GetGridData(i,G2_UnPaid_Amt)) - Number(grdPayDetail.GetGridData(i,G2_Deduct_Amt)) 
                    
                    if (unpaid_amt < set_value)
                    {
                        grdPayDetail.SetGridText(i,G2_Pay_Amt,unpaid_amt);
                        grdPayDetail.SetGridText(i,G2_Total_Pay,unpaid_amt + Number(grdPayDetail.GetGridData(i,G2_Deduct_Amt)));
                     
                        set_value = set_value - unpaid_amt;
                        
                    }else
                    {
                        grdPayDetail.SetGridText(i,G2_Pay_Amt,set_value);
                        grdPayDetail.SetGridText(i,G2_Total_Pay,unpaid_amt + Number(grdPayDetail.GetGridData(i,G2_Deduct_Amt)));
                        
                        set_value = 0;
                        break;
                    }
                   
                }
           
         txtTotalPay.text = Number(txtDeduct.text) +Number(txtPaymentQty.text)
    
}
//------------------------------------------------------------------
 function SetParentPKtoGrid()
 {
        for ( i = 1; i < grdPayDetail.rows ; i++ )
        {
            var v_value1, v_value2
            v_value1 = grdPayDetail.GetGridData(i,G2_Deduct_Amt)
            v_value2 = grdPayDetail.GetGridData(i,G2_Pay_Amt)
            
            if (Number(v_value1) != 0 || Number(v_value2) != 0)
            {
                if ( grdPayDetail.GetGridData(i,G2_Payment_Pk) == "" )
                {
                    grdPayDetail.SetGridText( i ,G2_Payment_Pk , txtPaymentPK.text ) ;
                }
            }
        }
 }
  
//---------------------------Edit payment------------------------------
function OnEditStatus()
{
    if(chkEdit.value =='Y')
    {
        dtFrom.SetEnable(true);
        dtTo.SetEnable(true);
        
         grdPayDetail.GetGridControl().ColHidden(G2_Total_Amt)          = false ;
         grdPayDetail.GetGridControl().ColHidden(G2_Paid_Amt)          = false ;
         grdPayDetail.GetGridControl().ColHidden(G2_UnPaid_Amt)          = false ;
         grdPayDetail.GetGridControl().ColHidden(G2_Checked)          = false ;
         
         if(grdPayDetail.rows >1)
         {
            grdPayDetail.SetCellBold( 1, G2_Deduct_Amt, grdPayDetail.rows - 1, G2_Total_Pay, true);         
            grdPayDetail.SetCellBgColor( 1, G2_Deduct_Amt , grdPayDetail.rows - 1, G2_Total_Pay , 0xCCFFFF );
         }
    }else
    {
        dtFrom.SetEnable(false);
        dtTo.SetEnable(false);
         
         grdPayDetail.GetGridControl().ColHidden(G2_Total_Amt)          = true ;
         grdPayDetail.GetGridControl().ColHidden(G2_Paid_Amt)          = true ;
         grdPayDetail.GetGridControl().ColHidden(G2_UnPaid_Amt)          = true ;
         grdPayDetail.GetGridControl().ColHidden(G2_Checked)          = true ;
       
         if(grdPayDetail.rows>1)
         {
            grdPayDetail.SetCellBold( 1, G2_Deduct_Amt, grdPayDetail.rows - 1, G2_Total_Pay, true);
            grdPayDetail.SetCellBgColor( 1, G2_Deduct_Amt , grdPayDetail.rows - 1, G2_Total_Pay , 0xCCFFFF );
         }
    }
}
//==========================================================================================

function OnChgOption()
{ 
    var strRad = radTab.GetData();
         
	switch (strRad)
	{
		case '1'://manual select request				    			
            lblInstr.text = "Select Request on Grid Detail to make Payment slip for !"		    
        break;
		
        case '2'://stock avaliable
			lblInstr.text = "Input Pay Amt or Deduct Amt for Payment slip!"
        break;
     }
     
}

//---------------------------Toggle----------------------------------
 function OnToggle(obj)
 {
    switch(obj)
    {
     case 'L-R': //left-right
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
            right.style.width="60%";
            imgArrow.src = "../../../system/images/prev_orange.gif";
        }
    
    break;
    case 'U-D'://up - down
        if(imgUp.status == "expand")
        {
            m_top.style.display="none";       
            imgUp.status = "collapse";
            m_down.style.height="65%";
            imgUp.src = "../../../system/images/down.gif";
        }
         else
        {
            m_top.style.display="";
            imgUp.status = "expand";
            m_down.style.height="35%";
            imgUp.src = "../../../system/images/up.gif";
        }
    break;    
    }
    
 }

</script>

<body>
    
   <!--------------------------------REQ------------------------------------->
    <gw:data id="data_dsap00080" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsap00080"  >
                <input bind="grdCollectReq" >
				    <input bind="txtCustReq" />			        	      
				    <input bind="txtCollectReqPara" />			        	      
				    <input bind="txtCollectReqValue" />			        	      
                </input>
                <output bind="grdCollectReq" />
            </dso>
        </xml>
    </gw:data>    
     <!----------------------------------PAY----------------------------------->
    <gw:data id="data_dsap00080_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsap00080_1"  >
                <input bind="grdPayment" >
				    <input bind="txt_P_BillPK" />			        	      
				    <input bind="dtCollectFrom" />			        	      
				    <input bind="dtCollectTo" />		
				    <input bind="txtPayNo" />			        	      
                </input>
                <output bind="grdPayment" />
            </dso>
        </xml>
    </gw:data>  
       <!--------------------------------------------------------------------->
   <gw:data id="data_dsap00080_2" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="control"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="<%=l_user%>lg_SEL_dsap00080_2" procedure="<%=l_user%>lg_UPD_dsap00080_2" >
                <inout>
				    <inout bind="txtPaymentPK" />    
				    <inout bind="txtSlipNo" /> 
				    <inout bind="dtPaymentDT" /> 
				    
				    <inout bind="txtBillPK" /> 
				    <inout bind="txtBillTo" /> 				    
				    <inout bind="txtChargerPK" /> 
				    <inout bind="txtChargerName" /> 
				    
				    <inout bind="lstCurrency" />
				    				    
				    <inout bind="txtPaymentQty" /> 				    
				    <inout bind="txtDeduct" /> 
				    <inout bind="txtTotalPay" /> 				    
				    <inout bind="txtPrepay" /> 
				    <inout bind="txtDesc" /> 
                </inout>
            </dso>
        </xml>
    </gw:data>  
    <!--------------------------------Pay detail------------------------------------->
    <gw:data id="data_dsap00080_3" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsap00080_3" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" procedure="<%=l_user%>lg_UPD_dsap00080_3">
                <input bind="grdPayDetail" >
				    <input bind="txtPaymentPK" />
			        <input bind="txtBillPK" />
			        <input bind="dtFrom" />
			        <input bind="dtTo" />
			        <input bind="txtReqNo" />  
			        <input bind="chkEdit" />			       	      
                </input>
                <output bind="grdPayDetail" />
            </dso>
        </xml>
    </gw:data>
   <!--------------------------------------------------------------------------------------------> 
    <table style="width: 100%; height: 100%" > 
        <tr>
            <td style="width:40%" id="left">
                 <fieldset style=" width:100%; height:95%">
                    <legend><font color="gray" size="1" style="vertical-align:bottom">* RECEIVABLE LIST</font></legend>
                    <table style="width: 100%; height: 100%"  >                               
                        <tr style="height:5%">                                 
                            <td style="width: 10%; white-space: nowrap" align="right">                                
                                Customer
							</td>
                            <td style="width: 50%" colspan="3">
                                <gw:textbox id="txtCustReq" maxlen="100" styles='width:100%' />
                            </td> 
                            <td style="width: 1%">
                                <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('COLLECT_REQ')" />
                            </td> 
                        </tr>                                   
                        <tr style="height:5%">
                            <td style="width: 10%; white-space: nowrap" align="right">
                                Pay Amt
                            </td>
                            <td style="width: 20%">
                                <gw:list id="txtCollectReqPara" styles='width:100%;' /> 
                            </td>
                            <td style="width: 30%" colspan="2" >
                                <gw:textbox id="txtCollectReqValue" maxlen="100" styles='width:100%' onenterkey="OnSearch('COLLECT_REQ')" />
                            </td> 
                            <td style="width: 1%">                                 
                            </td>    
                        </tr>                              
                        <tr style="height:90%">
                               <td colspan="6">                                           
                                    <gw:grid id='grdCollectReq'
                                        header='_PARTNER_PK|Partner ID|Partner Name|Total Amt|Pay Amt|Balance Amt|CCY'
                                        format='0|0|0|0|0|0|0'
                                        aligns='0|0|0|0|0|0|0'
                                        check='||||||'
                                        editcol='0|0|0|0|0|0|0'
                                        widths='0|1500|2500|1500|1500|1500|800'
                                        styles='width:100%; height:100%'                                         
                                      />                                                       
                                </td>
                        </tr>
                    </table>
                </fieldset> 
            </td>
            <td style="width:60%" id="right" >
				<fieldset style=" width:100%; height:95%">
                    <legend><font color="gray" size="1" style="vertical-align:bottom">* COLLECTION SLIP</font></legend>			                 
                         <table style="width: 100%; height: 100%">
                                <tr style="height:20%">
                                     <td style="width: 5%; white-space: nowrap" align="right">
                                        Slip Date
                                        <gw:datebox id="dtCollectFrom" lang="<%=Application("Lang")%>" mode="01" />
                                        ~
                                        <gw:datebox id="dtCollectTo" lang="<%=Application("Lang")%>" mode="01" />
                                        
                                    </td>                        
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        Slip No
                                    </td>
                                    <td style="width:30%">
                                        <gw:textbox id="txtPayNo" maxlen="100" styles='width:100%' onenterkey="OnSearch('PAID')" />
                                        <gw:textbox id="txt_P_BillPK" maxlen="100" styles='width:100%; display:none'  />
                                    </td>
                                    
                                    <td style="width:20%">
                                        
                                    </td>
                                    
                                    <td style="width:10%">
                                        <gw:imgbtn id="btnSearchM"  img="search" alt="Search Payment" onclick="OnSearch('PAID')" />
                                    </td>                   
                                     
                                </tr>
                                <tr style="height:80%">
                                    <td colspan=7>                                         
                                        <gw:grid id='grdPayment'
                                            header='_PK|Pay Date|_TCO_BUSPARTNER_PK|Partner|Pay Amt|Deduct Amt|Total Pay|CCY|Description'
                                            format='0|4|0|0|-2|-2|-2|0|0'
                                            aligns='0|0|0|0|0|0|0|0|0'
                                            check='||||||||'
                                            editcol='1|1|1|1|1|1|1|3|1'
                                            widths='0|0|0|2000|1500|1500|1500|800|2000'
                                            sorting='T'
                                            autosize='T' 
                                            oncellclick='OnSearch("MASTER")'
                                            styles='width:100%; height:100%'
                                            />                                        
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>                    
                    <tr style="height:30%" >
                        <td>
                              <table style="width: 100%; height: 100%" cellpadding="1"; cellspacing="0" >
                                <tr>
                                    <td style="width:1%">
                                         <img status="expand" id="imgUp" alt="Hide Payment List" src="../../../system/images/up.gif"
                                         style="cursor: hand" onclick="OnToggle('U-D')" />
                                    </td>                                    
                                    <td style="width:10%">
                                    </td>
                                    <td style="width:74%"  colspan="5" > 
                                        <gw:label id="lblInstr" styles="color:teal;font-weight:bold" />
                                    </td>                               
                                         
                                    <td style="width: 2%">
                                        <gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnNewPayment()" />
                                    </td>
                                    
                                    <td style="width: 2%">
                                        <gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete('Master')" />
                                    </td>
                                    <td style="width: 2%">
                                        <gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSaveData('MASTER')" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 11%; white-space: nowrap" align="right" colspan='2'>
                                        Slip No
                                    </td>
                                    <td style="width: 20%"  > 
                                         <gw:textbox id="txtSlipNo" maxlen="100" styles='width:100%' csstype="mandatory" />
                                         <gw:textbox id="txtPaymentPK"  styles='width:100%;display:none'  />
                                    </td>   
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Pay. DT
                                    </td>
                                    <td style="width: 20%"> 
                                         <gw:datebox id="dtPaymentDT" lang="<%=Application("Lang")%>" mode="01" />
                                    </td>                                 
                                </tr>
                                
                                <tr>
                                    <td style="width: 11%; white-space: nowrap" align="right" colspan="2">
                                        <a title="Supplier" onclick="OnPopUp('BILLTO')" href="#tips" style="color: #0000ff">
                                                Supplier</a></td>
                                    <td style="width:50%" colspan="3">
                                        <gw:textbox id="txtBillPK" maxlen="100" styles='width:100%; display:none'  />
                                        <gw:textbox id="txtBillTo" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdPO')" />
                                    </td>
                                     <td align="right" style="width: 10%" >    
                                        CCY
                                    </td>
                                     <td style="width:20%; white-space: nowrap"  align="right"  colspan="4">
                                         <gw:list id="lstCurrency" styles='width:100%;' /> 
                                    </td> 
                                </tr>
                                 <tr>
                                    <td style="width: 11%; white-space: nowrap" align="right" colspan="2">Description
                                    </td>
                                    <td style="width:89%" colspan="8">
                                        <gw:textbox id="txtDesc" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdPO')"  />
                                    </td>
                                     
                                </tr>     
                                <tr>
                                   
                                    <td style="width: 11%; white-space: nowrap" align="right" colspan="2">
                                        <a title="Supplier" onclick="OnPopUp('EMP')" href="#tips" style="color: #0000ff">
                                                Charger</a></td>
                                    <td style="width:50%" colspan="3" >
                                        <gw:textbox id="txtChargerPK" maxlen="100" styles='width:100%; display:none'  />
                                        <gw:textbox id="txtChargerName" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdPO')" />
                                    </td> 
                                    
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Receivable
                                    </td>
                                    <td style="width: 20%"  colspan='4'> 
                                         <gw:textbox id="txtPrepay" maxlen="100" styles='width:100%' type="number"
                                            format="###,###,###.##R" onenterkey="OnSearch('grdPO')"  />
                                    </td>
                                   
                                </tr>       
                                 <tr>
                                    <td style="width: 11%; white-space: nowrap" align="right" colspan='2'>Deduct
                                    </td>
                                     <td style="width:20%; white-space: nowrap"   align="right">
                                        <gw:textbox id="txtDeduct" maxlen="100" styles='width:100%' type="number"
                                            format="###,###,###.##R"  onenterkey="OnDataAutoMap()"  />
                                    </td>                                    
                                    <td style="width: 10%" align='center'  align="right">
                                        Pay Amt
                                    </td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtPaymentQty"  styles='width:100%' type="number"
                                            format="###,###,###.##R" onenterkey="OnDataAutoMap()"/>
                                    </td>
                                     <td style="width: 10%; white-space: nowrap" align="right">Total Pay.
                                    </td>
                                    <td style="width: 20%"   colspan='4'>
                                        <gw:textbox id="txtTotalPay"  styles='width:100%' type="number"
                                            format="###,###,###.##R"  />
                                    </td>  
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height:35%" id="m_down">
                        <td>
                            <table style="width: 100%; height: 100%" cellpadding=0; cellspacing=1>
                                <tr style="height:20%">
                                     <td style="width: 40%; white-space: nowrap" align="right">
                                        Req DT
                                        <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />
                                        ~
                                        <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" />
                                        
                                    </td>                        
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Req No
                                    </td>
                                    <td style="width:20%">
                                        <gw:textbox id="txtReqNo" maxlen="100" styles='width:95%' onenterkey="OnSearch('grdPO')" />
                                    </td>
                                    <td style="width:5%">
                                        <gw:imgbtn id="btnSearch"  img="search" alt="Search" onclick="OnSearch('DETAIL')" />
                                    </td>
                                                                       
                                    <td style="width:25%;white-space: nowrap">
                                        <gw:radio id="radTab" value="2" styles="width:100%" onchange="OnChgOption()"> 
                                            <span value="1" id="tab_stock_booking">Select Req</span> 
                                            <span value="2" id="tab_stock_avaiable">Auto </span> 
                                        </gw:radio>
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="center">                                   
                                        <gw:checkbox id="chkEdit" defaultvalue="Y|N" value="N"  onclick="OnSearch('DETAIL')" /> Edit
                                    </td>                                                                
                                </tr>
                                <tr style="height:80%">
                                    <td colspan=7>
                                          <gw:grid id='grdPayDetail'
                                            header='_PAYMENT_SLIP_D_PK|_PAYMENT_SLIP_M_PK|_PC_PAYMENT_REQ_M_PK|Req. Date|Req. No|Req. Desc|Total Amt|Paid Amt|Unpaid Amt|Select|Deduct|Pay Amt|Total Pay|Payment Remark'
                                            format='0|0|0|4|0|0|-2|-2|-2|3|-2|-2|-2|0'
                                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                            check='|||||||||||||'
                                            editcol='0|0|0|0|0|0|0|0|0|0|1|1|0|1'
                                            widths='0|0|0|1200|1500|2000|1500|1500|1500|800|1500|1500|1500|1500'
                                            sorting='T'
                                            autosize='T' 
                                            styles='width:100%; height:100%'     
                                            onafteredit ="OnAfterGridInput()"                                      
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
<!-- <img status="expand" id="imgArrow" alt="Hide Payable List"  src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle('L-R')" /> -->
  <!--------------------------------------------------------------->
    <gw:textbox id="txt_tmp" maxlen="100" styles='width:100%;display:none' />                                  
</body>
</html>
