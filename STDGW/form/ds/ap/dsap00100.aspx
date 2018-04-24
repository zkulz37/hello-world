<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Collection Balance Checking</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>


    var G1_PARTNER_NAME 	= 0,
	    G1_REQ_DATE 	    = 1,
		G1_REF_NO 	        = 2,
        G1_SLIP_NO 	        = 3,                        
		G1_ITEM_AMOUNT		= 4,
        G1_VAT_AMOUNT       = 5,
        G1_TOTAL_AMOUNT     = 6,
        G1_PAY_AMOUNT 	    = 7,
		G1_BAL_AMOUNT 	    = 8,
        G1_TR_CCY 	        = 9,
        G1_EX_RATE 	        = 10,
        G1_PAYMENT_DESC 	= 11,
        G1_COLLECT_REQ_M_PK = 12;
		
    var G2_PARTNER_ID		= 0,
		G2_PARTNER_NAME		= 1,
		G2_MONTH			= 2,
		G2_REQ_AMT			= 3,
		G2_PAY_AMT			= 4,
		G2_BAL_AMT			= 5,
		G2_CCY 				= 6;
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

		grdMonth.GetGridControl().MergeCells  = 2 ;
		grdMonth.GetGridControl().MergeCol(0) = true;
        grdMonth.GetGridControl().MergeCol(1) = true;
		
        var trl;

        trl = grdDetail.GetGridControl();
        trl.ColFormat(G1_ITEM_AMOUNT)    = "###,###,###,###,###.##";
        trl.ColFormat(G1_VAT_AMOUNT)     = "###,###,###,###,###.##";
        trl.ColFormat(G1_TOTAL_AMOUNT)   = "###,###,###,###,###.##";
        trl.ColFormat(G1_PAY_AMOUNT)     = "###,###,###,###,###.##";
        trl.ColFormat(G1_BAL_AMOUNT)     = "###,###,###,###,###.##";

        trl = grdMonth.GetGridControl();
        trl.ColFormat(G2_REQ_AMT) = "###,###,###,###,###.##";
        trl.ColFormat(G2_PAY_AMT) = "###,###,###,###,###.##";
        trl.ColFormat(G2_BAL_AMT) = "###,###,###,###,###.##";	
    }
    //---------------------------------------------------------   
    function OnSearch(pos) 
	{
		switch( pos)
		{
			case 'Detail' :
				data_dsap00100.Call('SELECT');
			break;
			
			case 'Month' :
				data_dsap00100_1.Call('SELECT');
			break;	
		}		        
    }	 
    //---------------------------------------------------------
    function OnDataReceive(obj) 
	{
        switch (obj.id) 
		{
            case 'data_dsap00100':  
			 	if (grdDetail.rows > 1)
                {
                    grdDetail.SetCellBold( 1, G1_REF_NO      ,   grdDetail.rows-1,  G1_REF_NO      , true);                
                    grdDetail.SetCellBold( 1, G1_PARTNER_NAME,   grdDetail.rows-1,  G1_PARTNER_NAME, true);   
                    grdDetail.SetCellBold( 1, G1_TOTAL_AMOUNT,   grdDetail.rows-1,  G1_PAY_AMOUNT  , true);
					
					grdDetail.SetCellFontColor(1, G1_BAL_AMOUNT, grdDetail.rows-1, G1_BAL_AMOUNT, 0x3300cc);
                }
            break;
			
			case 'data_dsap00100_1':
				if ( grdMonth.rows > 1 )
		        {             
		            grdMonth.Subtotal( 0, 2, -1, '3!4!5');
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
			txtCollectReqPK.text = grdDetail.GetGridData( grdDetail.row, G1_COLLECT_REQ_M_PK); 
            txtPartnerName.text  = grdDetail.GetGridData( grdDetail.row, G1_PARTNER_NAME);
            txtReqDate.text      = grdDetail.GetGridData( grdDetail.row, G1_REQ_DATE);
            txtSlipRef.text      = grdDetail.GetGridData( grdDetail.row, G1_SLIP_NO) + ' / ' +  grdDetail.GetGridData( grdDetail.row, G1_REF_NO);
			
			var path = System.RootURL + "/form/ds/ap/dsap00101.aspx" ; 
			var object = System.OpenModal( path ,600 , 400 ,  'resizable:yes;status:yes', this);
		}	
	}
    //==================================================================================================
    function OnReport(pos)
	{
	    switch(pos)
	    {
	        case'1':
	            var url =System.RootURL + "/reports/ds/ap/rpt_dsap00100.aspx?p_from_dt="+dtFrom.value + '&p_to_dt=' + dtTo.value + '&p_partner=' + txtPartnerDetail.text + '&p_slip_ref_no=' + txtSlip.text + '&p_bal_yn=' + chkBal.value;
                System.OpenTargetPage(url); 
	        break;
	        case'2':
	            var url =System.RootURL + "/reports/ds/ap/rpt_dsap00101.aspx?p_from_dt="+dtFromMonth.value + '&p_to_dt=' + dtToMonth.value + '&p_partner=' + txtPartnerMonth.text;
                System.OpenTargetPage(url); 
	        break;
	    }
            
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
                    <input bind="txtPartnerDetail" />
                    <input bind="txtSlip" />  
                    <input bind="chkBal" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale"   function="<%=l_user%>lg_sel_dsap00100_1" > 
                <input> 
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" />  
                    <input bind="txtPartnerMonth" />
                </input> 
                <output bind="grdMonth" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:tab>
    <table style="width: 100%; height: 100%" name="Payment Detail">
        <tr id='top' style="height: 1%">
            <td style="width: 15%; white-space: nowrap" align="left">
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
            <td style="width: 12%">
                <gw:textbox id="txtPartnerDetail" styles="width:100%" onenterkey="OnSearch('Detail')" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="center">
                Slip/Ref No
            </td>
            <td style="width: 12%" align="right">
                <gw:textbox id="txtSlip" styles="width:100%" onenterkey="OnSearch('Detail')" />
            </td>
            <td style="width: 8%; white-space: nowrap" align="center">
                Balance<gw:checkbox id="chkBal" defaultvalue="Y|N" value="Y" onchange="OnSearch('Detail')" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnPopUp()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport('1')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Get Order" onclick="OnSearch('Detail')" />
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

	<table style="width: 100%; height: 100%" name="Monthly">
		<tr id='top' style="height: 1%">
            <td style="width: 15%; white-space: nowrap" align="left">
                Req Month
                <gw:datebox id="dtFromMonth" lang="<%=Session("Lang")%>" styles="width=80%" type="month" onchange="OnSearch('Month')" />
                ~
                <gw:datebox id="dtToMonth" lang="<%=Session("Lang")%>" styles="width=80%" type="month" onchange="OnSearch('Month')"/>
            </td>
            <td style="width: 5%; white-space: nowrap" align="center">
               Partner
            </td>
            <td style="width: 20%" align="right">
                 <gw:textbox id="txtPartnerMonth" styles="width:100%" onenterkey="OnSearch('Month')" />
            </td>
            <td style="width: 12%">
                
            </td>
            <td style="width: 5%; white-space: nowrap" align="center">
                
            </td>
            <td style="width: 12%" align="right">
                
            </td>
            <td style="width: 8%; white-space: nowrap" align="center">
                
            </td>
            <td style="width: 1%">
                
            </td>
            <td style="width: 1%">
               <gw:imgbtn img="excel" alt="Report" id="btnReport1" onclick="OnReport('2')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch1" img="search" alt="Search1" text="Get Order" onclick="OnSearch('Month')" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="13">

					<gw:grid id='grdMonth'
						header='Partner ID|Partner Name|Month|Req Amount|Pay Amount|Bal Amount|CCY'
						format='0|0|0|0|0|0|0'
						aligns='0|0|1|3|3|3|1'
						check='||||||'
						editcol='0|0|0|0|0|0|0'
						widths='1500|3500|1500|2000|2000|2000|1000'
						sorting='F'
						styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    </gw:tab>
    <gw:textbox id="txtCollectReqPK" styles="width:100%; display:none" />
    <gw:textbox id="txtPartnerName" styles="width:100%; display:none" />
    <gw:textbox id="txtReqDate" styles="width:100%; display:none" />
    <gw:textbox id="txtSlipRef" styles="width:100%; display:none" />
</body>
</html>
