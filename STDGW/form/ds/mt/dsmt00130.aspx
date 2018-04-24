<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Incentive Summary 2</title>
</head>

<script>
 
 var G1_EMP_PK		= 0,
 	 G1_EMP_ID		= 1,
	 G1_EMP_NAME	= 2;
	  
 var G2_SLIP_NO		= 0, 
 	 G2_OUT_DATE	= 1,
	 G2_PO_NO		= 2,
	 G2_SEQ			= 3,
	 G2_ITEM_CODE	= 4,
	 G2_ITEM_NAME	= 5,
	 G2_NULL_01		= 6,
	 G2_NULL_02		= 7,
	 G2_UOM			= 8,
	 G2_OUT_QTY		= 9, 
	 G2_U_PRICE		= 10,
	 G2_ITEM_AMOUNT	= 11,
	 G2_TAX_AMOUNT	= 12,
	 G2_TOTAL_AMOUNT= 13,
	 G2_CCY			= 14;
 
 var G3_EMP_ID			= 0,
 	 G3_EMP_NAME		= 1,
	 G3_SALE_TYPE		= 2,
	 G3_ITEM_AMOUNT		= 3,
	 G3_TAX_AMOUNT		= 4,
	 G3_TOTAL_AMOUNT	= 5,
	 G3_CCY				= 6;
  
 //===============================================================
 function BodyInit()
 { 
 	System.Translate(document);  // Translate to language session
	
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------
    FormatGrid();
    //----------------  
	OnChangeMonth();  
 }
 //===============================================================

 function FormatGrid()
 {
      grdDetail.GetGridControl().ColFormat(G2_OUT_QTY)  	= "###,###,###,###,###.##";
	  grdDetail.GetGridControl().ColFormat(G2_U_PRICE) 		= "###,###,###,###,###.######";
      grdDetail.GetGridControl().ColFormat(G2_ITEM_AMOUNT)  = "###,###,###,###,###.##";
      grdDetail.GetGridControl().ColFormat(G2_TAX_AMOUNT)	= "###,###,###,###,###.##"; 
	  grdDetail.GetGridControl().ColFormat(G2_TOTAL_AMOUNT)	= "###,###,###,###,###.##";		
	  
	  grdCustomer.GetGridControl().ColFormat(G3_ITEM_AMOUNT)  = "###,###,###,###,###.##";	 
	  grdCustomer.GetGridControl().ColFormat(G3_TAX_AMOUNT)   = "###,###,###,###,###.##";	
	  grdCustomer.GetGridControl().ColFormat(G3_TOTAL_AMOUNT) = "###,###,###,###,###.##";	        
 }

 //===============================================================
 function OnSearch(pos)
 {
 	switch (pos)
	{
		case 'Detail_Tab1' :
			if ( grdSearch.row > 0 )
			{
				txtEmpPK.text = grdSearch.GetGridData( grdSearch.row, G1_EMP_PK );
				data_dsmt00130_1.Call("SELECT");
			}
			else
			{
				grdDetail.ClearData();
			}
			
		break;
		
		case 'Search_Tab1' :
			data_dsmt00130.Call("SELECT");
		break;
		
		case 'Detail_Tab2' :
			data_dsmt00130_2.Call("SELECT");
		break;
		
	}       
 }
 //===============================================================
 function OnDataReceive(obj)
 {
      switch (obj.id)         
      {
	  		case 'data_dsmt00130_1':
				if (grdDetail.rows >1)
				{
					grdDetail.Subtotal( 0, 2, -1, '9!11!12!13');
				}
			break;
			
            case 'data_dsmt00130_2' :
			  grdCustomer.Subtotal( 0, 2, -1, '3!4!5');
            break;           	            
      }	 
 }
 //===============================================================
 
function OnReport()
{ 
           var url = System.RootURL + '/reports/ds/bs/rpt_dsmt00130.aspx?p_partner_pk='+ txtEmpPK.text 
           + '&p_from_date=' + dtFrom.value 
           + '&p_to_date=' + dtTo.value 
           + '&p_po=' + txtPOTab1.text
           + '&p_item=' + txtItemTab1.text;
		   
           System.OpenTargetPage(url);  
}
 
 //===============================================================
 function OnChangeTab(pos)
 {
    switch(pos)
    {
        
    } 
 }
 //===============================================================
 
 function OnCheckDate()
 {
 	if ( chkDate.value == 'N' )
	{
		dtFrom.SetEnable(false);
		dtTo.SetEnable(false);
	}
	else
	{
		dtFrom.SetEnable(true);
		dtTo.SetEnable(true);	
	}
 }
 //=================================================================
 function OnChangeMonth()
 {
    pro_dsmt00130.Call();
 }
 //=================================================================
</script>

<body>
    <gw:data id="pro_dsmt00130" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsmt00130" > 
                <input>
                    <input bind="dtMonth" />
                </input> 
                <output>
                    <output bind="dtFrom_Date" />
                    <output bind="dtTo_Date" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------------->
    <gw:data id="data_dsmt00130_2" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsmt00130_2" > 
                <input bind="grdCustomer" >
				    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />                
					<input bind="txtCustTab2" />				
                </input>
                <output bind="grdCustomer" />
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------------->
    <gw:data id="data_dsmt00130" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsmt00130" > 
                <input bind="grdSearch" >
				    <input bind="dtFrom" />
                    <input bind="dtTo" />                                
					<input bind="txtCustTab1" />					 				
                </input>
                <output bind="grdSearch" />
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------------->
    <gw:data id="data_dsmt00130_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsmt00130_1" > 
                <input bind="grdDetail" >
                    <input bind="txtEmpPK" />
				    <input bind="dtFrom" />
                    <input bind="dtTo" />        
                    <input bind="txtPOTab1" />  
					<input bind="txtItemTab1" />                       				 
                </input>
                <output bind="grdDetail" />
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------------->
    <gw:tab>
    <table border="1" style="width: 100%; height: 100%" name="By Each Employee">
        <tr style="height: 2%">
            <td style="width: 25%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr>
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 90%; white-space: nowrap" >
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="" />                            
                        </td>
						<td style="width: 5%" align="right">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('Search_Tab1')" />
                        </td>
                    </tr>                    
                    <tr>
                        <td style="width: 5%" align="right">
                            Cust
                        </td>
                        <td style="width: 20%; white-space: nowrap" colspan="2">
                            <gw:textbox id="txtCustTab1" styles='width:100%' onenterkey="OnSearch('Search_Tab1')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_EMP_PK|Emp ID|Emp Name' format='0|0|0'
                                aligns='0|0|0' check='||' editcol='1|1|1' widths='0|1200|1000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Detail_Tab1')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 60%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">  
						<td style="width: 5%">
                            P/O
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtPOTab1" styles='width:100%' onenterkey="OnSearch('Detail_Tab1')" />
                        </td>						                      
                        <td style="width: 5%">
                            Item
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtItemTab1" styles='width:100%' onenterkey="OnSearch('Detail_Tab1')" />
                        </td>
						<td style="width: 5%" align="right" >                             
                        </td>
                        <td style="width: 25%">                            
                        </td>
						<td style="width: 9%">
						</td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <gw:grid id='grdDetail' 
								header='Slip No|Out Date|P/O No|Seq|Item Code|Item Name|_NULL_01|_NULL_02|UOM|Out Qty|U/Price|Item Amount|Tax Amount|Total Amount|CCY'
                                format='0|4|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|1|0|0|0|0|1|1|1|3|3|3|3|3|1' 
								check='||||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								widths='1500|1200|1500|800|1500|2500|1500|1500|800|1200|1200|1500|1500|1500|800'
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table border="1" style="width: 100%; height: 100%" name="By All Employee"> 
                    <tr style="height: 1%">
						<td>
							<table style="width: 100%; height: 100%">
								<tr>
			 						<td style="width: 5%">
			                            Month
			                        </td>
			                        <td style="width: 5%">
			                            <gw:datebox id="dtMonth" text="" maxlen="10" type="month" lang="<%=Session("Lang")%>"
			                                onchange="OnChangeMonth()" />
			                        </td>
			                        <td style="width: 5%" align="right">
			                            Date
			                        </td>
			                        <td style="width: 25%; white-space: nowrap">
			                            <gw:datebox id="dtFrom_Date" text="" maxlen="10" type="date" lang="<%=Session("Lang")%>" />                                              
								  		~
			                            <gw:datebox id="dtTo_Date" text="" maxlen="10" type="date" lang="<%=Session("Lang")%>" />
			                        </td>
			                        <td style="width: 5%">
			                            Customer
			                        </td>
			                        <td style="width: 30%">
			                            <gw:textbox id="txtCustTab2" styles='width:100%' onenterkey="OnSearch('Detail_Tab2')" />
			                        </td>
			                        <td style="width: 20%">
			                            &nbsp;
			                        </td>
			                        <td style="width: 5%">
			                            <gw:imgbtn id="ibtnSearch2" img="search" alt="Search" text="Search" onclick="OnSearch('Detail_Tab2')" />
			                        </td>								
								</tr>
							</table>
						</td>                       
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="11">
                            <gw:grid id='grdCustomer' header='Customer ID|Customer Name|Sale Type|Item Amount|Tax Amount|Total Amount|CCY'
                                format='0|0|0|0|0|0|0' aligns='0|0|1|3|3|3|1' check='||||||' editcol='0|0|0|0|0|0|0'
                                widths='1500|4000|1500|1500|1500|1500|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>                
    </table>
    </gw:tab>
    <!-------------------------------------------------------------------------->
    <gw:textbox id="txtEmpPK" styles='width:100%;display:none' />
</body>
</html>
