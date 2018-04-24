<!-- #include file="../../../system/lib/form.inc" -->
<html>
<%  ESysLib.SetUser("prod")%>
<head>
    <title>Daily Production Instruction</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
 
 //---------------------------------------------------------
 function BodyInit()
 {
//      OnSearch('grdDetail');
        var ldate;
        ldate = dtFrom.value ;         
        ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01';
        dtFrom.value = ldate;
      BindingDataList();
 }
 
 //---------------------------------------------------------
 function OnSearch()
 {      
       data_grdDailyProd.Call("SELECT");
 }

//----------------------------------------------------------
function BindingDataList()
 {    
         var fg = grdDailyProd.GetGridControl();
        fg.ColFormat(5)= "#,###,###,###";
        fg.ColFormat(6)= "#,###,###,###";
        var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
        data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>||";    
        lstMachineNo.SetDataText(data);
        lstMachineNo.value="";
        <%=ESysLib.SetGridColumnComboFormat("grdDailyProd",10,"select   code, code ||' - '|| code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0101' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
        <%=ESysLib.SetGridColumnComboFormat("grdDailyProd",11,"select   code, code ||' - '|| code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0040' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;
        <%=ESysLib.SetGridColumnComboFormat("grdDailyProd",20,"select   code, code||' - '||code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0010' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
        <%=ESysLib.SetGridColumnComboFormat("grdDailyProd",12,"select   code, code ||' - '|| code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
        txtCapPinNo.SetEnable(false);
        txtBodyPinNo.SetEnable(false); 
        dso_shpc00010.Call();
 }
function OnNew()
{
    if(lstMachineNo.value !="")
    {
    
        var path = System.RootURL + "/form/sh/pc/shpc00011.aspx?group_type=||||||";
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                        arrTemp = object[i];
                        grdDailyProd.AddRow(); 
                        //Form : 0 PK|1 _Item_pk|2 Product Code|3 Product Name|4 Lot No|5 Intructed Qty|6 Target Qty|7 Intructed Date|8 Require Day|9 Issue No|10 Type Code|11 Type Text|12 Size|13 Cap Color|14 Body Color|15 Printing|16 Customer Code|17 Customer Name|18 Color Match|19 Order No'
                        //Popup : 0 item_pk|1 buspartner_pk|2 Item Code|3 Item Name|4 Spec|5 Uom|6 Cap Color|7 Body Color|8 Cap Print Type|9 Body Print Type|10 Cap Print Color|11 Body Print Color|12 Size|13 Partner ID|14 Partner Name" 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 1, arrTemp[0]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 2,arrTemp[2] );
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 3, arrTemp[3]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 12, arrTemp[12]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 13, arrTemp[6]); 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 14, arrTemp[7]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 15, arrTemp[15]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 16, arrTemp[13]);  
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 17, arrTemp[14]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 23, arrTemp[1]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 19, lstCompany.value); 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 20, lstMachineNo.value);   
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 21, txtCapPinNo.text); 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 22, txtBodyPinNo.text); 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 24, lblPinType.text);                     
                    }           
	        }
	 }
	 else
	 {
	     alert("Please input Machine No.");
	 }
}
function OnSave()
{
     data_grdDailyProd.Call();
}
function OnchangMachine()
{
    dso_shpc00010.Call();
}
function OnDataReceive(obj)
{
    /*if(obj.id=='data_grdDailyProd')
    {
         if ( grdDailyProd.rows > 1 )
	            {
      		        grdDailyProd.SetCellBgColor(1, 2, grdDailyProd.rows-1, 4, 0xd4d2ff );
      		        grdDailyProd.SetCellBgColor(1, 8, grdDailyProd.rows-1, 9, 0xd4d2ff );
      		        grdDailyProd.SetCellBgColor(1, 12, grdDailyProd.rows-1, 17, 0xd4d2ff );
      		        
                    /*grdDailyProd.SetCellBold( 1, G1_OT_Hours,    grdDailyProd.rows - 1, G1_Line_Capa_Qty, true);
                    grdDailyProd.SetCellBold( 1, G1_Shift_Hours, grdDailyProd.rows - 1, G1_Shift_Hours,   true);      		        
                }
    }*/
    if(obj.id=='dso_shpc00010')
    {
        OnSearch();
    }
}
function OnDelete()
{
    if(confirm('Do you want to delete ?'))
            {
               grdDailyProd.DeleteRow();
               data_grdDailyProd.Call();
            }
}
function CanNotCheck()
{
    if(grdDailyProd.col==18)
    {
          grdDailyProd.row = -1;
    }
}
function OnchangeTarget()
{
    if(grdDailyProd.col==6)
    {
        for (i = 1; i < grdDailyProd.rows; i++)
        {
            if(grdDailyProd.GetGridData(i, 6) > grdDailyProd.GetGridData(i, 5)) 
            {
                alert("you must input target Qty smaller Instructed Qty row "+i);
            } 
        } 
     }
}
function OnPopupSaleOrder()
{
    if(lstMachineNo.value !="")
    {
        var fpath = System.RootURL + "/form/sh/pc/shpc00010_PopupSaleOrder.aspx";
            var object = System.OpenModal(fpath , 1000 , 600 , 'resizable:yes;status:yes'); 
            if ( object != null )
             {
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                        arrTemp = object[i];
                        grdDailyProd.AddRow(); 
                        //Form : 0 PK|1 _Item_pk|2 Product Code|3 Product Name|4 Lot No|5 Intructed Qty|6 Target Qty|7 Intructed Date|8 Require Day|9 Issue No|10 Type Code|11 Type Text|12 Size|13 Cap Color|14 Body Color|15 Printing|16 Customer Code|17 Customer Name|18 Color Match|19 Order No'
                        //Popup : 0_SaleOrderpkM|1_SaleOrderpkD|2_ItemPK|3_BuspartnerPK|4-order No|5-Order Date|6-Plan Qty|7-Order Qty|8-Balance|9-Item Code|10-Item Name|11-Spec|12-Uom|13-Cap Color|14-Body Color|15-Cap Print Type|16-Body Print Type|17-Cap Print Col|18-Body Print Col|19-Size Code|20-Partner ID|21-Partner Name|22 Print YN" 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 1, arrTemp[2]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 2,arrTemp[9] );
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 3, arrTemp[10]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 12, arrTemp[19]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 13, arrTemp[13]); 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 14, arrTemp[14]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 15, arrTemp[22]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 16, arrTemp[20]);  
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 17, arrTemp[21]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 23, arrTemp[3]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 25, arrTemp[1]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 5, arrTemp[8]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 26, arrTemp[4]);
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 19, lstCompany.value); 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 20, lstMachineNo.value);   
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 21, txtCapPinNo.text); 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 22, txtBodyPinNo.text); 
                        grdDailyProd.SetGridText( grdDailyProd.rows-1, 24, lblPinType.text);                     
                    }           
	        }
	}
	else
	 {
	     alert("Please input Machine No.");
	 }    
} 
function OnPrint()
{
    var fpath = System.RootURL + "/form/sh/pc/shpc00020.aspx?p_date_from="+dtFrom.value+"&p_date_to="+dtTo.value; 
                var object = System.OpenModal( fpath , 550 , 300 , 'resizable:yes;status:yes'); 
                
}
//------------------------------------------------------------------------------
</script>

<body>
    <gw:data id="dso_shpc00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="PROD.SP_PRO_shpc00010_SH" > 
                <input>
                     <input bind="lstCompany" />
                     <input bind="lstMachineNo" />
                </input> 
                <output>
                    <output bind="txtCapPinNo" />
                    <output bind="txtBodyPinNo" />
                    <output bind="lblPinType" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_grdDailyProd" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26" function="PROD.sp_sel_shpc00010_1_SH" procedure="PROD.sp_upd_shpc00010_1_SH">
                <input bind="grdDailyProd" >
                    <input bind="lstCompany" />
                    <input bind="lstMachineNo" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtCapPinNo" />
                    <input bind="txtBodyPinNo" />
                    <input bind="lblPinType" />
                </input>
                <output bind="grdDailyProd" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 15%" align="right" >
                <b>Plant</b>
            </td>
            <td style="width: 33%" align="right">
                <gw:list id="lstCompany" styles='width:100%' />
            </td>
            <td style="width: 15%" align="right">
                <b>Cap Pin No</b>
            </td>
            <td style="width: 25%" align="right">
                <gw:textbox id="txtCapPinNo" styles="width: 100%" />
            </td>
            <td style="width: 3%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn img="new" alt="New" onclick="OnNew()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
            </td>
        </tr>
        <tr style="height: 2%">
            <td style="width: 15%" align="right">
                <b>Machine No</b>
            </td>
            <td style="width: 25%" align="right">
               <gw:list id="lstMachineNo" onchange="OnchangMachine()" styles='width:100%' />
            </td>
            <td style="width: 15%" align="right">
                <b>Body Pin No</b>
            </td>
            <td style="width: 25%" align="right">
                <gw:textbox id="txtBodyPinNo" styles="width: 100%" />
            </td>
            <td style="width: 10%" align="right" colspan="2">Pin Type
            </td>
            <td style="width: 5%" align="right"><gw:label id="lblPinType" styles="width: 100%; color: red" />
            </td>
            <td style="width: 5%"><gw:imgBtn id="ibtnSearch"  alt="Popup"  img="popup" text="Search"  onclick="OnPopupSaleOrder()" /></td>
        </tr>
        <tr style="height: 2%">
            <td style="width: 15%" align="right">
                <b>Period Date</b>
            </td>
            <td style="width: 40%" align="left">
               <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
               ~
               <gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
            </td>
            <td style="width: 15%" align="right">
                <b>Enter Date</b>
            </td>
            <td style="width: 25%" align="left">
               <gw:datebox id="dtEnterDate" lang="<%=Session("Lang")%>" />
            </td>
            <td style="width: 5%" colspan="2" align="right"><gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnPrint()" styles='width:100%'/>
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="8">
                <gw:grid id='grdDailyProd' header='_PK|_Item_pk|Product Code|Product Name|Lot No|Intructed Qty|Target Qty|Intructed Date|Require Day|Issue No|Type Code|Type Text|Size|Cap Color|Body Color|Printing|Customer Code|Customer Name|Color Match|_Company_PK|_HOKI|_CapPinNo|_BodyPinNo|_TCO_BUSPARTNER_PK|_PrintType_YN|_SaleOrderD_PK|Sale Order No'
                    format='0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|3|3|0|3|3|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0' defaults='||||||||||||||||||||||||||'
                    editcol='1|1|0|0|0|1|1|1|0|0|1|1|0|0|0|0|0|0|0|1|1|1|1|1|1|0|0' widths='1000|1200|1200|1500|1500|1500|1500|1500|1500|1700|1500|1500|1500|1500|1500|1700|1500|1500|1500|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%' autosize='T' 
                    editcolcolor ="T" oncellclick="CanNotCheck()" onafteredit="OnchangeTarget()" />
            </td>
        </tr>
    </table>
   <gw:textbox id="txtGroupPK" style="display: none" />
</body>

</html>
