<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("prod")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Group Entry</title>
</head>

<script>
var callerWindowObj = dialogArguments; 
function BodyInit()
{    
    Bingding();
    OnSearch();
    
}
function Bingding()
{
    var datalstCompany = "<%=ESysLib.SetListDataSQL("select pk, partner_name from comm.tco_company where del_if=0")%>"; 
    lstCompany.SetDataText(datalstCompany);  
     var datalstMachineNo = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>";    
    lstMachineNo.SetDataText(datalstMachineNo);
     var datalstSize = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0020') FROM DUAL" )%>";    
    lstSize.SetDataText(datalstSize);
    <%=ESysLib.SetGridColumnComboFormat("grdMoldPin",2,"select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0010' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdMoldPin",3,"select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;
    //txCompanyPK.text = "<%=session("company_pk") %>";
} 
function OnSearch()
{
    dsoMoldPin.Call("SELECT");
}
function OnDelete()
{
    grdMoldPin.DeleteRow();  
    if (confirm('Are you sure you want to delete?'))
        {
            dsoMoldPin.Call();
        }
}
function SetCompanyPKToGrid(){
    var Compk="<%=session("company_pk") %>";
    for(var i=0;i<grdMoldPin.rows;i++){
        if(grdMoldPin.GetGridData(i,8) == ""){
            grdMoldPin.SetGridText(i,8,Compk);
        }
    }
}
function OnSelectPin()
{
    dialogArguments.txtCapPinNo.text = grdMoldPin.GetGridData(grdMoldPin.row,4)
    dialogArguments.txtBodyPinNo.text = grdMoldPin.GetGridData(grdMoldPin.row,5) 
    this.close();	
}
</script>

<body bgcolor='#F5F8FF'>
    <gw:data id="dsoMoldPin"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8" function="PROD.sp_sel_shpb00020" procedure="PROD.sp_upd_shpb00020">  
                <input bind="grdMoldPin"   >  
                    <input bind="lstCompany" />  
                    <input bind="lstMachineNo" />  
                    <input bind="lstSize" />  	 															
                </input> 
                <output bind="grdMoldPin" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style=" height: 2%">
                        <td>
                        <fieldset>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td width="5%">
                                        Company
                                    </td>
                                    <td width="23%">
                                        <gw:list id="lstCompany" onchange="OnSearch()" />
                                    </td>
                                    <td width="9%">
                                        Machine No
                                    </td>
                                    <td width="18%">
                                        <gw:list id="lstMachineNo" onchange="OnSearch()" />
                                    </td>
                                    <td width="5%">
                                        Size
                                    </td>
                                    <td width="13%">
                                        <gw:list id="lstSize" onchange="OnSearch()" />
                                    </td>
                                    <td width="5%">
                                    </td>
                                    <td width="3%">
                                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                                    </td>                                   
                                </tr>
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="11">
                            <gw:grid id='grdMoldPin' header='_PK|No|Machine No|Size|Pin No(Cap)|Pin No(Body)|Install Date|Enter Date|_CompanyPK'
                                format='0|0|0|0|0|0|4|4|0' aligns='0|0|0|0|0|0|0|0|0' defaults='||||||||' editcol='1|0|1|1|1|1|1|1|1'
                                widths='1000|1500|1500|1500|1500|1500|1500|1500|0' sorting='T' styles='width:100%; height:100%'
                                autosize='T' oncelldblclick="OnSelectPin()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txCompanyPK" styles="display:none" />
</body>
