<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>L/C OPEN</title>
    <style type="text/css">
        .style1
        {
            width: 12%;
        }
        .style2
        {
            width: 1%;
        }
    </style>
</head>
<script type="text/javascript" language="javascript">

var flag, isLoadBank;
var G_LC_pk = 0;
var rtnLGCode = '' ;

var G_DETAIL_PK     = 0,
    G_MASTER_PK     = 1,
    G_SO_D_PK       = 2,
    G_ORDER_NO      = 3,
    G_ITEM_PK       = 4,
    G_ITEM_NM       = 5,
    G_UOM           = 6,
    G_QTY           = 7,
    G_UNIT_PRICE    = 8,
    G_AMOUNT        = 9,
    G_REMARK        = 10;
    
var GS_PK           = 0,    
    GS_SLIP_NO      = 1,
    GS_LC_OPEN_DT   = 2,
    GS_LC_NO        = 3,
    GS_PARTNER_NAME = 4,
    GS_LC_QTY       = 5,
    GS_EX_AMT       = 6,
    GS_LC_AMT       = 7,
    GS_NEGO_BANK    = 8,
    GS_PAYMENT      = 9;

//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";  
    //-------------------------
    txtSlipNo.SetEnable(false);
    txtChargerNM.SetEnable(false);
    txtBuyerNM.SetEnable(false);
    txtLCQty.SetEnable(false);
    txtLCAmt.SetEnable(false);
    txtExcAmt.SetEnable(false);
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
	
    /*data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0010' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %>|| ";             
    lstNegoBank.SetDataText( data);
    lstNegoBank.value = '' ;*/
   	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0120' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %>|| ";                 
    lstTerm.SetDataText(data); 
    lstTerm.value = '' ;

    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %>";                 
    lstCCY.SetDataText(data); 
    lstCCY.value = 'USD' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
    lstCompany.SetDataText(data);	 
    lstCompany.value= txtCompany_PK.text;	    
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
            case 'BUYER':
                 var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                txtBuyerNM.text = object[2];
	                txtBuyerPK.text =  object[0];	                
	             }                              
            break;  
            case 'BANK':
                 var path = System.RootURL + "/form/kb/lc/kblc00043.aspx";
	             var object = System.OpenModal( path ,600 , 400 ,  'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {
	                txtBankPK.text   = object[0];
                    txtBankNM.text = object[4];
                    txtTacAbdepomtPK.text = object[1];
                    lstCCY.value            = object[2];
                    isLoadBank              = "false";
                    pro_kblc00160_3.Call();
	             }                       
            break; 
            case 'TERM':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0120";
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
	                    lstTerm.value = object[1];      
	                }    	                
	             }                              
            break;                   
            case 'SALE_ORDER':
                 var path = System.RootURL + "/form/kb/lc/kblc00161.aspx";
	             var object = System.OpenModal( path ,1000 ,600 ,'resizable:yes;status:yes',this);
    	         
	             if ( object != null )
	             {	        	                   
	                var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
        
                        grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK, txtMasterPK.text); //master_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G_SO_D_PK, arrTemp[0]); //sa_order_d_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G_ORDER_NO, arrTemp[2]); //sale order no
                        grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK, arrTemp[3]);  
                        grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NM, arrTemp[4] + " - " + arrTemp[5]);  
                        grdDetail.SetGridText( grdDetail.rows-1, G_UOM, arrTemp[7]);      
                        grdDetail.SetGridText( grdDetail.rows-1, G_QTY, arrTemp[6]);      
                        grdDetail.SetGridText( grdDetail.rows-1, G_UNIT_PRICE, arrTemp[8])
                        grdDetail.SetGridText( grdDetail.rows-1, G_AMOUNT, arrTemp[9]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G_REMARK, arrTemp[10]);   
                        					
                    } 
                    OnCalc(); 	                
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
            data_kblc00160_search.Call("SELECT");
        break;
        case 'Master':
            flag = 'view' ;
            txtMasterPK.text  = grdSearch.GetGridData(grdSearch.row,0);
            data_kblc00160.Call("SELECT");
        break;  
        case 'Detail':
            data_kblc00160_1.Call("SELECT");
        break;   
        case 'CCY':
            isLoadBank = "true";
            pro_kblc00160_3.Call();
        break;             
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
                lstNegoBank.SetDataText(txtLGCodeList.text);  
                lstNegoBank.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0120')
             {
                lstTernCondi.SetDataText(txtLGCodeList.text);  
                lstTernCondi.value = rtnLGCode;                      
             }
              
        break;
        case 'data_kblc00160_search':
            lblRecord.text  = ( grdSearch.rows -1 )+ " record(s)."
            pro_kblc00160_3.Call();
        break;
        case 'data_kblc00160':
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
      case 'pro_kblc00160_3':
        if(isLoadBank == "true")
        {
            txtBankPK.text = "";
            txtBankNM.text = "";
            txtTacAbdepomtPK.text = "";
        }
        OnCalc();
      break;
    }
}
//====================================================================================

function Validate()
{   
    if(txtLCNo.text == "")
    {
        alert("Please, input L/C No!");
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
                data_kblc00160.Call();
                flag='save';
            }
        break;
        
        case 'Detail':        
            data_kblc00160_1.Call();
        break;
    }
}
//====================================================================================

function OnAddNew(pos)
{
    switch (pos)
    {   
         case 'Master': 
                data_kblc00160.StatusInsert();
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
       data_kblc00160.StatusDelete();
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
    var sum_qty = 0, unit_price = 0, amt = 0, sum_amt = 0;
    for(var i = 1; i < grdDetail.rows; i++)
    {
        if(grdDetail.GetRowStatus(i) != 80 && grdDetail.GetRowStatus(i) != 64)
        {
            sum_qty += Number(grdDetail.GetGridData(i, G_QTY));
            
            unit_price = Number(grdDetail.GetGridData(i, G_UNIT_PRICE))
            amt = unit_price * Number(grdDetail.GetGridData(i, G_QTY));
            grdDetail.SetGridText( i, G_AMOUNT, amt);
            
            sum_amt += amt;
        }
    }
    txtLCQty.text = System.Round( sum_qty, 2);
    txtLCAmt.text = System.Round( sum_amt, 2);
    
    txtExcAmt.text = Number(txtLCAmt.text) * Number(txtExRate.text);
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
    <gw:data id="data_kblc00160_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid" function="<%=l_user%>lg_sel_kblc00160"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtSearchNo"	/>	
					<input	bind="txtSearchBy"	/>	
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kblc00160" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19"	function="<%=l_user%>lg_sel_kblc00160_1"	procedure="<%=l_user%>lg_upd_kblc00160_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="lstCompany"	/>
						<inout	bind="txtChargerPK"	/>
						<inout	bind="txtChargerNM"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="dtOpenDate"	/>
						<inout	bind="dtStartDate"	/>
						<inout	bind="dtEndDate"	/>
                        <inout	bind="txtBankPK"	/>
                        <inout	bind="txtBankNM"	/>	
						<inout	bind="lstTerm"	/>
						<inout	bind="txtBuyerPK"	/>	
						<inout	bind="txtBuyerNM"	/>
						<inout	bind="lstCCY"	/>
						<inout	bind="txtExRate"	/>
						<inout	bind="txtLCQty"	/>
						<inout	bind="txtExcAmt"	/>
						<inout	bind="txtLCAmt"	/>
						<inout	bind="txtRemark"	/>					
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_kblc00160_1" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9,10" function="<%=l_user%>lg_sel_kblc00160_2" procedure="<%=l_user%>lg_upd_kblc00160_2">
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--------------------------------------Thuc hien auto get currency ------------------------------->
    <gw:data id="pro_kblc00160_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>sp_get_rate" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="lstCCY" />
                    <input bind="dtOpenDate" />
                </input> 
                <output>
                    <output bind="txtExRate" />
                    <output bind="txtNull" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 20%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td colspan="7" class="style1">
                        </td>
                        <td align="right" class="style2">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td align="right" class="style2">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                        </td>
                        <td align="right" class="style2">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Slip No
                        </td>
                        <td style="width: 1%">
                            <gw:textbox id="txtSlipNo" styles="width:100%;" csstype="mandatory" readonly="T" />
                        </td>
                        <td style="width: 1%; white-space: nowrap" align="right">
                            Company
                        </td>
                        <td style="width: 10%" colspan="2">
                            <gw:list id="lstCompany" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%;">
                            Charger
                        </td>
                        <td style="width: 18%">
                            <gw:textbox id="txtChargerPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtChargerNM" styles="width:100%;display" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            L/C No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtLCNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 12%;">
                            L/C Open Date
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:datebox id="dtOpenDate" lang="1" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Start Date
                        </td>
                        <td style="width: 18%">
                            <gw:datebox id="dtStartDate" lang="1" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('BANK')" href="#tips" style="color: #0000ff">Nego Bank</a>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtBankPK" styles="width:100%;display:none" readonly="true" />
                            <gw:textbox id="txtBankNM" csstype="mandatory" styles="width:100%;" readonly="true" />
                        </td>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('TERM')" href="#tips" style="color: #0000ff">Term & Condition</a>
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:list id="lstTerm" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%;">
                            End Date
                        </td>
                        <td style="width: 18%">
                            <gw:datebox id="dtEndDate" lang="1" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('BUYER')" href="#tips" style="color: #0000ff">Buyer</a>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtBuyerPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtBuyerNM" styles="width:100%;display" />
                        </td>
                        <td align="right" style="width: 12%;">
                            CCY
                        </td>
                        <td style="width: 8%">
                            <gw:list id="lstCCY" styles="width:100%;" onchange="OnSearch('CCY')"/>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtExRate" styles="width:100%" type="number" format="###,###,###.##R"
                                 onchange="OnCalc()" />
                        </td>
                        <td align="right" style="width: 5%;">
                            L/C Qty
                        </td>
                        <td style="width: 18%">
                            <gw:textbox id="txtLCQty" styles="width:100%" type="number" format="###,###,###.##R" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Remark
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtRemark" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Exchange Amount
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:textbox id="txtExcAmt" styles="width:100%" type="number" format="###,###,###.##R" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            L/C Amount
                        </td>
                        <td style="width: 18%">
                            <gw:textbox id="txtLCAmt" styles="width:100%" type="number" format="###,###,###.##R" />
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
                            <gw:icon id="idBtnSO" img="2" text="Sale Order" styles='width:5%' onclick="OnPopUp('SALE_ORDER')" />
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
        <tr style="height: 30%">
            <td colspan="8">
                <gw:grid id='grdDetail' header='_DETAIL_PK|_MASTER_PK|_TLG_SO_D_PK|Order No|_item_pk|Item Name|UOM|Qty|Unit Price|Amount|Remark'
                    format='0|0|0|0|0|0|0|1|1|1|0' aligns='0|0|0|0|0|0|1|0|0|0|0' check='||||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1|1' widths='0|0|0|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit="OnCalc()" />
            </td>
        </tr>
        <tr style="height: 8%">
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
                        <td align="right" style="width: 10%;">
                            Slip No / LC No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearchNo" styles="width:100%;" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Search by
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearchBy" styles="width:100%;" onenterkey="OnSearch('grdSearch')"  />
                        </td>
                        <td style="width: 10%" align="right">
                            <gw:label id="lblRecord" text="" styles="color:red" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 41%">
            <td colspan="8">
                <gw:grid id='grdSearch' header='_PK|Slip No|LC Date|LC No|Partner Name|LC Qty|Ex Amt|LC Amt|Nego Bank|Payment'
                    format='0|0|4|0|0|1|1|1|0|0' aligns='0|0|0|0|0|0|0|0|1|1' check='|||||||||' editcol='1|1|1|1|1|1|1|1|1|1'
                    widths='0|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                    styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
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
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<gw:textbox id="txtSONo" styles='display:none;width:100%' />
</html>
