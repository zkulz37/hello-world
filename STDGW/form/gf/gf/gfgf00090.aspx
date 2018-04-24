﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>
//var Insert      = 'F';
//var Modify      = 'F';
//var Delete    = 'F';
function BodyInit()
{   
            System.Translate(document);
           BindingDataList();
           FormatGrid(); 
}
function BindingDataList()
{
        txtCompany.text = "<%=Session("COMPANY_PK") %>";
       //----- Depr. method 
       <%=ESysLib.SetGridColumnComboFormat("grdDetail", 20, "SELECT TRIM(A.CODE), A.CODE_NM FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACDF0060'")%>; 
       //--------CCY
       <%=ESysLib.SetGridColumnComboFormat("grdDetail", 28,"SELECT TRIM(A.CODE), A.CODE_NM FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110'")%>; 
       //--------Status------------
       <%=ESysLib.SetGridColumnComboFormat("grdDetail", 41,"SELECT TRIM(A.CODE), A.CODE_NM FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACDF0070'")%>; 
       //------Kind----------
       <%=ESysLib.SetGridColumnComboFormat("grdDetail", 17,"SELECT b.CODE, b.code||'--'||B.CODE_NM from tco_abcodegrp a, tco_abcode b where a.pk = b.tco_abcodegrp_pk  and a.del_if = 0 and b.del_if = 0 and a.id = 'ACDF0010'" )%>; 
	   //------Location----------
	   
	   <%=ESysLib.SetGridColumnComboFormat("grdDetail", 3,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0025' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM" )%>; 
	   var trl = grdDetail.GetGridControl();
	 	trl.FrozenCols = 5;

	   
}
//-----------------------------------------------------------------------------------------
function OnSearch()
{
        dat_Update.Call("SELECT");
}
//----------------------------------------------------
function FormatGrid()
{
            var trl;
    trl = grdDetail.GetGridControl();	
    trl.ColFormat(29)              = "###,###,###,###,###";
    trl.ColFormat(30)              = "###,###,###,###,###";
    trl.ColFormat(31)              = "###,###,###,###,###";
    trl.ColFormat(32)              = "###,###,###,###,###";
    trl.ColFormat(33)              = "###,###,###,###,###";
    trl.ColFormat(34)              = "###,###,###,###,###";
    trl.ColFormat(35)              = "###,###,###,###,###";
    trl.ColFormat(36)              = "###,###,###,###,###";
    trl.ColFormat(37)              = "###,###,###,###,###";
    trl.ColFormat(38)              = "###,###,###,###,###";
    trl.ColFormat(39)              = "###,###,###,###,###";
    trl.ColFormat(40)              = "###,###,###,###,###";
	trl.ColFormat(47)              = "###,###,###,###,###";
	trl.ColFormat(48)              = "###,###,###,###,###";
	trl.ColFormat(50)              = "###,###,###,###,###";
}
function OnPrint()
{
                var url = System.RootURL + "/reports/gf/gf/gfgf00090.aspx?company_pk=" +lstCompany.value  + '&Asset=' + txtVoucher.text;     
                 System.OpenTargetPage(url);      
}
function OnNew()
{
            var i = 0;
            
             grdDetail.AddRow();
          for(i=1; i < grdDetail.rows; i++)
           {
                   grdDetail.SetGridText(grdDetail.rows-1, 0, i);
                 
           }     
      
}

function OnSave()
{
           for(i=1; i < grdDetail.rows; i++)
           {
                   grdDetail.SetGridText(grdDetail.rows-1, 0, i);
                   if(grdDetail.GetGridData(i,63) == '')
                   { 
                        grdDetail.SetGridText(i, 63, txtCompany.text); 
                    } 
           }     
        dat_Update.Call();
}

function OnDelete(obj)
{
        switch(obj)
        {
                case 1:
                            grdDetail.DeleteRow();        
                break;
                case 2:
                            if(confirm("Are you sure you want to delete all data!!"))
                            {
                                    dso_Delete.Call();
                            } 
                break;
        } 
        
}
function OnRefresh()
{
        grdDetail.GridRefresh();

}
function OnDataReceive(obj)
{
        if(obj.id=='dat_Update')
       {
                FormatGrid();
       } 
       else if(obj.id=='dso_Delete')
       {
                OnSearch();
       }
}
function OnTotal_Month()
{
            var Year = Number(grdDetail.GetGridData(grdDetail.row, 24));
            var Month = Number(grdDetail.GetGridData(grdDetail.row, 25));
            var Total_Month = Number((Year * 12) + Month);
            grdDetail.SetGridText(grdDetail.row, 26, Total_Month);  
}
</script>

<body>
<gw:data id="dat_Update"   onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64" function="sp_sel_gfgf00090" procedure="sp_upd_gfgf00090"   > 
            <input bind="grdDetail">                    
               
                <input bind="lstCompany" /> 
                <input bind="txtVoucher" /> 
            </input> 
            <output bind="grdDetail" /> 
        </dso> 
    </xml> 
</gw:data>   
 
  <gw:data id="dso_Delete" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="process" procedure="ac_pro_tac_gffa_mst" >
                <input> 
					<input bind="tac_gffa_mst_pk" />                    				 
                </input>  
                <output>
                     <output bind="txtReturn" />
				</output> 
            </dso> 
        </xml> 
    </gw:data>
    
    <table style="background: #BDE9FF; height: 100%; width: 100%" >
        <tr>
      
            <td style="background: white; width: 100%" id="idRIGHT">
                <table cellpadding="0" cellspacing="0" style="height: 100%; width: 100%" border="0">
                    <tr style="height: 5%" width="100%">
                        <td width="100%">
                            <fieldset style="padding:4">
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td align="right" width="8%">Company&nbsp;</td>
                                        <td  width="42%"><gw:list id="lstCompany" style="width:100%" value="<%=Session("COMPANY_PK")%>" maxlen=100>                                
                                                <data><%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%></data>
                                            </gw:list>
                                         </td>
                                        
                                        <td align="right" width="15%">Asset&nbsp;</td>
                                        <td width="30%"> <gw:textbox id="txtVoucher" onenterkey="OnSearch()" styles='width:100%;' /></td>
                                       <td width="5%"></td> 
                                       <td><gw:imgbtn img="refresh" alt="Search" onclick="OnRefresh()" /></td> 
                                        <td><gw:imgbtn img="search" alt="Search" onclick="OnSearch()" /></td>
                                       <td><gw:imgbtn img="new" alt="New" onclick="OnNew()" /></td> 
                                       <td><gw:imgbtn img="save" alt="Save" onclick="OnSave()" /></td> 
                                       <td><gw:imgbtn img="delete" alt="Delete" onclick="OnDelete(1)" /></td> 
                                        <td><gw:imgbtn img="excel" alt="Print" onclick="OnPrint()" /></td>
                                       <td><gw:imgbtn img="deselectall" alt="Delete All" onclick="OnDelete(2)" /></td> 
                                    </tr>
                                   
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 95%" width="100%">
                        <td>
                            <!--header='0.No|1.Asset Code|2.Ref.No|3.Asset/Tool|4.Asset Name|5.Local Name|6.Kor.Name|7.Account Code|8.Acc.Name|9.Acc.Depr Code|10.Acc.Depr Name|11.Acc.Expense Code|12.Acc.Expense Name|13.P/L Unit Code|14.P/L Unit Name|15.P/L Center Code|16.P/L Center Name|17.Kind|18.Department|19.Charger|20.Depr. Method|21.Depr. Rate|22.Service Date|23.Depr. Date|24.Estime life(year)|25.Month(s)|26.Total month(s)|27.Day(s)|28.CCY|29.Original Cost|30.Original Amt|31.Begin Depr|32.Begin Depr Amt|33.Monthly Depr|34.Monthly Depr Amt|35.Daily Depr|36.Daily Depr Amt|37.Accum Depr|38.Accum Depr Amt|39.Remain Depr|40.Remain Depr Amt|41.Status|42.Prod Year|43.Invoice Date|44.Invoice No|45.Serial No|46.Voucher No|47.Price|48.Amount|49.Origin|50.Quantity|51.Capacity|52.Model|53.Engine No|54.Location|55.Description|56.Local Description|57._pk|58._acc_pk|59._acc_exp_pk|60._acc_depr_pk|61._plunit_pk|62._plcenter_pk|63._company_pk|64._department_pk'-->
                            <gw:grid id="grdDetail" 
                                header='No|Asset Code|Ref.No|Asset/Tool|Asset Name|Local Name|Kor.Name|Account Code|Acc.Name|Acc.Depr Code|Acc.Depr Name|Acc.Expense Code|Acc.Expense Name|P/L Unit Code|P/L Unit Name|P/L Center Code|P/L Center Name|Kind|Department|Charger|Depr. Method|Depr. Rate|Service Date|Depr. Date|Estime life(year)|Month(s)|Total month(s)|Day(s)|CCY|Original Cost|Original Amt|Begin Depr|Begin Depr Amt|Monthly Depr|Monthly Depr Amt|Daily Depr|Daily Depr Amt|Accum Depr|Accum Depr Amt|Remain Depr|Remain Depr Amt|Status|Prod Year|Invoice Date|Invoice No|Serial No|Voucher No|Price|Amount|Origin|Quantity|Capacity|Model|Engine No|Location|Description|Local Description|_pk|_acc_pk|_acc_exp_pk|_acc_depr_pk|_plunit_pk|_plcenter_pk|_company_pk|_department_pk'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                                aligns='1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|3|1|1|3|3|3|3|1|3|3|3|3|3|3|3|3|3|3|3|3|1|1|1|0|0|0|3|3|0|3|0|1|0|1|0|0|0|0|0|0|0|0|0|1' 
                                defaults='|||||||||||||||||||||||||||||||||||||||||A|||||||||||||||||||||||' 
                               editcol='0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                                widths='500|2000|2000|1500|3000|3000|3000|2000|3000|2000|3000|2000|3000|2000|3000|2000|3000|3000|4000|3000|1500|1500|1200|1200|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1200|1000|1200|2000|2000|2000|2000|2000|3000|2000|2000|1500|2000|1500|3000|3000|0|0|0|0|0|0|0|0' 
                                sorting='T' styles="width:100%;height:100%" 
                               acceptNullDate
                               onafteredit="OnTotal_Month()"  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------->
    <gw:textbox id="txtCompany" styles='width:100%;display:none' />
    <gw:textbox id="tac_gffa_mst_pk" styles='width:100%;display:none' />
        <gw:textbox id="txtReturn" styles='width:100%;display:none' />

    <!---------------------------------------------------------------------->
</body>
</html>
