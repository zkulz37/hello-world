<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%  ESysLib.SetUser("acnt")%>
<script>
var mua        = 3,
    ban        = 4,
    nhanvao    = 5,
    guidi      = 6,
    phimua     =7,
    phiban     = 8,
    tongphi    = 9,
    thue       = 10;
function BodyInit()
{
  grdDetail.AddRow();
  MergeHeaderGrid();
  grdDetail.GetGridControl().WordWrap = true;
  grdDetail.GetGridControl().RowHeight(0) = 300 ;
  BindingDataList();
  //OnSearch();
  OnFormatGrid();
      
}
function BindingDataList()
{
    var ls_company         = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_sanGd = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0005') FROM DUAL")%>|All|-Chọn Tất Cả-";
    lstCompany.SetDataText(ls_company);
    lsttrans.SetDataText(ls_sanGd);
    lsttrans.value="All";
}
function MergeHeaderGrid()
{
        var fg=grdDetail.GetGridControl(); 	    
        fg.FixedRows = 2
        fg.MergeCells =5	
		fg.MergeRow(0) = true
		
        fg.Cell(0, 0, 3,0, 6)  = "Giá Trị"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 3, 1) = "Mua"
	    fg.Cell(0, 1, 4, 1) = "Bán"
	    fg.Cell(0, 1, 5, 1) = "Được Nhận Vào"
	    fg.Cell(0, 1, 6, 1) = "Phải Gởi Đi"
	    
	    fg.Cell(0, 0, 7,0, 9)  = "Phí Giao Dịch"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 7, 1) = "Phí Mua"
	    fg.Cell(0, 1, 8, 1) = "Phí Bán"
	    fg.Cell(0, 1, 9, 1) = "Tổng Phí" 
	  
	    
		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "Sàn Giao Dịch"	
		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Ngày"	
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Loại Tài Khoản"	
		fg.MergeCol(10) = true
		fg.Cell(0, 0, 10, 1, 10) = "Thuế"	
	   
		
		//fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4; 
		//fg.Cell(10, 1, 1, 1,fg.Cols - 1) = true; //Format all col merge : Fone = Bold		
}
function OnSearch()
{
    dso_Search.Call("SELECT");
    
}
function OnDataRecive(obj)
{
    MergeHeaderGrid()
}
function OnFormatGrid()
{
    var trl;
    trl = grdDetail.GetGridControl();	
    trl.ColFormat(mua)                  = "###,###,###,###,###.##";    
    trl.ColFormat(ban)                  = "###,###,###,###,###.##";    
    trl.ColFormat(nhanvao)              = "###,###,###,###,###.##";
    trl.ColFormat(guidi)                = "###,###,###,###,###.##";
    trl.ColFormat(phimua)               = "###,###,###,###,###.##";    
    trl.ColFormat(phiban)               = "###,###,###,###,###.##";
    trl.ColFormat(tongphi)              = "###,###,###,###,###.##";
    trl.ColFormat(thue)                 = "###,###,###,###,###.##";
}
function OnPrint()
{
    var  url = '/reports/gf/os/gfos00060.aspx?company=' + lstCompany.value + '&giaodich=' + lsttrans.value + '&from=' + dtfrdate.value + '&to=' + dttodate.value ;
    //var  url = '/reports/gf/hg/gfhg00010.aspx?seq=6119' ;
    System.OpenTargetPage( System.RootURL+url , "newform" );
}
</script>
<body>
<gw:data id="dso_Search" onreceive="OnDataRecive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="acnt.sp_sel_gfos00060_search" > 
                <input> 
                    <input bind="lstCompany" /> 
                    <input bind="lsttrans" /> 
                    <input bind="dtfrdate" /> 
                    <input bind="dttodate" />  
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
 <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width:100%;height:5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td width="100%" align="center">
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                               
                                                    <td align="right" width="23%">
                                                        Công ty</td>
                                                    <td width="40%" colspan="5">
                                                        <gw:list id="lstCompany" styles='width:100%' />
                                                    </td>
                                                    
                                                    <td width="5%">
                                                    
                                                        <gw:imgbtn id="ibtnSearch" img="search" width="100%" alt="Search" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="5%"><gw:imgbtn id="ibtnSearch1" img="excel" width="100%" alt="Print" onclick="OnPrint()" /></td>
                                                   <td width="27%"></td>
                                                </tr>
                                                <tr>
                                                    <td width="23%" align="right">
                                                        Sàn Giao Dịch</td>
                                                    <td width="20%">
                                                        <gw:list id="lsttrans" styles='width:100%' />
                                                    </td>
                                                    <td width="20%" align="right">
                                                        Ngày Giao Dịch</td>
                                                    <td width="5%" >
                                                        <gw:datebox id="dtfrdate" type="date" lang="1" />
                                                    </td>
                                                   <td align="center">~</td>
                                                   <td width="5%"><gw:datebox id="dttodate" type="date" lang="1" /></td>
                                                   <td colspan="2" width="27%"></td>
                                                   
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                  </table>
                  </td> 
                           
        </tr>
        <tr style="width:100%;height:95%">
             <td width="100%">
                            <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                                height: 100%;">
                                <tr valign="top">
                                    <td width="100%">
                                    <!-- header="0._pk|1.Sàn Giao Dịch|2.Ngày|3.Loại Tài Khoản|4.Mua|5.Bán|6.Được Nhận Vào|7.Phải Gởi Đi|8.Phí Mua|9.Phí Bán|10.Tổng Phí|11.Thuế"  --> 
                                     <gw:grid   
                                        id="grdDetail"  
                                        
                                        header="Sàn Giao Dịch|Ngày|Loại Tài Khoản|Mua|Bán|Được Nhận Vào|Phải Gởi Đi|Phí Mua|Phí Bán|Tổng Phí|Thuế"   
                                        format="0|4|0|0|0|0|0|0|0|0|0"  
                                        aligns="2|2|2|3|3|3|3|3|3|3|3"  
                                        defaults="||||||||||"  
                                        editcol="0|0|0|0|0|0|0|0|0|0|0"  
                                        widths="1500|1100|1500|2000|2000|2000|2000|2000|2000|2000|2000"  
                                        styles="width:100%; height:100%"   
                                        sorting="T"   
                                        />
                                    </td>
                                    </tr>
                                    </table>
                                    </td>
                                    
        </tr>
    </table>
</body>
</html>