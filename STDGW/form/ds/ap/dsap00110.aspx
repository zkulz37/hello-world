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
    //---------------------------------------------------------
    function BodyInit() 
	{        
	    
        CreateHeader(grdCollection_sum);
        
       // OnFormatGrid();
       OnSearch() 
    }
	 //------------------------------------------------------------------------------------------------
   function OnFormatGrid() 
	{ 
	   
    }
    //---------------------------------------------------------   
    function CreateHeader(oGrid)
    {
        switch(oGrid.id)
        {
            case 'grdCollection_sum':            
           
            var fg=oGrid.GetGridControl();
            if (oGrid.rows <2)
            {
               oGrid.AddRow()
            }
	        fg.FixedRows = 2;
	        fg.MergeCells = 5;
	        oGrid.SetCellBold(1,1,1,7,true);
	        fg.MergeCol(1) = true;
            fg.Cell(0, 0,1, 1, 1) = "Month";
	        fg.MergeRow(0) = true;
	        fg.Cell(0, 0, 2, 0, 4) = "Order" ;
		    fg.Cell(0, 1, 2, 1) 	= "New";
		    fg.Cell(0, 1, 3, 1 ) 	= "A/R";
		    fg.Cell(0, 1, 4, 1) 	= "Order Balance";
 	        fg.MergeRow(0) = true;
	        fg.Cell(0, 0, 5, 0, 7) = "A/R" ;
		    fg.Cell(0, 1, 5, 1) 	= "A/R";
		    fg.Cell(0, 1, 6, 1 ) 	= "Collection";
		    fg.Cell(0, 1, 7, 1) 	= "A/R Balance";
            break;
        }
        System.Translate(document);
    }
    //---------------------------------------------------------   
    function OnSearch() 
	{
        data_dsap00110.Call('SELECT')
    }
    //---------------------------------------------------------
    function OnDataReceive(obj) 
	{
        switch (obj.id) 
		{
            case 'data_dsap00110': 
                CreateHeader(grdCollection_sum); 
                grdCollection_sum.Subtotal( 0, 2, -1, '2!3!4!5!6!7','###,###,###.##');
			 	/*if (grdDetail.rows > 1)
                {
                    grdDetail.SetCellBold( 1, G_REF_NO      ,   grdDetail.rows-1,  G_REF_NO      , true);                
                    grdDetail.SetCellBold( 1, G_PARTNER_NAME,   grdDetail.rows-1,  G_PARTNER_NAME, true);   
                    grdDetail.SetCellBold( 1, G_TOTAL_AMOUNT,   grdDetail.rows-1,  G_PAY_AMOUNT  , true);
					
					grdDetail.SetCellFontColor(1, G_BAL_AMOUNT, grdDetail.rows-1, G_BAL_AMOUNT, 0x3300cc);
                }*/
            break;
        }
    }
	
	//==================================================================================================
    function OnPopUp() 
	{	   
            var path = System.RootURL + "/form/ds/ap/dsap00101.aspx?p_pc_payment_req_m_pk=" + grdDetail.GetGridData( grdDetail.row, G_PC_PAYMENT_REQ_M_PK);
			
            txtPartnerName.text = grdDetail.GetGridData( grdDetail.row, G_PARTNER_NAME);
            txtReqDate.text     = grdDetail.GetGridData( grdDetail.row, G_REQ_DATE);
            txtSlipRef.text     = grdDetail.GetGridData( grdDetail.row, G_SLIP_NO) + ' / ' +  grdDetail.GetGridData( grdDetail.row, G_REF_NO);
			
			var object = System.OpenModal( path ,600 , 400 ,  'resizable:yes;status:yes', this);
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
    <gw:data id="data_dsap00110" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale"   function="<%=l_user%>lg_sel_dsap00110" > 
                <input> 
                    <input bind="dtMonth" /> 
                </input> 
                <output bind="grdCollection_sum" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    
	<gw:tab id="idTab">
		<table name="Sales & Collection summary" width="100%" style="height:100%">
			<tr style="height:10%">
			    <td width="100%">
				    <table width="100%">
					    <tr>
						    <td width="6%" align="right"><b> Year </b></td>
						    <td width="6%"><gw:datebox id="dtMonth" type="year"  lang="<%=Session("Lang")%>" onchange="" /></td>
						    <td width="51%"></td>
						    <td width="3%"><gw:imgBtn img="search" alt="Search"   id="idBtnSearch1"   onclick="OnSearch()"/></td>
    						
					    </tr>
				    </table>
			    </td>
			</tr>
			<tr style="height:90%">
		        <td width="100%">
		           <gw:grid   
		           id="grdCollection_sum"  
		           header="_seq|Month|New order |A/R order|Order balance|A/R|A/R Collection|A/R Balance"   
		           format="0|0|0|-2|-2|-2|-2|-2"  
		           aligns="0|0|3|3|3|3|3|3"  
		           defaults="|||||||"  
		           editcol="0|0|0|0|0|0|0|0"  
		           widths="0|1500|1500|1500|1500|1500|1500|1500"  
		           styles="width:100%; height:100%"   
		           sorting="F"
                   param="0,1,2,3,4,5,6,7"  /> 
		        </td>
		    </tr>
		</table>
			<table name="Sales & Collection for customer" width="100%">
			<tr>
			    <td widht="100%">
				    <table width="100%" cellpadding=0 cellspacing=0  border=0>
					    <tr>
                        <td width="5%" align="right"><b>Year</b></td>
                        <td width="10%"><gw:datebox id="dtYear" lang="<%=session("lang")%>" type="year" /></td>
                        <td width="5%"><b style="color: Blue; cursor: hand" onclick="OnGetCustomer(0)">Company</b></td>
                        <td width="5%"><gw:textbox id="txtCustomerPK" styles="width:100%;display:none" /> <gw:textbox id="txtCustomerID" styles="width:100%" />
                        <td width="35%"><gw:textbox id="txtCustomerName" styles="width:90%" /></td>
                        <td width="10%"><gw:checkbox id="ckCustomer" defaultvalue="SO|N" /><b>Customer</b></td>
                        <td width="10%"><gw:checkbox id="ckVendor" defaultvalue="PO|N" /><b>Vendor</b></td>
                        <td width="1%"><gw:imgBtn img="search" onclick="onSearch(2)" /></td>
                      
                    </tr>
				    </table>
			    </td>
			</tr>
			<tr>
		        <td>
		           <gw:grid   
		           id="grdSO"  
		           header="_seq|Period|Balance|Sum|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec"   
		           format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
		           aligns="0|0|3|3|3|3|3|3|3|3|3|3|3|3|3|3"  
		           defaults="|||||||||||||||"  
		           editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"   
		           widths="0|2500|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600"  
		           styles="width:100%; height:430"   
		           sorting="F"
				   param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"  /> 
		        </td>
		    </tr>
		</table>
		<table name="Purchasing & Payment summary" width="100%">
			<tr>
			    <td widht="100%">
				    <table width="100%">
					    <tr>
						    <td width="6%" align="right"><b> Year :</b></td>
						    <td width="6%"><gw:datebox id="dtYear_PO" type="year"  lang="<%=Session("Lang")%>" onchange="" /></td>
						    <td width="51%"></td>
						    <td width="3%"><gw:imgBtn img="search" alt="OnSearch"   id="idBtnSearch"   onclick="onSearch(1)"/></td>
    						
					    </tr>
				    </table>
			    </td>
			</tr>
			<tr>
		        <td>
		           <gw:grid   
		           id="grdPO"  
		           header="_0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20"   
		           format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
		           aligns="0|0|3|1|3|3|1|3|3|1|3|3|1|3|3|1|3|3|1|3|3"  
		           defaults="||||||||||||||||||||"  
		           editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
		           widths="0|1600|2000|2000|2000|2000|2000|2000|1600|2000|2000|2000|2000|2000|2000|1600|2000|2000|2000|2000|2000"  
		           styles="width:100%; height:430"   
		           sorting="T"
				   param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"  /> 
		        </td>
		    </tr>
		</table>
		<table name="Purchasing & Payment for vendor" width="100%">
			<tr>
			    <td widht="100%">
				    <table width="100%" cellpadding=0 cellspacing=0  border=0>
					    <tr>
                        <td width="5%" align="right"><b>Year</b></td>
                        <td width="10%"><gw:datebox id="dtYear_PO1" lang="<%=session("lang")%>" type="year" /></td>
                        <td width="5%"><b style="color: Blue; cursor: hand" onclick="OnGetCustomer(1)">Company</b></td>
                        <td width="5%"><gw:textbox id="txtCustomerPK1" styles="width:100%;display:none" /> <gw:textbox id="txtCustomerID1" styles="width:100%" />
                        <td width="35%"><gw:textbox id="txtCustomerName1" styles="width:90%" /></td>
                        <td width="10%"><gw:checkbox id="ckCustomer1" defaultvalue="SO|N" /><b>Customer</b></td>
                        <td width="10%"><gw:checkbox id="ckVendor1" defaultvalue="PO|N" /><b>Vendor</b></td>
                        <td width="1%"><gw:imgBtn img="search" onclick="onSearch(3)" /></td>
                      
                    </tr>
				    </table>
			    </td>
			</tr>
			<tr>
		        <td>
		           <gw:grid   
		           id="grdPO1"  
		           header="_seq|Period|Currency|Balance|Sum|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec"   
		           format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
		           aligns="0|0|0|3|3|3|3|3|3|3|3|3|3|3|3|3|3"  
		           defaults="||||||||||||||||"  
		           editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"   
		           widths="0|2500|1000|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600|1600"  
		           styles="width:100%; height:430"   
		           sorting="F"
				   param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"  /> 
		        </td>
		    </tr>
		</table>
	</gw:tab>

    <gw:textbox id="txtPartnerName" styles="width:100%; display:none" />
    <gw:textbox id="txtReqDate" styles="width:100%; display:none" />
    <gw:textbox id="txtSlipRef" styles="width:100%; display:none" />
</body>
</html>
