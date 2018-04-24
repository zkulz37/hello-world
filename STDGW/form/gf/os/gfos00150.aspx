<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Genuwin</title>
</head>
<%ESysLib.SetUser("acnt")%>
<script type="text/javascript" language="javascript">
function BodyInit()
{
      MergeHeader();  

    var ngaythanhtoan = "DATA|1|Ngày khớp lệnh|2|Ngày thanh toán";
    lstNgaythanhtoan.SetDataText(ngaythanhtoan);
}
function OnSearch()
{
    DSO_Grid.Call("SELECT");
}

function OnDataReceive(obj)
{
   if(obj.id=="DSO_Grid")
   {
       
           //   idgrid.Subtotal (0,2 ,0, '2!3!4!5','',true,1,'Tổng cộng');
		  
		            // idgrid.SetCellBgColor(idgrid.rows - 1,0,idgrid.rows - 1, idgrid.cols - 1,Number("0xabcdef"));
		          /*    for(i=1;i<idgrid.rows;i++)
		               {
				            if (idgrid.GetGridData(i,0)=="Tổng cộng")
				            {
					            idgrid.SetGridText(i,0,"");
					            idgrid.SetCellBgColor(i,0,i,1,0xabcdef);
				            }
		               }*/
		               
		               
    MergeHeader();
    var ctr=idgrid.GetGridControl(); 
			ctr.OutlineBar =2 ;
			 ctr.SubTotal(2,0, 3,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true);
			 ctr.SubTotal(2,0, 4,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true);
			 ctr.SubTotal(2,0, 5,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true); 
			 ctr.SubTotal(2,0, 6,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true); 
			 ctr.SubTotal(2,0, 7,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true);
			 ctr.SubTotal(2,0, 8,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true);
			 ctr.SubTotal(2,0, 9,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true); 
			 ctr.SubTotal(2,0, 10,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true); 
			 ctr.SubTotal(2,0, 11,'',0x99FFFF,0x000000,'1','Tổng cộng: ','',true);  
			 
			 ctr.SubTotal(2,1, 3,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);
             ctr.SubTotal(2,1, 4,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);
             ctr.SubTotal(2,1, 5,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);  
             ctr.SubTotal(2,1, 6,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);  
             ctr.SubTotal(2,1, 7,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);
             ctr.SubTotal(2,1, 8,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);
             ctr.SubTotal(2,1, 9,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);  
             ctr.SubTotal(2,1, 10,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);    
             ctr.SubTotal(2,1, 11,'',0x99FFCC,0x000000,'1','Tổng:%s ','',true);      
    }
}
function OnPrint()
{
             var from = dtNgayKhopLenh.value;
             var to =  dtNgayKhopLenh_to.value;
           
          
             from = from.substr(6,2) +"/"+ from.substr(4,2)+"/"+from.substr(0,4);
             to = to.substr(6,2) +"/"+ to.substr(4,2)+"/"+to.substr(0,4);
           var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=gf/os/rpt_gfos00150.rpt&procedure=acnt.rpt_sp_sel_gfos00150&parameter="+lstCompany.value+","+dtNgayKhopLenh.value+","+dtNgayKhopLenh_to.value+","+lstNgaythanhtoan.value+","+from+","+to;   
            
       System.OpenTargetPage( url , 'newform' ); 
}
function MergeHeader()
{
                var fg=idgrid.GetGridControl(); 	
        if(fg.Rows < 2)
		{
		   idgrid.AddRow();     
		}    
        fg.FixedRows = 2
        fg.MergeCells =5	
        
		fg.MergeRow(0) = true
		
		
		fg.Cell(0, 0, 3,0, 4)  = "VCB"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 3, 1, 3) = "Mua"
	    fg.Cell(0, 1, 4, 1, 4) = "Bán" 
	    
	   fg.Cell(0, 0, 5,0, 6)  = "BIDV"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 5, 1, 5) = "Mua"
	    fg.Cell(0, 1, 6, 1, 6) = "Bán"  
	   
	   fg.Cell(0, 0, 7,0, 8)  = "VCSC HCM"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 7, 1, 7) = "Mua"
	    fg.Cell(0, 1, 8, 1, 8) = "Bán"  
	   
	   fg.Cell(0, 0, 9,0, 10)  = "VCSC HN"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 9, 1, 9) = "Mua"
	    fg.Cell(0, 1, 10, 1, 10) = "Bán"  
	    
	   
	   fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Ngày thanh toán"	
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Ngày khớp lệnh"	
	    fg.MergeCol(11) = true
		fg.Cell(0, 0, 11, 1, 11) = "Tổng"	
		

    fg.ColFormat(3) = "###,###"; 
    fg.ColFormat(4) = "###,###"; 
	fg.ColFormat(5) = "###,###"; 
	fg.ColFormat(6) = "###,###"; 
	fg.ColFormat(7) = "###,###"; 
    fg.ColFormat(8) = "###,###"; 
	fg.ColFormat(9) = "###,###"; 
	fg.ColFormat(10) = "###,###"; 
	fg.ColFormat(11) = "###,###"; 
  
}
</script>
<body>
<gw:data id="DSO_Grid" onreceive="OnDataReceive(this)">
    <xml> 
        <dso id="2" type="grid" function="acnt.sp_sel_gfos00150_1"> 
            <input bind="idgrid">
                <input bind="lstCompany" />
                <input bind="dtNgayKhopLenh" />
				<input bind="dtNgayKhopLenh_to" />
				<input bind="lstNgaythanhtoan" />
            </input>
            <output bind="idgrid" /> 
        </dso> 
    </xml> 
</gw:data>
<table border="0"  cellpadding="0" cellspacing="0" style="width:100%;height:100%;">
 <tr style="width:100%;height:5%">
                      <td>
                             <fieldset style="padding:2">
                                      <table width="100%">
                                             <tr>
                                                      <td align="right" width="10%">Công ty</td>
                                                      <td width="50%"><gw:list id="lstCompany" style="width:100%" value="<%=Session("COMPANY_PK")%>" maxlen=100>                                
                                                                                 
                                                <data><%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%></data>
                                            </gw:list>
                                                      </td>
                                                      <td align="right" width="50%"><gw:list id="lstNgaythanhtoan" onchange="OnSearch()" style="width:100%"  />
                                                           
                                                      </td>
                                                      <td> <gw:datebox id="dtNgayKhopLenh" lang="<%=Session("Lang")%>"  /></td>
                                                       <td align="center">~</td>
                                                      <td > <gw:datebox id="dtNgayKhopLenh_to" lang="<%=Session("Lang")%>"  /></td>
                                                      <td ><gw:imgbtn id="btnSave" img="search" alt="Search" onclick="OnSearch()" /></td>
                                                      <td ><gw:imgbtn id="btnSave1" img="printer" alt="Print" onclick="OnPrint()" /></td>
                                             </tr>
                                      </table>
                             </fieldset>
                      </td>
              </tr>
              <tr   style="width:100%;height:95%">
                      <td width="100%">
                           <!--   0.|1.Ngày thanh toán|2.Ngày khớp lệnh|3.VCB_mua|4.VCB_ban|5.BIDV_mua|6.BIDV_ban|7.VCSCHCM_mua|8.VCSCHCM_ban|9.VCSCHN_mua|10.VCSCHN_ban|11.tong"-->
                                <gw:grid   
								             id="idgrid"
						                header  ="|Ngày thanh toán|Ngày khớp lệnh|VCB_mua|VCB_ban|BIDV_mua|BIDV_ban|VCSCHCM_mua|VCSCHCM_ban|VCSCHN_mua|VCSCHN_ban|tong"
						                format  ="0|4|4|0|0|0|0|0|0|0|0|0"  
						                aligns   ="0|0|0|3|3|3|3|3|3|3|3|3"  
						                defaults="|||||||||||"  
						                editcol ="0|0|0|0|0|0|0|0|0|0|0|0"  
						                widths  ="2500|1500|1500|2000|2000|2000|2000|2000|2000|2000|2000|2000"  
						                styles  ="width:100%; height:100%"
						                sorting="T" 
						                /> 
                            </td>
              </tr>
             
      </table>
</body>
</html>
