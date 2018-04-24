<%@ Page Language="C#" %> 

<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Invoice</title>
</head>
 <%ESysLib.SetUser("comm");%>
 
 <script language="javascript" type="text/javascript">
 
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        
        var ldate;
        ldate=dtTo.value;
        dtFrom.value=ldate.substr(0,6) + '01';
        grdInvoice.GetGridControl().FrozenCols = 4;
        <%=ESysLib.SetGridColumnComboFormat("grdInvoice", 9, "select lower(a.CODE),  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0020' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; //trade term
        <%=ESysLib.SetGridColumnComboFormat("grdInvoice", 11, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; //curr
        <%=ESysLib.SetGridColumnComboFormat("grdInvoice", 10, "select lower(a.CODE),  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; //method
        <%=ESysLib.SetGridColumnComboFormat("grdInvoice", 13, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0020' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; //
    }
        
    function onSelectRow()
    {
        var row  = grdInvoice.row;
	    txtCinvPK.text  = grdInvoice.GetGridData(row,0);
	    dat_epgd00010_2.Call('');
    }
    //------------------------------------------------------------------------------------
    function OnSelect()
    {
        var code_data=new Array();
        var dataReturn = new Array();
	    var ctrl = grdInvoice.GetGridControl();
	    var index, rowNo
    	
	    index =0;
	    rowNo = 0 ;
    	
	    if(grdInvoice.SelectedRows == 0)
        {
            return ;
        }
        else
	    {
	        for(var i=0; i < ctrl.SelectedRows; i++)
		    {	  
	            rowNo = ctrl.SelectedRow(i)
	            for(var j=0; j < grdInvoice.cols -1; j++)
        	    {
        		    code_data[index] = grdInvoice.GetGridData(rowNo , j );
        		    index ++;
        	    }        
		    }
		    dataReturn[0]=code_data;
		    
		    for(i=1;i<grdCInvDetail.rows; i++)                      
            { 	
                code_data = new Array();
                index=0;
                for(j=0; j < grdCInvDetail.cols -1; j++)
        	    {
        		    code_data[index] = grdCInvDetail.GetGridData(i, j );
        		    index ++;
        	    }   
                dataReturn[i]=code_data; 
            }
	    }	   
	    window.returnValue = dataReturn; 
	    this.close(); 	
    }

 </script>
<body>
    <!------------------------------------------------------------------>
    <gw:data id="dat_epgd00010_1"  onreceive="" > 
        <xml> 
            <dso id="1" type="grid" parameter="0" function="imex.sp_sel_ex_CInvoice"  > 
                <input bind="grdInvoice">                    
                    <input bind="txtSlipNo" /> 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input> 
                <output bind="grdInvoice" /> 
            </dso> 
        </xml> 
    </gw:data> 
    <!------------------------------------------------------------------>
    <gw:data id="dat_epgd00010_2"  onreceive="" > 
        <xml> 
            <dso id="1" type="grid" parameter="0" function="imex.sp_sel_ex_Inv_dtl_for_decl"  > 
                <input bind="grdCInvDetail">                    
                    <input bind="txtCinvPK" /> 
                </input> 
                <output bind="grdCInvDetail" /> 
            </dso> 
        </xml> 
    </gw:data> 
    <!------------------------------------------------------------------>
    <form id="form1" runat="server">
    <div>
        <table cellpadding=0 cellspacing=0 border=0 width="100%">
            <tr>
                <td width="10%">Invoice No</td>
                <td width="15%"><gw:textbox id="txtSlipNo" csstype="filter" styles="width:100%;" /></td>
                <td width="15%" align=right >Invoice Date &nbsp;&nbsp;</td>
                <td width="10%"><gw:datebox id="dtFrom" lang="1" width="10%" csstype="filter"/></td>
                <td width="2%">~</td>
                <td width="10%"><gw:datebox id="dtTo" lang="1" width="10%" csstype="filter"/></td>
                <td width="30%"></td>
                <td width="2%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epgd00010_1.Call('SELECT')" /></td>
                <td width="2%"><gw:imgbtn id="btnSel" img="select" alt="Select" text="Select" onclick="OnSelect()" /></td>
            </tr>
            <tr>
                <td colspan="9">
                    <gw:grid id='grdInvoice'
                        header='_Pk|_Vend_Pk|Vendor ID|Vendor|Invoice Date|Invoice No|Contr No|Contr Date|Exp Date|Trade Terms|Pay Meth|Pay Curr.|Ex. Rate|Pay Term'
                        format='0|0|0|0|4|0|0|4|4|2|2|0|0|2'
                        aligns='0|0|0|0|1|0|0|1|1|0|0|0|3|0'
                        defaults='|||||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|0|0|2000|1200|1500|1500|1200|1200|1500|1500|1000|1300|1500'
                        sorting='T'
                        oncellclick="onSelectRow()"
                        styles='width:100%; height:240'
                    />
                </td>
            </tr>
            <tr>
                <td colspan="9">
                <%--'0._PK|1._TIM_CINV_MST_A_PK|2._TCO_ITEM_PK|3._TIM_ORDER_PK|4.ORDER NO|5.ITEM CODE|6.ITEM NAME
                |7.HS CODE|8.UNIT|9.PRICE|10.DECL QTY|11._cvn_ratio|12._unit_pack|13._qty_pack|14._tran_rate'--%>
                    <gw:grid id='grdCInvDetail'
                        header='_Pk|_Tim_Cinv_Mst_A_Pk|_Tco_Item_Pk|_Tim_Order_Pk|Order No|Item Code|Item Name|Hs Code|Unit|Price|Decl Qty|_Cvn_Ratio|_unit_pack|_qty_pack|_tran_rate|_weight_rate|_unit_weight|_net_weight'
                        format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        aligns='0|0|0|0|0|0|0|0|1|3|3|0|0|0|0|0|0|0'
                        defaults='|||||||||||||||||'
                        editcol='1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0'
                        widths='0|0|0|0|1500|1500|2500|1300|1100|1050|1000|0|0|0|0|0|0|0'
                        sorting='T'
                        param="0,1,2,3,4,5,6,7,8,9,10"
                        styles='width:100%; height:260'
                    />
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
<gw:textbox id="txtCinvPK"  styles="display:none" />