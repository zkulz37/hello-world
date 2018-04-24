<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Delivery List</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

var G1_PROD_INCOM_PK  = 0,
    G1_INCOM_SLIP	  = 1,
	G1_PARTNER        = 2,
	G1_PO_NO	      = 3,
	G1_STYLE	      = 4,
	G1_BOX_NO         = 5,
	G1_SEQ            = 6,
	G1_LINE           = 7,
	G1_ITEM_CD        = 8,
	G1_ITEM_NM        = 9,
	G1_UOM            = 10,
	G1_IN_QTY         = 11;
	
 var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
 var callerWindowObj = dialogArguments;  
//--------------------------------------------------------------------- 
function BodyInit()
{
    System.Translate(document);   
     //----------------------------------  
    dtFrom.value =  callerWindowObj.dtFrom.value;    
    dtTo.value = callerWindowObj.dtTo.value;    
    txtPOStyle.text = callerWindowObj.txtPOStyle.text;    
    txtBoxNo.text = callerWindowObj.txtBoxNo.text;    
    lstLine.value = callerWindowObj.lstLine.value;      
    //---------------------------------
    grdPackages.GetGridControl().MergeCells  = 2 ;	
    grdPackages.GetGridControl().MergeCol(0) = true ;	
    grdPackages.GetGridControl().MergeCol(1) = true ;   	
    grdPackages.GetGridControl().MergeCol(2) = true ;
    //---------------------------------
    SetGridFormat();    
    OnSearch('grdPackages')   
}

 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {        	
	 grdPackages.GetGridControl().Cell( 7, 0, G1_INCOM_SLIP, 0, G1_INCOM_SLIP) = 0x3300cc;
	                               
	 //---------------------------------------
     data = "<%=ESysLib.SetListDataSQL("SELECT pk ,line_id || ' - ' || line_name  FROM tlg_pb_line  WHERE del_if = 0 and use_yn = 'Y' ORDER BY line_id" )%>||";    
     lstLine.SetDataText(data);
	 lstLine.value = '';
	  
	 //---------------------------------------
	 grdPackages.GetGridControl().ColFormat(G1_IN_QTY) = "###,###,###.##";
 }
 
//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch(pos)
    {
        case 'grdPackages':
            data_dsep00092.Call('SELECT');   
        break;          
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    { 
        case 'data_dsep00092':
            if (grdPackages.rows > 1)            
            {
                grdPackages.SetCellBold( 1, G1_INCOM_SLIP, grdPackages.rows-1, G1_INCOM_SLIP, true); 
                grdPackages.SetCellBold( 1, G1_PO_NO, grdPackages.rows-1, G1_PO_NO, true);
                grdPackages.SetCellBold( 1, G1_BOX_NO, grdPackages.rows-1,G1_BOX_NO, true);
                grdPackages.SetCellBold( 1, G1_IN_QTY, grdPackages.rows-1,G1_IN_QTY, true);
            }
		
        break;    
        
		case 'pro_dsep00092':
              alert(txtReturnValue.text)
              data_dsep00092.Call('SELECT')
        break;    
        
    }
}

//=====================================================================================
function OnProcess(pos)
{
     switch(pos)
     {       
             case 'DELI' :
                if (grdPackages.row >0)
                {
                    txtMasterPK.text = grdPackages.GetGridData(grdPackages.row,G1_PROD_INCOM_PK);
                    pro_dsep00092.Call();     
                }else
                {
                    alert("Please select a slip to cancel!");
                }
               
	        break;
     }
} 


</script>

<body>
     <!-------------------------------------------------------------------->
     <gw:data id="pro_dsep00092" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsep00092" > 
                <input>
                     <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>  
      <!--------------------------------------------------------------------------->
      <gw:data id="data_dsep00092" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00092" > 
                <input bind="grdPackages" >  
					<input bind="dtFrom" /> 
                     <input bind="dtTo" />
					 <input bind="txtPOStyle" />
					 <input bind="txtBoxNo" />
					 <input bind="lstLine" />
                </input> 
               <output bind="grdPackages" /> 
            </dso> 
        </xml> 
    </gw:data>  
    <!-------------------------------------------------------------------->                                  
        <table style="width: 100%; height: 100%"  >           
            <tr> 
             <td style="width: 5%" align="right">
                    Date
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
                <td style="width: 1%" align='right' >
                    <gw:imgbtn id="ibtnSearch01" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('grdPackages')" />
                </td>
                <td style="width: 1%">
                  <gw:icon id="btnCancelDELI" img="2" text="Cancel" alt="Auto Take In"
                                    styles='width:100%' onclick="OnProcess('DELI')" />
                </td>
            </tr>
            <tr style="height: 90%">
                <td colspan="12">
                 <gw:grid id='grdPackages'
                    header='_PR_DELIVERY_M_PK|Slip No|Partner Name|SO/PO No|Style ID|Item BC|Pack Seq|Line|Item Code|Item Name|UOM|Out Qty'
                    format='0|0|0|0|0|0|0|0|0|0|0|-2'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0'
                    check='|||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1500|2000|1500|1500|1500|1000|1500|1500|2000|1000|1500'
                    sorting='T' 
                    styles='width:100%; height:100%'
                    oncellclick=""
                    />      
                </td>
            </tr> 
        </table>              
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
    <!------------------------------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles="width: 100%;display:none" />
</body>
</html>
