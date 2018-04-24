 

<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Declaration Liquidation</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script language="javascript" type="text/javascript">
var action ;
var action_ex_item = 'Search';
//------------------------------------------------------------------------------------
 //grdExpDecl
 var g_ex_pk        = 0,
     g_ex_Seq       = 1,
     g_ex_dec_no    = 2,
     g_ex_type      = 3,
     g_ex_reg_dt    = 4,
     g_ex_date      = 5,
     g_ex_curr      = 6,
     g_ex_tr        = 7,
     g_ex_rate      = 8,
     g_custom_pk    = 9,
     g_custom_off   = 10,
     g_tie_lidquiddoc_pk = 11;  
 //grdExpProd
    var g_exp_item_pk =0;
 //grdExpProdItem
    var gi_ex_decl_no   = 0,
        gi_ex_decl_dt   = 1 ,
        gi_ex_decl_type = 2;
        
   //grdImpDecl
    //0.pk|1.No|2.decl_no|3.decl_type|4.decl_date|5.import_date|6.tr_ccy|7.tot_net_tr_amt
    //|8.ex_rate|9.partner_name|10.tie_liquiddoc_pk|11.tex_decl_mst_pk|12.tco_busp--%> 
    var g_Liqui_im_dtl_pk = 0,
        g_im_no      = 1,   
        g_im_decl_no    = 2,
        g_im_decl_type  = 3,
        g_im_decl_dt    = 4,
        g_im_imp_dt     = 5,
        g_im_exp_dt     = 6,
        g_im_ccy        = 7,
        g_im_amt        = 8,
        g_im_ex_rate    = 9,

        g_im_part_nm    = 10,
        g_im_tie_liquiddoc = 11,
        g_im_tim_decl_mst_pk =12,
        g_im_tco_bus         =13;      
        

 
//------------------------------------------------------------------------------------
function BodyInit()
{
    
}

function OnPrint()
{
	if(rdoRPT.value==1)
	{
		 var url ='/reports/ep/hl/rpt_ephl00060.aspx?p_cus_code=' + txtcus_code.text +'&p_liquidation_seq=' + txtliquidation_seq.text + '&p_com_code=' + txtcom_code.text ;
    System.OpenTargetPage( System.RootURL+url , 'newform' );
	}
	if(rdoRPT.value==5)
	{
		 var url ='/reports/ep/hl/rpt_ephl00060_5.aspx?p_cus_code=' + txtcus_code.text +'&p_liquidation_seq=' + txtliquidation_seq.text + '&p_com_code=' + txtcom_code.text ;
    System.OpenTargetPage( System.RootURL+url , 'newform' );
	}
	if(rdoRPT.value==6)
	{
		 var url ='/reports/ep/hl/rpt_ephl00060_6.aspx?p_cus_code=' + txtcus_code.text +'&p_liquidation_seq=' + txtliquidation_seq.text + '&p_com_code=' + txtcom_code.text ;
    System.OpenTargetPage( System.RootURL+url , 'newform' );
	}
	
}

</script>

<body>
  
    <form id="form1" runat="server">
        <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
           
            <tr style="height: 1%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 50%">
                                    <td style="width: 1%" align="right">
                                        Date</td>
                                    <td style="width: 20%" align="left">
                                        <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" />
                                        ~<gw:datebox id="dtTo" lang="<%=Application("Lang")%>" /></td>
                                    <td style="width: 5%" align="right">
                                        Item</td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtItem" styles="width:100%;" onenterkey="OnSearch('Monthly')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print"   onclick="OnPrint()"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
            <tr style="height: 100%">
                <td >
                    <gw:tab id="idTab" onpageactivate="" style="width: 100%; height: 100%; border1px">
                    <table id="Báo cáo theo thanh lý máy" name="Báo cáo theo thanh lý máy" style="width: 100%; height: 100%"
                     <tr>
				    <td  valign="top" ><gw:radio id="rdoRPT" value="1" onchange="OnDisplay()">
                                        <span value="1">BC01: BC chi tiết NPL dùng để XS hàng XK </span><br></br>
                                        <span value="2">BC02: BC chi tiết NPL hủy, biếu tặng </span><br></br>
										 <span value="3">BC03: BC chi tiết NPL tái xuất </span> <br></br>
										  <span value="4">BC04: BC chi tiết NPL nộp thuế vào ngân sách </span><br></br>
										  <span value="5">BC05: BC tổng hợp NPL thanh lý </span><br></br>
										  <span value="6">BC06: BC chi tiết tính thuế NPL dùng để SX hàng XK </span><br></br>
										<span value="7">BC07: BC chi tiết tính  phạt chậm nộp NPL dùng để SX hàng XK </span><br></br>
										  <span value="8">BC08: BC chi tiết tính thuế NPL hủy, biếu tặng </span><br></br>
										  <span value="9">BC09: BC chi tiết tính  phạt chậm nộp NPL hủy,biếu tặng  </span><br></br>
                                       	<span value="10">BC10: BC chi tiết tính thuế NPL tái xuất trong hạn 1 năm </span><br></br>
										<span value="11">BC11: BC chi tiết tính thuế NPL tái xuất ngoài hạn 1 năm </span><br></br>
										<span value="12">BC12:BC chi tiết tính  phạt chậm nộp NPL tái xuất </span><br></br>
                                       	<span value="13">BC13: BC chi tiết tính thuế NPL nộp thuế vào ngân sách </span><br></br>
										<span value="14">BC14:BC chi tiết tính phạt chậm nộp NPL nộp thuế vào ngân sách</span><br></br>
										<span value="15">BC15:BC tổng hợp thuế thanh lý  </span><br></br>
                                       <span value="16">BC16:Các báo cáo thanh lý mở rộng  </span>
                                       
									   </gw:radio>
					</td>
					</tr>

                    </table>
                    <table id="Báo cáo theo QĐ 929" name="Báo cáo theo QĐ 929" style="width: 100%; height: 100%"
                        
                    </table>
                    <table id="Báo Cáo thông tư 59" name="Báo Cáo thông tư 59" style="width: 100%; height: 100%">
                       
                    </table>
					 <table id="BC Chế xuất" name="BC Chế xuất" style="width: 100%; height: 100%">
                        
                    </table>
					 <table id="Báo cáo theo TT1194" name="Import Materials" style="width: 100%; height: 100%">
                        
                    </table>
                   
                    </gw:tab>
                </td>
            </tr>
        </table>
    </form>
</body>
<gw:textbox id="txtcus_code" text="P03L" styles='display:none;' />
<gw:textbox id="txtliquidation_seq" text="1" styles='display:none;' />
<gw:textbox id="txtMasterPK" text="" styles='display:none;' />
<gw:textbox id="txtcom_code" text="0900283167" styles='display:none;' />
<gw:textbox id="txtResult" text="" styles='display:none;' />
<!---------------------------------------->
<gw:textbox id="txtExpDeclare" text="" styles='display:none;' />
</html>
