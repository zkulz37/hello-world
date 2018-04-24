<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Genuwin</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script language="javascript" type="text/javascript">
   function BodyInit()
     {       
        System.Translate(document);  // Translate to language session
        
        var now = new Date(); 
        var lmonth, ldate;
         
        BindingDataList(); 
                      
     }
     //----------------------------------------------------------------------------------------
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>|-1|Select All";   
         var data2 = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.del_if=0 and b.del_if=0 order by a.CODE")%>|ALL|Select All";  //currency 
                          
         lstCompany.SetDataText(data1);    
         //lstCompany.value='-1';     
         lstStatus.SetDataText('DATA|1|SAVED|2|SUBMITTED|3|APPROVED|4|CANCEL||'); 
		 lstStatus.value ='1';
     }
      
    //----------------------------------------------------------------------------
    function SetGridFormat()
    {
        var ctr = grdInvoices.GetGridControl(); 
        ctr.ColFormat(11) = "#,###,###,###,###,###";
        ctr.ColFormat(12) = "#,###,###,###,###,###.##";
        ctr.ColFormat(13) = "#,###,###,###,###,###";
        
        var ctr = grdTotal.GetGridControl(); 
        ctr.ColFormat(2) = "#,###,###,###,###,###.##";
        ctr.ColFormat(3) = "#,###,###,###,###,###";
    }    
    //----------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch(obj.id)
        {
            case 'dat_epei00040_1':
                
            break;
           
        }        
    }
    //----------------------------------------------------------------------------
</script>
<body>
<!------------------------Get Contract List -------------------------------------->
<gw:data id="dat_epei00040_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,9" function="lg_sel_epex00040"   > 
            <input bind="grdInvoices">                    
                <input bind="lstCompany" /> 
                <input bind="dtFromDate" />  
                <input bind="dtToDate" />
                <input bind="txtInvoiceNo" /> 
                <input bind="txtCustomer" />   
                <input bind="txtItem" /> 
                <input bind="lstStatus" /> 
            </input> 
            <output bind="grdInvoices" /> 
        </dso> 
    </xml> 
</gw:data> 
<!-------------------------------------------------------------------------------->
        <table cellpadding=0 cellspacing=0 width="100%" border=0>
            <tr>
                <td width="8%">
					<table style="height: 100%; width: 100%" border="0">
						<tr>
							<td width="8%">Company :</td>
							<td width="24%"><gw:list id="lstCompany" styles="width:100%;"></gw:list></td>
							<td width="6%">Customer :</td>
							<td width="22%"><gw:textbox id="txtCustomer"  text=""  styles='width:100%;' /></td>
							<td width="5%"></td>
							<td width="5%">Item :</td>
							<td width="23%"><gw:textbox id="txtItem"  text=""  styles='width:100%;' /></td>
							<td width="3%" align="right"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epei00040_1.Call('SELECT');" /></td>        
							<td width="4%"><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td> 
						</tr>
					</table>
				</td>                    
            </tr>
			<tr>
                <td width="8%">
					<table style="height: 100%; width: 100%" border="0">
						<tr>
							<td width="8%">Invoice Date :</td>
							<td width="8%"><gw:datebox id="dtFromDate" lang="1"  styles='width:100%;' onchange=""/></td>
							<td width="2%" align="center">~</td>
							<td width="8%"><gw:datebox id="dtToDate" lang="1"  styles='width:100%;' onchange=""/></td>
							<td width="4%"></td>
							<td nowrap width="6%">Invoice No :</td>
							<td width="23%"><gw:textbox id="txtInvoiceNo"  text=""  styles='width:100%;' /></td>
							<td width="4%"></td> 
							<td nowrap width="6%">Status :</td>
							<td width="23%"><gw:list id="lstStatus" styles="width:100%;" ></gw:list></td>
							<td width="18%"></td>
						</tr>
					</table>
				</td>                    
            </tr> 
            <tr>
                <td colspan="16">
                    <gw:grid id='grdInvoices'
                        header='_pk|Status|Invoice No|Invoice Date|_Partner_cust_pk|Partner ID|Partner Name|_pk|SEQ|Ref No|Item Code|Item Name|Item Description|Cust Item|UOM|QTY|Unit Price|Item Amount|Description'
                        format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                        aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                        defaults='||||||||||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                        widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                        sorting='T'
                        styles='width:100%; height:400'
						autosize='T'
                        oncelldblclick=""
                        acceptNullDate='true'
                    />
                </td>
            </tr>
           
        </table>
</body>
</html>
