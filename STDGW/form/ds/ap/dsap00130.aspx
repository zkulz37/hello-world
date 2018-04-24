<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Payment Request Closing </title>
</head>

<script type="text/javascript">
 //---------------------------------------------------------
 // columns of grdReqDetail
 var	iColMCloseYN		= 0,	
		iColMPK				= 1,
        iColMSlip_No        = 2,
		iColMOrderDate		= 3,
		iColMBillTo			= 4,
		iColMOrderStatus	= 5,
		iColMOrderType		= 6,
		iColMOrder_AMT       = 7,
        iColMTotal_AMT      = 8,
        iColMDescription    = 9;

//--------------------------------------------------------------------------        
 function BodyInit()
 {
    System.Translate(document); 
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-90));      
      OnChangeClose()
      //---------------------------
      BindingDataList();
      FormatGrid()
      //---------------------------
      //grdDetail.GetGridControl().FrozenCols = 7;
      //---------------------------      
      
      OnSearch(1)
 } 
//--------------------------------------------------------------------------        

 function BindingDataList()
 {         
    System.Translate(document);
    var sData="";
        
    sData = "DATA|O|Order Date|E|ETD";
    idList.SetDataText(sData);
     
      
    sData = "<%=ESysLib.SetGridColumnDataSQL("SELECT   code, (code || ' ' || code_nm) code_nm  FROM sale.lg_code a, sale.lg_code_group b  WHERE a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGSA1020' AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn DESC, ord")%>";
    grdReqDetail.SetComboFormat(iColMOrderType,sData);
   
 } 
 //--------------------------------------------------------------------------        
    
 function OnSearch()  
 {
       dsap00130.Call("SELECT")    
 }
 //--------------------------------------------------------------------------        

  function OnPopUp(pos)
 {
	switch(pos)
	{
		case 'CUSTOM':
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	         
	             txtBillToCode.text = object[1];               

              }
		break;
		//------
		case 'View_Detail':
		    if(grdReqDetail.row>0)
		    {
			var path = System.RootURL + '/form/ds/ap/dsap00131.aspx?master_pk=' + grdReqDetail.GetGridData(grdReqDetail.row,iColMPK) ;
			var object = System.OpenModal( path, 800, 600, 'resizable:yes;status:yes', this);
			    if ( object != null )                    
                {
                    OnSearch();
                }
             }else
               {
                alert("Please select a SO to view detail!");
               }
		break;	
	} 
 }
 
 //--------------------------------------------------------------------------        

 function OnDataReceive(obj)
 {
    if(obj.id=="dsap00130")
    {
        if(grdReqDetail.rows>1)
      {
        grdReqDetail.SetCellBold( 1, iColMSlip_No, grdReqDetail.rows - 1, iColMSlip_No, true);
      }
        lblRecord.text= grdReqDetail.rows-1 + " record(s)"		
    }
    if(obj.id=="dsap00130_1")
    {   if(grdReqDetail.rows>1)
      {
        grdReqDetail.SetCellBold( 1, iColMSlip_No, grdReqDetail.rows - 1, iColMSlip_No, true);
      }
        lblRecord.text= grdReqDetail.rows-1 + " record(s)"
    }

 }
 //--------------------------------------------------------------------------        

 function OnGridCellClick(obj)
 {
    if(obj.id =="grdReqDetail")
    {
        
        txtOrderPK.SetDataText(grdReqDetail.GetGridData(event.row,0));
        dsap00130_1.Call("SELECT")
    }  
 }
 //--------------------------------------------------------------------------        

 function FormatGrid()
 {          
        var trl ;      
        //-----------------------------
        trl = grdReqDetail.GetGridControl();
        trl.ColFormat(iColMOrder_AMT)           = "###,###,###,###,###.##";
        trl.ColFormat(iColMTotal_AMT)           = "###,###,###,###,###.##";  
        trl.FrozenCols = 1;  
		
 }
 //--------------------------------------------------------------------------        

 function OnSave(obj)
 {
    if(obj==1)
    {
	    dsap00130.Call();
	}else
	{
	     dsap00130_1.Call();
	}
 }
 
 //==================================================================

function OnChangeClose()
{
    if ( chkClose.value == "Y" ) 
    {
        btnClose.style.display   = "none" ;
        btnUnClose.style.display = "" ;
    }
    else
    {
        btnClose.style.display   = "" ;
        btnUnClose.style.display = "none" ;
    } 
    OnSearch();
}
</script>

<body style="margin:0 0 0 0; padding:0 0 0 0;">   
    <gw:data id="dsap00130" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsap00130" parameter="0,1" procedure="<%=l_user%>lg_upd_dsap00130"> 
                    <input bind="grdReqDetail" > 
                        <input bind="dtFrom" /> 
                        <input bind="dtTo" />  
                        <input bind="txtOrderNo" />
                        <input bind="txtBillToCode" /> 
                        <input bind="chkClose" /> 
                     </input> 
                    <output bind="grdReqDetail" /> 
                </dso> 
            </xml> 
        </gw:data>
   
    <!------------------------------------------------------------------>
     <gw:data id="dsap00130_1" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsap00130" parameter="0,1" procedure="<%=l_user%>lg_upd_dsap00130_1"> 
                    <input bind="grdReqDetail" > 
                        <input bind="dtFrom" /> 
                        <input bind="dtTo" />  
                        <input bind="txtOrderNo" />
                        <input bind="txtBillToCode" /> 
                        <input bind="chkClose" /> 
                     </input> 
                    <output bind="grdReqDetail" /> 
                </dso> 
            </xml> 
        </gw:data>
        
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 4%">
            <td>
                <table style="width: 100%; height: 100%" border="0">
                    <tr>
                        <td style="width: 10%">
                           Req DT
                        </td>
                        <td style="width: 20%; white-space: nowrap" align="left">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="width: 5%; white-space: nowrap;" align="right">
                            <b>REQ No</b>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtOrderNo" styles="width:100%" onenterkey="OnSearch(1)" />
                        </td>
                        <td style="width: 9%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('CUSTOM')">Customer </b>
                        </td>
                        <td style="width: 25%; white-space: nowrap;">
                            <gw:textbox id="txtBillToCode"  styles='width:100%' onenterkey="OnSearch(1)" />
                         </td>   
                                           
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Get Order" onclick="OnSearch(1)" />
                        </td>
                       
                    </tr>
                    <tr>
                        <td style="width: 100%" colspan="8">
                             <table style="width:100%; height:100%">
                                <tr>
                                 <td style="width: 15%" align="left">
                                    <b>Close YN</b>
                                    <gw:checkbox id="chkClose" defaultvalue="Y|N" value="N" onchange="OnChangeClose()" />
                                </td>
                                 <td style="width: 5%" align="right">
                                    <gw:icon id="btnClose" img="2" text="Close" styles='width:100%' onclick="OnSave(1)" />
                                    <gw:icon id="btnUnClose" img="2" text="UnClose" styles='width:100%' onclick="OnSave(2)" />
                                </td>
                                <td style="width: 30%">
                                </td>
                                 <td style="width: 20%" align="right" colspan="3">
                                    <gw:label id="lblRecord" styles='width:100%;color:Red' text="0 record(s)" />
                                </td>
                                <td style="width: 1%; white-space: nowrap" colspan="2">
                                    <gw:icon id="idBtnView" img="2" text="View Detail" styles='width:100%' onclick="OnPopUp('View_Detail')" />
                                </td>
                                </tr>
                             </table>   
                        </td>                        
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 40%">
            <td style="width: 100%">
                <gw:grid id='grdReqDetail' header='Select|_pc_collect_req_m_pk|Partner ID|Partner Name|Req Date|Ref No|Slip No|Item Amt|Vat Amt|Total Amt|Pay Amt|Bal Amt|CCY|Ex Rate|Desc'
            		format='3|0|0|0|4|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|1|0|0|3|3|3|3|3|1|3|0' 
					check='||||||||||||||'
            		editcol='1|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            		widths='800|0|1500|3000|1200|1500|1500|1500|1500|1500|1500|1500|1000|1200|1000'
            		sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------------->
    <gw:textbox id="txtOrderPK" csstype="mandatory" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtOutGoPK" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
</body>
</html>
