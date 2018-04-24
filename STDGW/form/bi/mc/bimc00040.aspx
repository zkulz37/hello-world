<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<head>
    <title>W/H Closing Checking</title>
</head>

<script>
 
 var G_PK=0;
//'_PK|_M_PK|Seq|_ITEM_PK|Item Code|Item Name|UOM|Lot No|Unit Price|Begin Qty|Begin Amount|In Qty|In Amount|Out Qty|Out Amount|End Qty|End Amount|Remark'
var 
    G1_ITEM_CODE    = 4,
    G1_ITEM_NAME    = 5,
    G1_UOM          = 6,
    G1_LOT_NO       = 7,
	G1_UPRICE		= 8,
    G1_BEGIN_QTY    = 9,
    G1_BEGIN_AMOUNT = 10,
	G1_IN_QTY  	= 11,
    G1_IN_AMOUNT    = 12,
    G1_OUT_QTY      = 13,   
    G1_OUT_AMOUNT   = 14,
    G1_END_QTY      = 15,
    G1_END_AMOUNT   = 16;
  
 //===============================================================
 function BodyInit()
 { 
    System.Translate(document);  // Translate to language session
    //----------------

    FormatGrid();
    OnChangeTab('radType');
    //----------------
	
	OnSetGrid();    
 }
 //===============================================================

 function FormatGrid()
 {
 		
		
    	data = "<%=ESysLib.SetListDataSQL("select pk, grp_cd || ' - ' || grp_nm from tlg_it_itemgrp where del_if = 0 and use_yn = 'Y' order by grp_cd ")%>||";     
    	lstItemGroup.SetDataText(data);
   	 	lstItemGroup.value = '';
   	 	
   	 	data = "<%=ESysLib.SetListDataFUNC("SELECT lg_get_report_lst2('bimc00040',1) FROM DUAL" )%>"; 
        lstReportType.SetDataText(data);

       data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_id||' * '||wh_name  FROM tlg_in_warehouse  WHERE del_if = 0 and use_yn = 'Y' ORDER BY wh_name  ASC" )%>";    
       lstWarehouse.SetDataText(data);

        //------------
        var ctrl = grdDetail.GetGridControl();
		ctrl.ColFormat(G1_UPRICE)       = "#,###,###,###,###,###.###";
        ctrl.ColFormat(G1_BEGIN_QTY)    = "#,###,###,###,###,###.###";
        ctrl.ColFormat(G1_BEGIN_AMOUNT) = "#,###,###,###,###,###.###";
        ctrl.ColFormat(G1_IN_QTY)       = "#,###,###,###,###,###.###";        
        ctrl.ColFormat(G1_IN_AMOUNT)    = "#,###,###,###,###,###.###";
        ctrl.ColFormat(G1_OUT_QTY)      = "#,###,###,###,###,###.###";
        ctrl.ColFormat(G1_OUT_AMOUNT)   = "#,###,###,###,###,###.###";
        ctrl.ColFormat(G1_END_QTY)      = "#,###,###,###,###,###.###";
        ctrl.ColFormat(G1_END_AMOUNT)   = "#,###,###,###,###,###.###";  
           
 }

 //===============================================================
 
 function OnSearch_Detail()
 {

    if ( grdVouchers.row > 0 )
            {
                txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G_PK );
                 data_bimc00040.Call("SELECT");
            }
 }
 
 //===============================================================
 function OnDataReceive(obj)
 {
    if(obj.id=="data_bimc00040")
      grdDetail.Subtotal( 0, 2, -1, '9!10!11!12!13!14!15!16','###,###,###.##');
 }
 
 //===============================================================



 //===============================================================
 
function OnReport()
{   
    var url =System.RootURL + '/reports/bi/mc/'+lstReportType.value+'?p_master_pk='+ txtMasterPK.text + '&p_item_grp_pk='+lstItemGroup.value +'&p_item='+txtItem.text;
    window.open(url); 
    
//	switch(pos)
//	{
//		case '10':
//			var url =System.RootURL + '/reports/bi/mc/rpt_bimc00040.aspx?p_wh_type='+ lstWHType.value +'&p_tin_warehouse_pk='+ lstWarehouse.value +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value +'&p_item='+txtItem.text;
//			window.open(url); 			
//		break;
//		
//		case '20':
//			var url =System.RootURL + '/reports/bi/mc/rpt_bimc00041.aspx?p_tin_warehouse_pk='+ lstWarehouse.value +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value +'&p_item='+txtItem.text;
//			window.open(url);   			
//		break;
//		
//		case '30':
//			var url =System.RootURL + '/reports/bi/mc/rpt_bimc00042.aspx?p_tin_warehouse_pk='+ lstWarehouse.value +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value ;
//			window.open(url);  			
//		break;	

//		case '40':
//			var url =System.RootURL + '/reports/bi/mc/rpt_bimc00043.aspx?p_item='+ txtItem.text +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value ;
//			window.open(url);   			
//		break;	
//		
//		case '41':
//			var url =System.RootURL + "/reports/bi/mc/rpt_bimc00045.aspx?p_from_date="+dtFrom.value+ "&p_to_date=" + dtTo.value ;
//				url = url + "&p_wh_type=" + lstWHType.value + "&p_wh=" + lstWarehouse.value + "&p_wh_name=" + lstWarehouse.GetText() ;
//				url = url + "&p_item_grp=" + lstItemGroup.value + "&p_item=" + txtItem.text ;
//			window.open(url);			
//		break;	

//		case '50':
//			var url =System.RootURL + '/reports/bi/mc/rpt_bimc00040_bkvn.aspx?p_item='+ txtItem.text +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value +'&p_tin_warehouse_pk='+ lstWarehouse.value +'&p_item_grp_pk='+lstItemGroup.value ;
//			window.open(url);       			
//		break;	

//		case 'ST01':
//			var url =System.RootURL + '/reports/bi/mc/rpt_bimc00040_ST01.aspx?p_wh_type='+ lstWHType.value +'&p_wh_pk='+ lstWarehouse.value +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value +'&p_item_grp_pk='+ lstItemGroup.value +'&p_item='+ txtItem.text ;
//			window.open(url);       			
//		break;
		
//		case 'FOSE01':
//			var url =System.RootURL + '/reports/bi/mc/rpt_bimc00040_FOSE01.aspx?p_wh_type='+ lstWHType.value +'&p_wh_pk='+ lstWarehouse.value +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value +'&p_item_grp_pk='+ lstItemGroup.value +'&p_item='+ txtItem.text ;
//			window.open(url);       			
//		break;
//	}
	 
}


function onSearch_Master()
{

    data_bimc00040_master.Call("SELECT");
            
}

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

 //=================================================================
</script>

<body>
	
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_bimc00040_master" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1" function="<%=l_user%>lg_sel_bimc00040_Master" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstWarehouse" />
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>


    <gw:data id="data_bimc00040" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_bimc00040" > 
                <input bind="grdDetail" >
                    <input bind="txtMasterPK" />
                    <input bind="lstItemGroup" />
                    <input bind="txtItem" />
                </input>
                <output bind="grdDetail" />
            </dso>
        </xml>
    </gw:data>
    
    <!-------------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height:1%">
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                        <td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td><td style="width: 1%"></td>
                    <tr>
                    <tr style="height: 5%">
                            <td colspan=5 style="width: 5%" align="right">Date</td>
                            <td colspan=20 style="width: 20%; white-space: nowrap">
                                <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01"   />
                                ~
                                <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01"   />
                            </td>
                        
                            <td colspan=5 style="width: 5%" align="right">
                                <gw:imgbtn id="ibtnSearch_M" img="search" alt="Search" text="Search" onclick="onSearch_Master()" />
                            </td>
                            
                            <td colspan=5 style="width: 5%" align="right">
                                Item
                            </td>
						    <td colspan=15 style="width: 15%; white-space: nowrap"  >
                                <gw:list id="lstItemGroup" styles="width:100%" onclick="" />
                            </td>
                            <td colspan=15 style="width: 25%; white-space: nowrap"  >
                                <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch_Detail()" />
                            </td>
                            
                            <td colspan=5 style="width: 5%" align="right">
                                <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch_Detail()" />
                            </td>
                            <td colspan=10 align="right" style="white-space: nowrap; width: 5%">
                            Report List
                            </td>
                            <td colspan=15 align="right" style="white-space: nowrap; width: 20%">
                                <gw:list id="lstReportType" styles='width:100%;' />
                            </td>
                            <td colspan=5 style="width: 5%" align="right">
							    <gw:imgbtn id="ibtnReport" img="excel" alt="report" text="Report" onclick="OnReport()" /> 	
                            </td>

                        
                    </tr>
                    <tr style="height: 5%">
                        <td colspan=5 style="width: 5%" align="right">
                                W/H
                            </td>
						 <td colspan=25 style="width: 25%; white-space: nowrap">                           
							<gw:list id="lstWarehouse" styles='width:100%' csstype="mandatory" onchange="" />
                        </td>
                        <td colspan=70 style="width: 25%; white-space: nowrap" align="center" >&nbsp;</td>
                        
                    </tr>
                   <tr style="height: 89%">
                        <td colspan=30>
                            <gw:grid id="grdVouchers" 
                                header="_PK|Date|Status|W/H" format="0|4|0|0" aligns="0|1|0|0"
                                defaults="|||" 
                                editcol="0|0|0|0" 
                                widths="0|1200|1000|1000" styles="width:100%; height:100%"
                                sorting="T" param="0,1,2,3" 
                                oncellclick="OnSearch_Detail()" />
                        </td>
                        <td colspan=70>
                            <gw:grid id='grdDetail' header='_PK|_M_PK|_Seq|_ITEM_PK|Item Code|Item Name|UOM|Lot No|Unit Price|Begin Qty|Begin Amount|In Qty|In Amount|Out Qty|Out Amount|End Qty|End Amount|Remark'
                                format='0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1' 
								aligns='0|0|0|0|0|0|1|1|3|3|3|3|3|3|3|3|3|0'
                                editcol='0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1' 
								widths='0|0|800|0|1500|2500|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1000'
                                sorting='T' styles='width:100%; height:100%' onafteredit="" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
    </table>
    <!-------------------------------------------------------------------------->
</body>
</html>
<gw:textbox id="txtMasterPK" styles="display:none;" />