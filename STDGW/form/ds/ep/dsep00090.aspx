<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Packages In/Out</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

var G1_CHK		  = 0,
	G1_PACKAGE_PK = 1,
	G1_CUST		  = 2,	
	G1_PO_NO	  = 3,
	G1_STYLE	  = 4,
	G1_BOX_NO     = 5,
	G1_SEQ        = 6,
	G1_PACK_QTY	  = 7,	
	G1_LINE       = 8,
	G1_IN_TIME	  = 9,
	G1_IN_BY	  = 10,
	G1_OUT_TIME	  = 11,
	G1_OUT_BY	  = 12;	
	
var G2_ITEM_CODE	= 0,
	G2_ITEM_NAME	= 1,
	G2_UOM			= 2,
	G2_SUM_QTY		= 3,
	G2_SPEC01		= 4,
	G2_SPEC02		= 5,
	G2_SPEC03		= 6,
	G2_SPEC04		= 7,
	G2_SPEC05		= 8;
	
 var G3_CUST		= 0,
     G3_PO_NO		= 1,
	 G3_SEQ			= 2,
	 G3_ITEM_CODE	= 3,
	 G3_ITEM_NAME	= 4,
	 G3_UOM			= 5,
	 G3_IN_QTY		= 6,
	 G3_OUT_QTY		= 7;
	
 var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
//--------------------------------------------------------------------- 
function BodyInit()
{
    System.Translate(document);   
    //---------------------------------- 
    txtEmpPK.text = user_pk;
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));     
    //----------------------------------
    SetGridFormat();    
    //---------------------------------- 
	OnChangeTab(); 
	OnListChange();   
	
	       
}

 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {        	
	 grdPackages.GetGridControl().Cell( 7, 0, G1_PACK_QTY, 0, G1_PACK_QTY) = 0x3300cc;
	                               
	 //---------------------------------------
     var data = "DATA|10|INCOMING|20|OUTGOING";     
     idList.SetDataText(data);
     idList.value = '10';   
     //---------------------------------------
     data = "<%=ESysLib.SetListDataSQL("SELECT pk ,line_id || ' - ' || line_name  FROM tlg_pb_line  WHERE del_if = 0 and use_yn = 'Y' ORDER BY line_id" )%>||";    
     lstLine.SetDataText(data);
	 lstLine.value = '';
	  
	 //---------------------------------------
	 grdPackages.GetGridControl().ColFormat(G1_PACK_QTY) = "###,###,###.##";
	 
	 grdScanlog.GetGridControl().ColFormat(G3_IN_QTY)  = "###,###,###.##";
	 grdScanlog.GetGridControl().ColFormat(G3_OUT_QTY) = "###,###,###.##";
	 //---------------------------------------
	 grdScanlog.GetGridControl().MergeCells  = 2 ;	
     grdScanlog.GetGridControl().MergeCol(0) = true ;	
     grdScanlog.GetGridControl().MergeCol(1) = true ;   	
     grdScanlog.GetGridControl().MergeCol(2) = true ;
 }
 //-------------------------------------------------------------------------------------
function OnListChange()
{
		if ( idList.value == '10' )
		{
			btnDeli.style.display   = "none";
			btnIncome.style.display = "";
			
			btnCancelDeli.style.display   = "none";
			btnCancelIncome.style.display = "";
		}
		else
		{
			btnDeli.style.display   = "";
			btnIncome.style.display = "none";
			
			btnCancelDeli.style.display   = "";
			btnCancelIncome.style.display = "none";
		}
		
		OnSearch('grdPackages');
}
//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch(pos)
    {
        case 'grdPackages':
            data_dsep00090.Call('SELECT');   
        break;
        case 'grdSum':
            
            ConcatePK();
            data_dsep00090_1.Call('SELECT');
        break;   
		
		case 'grdScanlog':
			data_dsep00090_2.Call('SELECT');
		break;     
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    { 
        case 'data_dsep00090':
            if (grdPackages.rows > 1)            
            {
                grdPackages.SetCellBold( 1, G1_BOX_NO, grdPackages.rows-1, G1_BOX_NO, true); 
            }
			
			grdSum.ClearData();
        break; 
        
		case 'data_dsep00090_1':
            if (grdSum.rows > 1)            
            {
                grdSum.SetCellBold( 1, G2_SUM_QTY,   grdSum.rows-1, G2_SUM_QTY,   true); 
				
				grdSum.SetCellBold( 1, G2_ITEM_CODE, grdSum.rows-1, G2_ITEM_CODE, true);
            }
        break;          
        
		case 'pro_dsep00090':
              alert(txtReturnValue.text)
              data_dsep00090.Call('SELECT')
        break;    
        
		case 'pro_dsep00090_1':
               alert(txtReturnValue.text)
               data_dsep00090.Call('SELECT')
        break;    
    }
}
//--------------------------------------------------------------------------------------------------
function ConcatePK()
{
    var t_link ="" ;
    txtArrayPK.text ="";
    for (var i =1 ; i<grdPackages.rows; i++ )
    {
       
       	if ( grdPackages.GetGridData(i,G1_CHK) == -1 )
		{
			txtArrayPK.text = txtArrayPK.text + t_link + grdPackages.GetGridData(i,G1_PACKAGE_PK);
			t_link = ",";
		}		 
    }
    
}
//=====================================================================================
function OnProcess(pos)
{
     switch(pos)
     {       
             case 'Inco' :
				if ( txtArrayPK.text != '' )
				{
	            	if ( confirm('Do you want to process data.') )
	            	{                	                
	                	pro_dsep00090.Call();                
	            	}
				}	
				else
				{
					alert("Pls select packages to Take In!");
				}    
	        break;
	        case 'Deli' :
				if ( txtArrayPK.text != '' )
				{
	            	if ( confirm('Do you want to process data.') )
	            	{                	                
	                	pro_dsep00090_1.Call();                
	            	}
				}	
				else
				{
					alert("Pls select packages to Delivery!");
				}    
	        break;
     }
} 
 //=======================================================================
 function  OnCancel(obj)
 {
        if(obj=='INCOME')
        {
            var fpath = System.RootURL + "/form/ds/ep/dsep00091.aspx";
            var aValue = System.OpenModal( fpath , 800 , 600, 'resizable:yes;status:yes',this);
           
        }else //'DELIVERY'
        {
            var fpath = System.RootURL + "/form/ds/ep/dsep00092.aspx";
            var aValue = System.OpenModal( fpath , 800 , 600, 'resizable:yes;status:yes',this);            
            
        }
        
 }
  //==========================================================
 function OnChangeTab()
 {          
	switch (radTab.GetData())
	{
		case '1':
		    document.all("tab_scan_log").style.display = "";
		    document.all("tab_process").style.display  = "none";
		    
		    document.all("scanlog").style.color = "cc0000"; 
		    document.all("process").style.color = "";
        break;
        
        case '2':
		    document.all("tab_scan_log").style.display = "none";
		    document.all("tab_process").style.display  = "";
		    
		    document.all("scanlog").style.color = ""; 
		    document.all("process").style.color = "cc0000";       
        break;	                 
    } 
 }
 //=======================================================================
</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_dsep00090" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00090" > 
                <input bind="grdPackages" >  
					 <input bind="idList" />                     
                     <input bind="dtFrom" /> 
                     <input bind="dtTo" />
					 <input bind="txtPOStyle" />
					 <input bind="txtBoxNo" />
					 <input bind="lstLine" />
					 <input bind="txtEmpPK" />
					 <input bind="chkUser" />
                </input> 
                <output bind="grdPackages" /> 
            </dso> 
        </xml> 
    </gw:data>
	<!--------------------------------------------------------------------------->
      <gw:data id="data_dsep00090_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00090_2" > 
                <input bind="grdScanlog" >  
					 <input bind="dtFrom01" />                     
                     <input bind="dtTo01" />
					 <input bind="txtPOStyle01" />
                </input> 
               <output bind="grdScanlog" /> 
            </dso> 
        </xml> 
    </gw:data>     
      <!--------------------------------------------------------------------------->
      <gw:data id="data_dsep00090_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00090_1" > 
                <input bind="grdSum" >  
					 <input bind="txtArrayPK" />                     
                     <input bind="txtSearchD" />
                </input> 
               <output bind="grdSum" /> 
            </dso> 
        </xml> 
    </gw:data>  
    <!-------------------------------------------------------------------->
      <gw:data id="pro_dsep00090" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsep00090" > 
                <input>
                     <input bind="txtArrayPK" />
                     <input bind="txtEmpPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>      
    <!-------------------------------------------------------------------->
     <gw:data id="pro_dsep00090_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsep00090_1" > 
                <input>
                     <input bind="txtArrayPK" />
                     <input bind="txtEmpPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>  
    <!---------------------------------------------------------------------------> 
	<table style="width: 100%; height: 100%" >
		<tr style="height: 1%; background-color: #B4E7FF" >
           	<td style="white-space: nowrap;width: 40%" align="left">
               	<gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                   <span value="1" id="scanlog">Scan log</span> 
                   <span value="2" id="process">Process</span> 
               	</gw:radio>
           	</td>                                    
      	</tr>
		<tr style="height: 99%">
			<td>
				<table style="width: 100%; height: 100%" id="tab_scan_log" >
		           	<tr style="height: 1%">
		                <td style="width: 5%" align="right">
		                    Date
		                </td>
		                <td style="width: 20%; white-space: nowrap" align="left">
		                    <gw:datebox id="dtFrom01" lang="<%=Application("Lang")%>" mode="01"   />
		                    ~
		                    <gw:datebox id="dtTo01" lang="<%=Application("Lang")%>" mode="01"   />
		                </td>                                                               						
						<td align='right' style="width: 5%; white-space: nowrap">
		                    PO/Style/Cust
		                </td>
		                <td style="width: 20%; white-space: nowrap">
		                    <gw:textbox id="txtPOStyle01" styles='width:100%' onenterkey="OnSearch('grdScanlog')" />
		                </td>				 
		                <td style="width: 49%"></td>
						<td style="width: 1%" align='right' >
		                    <gw:imgbtn id="ibtnSearch01" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('grdScanlog')" />
		                </td>	               																			
		            </tr>  		                                    
		            <tr style="height: 49%">
		                <td colspan="12">
		                    <gw:grid id='grdScanlog' 
								header='Cust|P/O No|Seq|Item Code|Item Name|UOM|In Qty|Out Qty'
		                        format='0|0|0|0|0|0|0|0' 
								aligns='0|0|1|0|0|1|3|3' 
								defaults='|||||||' 
								editcol='0|0|0|0|0|0|0|0'
		                        widths='2500|2000|800|2000|3500|800|1500|1500' sorting='T' styles='width:100%; height:100%'		                     
		                        />
		                </td>
		            </tr>	
				</table>
				<table style="width: 100%; height: 100%" id="tab_process" >
		           	<tr style="height: 1%">
		                <td style="width: 5%" align="right">
		                    <gw:list id="idList" styles="color:blue;width:100" onchange="OnListChange()" />
		                </td>
		                <td style="width: 20%; white-space: nowrap" align="left">
		                    <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch('grdPackages')" />
		                    ~
		                    <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch('grdPackages')"  />
		                </td>                                                               
						
						<td align='right' style="width: 5%; white-space: nowrap">
		                    Line
		                </td>
		                <td style="width: 20%; white-space: nowrap">
		                    <gw:list id="lstLine" styles='width:100%' csstype="mandatory" onchange="OnSearch('grdPackages')" />
		                </td>				 
		                <td style="white-space: nowrap" style="width: 3%" >  
							<gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y">User</gw:checkbox>                      
		                </td>    
						<td style="width: 1%" align='right' colspan="2">
		                    <gw:imgbtn id="ibtnSearch01" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('grdPackages')" />
		                </td>	               																			
		            </tr>  
		            <tr>
		                <td align='right' style="width: 5%; white-space: nowrap">
		                    PO/Style/Cust
		                </td>
		                <td style="width: 20%; white-space: nowrap">
		                    <gw:textbox id="txtPOStyle" styles='width:100%' onenterkey="OnSearch('grdPackages')" />
		                </td>
						<td align='right' style="width: 5%; white-space: nowrap">
		                    Box No
		                </td>
		                <td style="width: 20%; white-space: nowrap">
		                    <gw:textbox id="txtBoxNo" styles='width:100%' onenterkey="OnSearch('grdPackages')" />
		                </td>
		                <td>
		                </td>	
		                 <td style="width: 1%; white-space: nowrap" align="center">
		                     <gw:icon id="btnDeli" img="2" text="Delivery" alt="Auto Delivery"
		                                    styles='width:100%' onclick="OnProcess('Deli')" />
		                      <gw:icon id="btnIncome" img="2" text="Income" alt="Auto Take In"
		                                    styles='width:100%' onclick="OnProcess('Inco')" />
		                </td>	
		                <td style="width: 1%; white-space: nowrap" align="center">
		                     <gw:icon id="btnCancelDeli" img="2" text="Cancel" alt="Auto Delivery"
		                                    styles='width:100%' onclick="OnCancel('DELI')" />
		                      <gw:icon id="btnCancelIncome" img="2" text="Cancel" alt="Auto Take In"
		                                    styles='width:100%' onclick="OnCancel('INCOME')" />
		                </td>	
		            </tr>                                
		            <tr style="height: 49%">
		                <td colspan="12">
		                    <gw:grid id='grdPackages' 
								header='Chk|_PK|Cust|P/O No|Style|Box No|Seq|Pack Qty|Line|In Time|In By|Out Time|Out By'
		                        format='3|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|0|0|0|1|1|3|0|1|1|1|1' 
								defaults='||||||||||||' 
								editcol='1|0|0|0|0|0|0|0|0|0|0|0|0'
		                        widths='800|0|2000|1500|2000|1500|800|1200|2000|2000|1200|2000|1200' sorting='T' styles='width:100%; height:100%'
		                        oncellclick="OnSearch('grdSum')"
		                        />
		                </td>
		            </tr>
		            <tr style="height: 1%">
		                <td style="width: 5%" align="right">
		                   Item
		                </td>
		                <td style="width: 20%; white-space: nowrap">
		                    <gw:textbox id="txtSearchD" styles='width:100%' onenterkey="OnSearch('grdSum')" />
		                </td>
		                <td style="width: 5%">
		                    <gw:imgbtn id="ibtnSearch02" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('grdSum')" />
		                </td>
		                <td style="width: 30%" align="center" colspan=9 >                    
		                </td>	                
		            </tr>
		            <tr style="height: 49%">
		                <td colspan="12">
		                    <gw:grid id='grdSum'
		                    header='Item Code|Item Name|UOM|Sum Qty|Spec 1|Spec 2|Spec 3|Spec 4|Spec 5'
		                    format='0|0|0|1|0|0|0|0|0'
		                    aligns='0|0|1|0|0|0|0|0|0'
		                    check='||||||||'
		                    editcol='0|0|0|0|0|0|0|0|0'
		                    widths='2000|4000|800|1500|1500|1500|1500|1500|1000'
		                    sorting='T'
		                    styles='width:100%; height:100%'
		                   />                                     
		                </td>
		            </tr> 
		        </table>              			
			</td>
		</tr>
	</table>                                      
    <!------------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
    <gw:textbox id="txtEmpPK" styles="width: 100%;display:none" />
    <gw:textbox id="txtArrayPK" styles="width: 100%;display:none" />
    <!------------------------------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles="width: 100%;display:none" />
	<!------------------------------------------------------------------------------->
</body>
</html>
