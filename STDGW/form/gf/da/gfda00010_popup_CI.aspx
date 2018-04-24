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
                <dso id="1" type="grid" parameter="0" function="imex.sp_sel_CInvoice_AP"  > 
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
                <dso id="1" type="grid" parameter="0" function="imex.sp_sel_Inv_dtl_for_AP"  > 
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
                        header='_Pk|_Vendor_Pk|Vendor ID|Vendor Name|Invoice Date|Invoice No|Item Origin|Transport By|Ship Date|_Ship_Pk|Ship To|Place Loading|Place Discharge|Trade Terms|Pay Method|Pay Ccy|Ex Rate|Pay Term|Book Amt'
                        format='0|0|0|0|4|0|0|0|4|0|0|0|0|2|2|0|0|2|1'
                        aligns='0|0|0|0|1|0|0|1|1|0|0|0|0|0|1|1|3|0|3'
                        defaults='||||||||||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|0|1500|3000|1300|1500|1500|1400|1200|0|2500|2000|2000|1500|1500|1500|1000|2000|1500'
                        sorting='T'
                        oncellclick="onSelectRow()"
                        styles='width:100%; height:240'
                    />
                </td>
            </tr>
            <tr>
                <td colspan="9">
                <%--0._PK|1._TIM_CINV_MST_A_PK|2._TCO_ITEM_PK|3._TIM_ORDER_PK|4.ORDER NO|5.ITEM CODE|6.ITEM NAME|7.HS CODE|8.UNIT|9.PRICE|10.DECL QTY|11._cnv_ratio'--%>
                    <gw:grid id='grdCInvDetail'
                        header='_PK|_TIM_CINV_MST_A_PK|_TCO_ITEM_PK|_TIM_ORDER_PK|ORDER NO|ITEM CODE|ITEM NAME|HS CODE|UNIT|PRICE|DECL QTY|TR_AMT|_acc_pk'
                        format='0|0|0|0|0|0|0|0|0|0|0|1|0'
                        aligns='0|0|0|0|0|0|0|0|1|3|3|3|0'
                        defaults='||||||||||||'
                        editcol='1|1|1|1|1|1|1|1|1|1|1|1|1'
                        widths='0|0|0|0|1500|1500|2500|1300|1100|1050|1000|1000|0'
                        sorting='T'
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12"
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