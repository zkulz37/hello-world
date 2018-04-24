<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Payment Balance Checking</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>


    var G_PARTNER_NAME 	        = 0,
	    G_REQ_DATE 	            = 1,
		G_REF_NO 	            = 2,
        G_SLIP_NO 	            = 3,                        
		G_ITEM_AMOUNT		    = 4,
        G_VAT_AMOUNT            = 5,
        G_TOTAL_AMOUNT          = 6,
        G_PAY_AMOUNT 	        = 7,
		G_BAL_AMOUNT 	        = 8,
        G_TR_CCY 	            = 9,
        G_EX_RATE 	            = 10,
        G_PAYMENT_DESC 	        = 11,
        G_PC_COLLECT_REQ_M_PK   = 12;
    //---------------------------------------------------------
    function BodyInit() 
	{        
	    System.Translate(document); 
        dtFrom.SetDataText(System.AddDate(dtTo.GetData(), -7));
        
        OnFormatGrid();
    }
	 //------------------------------------------------------------------------------------------------
   function OnFormatGrid() 
	{ 
		var sData = "";
		 
		grdDetail.GetGridControl().MergeCells  = 2 ;	
		grdDetail.GetGridControl().MergeCol(0) = true;
        grdDetail.GetGridControl().MergeCol(1) = true;
        grdDetail.GetGridControl().MergeCol(2) = true;
        grdDetail.GetGridControl().MergeCol(3) = true;
        grdDetail.GetGridControl().MergeCol(4) = true;
        grdDetail.GetGridControl().MergeCol(5) = true;
        grdDetail.GetGridControl().MergeCol(6) = true;
        grdDetail.GetGridControl().MergeCol(7) = true;
        grdDetail.GetGridControl().MergeCol(8) = true;
        grdDetail.GetGridControl().MergeCol(9) = true;
        grdDetail.GetGridControl().MergeCol(10) = true;
		
        var trl;

        trl = grdDetail.GetGridControl();
        trl.ColFormat(G_ITEM_AMOUNT)    = "###,###,###,###,###.##";
        trl.ColFormat(G_VAT_AMOUNT)     = "###,###,###,###,###.##";
        trl.ColFormat(G_TOTAL_AMOUNT)   = "###,###,###,###,###.##";
        trl.ColFormat(G_PAY_AMOUNT)     = "###,###,###,###,###.##";
        trl.ColFormat(G_BAL_AMOUNT)     = "###,###,###,###,###.##";
    }
    //---------------------------------------------------------   
    function OnSearch() 
	{
        data_dsap00100.Call('SELECT')
    }
    //---------------------------------------------------------
    function OnDataReceive(obj) 
	{
        switch (obj.id) 
		{
            case 'data_dsap00100':  
			 	if (grdDetail.rows > 1)
                {
                    grdDetail.SetCellBold( 1, G_REF_NO      ,   grdDetail.rows-1,  G_REF_NO      , true);                
                    grdDetail.SetCellBold( 1, G_PARTNER_NAME,   grdDetail.rows-1,  G_PARTNER_NAME, true);   
                    grdDetail.SetCellBold( 1, G_TOTAL_AMOUNT,   grdDetail.rows-1,  G_PAY_AMOUNT  , true);
					
					grdDetail.SetCellFontColor(1, G_BAL_AMOUNT, grdDetail.rows-1, G_BAL_AMOUNT, 0x3300cc);
                }
            break;
        }
    }
	//==================================================================================================
    function OnDateChange() 
	{
        var strRad = radSearchDate.GetData();

        switch (strRad) 
		{
            case 'a':
                dtFrom.SetDataText(System.AddDate(dtTo.GetData(), -7));
            break;
            case 'b':
                dtFrom.SetDataText(System.AddDate(dtTo.GetData(), -14));
            break;
            case 'c':
                dtFrom.SetDataText(System.AddDate(dtTo.GetData(), -30));
            break;
        }
    }
   
	//==================================================================================================
    function OnPopUp() 
	{	 
		if ( grdDetail.row > 0 )
		{              			
			txtCollectReqPK.text = grdDetail.GetGridData( grdDetail.row, G_PC_COLLECT_REQ_M_PK); 
            txtPartnerName.text  = grdDetail.GetGridData( grdDetail.row, G_PARTNER_NAME);
            txtReqDate.text      = grdDetail.GetGridData( grdDetail.row, G_REQ_DATE);
            txtSlipRef.text      = grdDetail.GetGridData( grdDetail.row, G_SLIP_NO) + ' / ' +  grdDetail.GetGridData( grdDetail.row, G_REF_NO);
			
			var path = System.RootURL + "/form/ds/ap/dsap00101.aspx" ; 
			var object = System.OpenModal( path ,600 , 400 ,  'resizable:yes;status:yes', this);
		}	
	}
    //==================================================================================================
    function OnReport()
	{
            var url =System.RootURL + "/reports/ds/ap/rpt_dsap00100.aspx?p_from_dt="+dtFrom.value + '&p_to_dt=' + dtTo.value + '&p_partner=' + txtPartner.text + '&p_slip_ref_no=' + txtSlip.text + '&p_bal_yn=' + chkBal.value;
            System.OpenTargetPage(url); 
    }
	//==================================================================================================
	
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale"   function="<%=l_user%>lg_sel_dsap00100" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" />  
                    <input bind="txtPartner" />
                    <input bind="txtSlip" />  
                    <input bind="chkBal" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr id='top' style="height: 1%">
            <td style="width: 20%; white-space: nowrap" align="left">
                Req Date
                <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" styles="width=80%" />
                ~
                <gw:datebox id="dtTo" lang="<%=Session("Lang")%>" styles="width=80%" />
            </td>
            <td style="width: 20%; background-color: #CCFFFF; white-space: nowrap" align="center">
                <gw:radio id="radSearchDate" value="a" styles="width:100%" onchange="OnDateChange()"> 
                         <span value="a">1 Week</span> 
                         <span value="b">2 Weeks</span> 
                         <span value="c">1 Month</span> 
                 </gw:radio>
            </td>
            <td style="width: 5%" align="right">
                Partner
            </td>
            <td style="width: 15%">
                <gw:textbox id="txtPartner" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="center">
                Slip/Ref No
            </td>
            <td style="width: 15%" align="right">
                <gw:textbox id="txtSlip" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td style="width: 8%; white-space: nowrap" align="center">
                Balance<gw:checkbox id="chkBal" defaultvalue="Y|N" value="Y" onchange="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnPopUp()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Get Order" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="13">
                <gw:grid id='grdDetail' header='Partner Name|Req Date|Ref No|Slip No|Item Amount|Vat Amount|Total Amount|Pay Amount|Bal Amount|CCY|Ex Rate|Payment Desc|_pc_collect_req_m_pk'
                    format='0|4|0|0|1|1|1|1|1|0|1|0|0' aligns='0|0|0|0|0|0|0|0|0|1|0|0|0' check='||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1500|1200|1000|1000|1500|1500|1500|1500|1500|1000|1000|1000|0'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    
	<gw:textbox id="txtCollectReqPK" styles="width:100%; display:none" />
    <gw:textbox id="txtPartnerName" styles="width:100%; display:none" />
    <gw:textbox id="txtReqDate" styles="width:100%; display:none" />
    <gw:textbox id="txtSlipRef" styles="width:100%; display:none" />
</body>
</html>
