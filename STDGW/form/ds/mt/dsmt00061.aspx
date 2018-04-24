<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>SALE PRICE ENTRY</title>
</head>

<script type="text/javascript" language="javascript">
var flag;
var G0_MASTER_PK	        = 0,
	G0_FR_DATE		        = 1,
	G0_TO_DATE		        = 2,	 
	G0_CHARGER_PK           = 3,
	G0_FULL_NAME            = 4,
	G0_DESCRIPTION          = 5,
	G0_STATUS               = 6,
	G0_TCO_BUSPARTER_PK     = 7,
	G0_PARTNER_NAME         = 8,
	G0_TLG_MT_DIVISION_PK   = 9,
	G0_TLG_MT_DIVISION_NM   = 10,
	G0_TLG_MT_PA_GROUP_PK   = 11,
	G0_TLG_MT_PA_GROUP_NM   = 12,
	G0_PRICE_TYPE           = 13, 
	G0_CCY                  = 14;
	

var G1_DETAIL_PK    	        = 0,
    G1_TLG_MT_SALE_PRICE_M_PK   = 1,
	G1_SEQ                      = 2,
	G1_TLG_IT_ITEM_PK           = 3,
	G1_ITEM_CODE                = 4,
	G1_ITEM_NAME                = 5,
	G1_UNIT_PRICE               = 6,
    G1_DESCRIPTION              = 7;
        	
var arr_FormatNumber = new Array();	
        
//======================================================================

function OnToggle(pos)
{
    switch (pos)
    {
        case '1':
            var left = document.all("left"); 
            var right = document.all("right"); 
            var imgArrow = document.all("imgArrow"); 

            if(imgArrow.status == "expand")
            {
                left.style.display="none";
                imgArrow.status = "collapse";
                right.style.width="100%";
                imgArrow.src = "../../../system/images/button/next.gif";
            }
            else
            {
                left.style.display="";
                imgArrow.status = "expand";
                right.style.width="70%";
                imgArrow.src = "../../../system/images/button/previous.gif";
            }        
        break; 
    }    
}
 
//=================================================================================

function BodyInit()
{
    System.Translate(document);  // Translate to language session

	txtMasterPK.text = "<%=Request.querystring("po_pk")%>";
	var status = "<%=Request.querystring("type")%>"; 
	
	if(status == "APPROVE")
	{
	    document.getElementById('idBtnCancel').style.display = "none";
	}
	else
	{
	    document.getElementById('idBtnApprove').style.display = "none";
	}
		
	txtChargerName.SetReadOnly(true);
	txtPartnerGroupName.SetReadOnly(true);
	txtPartnerName.SetReadOnly(true);
	txtDivisionName.SetReadOnly(true);
	
	FormFormat();      
	OnSearch('Master');
}
//=================================================================================
function FormFormat()
{  
     var data="";  	
  	  

     //data ="#1;QTY|#2;AMT|#3;RATE AMT|#3;RATE QTY";
     //grdDetail.SetComboFormat(G1_PROMO_TYPE,data);
	 	 	   
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL" )%>";    
     lstPriceType.SetDataText(data); 

     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCurrency.SetDataText(data);     
        	 	 	   
	 grdDetail.GetGridControl().ColFormat(G1_UNIT_PRICE)    = "###,###,###.##"; 
	 
	 arr_FormatNumber[G1_UNIT_PRICE] = 2;
}
//=================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_DSMT00061': //SEARCH  
        break;
		
        case 'data_DSMT00061_1': //MASTER
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_TLG_MT_SALE_PRICE_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_TLG_MT_SALE_PRICE_M_PK, txtMasterPK.text);
                    }    
                }                
                OnSave('Detail');  
            } 
            else
            {
                data_DSMT00061_2.Call('SELECT'); 
            }    
        break;
        
		case 'data_DSMT00061_2':
			if ( grdDetail.rows > 1 )
			{
				grdDetail.SetCellBold( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);		
			}
		break;
		
        case 'pro_dsmt00061': // APPROVE
            alert(txtValueReturn.text);
            window.returnValue =  1;
            window.close();
        break;
        case 'pro_dsmt00061_1': // CANCEL
            alert(txtValueReturn.text);
            window.returnValue =  1;
            window.close();
        break;
    }  
}
//=================================================================================
function OnSearch(pos)
{ 
    switch(pos)
    {
        case 'Master':
           	 	data_DSMT00061_1.Call('SELECT');
        break;
		
		case 'Detail' :
			data_DSMT00061_2.Call('SELECT');
		break; 
    }
}
//========================================================================================
function OnSubmit(pos)
{
	switch(pos)
	{
		case 'Approve':
			if(txtMasterPK.text != '')
		    {
		        pro_dsmt00061.Call();
		    }		
		break;
		case 'Cancel':
			if(txtMasterPK.text != '')
		    {
		        pro_dsmt00061_1.Call();
		    }		
		break;		
	}    
}
//=================================================================================
</script>

<body>
    <!--============================================= Master =====================================-->
    <gw:data id="data_DSMT00061_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14"	function="<%=l_user%>lg_sel_DSMT00061_1"	procedure="<%=l_user%>lg_UPD_DSMT00061">	
				<input>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="dtProFrom"	/>	
						<inout	bind="dtProTo"	/>
						<inout	bind="txtChargerPK"	/>	
						<inout	bind="txtChargerName"	/>
						<inout	bind="txtDesc"	/>											
						<inout	bind="lblStatus"	/>	
						<inout  bind="txtPartnerPK" />	
						<inout  bind="txtPartnerName" />						
						<inout  bind="txtDivisionPK" />	
						<inout  bind="txtDivisionName" />	
						<inout  bind="txtPartnerGroupPK" />		
						<inout  bind="txtPartnerGroupName" />	
			            <inout  bind="lstPriceType" />
			            <inout  bind="lstCurrency" />							
				</input>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_DSMT00061_2" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_DSMT00061_2" procedure="<%=l_user%>lg_UPD_DSMT00061_1">	
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Approve =====================================-->
    <gw:data id="pro_dsmt00061" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_PRO_DSMT00070"> 
                <input> 
			        <input bind="txtMasterPK" />  		
			    </input> 
                <output>
                    <output bind="txtValueReturn" />
                </output>           
            </dso> 
        </xml> 
    </gw:data>
    <!--============================================= Cancel =====================================-->
    <gw:data id="pro_dsmt00061_1" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_PRO_DSMT00070_1"> 
                <input> 
			        <input bind="txtMasterPK" />  		
			    </input> 
                <output>
                    <output bind="txtValueReturn" />
                </output>           
            </dso> 
        </xml> 
    </gw:data>    
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr>
            <td style="width: 100%; height: 100%" align="center" valign="top" id="right">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="width: 100%; height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:datebox id="dtProFrom" lang="1" width="10%" />
                            ~
                            <gw:datebox id="dtProTo" lang="1" width="10%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                        </td>
                        <td align='center' colspan="2">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="idBtnApprove" img="2" text="Approve" styles='width:15%' onclick="OnSubmit('Approve')" />
                            <gw:icon id="idBtnCancel" img="2" text="Cancel" styles='width:15%' onclick="OnSubmit('Cancel')" />
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 1%">
                        <td style="width: 5%; white-space: nowrap">
                            Charger
                        </td>
                        <td>
                            <gw:textbox id="txtChargerPK" styles='width:100%;display:none' />
                            <gw:textbox id="txtChargerName" styles='width:100%' />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Desc
                        </td>
                        <td style="width: 5%; white-space: nowrap" colspan="7">
                            <gw:textbox id="txtDesc" styles='width:100% ' />
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 1%">
                        <td colspan="11">
                            <table style="width: 100%; height: 100%; background-color: #B4E7FF" border="0">
                                <tr style="width: 100%; height: 1%; white-space: nowrap">
                                    <td style="width: 5%; white-space: nowrap">
                                        Division
                                    </td>
                                    <td style="width: 95%" colspan="3">
                                        <gw:textbox id="txtDivisionPK" styles='width:30%;display=none' />
                                        <gw:textbox id="txtDivisionName" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="width: 100%; height: 1%; white-space: nowrap">
                                    <td style="width: 5%; white-space: nowrap">
                                        P/Group
                                    </td>
                                    <td style="width: 95%" colspan="3">
                                        <gw:textbox id="txtPartnerGroupPK" styles='width:30%;display=none' />
                                        <gw:textbox id="txtPartnerGroupName" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="width: 100%; white-space: nowrap">
                                    <td style="width: 5%; white-space: nowrap">
                                        Partner
                                    </td>
                                    <td style="width: 95%" colspan="3">
                                        <gw:textbox id="txtPartnerPK" styles='width:30%;display=none' />
                                        <gw:textbox id="txtPartnerName" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="width: 100%; white-space: nowrap">
                                    <td style="width: 5%; white-space: nowrap">
                                        Price type
                                    </td>
                                    <td style="width: 45%">
                                        <gw:list id="lstPriceType" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap">
                                        CCY
                                    </td>
                                    <td style="width: 45%">
                                        <gw:list id="lstCurrency" styles='width:100%' onchange="" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="11">
                            <table style="width: 100%; height: 100%" border="0">
                                <tr>
                                    <td style="width: 97%; white-space: nowrap" align="left">
                                    </td>
                                    <td style="width: 1%; white-space: nowrap" align="center">
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 94%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' header='_pk|_tlg_mt_sale_price_m_pk|Seq|_tlg_it_item_pk|Item Code|Item Name|Unit Price|Description'
                                format='0|0|0|0|0|0|1|0' aligns='0|0|1|0|0|0|0|0' check='|||||||' editcol='1|1|1|1|1|1|1|1'
                                widths='0|0|1000|0|1500|3000|1000|1000' sorting='T' styles='width:100%; height:100%'
                                oncelldblclick="OnPopUp('Detail')" onafteredit="CheckInput()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------->
    <gw:textbox id="txtValueReturn" styles='width:100%;display:none' />
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <!--------------------------------------------------------->
</body>
</html>
