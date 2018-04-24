<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Nego</title>
    <style type="text/css">
        .style1
        {
            width: 12%;
            height: 23px;
        }
        .style2
        {
            height: 23px;
        }
        .style3
        {
            width: 15%;
            height: 23px;
        }
        .style4
        {
            width: 18%;
            height: 23px;
        }
    </style>
</head>
<script type="text/javascript" language="javascript">

var flag, isLoadBank;
var G_LC_pk = 0;
var rtnLGCode = '' ;

/*var G_DETAIL_PK     = 0,
    G_MASTER_PK     = 1,
    G_ORDER_NO      = 2,
    G_ITEM_PK       = 3,
    G_ITEM_NM       = 4,
    G_UOM           = 5,
    G_QTY           = 6,
    G_UNIT_PRICE    = 7,
    G_AMOUNT        = 8,
    G_REMARK        = 9;*/

var G_MASTER_PK = 0,
    G_DETAIL_PK = 1,
    G_SLIP_NO = 2,
    G_LC_DATE = 3,
    G_LC_NO = 4,
    G_PARTNER_PK = 5,
    G_PARTNER_NAME = 6,
    G_LC_QTY = 7,
    G_LC_AMT = 8,
    G_NEGO_AMT = 9,
    G_LC_BAL = 10,
    G_AR_INVC_DT = 11,
    G_AR_INVC_NO = 12,
    G_AR_INVC_AMT = 13,
    G_AR_LC_MAPPING_AMT = 14,
    G_AR_LC_AMT_BAL = 15,
    G_DELI_NO = 16,
    G_REMARK = 17;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";      
     //-------------------------
     txtChargerNM.SetEnable(false);
     txtNegoQty.SetEnable(false);
     txtNegoAmount.SetEnable(false);
     txtReceivedAmt.SetEnable(false);
     txtBuyerNM.SetEnable(false);
     txtExRecvAmt.SetEnable(false);
     txtSumDeductAmt.SetEnable(false);
     txtSlipNo.SetEnable(false);
     txtAccSlipNo.SetEnable(false);
     //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;  
   //---------------------------- 
    BindingDataList(); 
    OnAddNew('Master');
    OnSearch('grdSearch');
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";     
	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %>";                 
    lstCCY.SetDataText(data); 
    lstCCY.value = 'USD';

    data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
    lstCompany.SetDataText(data);	 
    lstCompany.value= txtCompany_PK.text;	 
       
    data = "DATA|1|SAVED|3|APPROVED|4|CANCEL|5|CANCEL SLIP||"
    lstStatus.SetDataText(data);
    lstStatus.value = "";
          		 
 }
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    right.style.display="";
    imgArrow.status = "collapse";
    left.style.width="25%";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    right.style.display="none";
    imgArrow.status = "expand";
    left.style.width="100%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {             
            case 'LC':
                if(txtBuyerPK.text == ""){ alert("Pls select one buyer");  return}
			    var path = System.RootURL + '/form/kb/lc/kblc00173.aspx?group_type=Y|Y|Y|Y|Y|Y';
                var object = System.OpenModal( path ,1050 , 600 ,  'resizable:yes;status:yes',this);
    	         
	             if ( object != null )
	             {	        
	                var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();

                        grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK, txtMasterPK.text); //master_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G_SLIP_NO, arrTemp[0]); 
                        grdDetail.SetGridText( grdDetail.rows-1, G_LC_DATE, arrTemp[1]);  
                        grdDetail.SetGridText( grdDetail.rows-1, G_LC_NO, arrTemp[2]);  
                        grdDetail.SetGridText( grdDetail.rows-1, G_PARTNER_PK, arrTemp[3]);      
                        grdDetail.SetGridText( grdDetail.rows-1, G_PARTNER_NAME, arrTemp[4]);      
                        grdDetail.SetGridText( grdDetail.rows-1, G_LC_QTY, arrTemp[5])
                        grdDetail.SetGridText( grdDetail.rows-1, G_LC_AMT, arrTemp[6]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G_NEGO_AMT, arrTemp[7]);   

                        grdDetail.SetGridText( grdDetail.rows-1, G_LC_BAL, arrTemp[8]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G_AR_INVC_DT, arrTemp[9]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G_AR_INVC_NO, arrTemp[10]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G_AR_INVC_AMT, arrTemp[11]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G_AR_LC_MAPPING_AMT, arrTemp[12]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G_AR_LC_AMT_BAL, arrTemp[13]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G_DELI_NO, arrTemp[14]);   
                    } 	
                    isLoadBank = "false";
                    pro_kblc00170_3.Call();
	             }                              
            break;    
            case 'BANK':
                 var path = System.RootURL + "/form/kb/lc/kblc00043.aspx?p_ccy=" + lstCCY.value;
	             var object = System.OpenModal( path ,600 , 400 ,  'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {
	                txtBankPK.text          = object[0];
                    txtBankNM.text          = object[4];
                    txtTacAbdepomtPK.text   = object[1];
                    lstCCY.value            = object[2];
                    isLoadBank              = "false";
                    pro_kblc00170_3.Call();
	             }                       
            break; 
            case 'CHARGER':
                var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
                var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

                if ( obj != null )
                {
                    txtChargerNM.text = obj[2];
                    txtChargerPK.text   = obj[0];
                }
            break;
            case 'BUYER':
                 var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                txtBuyerNM.text = object[2];
	                txtBuyerPK.text =  object[0];	                
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
            data_kblc00170_search.Call("SELECT");
        break;
        case 'Master':
            flag = 'view' ;
            txtMasterPK.text  = grdSearch.GetGridData(grdSearch.row, 0);
            data_kblc00170.Call("SELECT");
        break;  
        case 'Detail':
            data_kblc00170_1.Call("SELECT");
        break;
        case 'CCY':
            isLoadBank = "true";
            pro_kblc00170_3.Call();
        break;
    }
}
function OnCheckStatus()
{
    idBtnCopy.SetEnable(false) ;
    if (lblStatus.text == 'SAVED'||lblStatus.text == 'CANCEL')
    {
        idBtnAutoSlip.SetEnable(false) ;
        idBtnApprove.SetEnable(true) ;
        idBtnCancel.SetEnable(false) ;
    }
    else if(lblStatus.text == 'CANCEL SLIP')
    {
        idBtnCopy.SetEnable(false) ;
    }
    else
    { 
        idBtnApprove.SetEnable(false) ;
        if(txtAccSlipNo.text =="")
        {
            idBtnCancel.SetEnable(true) ;
            idBtnAutoSlip.SetEnable(true) ;
            idBtnCancelSlip.SetEnable(false) ;
        }
        else
        {
            idBtnCancel.SetEnable(false) ;
            idBtnAutoSlip.SetEnable(false) ;
            idBtnCancelSlip.SetEnable(true) ;
        }
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'IEBS0010')
             {
                lstBank.SetDataText(txtLGCodeList.text);  
                lstBank.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0120')
             {
                lstTernCondi.SetDataText(txtLGCodeList.text);  
                lstTernCondi.value = rtnLGCode;                      
             }
              
        break;
        case 'data_kblc00170_search':
            lblRecord.text  = ( grdSearch.rows -1 )+ " record(s)."
            idBtnApprove.SetEnable(false) ;
            idBtnCancel.SetEnable(false) ;
            idBtnAutoSlip.SetEnable(false) ;
            idBtnCancelSlip.SetEnable(false) ;
            idBtnCopy.SetEnable(false) ;
            pro_kblc00170_3.Call();
        break;
        case 'data_kblc00170':
            OnCheckStatus();
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i,G_MASTER_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('Detail');   
            } 
        break;
       case 'pro_kblc00170': 
        alert(txtReturnValue.text);
        data_kblc00170.Call('SELECT')
      break;
      
      case 'pro_kblc00170_1':
        alert(txtReturnValue.text);
        data_kblc00170.Call('SELECT')
      break;

      case 'pro_kblc00170_2':
        data_kblc00170.Call('SELECT')
      break;

      case 'pro_kblc00170_3':
        if(isLoadBank == "true")
        {
            txtBankPK.text = "";
            txtBankNM.text = "";
            txtTacAbdepomtPK.text = "";
        }
        OnCalc();
      break;

      case 'pro_kblc00170_4': // copy
        alert(txtReturnValue.text);
        data_kblc00170.Call('SELECT')
      break;

      case 'pro_kblc00170_5':// cancel slip
        data_kblc00170.Call('SELECT')
      break;
    }
}
//====================================================================================

function Validate()
{   
    if(txtLCNO.text =="")
    {
        alert("Please, input L/C No!")
        return false;
    }
    if(txtBankPK.text == "")
    {
        alert("Please, input Bank!")
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
            if(Validate())
            {
                data_kblc00170.Call();
                flag='save';
            }    
        break;
        
        case 'Detail':        
            data_kblc00170_1.Call();
        break;
    }
}
//====================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {   
         case 'Master':
                data_kblc00170.StatusInsert();
                txtSlipNo.text   = '***New Voucher***';
                txtChargerNM.text = "<%=Session("USER_NAME")%>";
                txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";  
                //-------------------------------------------         
                grdDetail.ClearData();
                flag = "view";        
         break;
    }
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00170.StatusDelete();
       OnSave('Master');
    }
 }
 
 function OnDeleteDetail()
 {
      if(confirm('Do you want to delete this Item?'))
      {
          if ( grdDetail.GetGridData( grdDetail.row, G_DETAIL_PK ) == '' )
          {
              grdDetail.RemoveRow();
          }
          else
          {   
              grdDetail.DeleteRow();
          }    
          OnCalc();
      } 
 }
 
 function OnUnDeleteDetail()
 {
     grdDetail.UnDeleteRow();
     OnCalc();
 }
//====================================================================================
function OnCalc()
{
	var nego_qty = 0, nego_amt = 0, qty = 0, unit_price = 0;
	for(var i = 1; i < grdDetail.rows; i++)
	{
        if(grdDetail.GetRowStatus(i) != 80 && grdDetail.GetRowStatus(i) != 64)
        {
	        //qty = Number(grdDetail.GetGridData(i, G_QTY));
	        //unit_price = Number(grdDetail.GetGridData(i, G_UNIT_PRICE));
	        //grdDetail.SetGridText( i,G_AMOUNT, qty * unit_price);
    	    
		    nego_qty += Number(grdDetail.GetGridData(i, G_LC_QTY));
		    nego_amt += Number(grdDetail.GetGridData(i, G_NEGO_AMT));
        }		    
	}
	txtNegoQty.text = nego_qty;
    txtNegoAmount.text = nego_amt;

	txtSumDeductAmt.text = Number(txtCommission.text) + Number(txtAlternative.text) + Number(txtOther.text) + Number(txtDelay.text) + Number(txtLess.text);
	txtReceivedAmt.text = nego_amt - Number(txtSumDeductAmt.text);
	txtExRecvAmt.text = Number(txtReceivedAmt.text) * Number(txtExRate.text);
} 

function OnProcess(obj)
{
   switch(obj)
     {   
        case "Approve" :
            if(txtMasterPK.text !="")
            {
                pro_kblc00170.Call();
            }else
            {
                alert("Please, select a slip to approve!");
            }
         break;
        case "Cancel" :
             if(txtMasterPK.text !="")
            {
                pro_kblc00170_1.Call();
            }else
            {
                alert("Please, select a slip to Cancel!");
            }
       
       break;        
       case "AutoSlip" :
             if(txtMasterPK.text !="")
            {
                pro_kblc00170_2.Call();
            }else
            {
                alert("Please, select a slip!");
            }
       break;
        case "Copy":
             if(txtMasterPK.text !="")
            {
                pro_kblc00170_4.Call();
            }else
            {
                alert("Please, select a slip to copy!");
            }
        break;
       case "CancelSlip" :
             if(txtMasterPK.text !="")
            {
                pro_kblc00170_5.Call();
            }else
            {
                alert("Please, select a slip!");
            }
       break;
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
    <!--============================================= Search =====================================-->
    <gw:data id="data_kblc00170_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid" function="<%=l_user%>lg_sel_kblc00170"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtSearchNo"	/>	
					<input	bind="txtSearchBy"	/>
                    <input	bind="lstStatus"	/>	
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kblc00170" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30"	function="<%=l_user%>lg_sel_kblc00170_1"	procedure="<%=l_user%>lg_upd_kblc00170_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
                        <inout	bind="txtSlipNo"	/>
						<inout	bind="lstCompany"	/>
						<inout	bind="txtChargerPK"	/>
						<inout	bind="txtChargerNM"	/>
						<inout	bind="txtRefNo"	/>
						<inout	bind="dtNegoDate"	/>
						<inout	bind="txtCommission"	/>
						<inout	bind="txtLCNO"	/>
						<inout	bind="txtNegoQty"	/>
						<inout	bind="txtAlternative"	/>
                        <inout	bind="txtNegoSeq"	/>	
						<inout	bind="txtNegoAmount"	/>
						<inout	bind="txtOther"	/>	
						<inout	bind="txtBankPK"	/>
                        <inout	bind="txtBankNM"	/>
						<inout	bind="txtReceivedAmt"	/>
						<inout	bind="txtDelay"	/>
						<inout	bind="txtBuyerPK"	/>
						<inout	bind="txtBuyerNM"	/>
						<inout	bind="lstCCY"	/>
						<inout	bind="txtExRate"	/>
						<inout	bind="txtLess"	/>
						<inout	bind="txtRemark"	/>
						<inout	bind="txtExRecvAmt"	/>
						<inout	bind="txtSumDeductAmt"	/>
                        <inout	bind="lblStatus"	/>
                        <inout	bind="txtTacAbdepomtPK"	/>
                        <inout	bind="txtAccSlipNo"	/>
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_kblc00170_1" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="<%=l_user%>lg_sel_kblc00170_2" procedure="<%=l_user%>lg_upd_kblc00170_2">
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!-------------------------------------- Approve ------------------------------->
    <gw:data id="pro_kblc00170" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00170" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------- Cancel ------------------------------>
    <gw:data id="pro_kblc00170_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00170_1" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien auto slip ------------------------------->
    <gw:data id="pro_kblc00170_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00170_2" > 
                <input>
                    <input bind="txtMasterPK" />
                    <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtAccSlipNo" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien auto get currency ------------------------------->
    <gw:data id="pro_kblc00170_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>sp_get_rate" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="lstCCY" />
                    <input bind="dtNegoDate" />
                </input> 
                <output>
                    <output bind="txtExRate" />
                    <output bind="txtNull" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien Copy ------------------------------->
    <gw:data id="pro_kblc00170_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00170_3" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien cancel slip ------------------------------->
    <gw:data id="pro_kblc00170_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00170_4" > 
                <input>
                    <input bind="txtMasterPK" />
                    <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtAccSlipNo" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr>
            <td id="left" style="width: 20%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 4%">
                        <td>
                            <table style="width: 100%; height: 100%" border="0">
                                <tr>
                                    <td align="right" style="width: 1%;">
                                        Date
                                    </td>
                                    <td style="white-space: nowrap; width: 1%">
                                        <gw:datebox id="dtFromSearch" lang="1" />
                                        ~
                                        <gw:datebox id="dtToSearch" lang="1" />
                                    </td>
                                    <td style="width: 98%" align="right" colspan="2">
                                        <img status="collapse" id="imgArrow" src="../../../system/images/button/next.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 1%; white-space: nowrap">
                                        Slip No
                                    </td>
                                    <td style="width: 99%" colspan="3">
                                        <gw:textbox id="txtSearchNo" styles="width:100%;" onenterkey="OnSearch('grdSearch')" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 1%; white-space: nowrap">
                                        Search
                                    </td>
                                    <td style="width: 99%" colspan="3">
                                        <gw:textbox id="txtSearchBy" styles="width:100%;" onenterkey="OnSearch('grdSearch')" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 1%;">
                                        Status
                                    </td>
                                    <td style="white-space: nowrap; width: 1%">
                                        <gw:list id="lstStatus" styles="width:100%;" onchange="OnSearch('grdSearch')" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap" align="right">
                                        <gw:label id="lblRecord" text="" styles="color:red" />
                                    </td>
                                    <td style="width: 97%">
                                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                                    </td>
                                </tr>
                                <tr style="height: 96%">
                                    <td colspan="8">
                                        <gw:grid id='grdSearch' header='_pk|Slip No|LC No|Nego Date|Partner Name|Nego Amt|Sum Deduct Amt|Received Amt|Ex Recv Amt|Full Name'
                                            format='0|0|0|4|0|1|1|1|1|0' aligns='0|0|0|1|0|0|0|0|0|0' check='|||||||||' editcol='0|0|0|0|0|0|0|0|0|0'
                                            widths='0|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                                            styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 80%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 8%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 25%" colspan="9">
                                        <table style="width: 100%; height: 100%">
                                            <tr style="height: 1%">
                                                <td align="right" style="width: 35%; white-space: nowrap">
                                                </td>
                                                <td align="right" style="width: 1%; white-space: nowrap">
                                                    <gw:icon id="idBtnApprove" img="2" text="Approve" styles='width:100%' onclick="OnProcess('Approve')" />
                                                </td>
                                                <td style="width: 1%" align="center">
                                                    <gw:icon id="idBtnCancel" img="2" text="Cancel" styles='width:100%' onclick="OnProcess('Cancel')" />
                                                </td>
                                                <td style="width: 1%" align="center">
                                                    <gw:icon id="idBtnCopy" img="2" text="Copy" onclick="OnProcess('Copy')" />
                                                </td>
                                                <td style="width: 1%" align="right">
                                                    <gw:icon id="idBtnAutoSlip" img="2" text="Auto Slip" styles='width:100%' onclick="OnProcess('AutoSlip')" />
                                                </td>
                                                <td style="width: 1%" align="right">
                                                    <gw:icon id="idBtnCancelSlip" img="2" text="Cancel Slip" styles='width:100%' onclick="OnProcess('CancelSlip')" />
                                                </td>
                                                <td style="width: 1%; white-space: nowrap">
                                                    ACC Slip No
                                                </td>
                                                <td style="width: 100%">
                                                    <gw:textbox id="txtAccSlipNo" csstype="mandatory" styles="width:50%;" />
                                                </td>
                                                <td style="white-space: nowrap" align="center">
                                                    <gw:label id="lblStatus" text="" styles="color:red" />
                                                </td>
                                                <td style="width: 1%" align="right">
                                                </td>
                                                <td style="width: 1%" align="right">
                                                    <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                                                </td>
                                                <td style="width: 1%" align="right">
                                                    <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                                                </td>
                                                <td style="width: 1%" align="right">
                                                    <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 1%">
                                        Slip No
                                    </td>
                                    <td style="width: 15%" colspan="3">
                                        <gw:textbox id="txtSlipNo" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        Company
                                    </td>
                                    <td style="width: 15%" colspan="2">
                                        <gw:list id="lstCompany" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <a onclick="OnPopUp('CHARGER')" href="#tips" style="color: #0000ff">Charger</a>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtChargerPK" styles="width:100%;display:none" />
                                        <gw:textbox id="txtChargerNM" styles="width:100%;display" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 12%;">
                                        Ref No
                                    </td>
                                    <td style="width: 1%" colspan="3">
                                        <gw:textbox id="txtRefNo" styles="width:100%" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        Nego Date
                                    </td>
                                    <td style="width: 15%" colspan="2">
                                        <gw:datebox id="dtNegoDate" lang="1" />
                                    </td>
                                    <td align="right" style="width: 5%;">
                                        Commission
                                    </td>
                                    <td style="width: 18%">
                                        <gw:textbox id="txtCommission" styles="width:100%" type="number" format="###,###,###.###"
                                            onchange="OnCalc()" onenterkey="OnCalc()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="style1">
                                        <a onclick="OnPopUp('LC')" href="#tips" style="color: #0000ff">L/C No</a>
                                    </td>
                                    <td colspan="3" class="style2">
                                        <gw:textbox id="txtLCNO" styles="width:100%;" />
                                    </td>
                                    <td align="right" class="style1">
                                        Nego Qty
                                    </td>
                                    <td colspan="2" class="style3">
                                        <gw:textbox id="txtNegoQty" styles="width:100%;" type="number" format="###,###,###.###" />
                                    </td>
                                    <td align="right" style="white-space: nowrap; width: 5%" class="style3">
                                        Alternative
                                    </td>
                                    <td class="style4">
                                        <gw:textbox id="txtAlternative" styles="width:100%;" type="number" format="###,###,###.###"
                                            onchange="OnCalc()" onenterkey="OnCalc()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 12%;">
                                        Nego Seq
                                    </td>
                                    <td colspan="3">
                                        <gw:textbox id="txtNegoSeq" styles="width:100%;" type="number" format="###,###,###" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        Nego Amount
                                    </td>
                                    <td style="width: 15%" colspan="2">
                                        <gw:textbox id="txtNegoAmount" styles="width:100%;" type="number" format="###,###,###.###" />
                                    </td>
                                    <td align="right" style="width: 8%;">
                                        Other
                                    </td>
                                    <td style="width: 18%">
                                        <gw:textbox id="txtOther" styles="width:100%;" type="number" format="###,###,###.###"
                                            onchange="OnCalc()" onenterkey="OnCalc()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 12%; white-space: nowrap">
                                        <a onclick="OnPopUp('BANK')" href="#tips" style="color: #0000ff">Nego Bank</a>
                                    </td>
                                    <td colspan="3">
                                        <gw:textbox id="txtBankPK" styles="width:100%;display:none" readonly="true" />
                                        <gw:textbox id="txtBankNM" csstype="mandatory" styles="width:100%;" readonly="true" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        Received Amt
                                    </td>
                                    <td style="width: 15%" colspan="2">
                                        <gw:textbox id="txtReceivedAmt" styles="width:100%;" type="number" format="###,###,###.###" />
                                    </td>
                                    <td align="right" style="width: 8%;">
                                        Delay
                                    </td>
                                    <td style="width: 18%">
                                        <gw:textbox id="txtDelay" styles="width:100%;" type="number" format="###,###,###.###"
                                            onchange="OnCalc()" onenterkey="OnCalc()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 12%;">
                                        <a onclick="OnPopUp('BUYER')" href="#tips" style="color: #0000ff">Buyer</a>
                                    </td>
                                    <td colspan="3">
                                        <gw:textbox id="txtBuyerPK" styles="width:100%;display:none" />
                                        <gw:textbox id="txtBuyerNM" styles="width:100%;display" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        CCY
                                    </td>
                                    <td style="width: 5%">
                                        <gw:list id="lstCCY" styles="width:100%;" onchange="OnSearch('CCY')" />
                                    </td>
                                    <td style="width: 10%">
                                        <gw:textbox id="txtExRate" styles="width:100%;" type="number" format="###,###,###.###"
                                            onchange="OnCalc()" onenterkey="OnCalc()" />
                                    </td>
                                    <td align="right" style="width: 8%;">
                                        Less
                                    </td>
                                    <td style="width: 18%">
                                        <gw:textbox id="txtLess" styles="width:100%;" type="number" format="###,###,###.###"
                                            onchange="OnCalc()" onenterkey="OnCalc()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 12%;">
                                        Remark
                                    </td>
                                    <td colspan="3">
                                        <gw:textbox id="txtRemark" styles="width:100%" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        Exchange Received Amt
                                    </td>
                                    <td style="width: 15%" colspan="2">
                                        <gw:textbox id="txtExRecvAmt" styles="width:100%;" type="number" format="###,###,###.###" />
                                    </td>
                                    <td align="right" style="width: 8%;">
                                        Sum Deduct Amt
                                    </td>
                                    <td style="width: 18%">
                                        <gw:textbox id="txtSumDeductAmt" styles="width:100%;" type="number" format="###,###,###.###" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            <table border="0">
                                <tr>
                                    <td align="right" style="width: 97%">
                                    </td>
                                    <td align="right">
                                    </td>
                                    <td align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDeleteDetail" onclick="OnDeleteDetail()" />
                                    </td>
                                    <td align="right">
                                        <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDeleteDetail" onclick="OnUnDeleteDetail()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 79%">
                        <td colspan="8">
                            <!--<gw:grid id='grdDetail' header='_MASTER_PK|_DETAIL_PK|Order No|_item_pk|Item Name|UOM|Qty|Unit Price|Amount|Remark'
                                format='0|0|0|0|0|0|1|1|1|0' aligns='0|0|0|0|0|1|0|0|0|0' check='|||||||||' editcol='0|0|0|0|0|0|1|1|0|1'
                                widths='0|0|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                                styles='width:100%; height:50%' onafteredit="OnCalc()" />-->
                            <gw:grid id='grdDetail' header='_MASTER_PK|_DETAIL_PK|Slip No|LC Date|LC No|_Partner_PK|Partner Name|LC Qty|LC Amt|Nego Amt|LC Bal|AR Invc Date|AR Invc No|AR Invc Amt|AR LC Mapping Amt|AR LC Amt Bal|Deli No|Remark'
                                format='0|0|0|4|0|0|0|1|1|1|1|4|0|1|1|1|0|0' aligns='0|0|0|1|0|0|0|0|0|0|0|1|0|0|0|0|0|0'
                                check='|||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0' widths='0|0|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit="OnCalc()" />
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
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />
<gw:textbox id="txtTacAbdepomtPK" text="" style="display: none" />
<gw:textbox id="txtNull" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
</html>
