<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>P/R CHECKING 2</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>
 
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
    
 var G1_GROUP        = 0,
     G1_ITEM_CODE    = 1,
     G1_ITEM_NAME    = 2,
     G1_UOM     	 = 3,
	 G1_TOTAL_REQ	 = 4,
	 G1_TOTAL_PO	 = 5,
     G1_REQ_QTY_01   = 6,
	 G1_PO_QTY_01    = 7,
     G1_REQ_QTY_02   = 8,
	 G1_PO_QTY_02    = 9,
     G1_REQ_QTY_03   = 10,
	 G1_PO_QTY_03    = 11,
     G1_REQ_QTY_04   = 12,
	 G1_PO_QTY_04    = 13,
     G1_REQ_QTY_05   = 14,
	 G1_PO_QTY_05    = 15,
     G1_REQ_QTY_06   = 16,
	 G1_PO_QTY_06    = 17,
     G1_REQ_QTY_07   = 18,
	 G1_PO_QTY_07    = 19,
     G1_REQ_QTY_08   = 20,
	 G1_PO_QTY_08    = 21,
     G1_REQ_QTY_09   = 22,
	 G1_PO_QTY_09    = 23,
     G1_REQ_QTY_10   = 24,
	 G1_PO_QTY_10    = 25;
   
 //=========================================================================
 function BodyInit()
 {
    System.Translate(document);
      //---------------------- 
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
      //----------------------       
      OnFormatGrid();
      //----------------------
	  OnSearch('HEADER');  
 } 
  
 //=========================================================================
 function OnFormatGrid()
 {       
	  var ctr = grdDetail.GetGridControl(); 
      
	  ctr.ColFormat(G1_TOTAL_REQ)  = "#,###,###,###,###,###.##";  
	  ctr.ColFormat(G1_TOTAL_PO)   = "#,###,###,###,###,###.##";  
      ctr.ColFormat(G1_REQ_QTY_01) = "#,###,###,###,###,###.##";     
	  ctr.ColFormat(G1_REQ_QTY_02) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_REQ_QTY_03) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_REQ_QTY_04) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_REQ_QTY_05) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_REQ_QTY_06) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_REQ_QTY_07) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_REQ_QTY_08) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_REQ_QTY_09) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_REQ_QTY_10) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_01) = "#,###,###,###,###,###.##";     
	  ctr.ColFormat(G1_PO_QTY_02) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_03) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_04) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_05) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_06) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_07) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_08) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_09) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G1_PO_QTY_10) = "#,###,###,###,###,###.##";	  
      //--------------------------------------------------------
      ctr.MergeCells  = 2 ;	
      ctr.MergeCol(0) = true ;	
      ctr.MergeCol(1) = true ;   	
      ctr.MergeCol(2) = true ;	
      ctr.MergeCol(3) = true ;	
           
      var data = "<%=ESysLib.SetListDataSQL("select pk, grp_cd || ' - ' || grp_nm from comm.tco_itemgrp where del_if = 0 and use_yn = 'Y' order by grp_cd ")%>||";     
      lstGroup.SetDataText(data);
   	  lstGroup.value = '';	         
 }
//=========================================================================
 function OnSearch(pos)
 {
 		switch(pos)
		{
			case 'DETAIL' :
				data_epbp00270.Call("SELECT");
			break;
			
			case 'HEADER' :
				pro_epbp00270.Call();
			break;
		}        	    	   		                           
 }

//=========================================================================
function OnDataReceive(po_oData)
{
      switch (po_oData.id)         
      {		        
            case 'data_epbp00270' :            
                lbRecord.text = grdDetail.rows - 2 + '(s)';
				
				MergeGrid();
				
                if ( grdDetail.rows > 1 )
                {
                    grdDetail.SetCellBold( 1,    G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);
                    grdDetail.SetCellBgColor( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_UOM, 0xCCFFFF );
										
					grdDetail.SetCellBgColor( 2, G1_REQ_QTY_01, grdDetail.rows - 1, G1_PO_QTY_01, 0xFFFFCC );
					grdDetail.SetCellBgColor( 2, G1_REQ_QTY_03, grdDetail.rows - 1, G1_PO_QTY_03, 0xFFFFCC );
					grdDetail.SetCellBgColor( 2, G1_REQ_QTY_05, grdDetail.rows - 1, G1_PO_QTY_05, 0xFFFFCC );
					grdDetail.SetCellBgColor( 2, G1_REQ_QTY_07, grdDetail.rows - 1, G1_PO_QTY_07, 0xFFFFCC );
					grdDetail.SetCellBgColor( 2, G1_REQ_QTY_09, grdDetail.rows - 1, G1_PO_QTY_09, 0xFFFFCC );
					
					grdDetail.SetCellFontColor(1, G1_TOTAL_REQ, grdDetail.rows - 1, G1_TOTAL_REQ, 0x3300cc);
					grdDetail.SetCellFontColor(1, G1_TOTAL_PO,  grdDetail.rows - 1, G1_TOTAL_PO,  0xcc0033);
                }                 
            break; 
			
			case 'pro_epbp00270' :
								
				grdDetail.AddRow();
				
				MergeGrid();
				 
			break;                
      }      
}            
 
//=========================================================================
function MergeGrid()
{
				var fg = grdDetail.GetGridControl();								
				fg.FixedRows  = 2 ;
            	fg.MergeCells = 5 ;	
				
				fg.MergeRow(0) = true;
				
				fg.Cell(0, 0, G1_GROUP,     1, G1_GROUP     ) = "Group";
				fg.Cell(0, 0, G1_ITEM_CODE, 1, G1_ITEM_CODE ) = "Item Code";
				fg.Cell(0, 0, G1_ITEM_NAME, 1, G1_ITEM_NAME ) = "Item Name";
				fg.Cell(0, 0, G1_UOM,       1, G1_UOM       ) = "UOM";
				
				fg.Cell(0, 0, G1_TOTAL_REQ, 0, G1_TOTAL_PO ) = "Total";
				fg.Cell(0, 1, G1_TOTAL_REQ, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_TOTAL_PO,  1 ) = "P/O" ;
				
				fg.Cell(0, 0, G1_REQ_QTY_01, 0, G1_PO_QTY_01 ) = txtDept01.text; 
				fg.Cell(0, 1, G1_REQ_QTY_01, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_01,  1 ) = "P/O" ;
				fg.Cell(0, 0, G1_REQ_QTY_02, 0, G1_PO_QTY_02 ) = txtDept02.text; 
				fg.Cell(0, 1, G1_REQ_QTY_02, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_02,  1 ) = "P/O" ;				
				fg.Cell(0, 0, G1_REQ_QTY_03, 0, G1_PO_QTY_03 ) = txtDept03.text;
				fg.Cell(0, 1, G1_REQ_QTY_03, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_03,  1 ) = "P/O" ;				 
				fg.Cell(0, 0, G1_REQ_QTY_04, 0, G1_PO_QTY_04 ) = txtDept04.text; 
				fg.Cell(0, 1, G1_REQ_QTY_04, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_04,  1 ) = "P/O" ;				
				fg.Cell(0, 0, G1_REQ_QTY_05, 0, G1_PO_QTY_05 ) = txtDept05.text; 
				fg.Cell(0, 1, G1_REQ_QTY_05, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_05,  1 ) = "P/O" ;				
				fg.Cell(0, 0, G1_REQ_QTY_06, 0, G1_PO_QTY_06 ) = txtDept06.text;
				fg.Cell(0, 1, G1_REQ_QTY_06, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_06,  1 ) = "P/O" ;				 
				fg.Cell(0, 0, G1_REQ_QTY_07, 0, G1_PO_QTY_07 ) = txtDept07.text; 
				fg.Cell(0, 1, G1_REQ_QTY_07, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_07,  1 ) = "P/O" ;				
				fg.Cell(0, 0, G1_REQ_QTY_08, 0, G1_PO_QTY_08 ) = txtDept08.text; 
				fg.Cell(0, 1, G1_REQ_QTY_08, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_08,  1 ) = "P/O" ;				
				fg.Cell(0, 0, G1_REQ_QTY_09, 0, G1_PO_QTY_09 ) = txtDept09.text; 
				fg.Cell(0, 1, G1_REQ_QTY_09, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_09,  1 ) = "P/O" ;				
				fg.Cell(0, 0, G1_REQ_QTY_10, 0, G1_PO_QTY_10 ) = txtDept10.text;
				fg.Cell(0, 1, G1_REQ_QTY_10, 1 ) = "Req" ;
				fg.Cell(0, 1, G1_PO_QTY_10,  1 ) = "P/O" ;
}
//========================================================================= 
</script>

<body>     
	<!------------------------------------------------------------------>
    <gw:data id="pro_epbp00270" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epbp00270" > 
                <input> 
                    <input bind="txtDept01" />
                </input>
	           <output>
	                <output bind="txtDept01" /> 
					<output bind="txtDept02" />
					<output bind="txtDept03" />
					<output bind="txtDept04" />
					<output bind="txtDept05" />
					<output bind="txtDept06" />
					<output bind="txtDept07" />
					<output bind="txtDept08" />
					<output bind="txtDept09" />
					<output bind="txtDept10" />
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <gw:data id="data_epbp00270" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" user="prod"  function="<%=l_user%>lg_sel_epbp00270" >
                <input  bind="grdDetail">
                    <input bind="dtFrom" />
                    <input bind="dtTo" />                    
                    <input bind="lstGroup" />
                    <input bind="txtItem" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>     
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Req Date
                        </td>
                        <td style="width: 15%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" />
                            ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="width: 5%" align="right">
                            Group
                        </td>
                        <td style="width: 35%" align="right">
                            <gw:list id="lstGroup" styles="width: 100%" onchange="OnSearch('DETAIL')" />
                        </td>
                        <td style="width: 5%" align="right">
                            Item
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch('DETAIL')" />
                        </td>                       
                        <td style="width: 19%; white-space:nowrap" align="center">
                            <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>                        
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch('DETAIL')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdDetail' 
					header='Group|Item Code|Item Name|UOM|Req|P/O|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3'                   
					editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='2000|1500|2500|800|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200'
                    sorting='T' styles='width:100%; height:100%' />                
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
	<gw:textbox id="txtDept01" styles="width:100%;display:none" />
	<gw:textbox id="txtDept02" styles="width:100%;display:none" />
	<gw:textbox id="txtDept03" styles="width:100%;display:none" />
	<gw:textbox id="txtDept04" styles="width:100%;display:none" />
	<gw:textbox id="txtDept05" styles="width:100%;display:none" />
	<gw:textbox id="txtDept06" styles="width:100%;display:none" />
	<gw:textbox id="txtDept07" styles="width:100%;display:none" />
	<gw:textbox id="txtDept08" styles="width:100%;display:none" />
	<gw:textbox id="txtDept09" styles="width:100%;display:none" />
	<gw:textbox id="txtDept10" styles="width:100%;display:none" />
</body>
</html>
