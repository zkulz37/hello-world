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
var v_language = "<%=Session("SESSION_LANG")%>";

var G1_CHK          = 0,
    G1_OUTGO_M_PK   = 1,
    G1_PARTNER_PK   = 2, 
    G1_PARTNER_ID   = 3,
    G1_PARTNER_NAME = 4,       
    G1_OUT_DATE     = 5,  
    G1_SLIP_NO      = 6,
    G1_ITEM_AMT     = 7,
    G1_VAT_AMT      = 8,
    G1_TOTAL_AMT    = 9,
    G1_TR_CCY       = 10,
    G1_EX_RATE      = 11,
	G1_CHARGER_PK	= 12,
	G1_CHARGER_NAME = 13,
    G1_REMARK       = 14;
    
var G2_PARTNER_ID 	 = 0,
	G2_PARTNER_NAME  = 1,
	G2_REQ_DATE 	 = 2,
	G2_REF_NO 	     = 3,
	G2_SLIP_NO 	     = 4,                        
	G2_ITEM_AMT	     = 5,
	G2_VAT_AMT       = 6,
	G2_TOTAL_AMT     = 7,
	G2_PAY_AMOUNT 	 = 8,
	G2_BAL_AMOUNT 	 = 9,
	G2_TR_CCY 	     = 10,
	G2_EX_RATE 	     = 11,
	G2_PAYMENT_DESC  = 12,
	G2_COLLECT_M_PK  = 13;
		
  //==================================================================
         
function BodyInit()
{            
    System.Translate(document); 
    dtOutFrom.SetDataText(System.AddDate(dtOutTo.GetData(),-30));  
    dtReqFrom.SetDataText(System.AddDate(dtReqTo.GetData(),-30));
	
    //-----------------------------------
    FormatGrid();
}
//==================================================================
  
function FormatGrid()
{
    var data="";    
  	
    var ctrl = grdOutDetail.GetGridControl();   
    grdOutDetail.GetGridControl().FrozenCols = G1_OUTGO_M_PK;
     
    ctrl.ColFormat(G1_ITEM_AMT)  = "###,###,###.##" ;
	ctrl.ColFormat(G1_VAT_AMT)   = "###,###,###.##" ;
	ctrl.ColFormat(G1_TOTAL_AMT) = "###,###,###.##" ;
	
	ctrl.ColFormat(G1_EX_RATE)   = "###,###,###.##" ;
    //---------------------
    ctrl = grdReqDetail.GetGridControl();    
			 
	ctrl.MergeCells  = 2 ;	
	ctrl.MergeCol(0) = true;
    ctrl.MergeCol(1) = true;
    ctrl.MergeCol(2) = true;
    ctrl.MergeCol(3) = true;
    ctrl.MergeCol(4) = true;
    ctrl.MergeCol(5) = true;

    ctrl.ColFormat(G2_ITEM_AMT)  = "###,###,###,###,###.##";
    ctrl.ColFormat(G2_VAT_AMT)   = "###,###,###,###,###.##";
    ctrl.ColFormat(G2_TOTAL_AMT) = "###,###,###,###,###.##";
    ctrl.ColFormat(G2_PAY_AMOUNT) = "###,###,###,###,###.##";
    ctrl.ColFormat(G2_BAL_AMOUNT) = "###,###,###,###,###.##";	
	ctrl.ColFormat(G2_EX_RATE)    = "###,###,###,###,###.##";      
}

//==================================================================
function OnSearch(id)
{
    switch(id)
    {
        case 'grdOutDetail':
            data_dsap00070.Call('SELECT');
        break;
        
        case 'grdReqDetail':
            data_dsap00070_1.Call('SELECT')
        break;        
      
    }
}

//==================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
	
		case 'NewReq':   
			   txtArrayRefPK.text = '';
         	   txtArrayRefNo.text = ''; 
			   //----------------------------
			   txtRequesterPK.text   = '' ;
			   txtRequesterName.text = '' ; 		
			   //----------------------------
			   txtPartnerPK.text    = '' ;
			   txtPartnerID.text    = '' ;
			   txtPartnerName.text	= '' ;
			   //----------------------------
			   txtTrCCY.text  = '' ;
			   txtExRate.text = '' ;
               //----------------------------
			                                          
               var path = System.RootURL + '/form/ds/ap/dsap00071.aspx';
               var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
               
               if ( object != null )                    
               {
                   OnSearch('grdOutDetail');
               }                     
         break ;
		 	
        case 'MakeReq':        
              
               if(GetArrayMaster())
               {
                    if ( txtArrayRefPK.text != '' )
                    {
                        var path = System.RootURL + '/form/ds/ap/dsap00071.aspx';
	                    var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
    	                
	                    if ( object != null )                    
	                    {
	                        OnSearch('grdOutDetail');
	                    }
                    }
               }
         break ;
         
         case 'ModifyOrdPlan':
            if ( grdReqDetail.row > 0 )
            {  
                var path = System.RootURL + '/form/ds/ap/dsap00072.aspx?master_pk='+ grdReqDetail.GetGridData( grdReqDetail.row, G2_COLLECT_M_PK);
	            var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
	            
            	if ( object != null )                    
                {
                    OnSearch('grdOutDetail');
                }
	        }
	        else
	        {
	            alert('Pls select Collection request to modify.');
	        }       	        
         break;                            
     }       
}
//==================================================================
function OnPrint()
{    
	
}
//==================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsap00070':                      
            lbRecord.text = grdOutDetail.rows-1 + " rec(s)";
                               
			if ( grdOutDetail.rows > 1 )
            {
                grdOutDetail.SetCellBold( 1, G1_SLIP_NO,    grdOutDetail.rows - 1, G1_SLIP_NO,    true);
				grdOutDetail.SetCellBold( 1, G1_PARTNER_ID, grdOutDetail.rows - 1, G1_PARTNER_ID, true);
				grdOutDetail.SetCellBold( 1, G1_TOTAL_AMT,  grdOutDetail.rows - 1, G1_TOTAL_AMT,  true);
                
                grdOutDetail.SetCellBgColor( 1, G1_ITEM_AMT,    grdOutDetail.rows - 1, G1_TOTAL_AMT,     0xCCFFFF);                             
                grdOutDetail.SetCellBgColor( 1, G1_PARTNER_ID , grdOutDetail.rows - 1, G1_PARTNER_NAME , 0xCCFFFF );    
            }      
			
			OnSearch('grdReqDetail');                      
        break;    
        
        case 'data_dsap00070_1':                               
            if ( grdReqDetail.rows > 1 )
            {
                grdReqDetail.SetCellBold( 1, G2_REF_NO,     grdReqDetail.rows - 1, G2_REF_NO,     true);
				grdReqDetail.SetCellBold( 1, G2_PARTNER_ID, grdReqDetail.rows - 1, G2_PARTNER_ID, true);
				grdReqDetail.SetCellBold( 1, G2_TOTAL_AMT,  grdReqDetail.rows - 1, G2_TOTAL_AMT,  true);
                
                grdReqDetail.SetCellBgColor( 1, G2_ITEM_AMT,    grdReqDetail.rows - 1, G2_TOTAL_AMT,     0xCCFFFF);                             
                grdReqDetail.SetCellBgColor( 1, G2_PARTNER_ID , grdReqDetail.rows - 1, G2_PARTNER_NAME , 0xCCFFFF );
				
				grdReqDetail.SetCellFontColor(1, G2_BAL_AMOUNT, grdReqDetail.rows-1, G2_BAL_AMOUNT, 0x3300cc);    
            }         
        break;  
        
        case 'pro_dsap00070_1' :
            alert(txtReturnValue.text);
            
            OnSearch('grdReqDetail') ;
        break;  
        
        case 'pro_dsap00070_2' :
            alert(txtReturnValue.text);
            
            OnSearch('grdReqDetail') ;
        break;   
        case 'pro_dsap00070' :
            alert(txtReturnValue.text);
            OnSearch('grdOutDetail') ;
        break;
        
    }
}

//==================================================================
function OnProcess(pos)
{
    switch (pos)
    {
                
        case 'MakeReq':
         
            if(GetArrayMaster())
            { 
                if ( txtArrayRefPK.text != '' )              
                {
                    if ( confirm("Do you want to make collection request for " + txtArrayRefNo.text + " ? ") )
                    {
						 txtChargerPK.text = "<%=Session("EMPLOYEE_PK")%>";
						 
                         pro_dsap00070.Call();
                    } 
                }  
            }           
        break;        
    }    
}
//=========================================================
function GetArrayMaster()
{
     var array_ref_no = '';
     var array_ref_pk = '';
	 
	 var vItemAmt = 0,vVatAmt = 0,vTotalAmt = 0;	       
	 
	 var t_link       = '';
	 
     var supplier_pk = '';
	 
     var success        = true;
	 	 
     //------------------------------------------                    
            for(i = 1; i < grdOutDetail.rows; i++)
            {
                if (grdOutDetail.GetGridData(i, G1_CHK) == -1)
                {
					//----------------------------
                    if ( supplier_pk != '' && supplier_pk != grdOutDetail.GetGridData(i, G1_PARTNER_PK) )
                    {
                        alert('Diffrence Supplier!');
                        success = false;
                        break;
                    }
                     
                    supplier_pk = grdOutDetail.GetGridData(i, G1_PARTNER_PK);
					//----------------------------
                    array_ref_no = array_ref_no + t_link + grdOutDetail.GetGridData(i, G1_SLIP_NO)   ;
                    array_ref_pk = array_ref_pk + t_link + grdOutDetail.GetGridData(i, G1_OUTGO_M_PK);
                    
					t_link = ',' ;
					//----------------------------	
					txtRequesterPK.text   = grdOutDetail.GetGridData(i, G1_CHARGER_PK) ;
					txtRequesterName.text = grdOutDetail.GetGridData(i, G1_CHARGER_NAME) ; 		
					//----------------------------
					txtPartnerPK.text   = grdOutDetail.GetGridData(i, G1_PARTNER_PK  ) ;
					txtPartnerID.text   = grdOutDetail.GetGridData(i, G1_PARTNER_ID  ) ;
					txtPartnerName.text	= grdOutDetail.GetGridData(i, G1_PARTNER_NAME) ;
					//----------------------------
					txtTrCCY.text	= grdOutDetail.GetGridData(i, G1_TR_CCY ) ;
					txtExRate.text	= grdOutDetail.GetGridData(i, G1_EX_RATE) ;
					//----------------------------
							  
            		vItemAmt  =  vItemAmt  + Number(grdOutDetail.GetGridData(i, G1_ITEM_AMT ));
            		vVatAmt   =  vVatAmt   + Number(grdOutDetail.GetGridData(i, G1_VAT_AMT  ));
            		vTotalAmt =  vTotalAmt + Number(grdOutDetail.GetGridData(i, G1_TOTAL_AMT));  
				}	                                    
            }
            
            if ( array_ref_pk == '' )
            {
                alert('You must select one Slip.');
            }
               
         	txtArrayRefPK.text = array_ref_pk;
         	txtArrayRefNo.text = array_ref_no; 
						          	   
       		txtItemAmt.text  = vItemAmt  ;
       		txtVatAmt.text   = vVatAmt   ;
       		txtTotalAmt.text = vTotalAmt ;
     //------------------------------------------                    		       
     return success;               
}
//==================================================================
 function OnToggle()
 {
    var tab_top  = document.all("tab_top");    
    var tab_bottom = document.all("tab_bottom");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        tab_top.style.display="none";       
        imgArrow.status = "collapse";
        tab_bottom.style.width="100%";
        imgArrow.src = "../../../system/images/down.gif";
    }
    else
    {
        tab_top.style.display="";
        imgArrow.status = "expand";
        tab_bottom.style.height="50%";
        imgArrow.src = "../../../system/images/up.gif";
    }
 }    
//==================================================================
   
</script>

<body>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsap00070" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dsap00070"  >
                <input bind="grdOutDetail" >
			        <input bind="dtOutFrom" />
			        <input bind="dtOutTo" />
			        <input bind="txtRefNo" />
			        <input bind="txtCustomer" />
                </input>
                <output bind="grdOutDetail" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsap00070_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsap00070_1"  >
                <input bind="grdReqDetail" >
				   <input bind="dtReqFrom" />
			        <input bind="dtReqTo" />
			        <input bind="txtRefNo2" />
			        <input bind="txtPSupplier" />
			        <input bind="chkClose" />
                </input>
                <output bind="grdReqDetail" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsap00070_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsap00070_1" > 
                <input>
                    <input bind="txtCollectReqPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsap00070_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsap00070_2" > 
                <input>
                    <input bind="txtCollectReqPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------make plan------------------------------->
    <gw:data id="pro_dsap00070" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsap00070" > 
                <input>
                    <input bind="txtChargerPK" />
                    <input bind="txtPartnerPK" />
                    <input bind="txtRequesterPK" />
					
					<input bind="txtArrayRefPK" />
					<input bind="txtRefNo" />
					
					<input bind="txtTrCCY" />
					<input bind="txtExRate" />
					
					<input bind="txtItemAmt" />
					<input bind="txtVatAmt" />
					<input bind="txtTotalAmt" />
                </input>                                  
                <output> 
                    <output bind="txtReturnValue" />                   
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 50%" id="tab_top">
            <td>
                <table style="width: 100%; height: 100%" border="0">
                    <tr>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Deli Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtOutFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtOutTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%" align="right">
                            Slip/Ref No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtRefNo" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdOutDetail')" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Customer
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtCustomer" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdOutDetail')" />
                        </td>
                        <td style="width: 10%; text-align: center">
                            <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'>rec(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdOutDetail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnMakeOrdPlanAuto" img="2" text="Auto Req" onclick="OnProcess('MakeReq')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnMakeOrdADV" img="2" text="Manual Req" onclick="OnPopUp('MakeReq')" />
                        </td>
						<td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="Add New Request" id="btnAddDetail" onclick="OnPopUp('NewReq')" />
                        </td>	
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="11">
                            <gw:grid id='grdOutDetail'
                            header='Chk|_PK|_cus_pk|Partner ID|Partner Name|Deli Date|Slip No|Item Amt|VAT Amt|Total Amt|CCY|Ex-Rate|_ReqEMP_PK|Requester|Remark'
                            format='3|0|0|0|0|4|0|0|0|0|0|0|0|0|0'
                            aligns='0|0|0|0|0|1|0|3|3|3|1|3|0|0|0'
                            check='||||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='600|0|0|1500|3000|1200|1500|1500|1500|1500|1000|1500|0|2000|1000'
                            sorting='T'
                            styles='width:100%; height:100%'
                             />							 							 					
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%" id="tab_bottom">
            <td>
                <table style="width: 100%; height: 100%" border="0">
                    <tr>
                        <td style="width: 1%" align="left">
                            <img id="imgArrow" status="expand" id="imgUp" src="../../../system/images/up.gif"
                                style="cursor: hand" onclick="OnToggle()" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Req Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtReqFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtReqTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 8%; white-space: nowrap" align="right">
                            Slip/Ref No
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtRefNo2" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdReqDetail')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Customer
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtPSupplier" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdOutDetail')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            Close
                            <gw:checkbox id="chkClose" defaultvalue="Y|N" value="N" onchange="OnChangeClose()" />
                        </td>
                        <td>
                        </td>                       
                        <td style="width: 1%">
                            <gw:icon id="btnModifyOrdPlan" img="2" text="Modify" onclick="OnPopUp('ModifyOrdPlan')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('grdReqDetail')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="excel" alt="Print Report" id="btnPrint" onclick="OnPrint()" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="14">                            
							<gw:grid id='grdReqDetail' header='Partner ID|Partner Name|Req Date|Ref No|Slip No|Item Amt|Vat Amt|Total Amt|Pay Amt|Bal Amt|CCY|Ex Rate|Desc|_pc_collect_req_m_pk'
                    		format='0|0|4|0|0|0|0|0|0|0|0|0|0|0' 
							aligns='0|0|1|0|0|3|3|3|3|3|1|3|0|0' 
							check='|||||||||||||'
                    		editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1500|3000|1200|1500|1500|1500|1500|1500|1500|1500|1000|1200|1000|0'
                    		sorting='T' styles='width:100%; height:100%' />
							
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtCollectReqPK" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtArrayRefPK" styles='width:100%;display:none' />
    <gw:textbox id="txtArrayRefNo" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtRequesterPK" styles="display:none" />
    <gw:textbox id="txtRequesterName" styles="display:none" />
    <!----------------------------------------------------------->
    <gw:textbox id="txtPartnerPK" styles="display:none" />
	<gw:textbox id="txtPartnerID" styles="display:none" />	
    <gw:textbox id="txtPartnerName" styles="display:none" />		
	<!----------------------------------------------------------->	
	<gw:textbox id="txtTrCCY" styles="display:none" />
	<gw:textbox id="txtExRate" styles="display:none" />
	
	<gw:textbox id="txtItemAmt" styles="display:none" />
	<gw:textbox id="txtVatAmt" styles="display:none" />	
	<gw:textbox id="txtTotalAmt" styles="display:none" />
	<!----------------------------------------------------------->	
	<gw:textbox id="txtChargerPK" styles="display:none" />
	<!----------------------------------------------------------->	
</body>
</html>
