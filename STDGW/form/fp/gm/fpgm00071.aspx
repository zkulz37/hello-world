<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Output Detail</title>
</head>

<script> 

var G2_COMP_PK      = 0,
    G2_IN_COMP_ID   = 1,
    G2_IN_COMP_NAME = 2,
    G2_SPEC01_PK    = 3,
    G2_SPEC01_ID    = 4,
    G2_SPEC02_PK    = 5,
    G2_SPEC02_ID    = 6,
    G2_SPEC03_PK    = 7,
    G2_SPEC03_ID    = 8,
    G2_SPEC04_PK    = 9,
    G2_SPEC04_ID    = 10, 
    G2_SPEC05_PK    = 11,
    G2_SPEC05_ID    = 12,
    G2_PLAN_QTY     = 13,
    G2_REQ_QTY      = 14,
    G2_PROD_QTY     = 15,
    G2_BAL_QTY      = 16;
	
var G3_DATE      = 0,
    G3_LINE      = 1,
    G3_COMP      = 2,
    G3_SPEC_01   = 3,
    G3_SPEC_02   = 4,
    G3_SPEC_03   = 5,
    G3_SPEC_04   = 6,
    G3_SPEC_05   = 7,
    G3_LOT       = 8,
    G3_CARD      = 9,
    G3_PROD      = 10,
    G3_DEFECT    = 11;	
 
//===============================================================================================
 function BodyInit()
 {  
      System.Translate(document);
	  
	  var ordplan_pk  = "<%=request.QueryString("ordplan_pk") %>";
	  txtOrdPlanPK.text = ordplan_pk ;	
	  
	  var pr_pk  = "<%=request.QueryString("pr_pk") %>";
	  txtProcessPK.text = pr_pk ;		  
    
      OnFormatGrid();	 	 
	  
	  OnChangeTab('chkDetail');
	  
	  OnSearch('header');
 } 

//===============================================================================================
 function OnFormatGrid()
 {
      var data="";    
      //-----------
      data = "data|VIE|VIE|ENG|ENG|KOR|KOR";
      lstLang.SetDataText(data);      
      lstLang.value = "<%=Session("SESSION_LANG")%>";	   
	
      grdDetail.GetGridControl().MergeCells  = 2 ;	
      grdDetail.GetGridControl().MergeCol(0) = true ;	
      grdDetail.GetGridControl().MergeCol(1) = true ;  
      grdDetail.GetGridControl().MergeCol(2) = true ; 
      grdDetail.GetGridControl().MergeCol(3) = true ; 
      grdDetail.GetGridControl().MergeCol(4) = true ; 
      grdDetail.GetGridControl().MergeCol(5) = true ; 
      grdDetail.GetGridControl().MergeCol(6) = true ;
      grdDetail.GetGridControl().MergeCol(7) = true ;
      grdDetail.GetGridControl().MergeCol(8) = true ;
      grdDetail.GetGridControl().MergeCol(9) = true ;
      grdDetail.GetGridControl().MergeCol(10) = true ;
      grdDetail.GetGridControl().MergeCol(11) = true ;
      grdDetail.GetGridControl().MergeCol(12) = true ;	
      grdDetail.GetGridControl().MergeCol(13) = true ;	
	  grdDetail.GetGridControl().MergeCol(14) = true ; 
	  grdDetail.GetGridControl().MergeCol(15) = true ;  	  	  	  	  	  
	  
      var trl ;
    
	  trl = grdDetail.GetGridControl();
    
      trl.ColFormat(G2_PLAN_QTY) = "###,###,###,###,###";
      trl.ColFormat(G2_REQ_QTY)  = "###,###,###,###,###";
      trl.ColFormat(G2_PROD_QTY) = "###,###,###,###,###";
			
 }
 
//===============================================================================================
 function OnDataReceive(po_oData)
 {
    switch (po_oData.id)
    {
            case 'data_fpgm00071_header':
            if(grdHeader.rows>1)
            {
                var col1=grdHeader.GetGridData(1,2);
                var dis_col1=grdHeader.GetGridData(1,3);
                var col2=grdHeader.GetGridData(1,4);
                var dis_col2=grdHeader.GetGridData(1,5);
                var col3=grdHeader.GetGridData(1,6);
                var dis_col3=grdHeader.GetGridData(1,7);
                var col4=grdHeader.GetGridData(1,8);
                var dis_col4=grdHeader.GetGridData(1,9);
                var col5=grdHeader.GetGridData(1,10);
                var dis_col5=grdHeader.GetGridData(1,11);
                if(dis_col1!=0)
                {
                    grdDetail.SetGridText(0,G2_SPEC01_ID,col1);
                    grdDetail.GetGridControl().ColHidden(G2_SPEC01_ID) = false ;
					
					grdTrans.SetGridText(0,G3_SPEC_01,col1);
                    grdTrans.GetGridControl().ColHidden(G3_SPEC_01) = false ;
					
					lbSpecGrp01.text = col1;
					chkSpecGrp01.value = 'Y';
					chkSpecGrp01.style.display = "";	                    
                }
				else
				{
					chkSpecGrp01.style.display = "none";
				}
					
                if (dis_col2!=0)
                {
                    grdDetail.SetGridText(0,G2_SPEC02_ID,col2);
                    grdDetail.GetGridControl().ColHidden(G2_SPEC02_ID) = false ;
					
					grdTrans.SetGridText(0,G3_SPEC_02,col2);
                    grdTrans.GetGridControl().ColHidden(G3_SPEC_02) = false ;					
                    
					lbSpecGrp02.text = col2;
					chkSpecGrp02.value = 'Y';
					chkSpecGrp02.style.display = "";	
                }
				else
				{
					chkSpecGrp02.style.display = "none";
				}
				
                if (dis_col3!=0)
                {
                    grdDetail.SetGridText(0,G2_SPEC03_ID,col3);
                    grdDetail.GetGridControl().ColHidden(G2_SPEC03_ID) = false ;

					grdTrans.SetGridText(0,G3_SPEC_03,col3);
                    grdTrans.GetGridControl().ColHidden(G3_SPEC_03) = false ;
					                    
					lbSpecGrp03.text = col3;
					chkSpecGrp03.value = 'Y';
					chkSpecGrp03.style.display = "";						
                }
				else
				{
					chkSpecGrp03.style.display = "none";
				}
				
                if (dis_col4!=0)
                {
                    grdDetail.SetGridText(0,G2_SPEC05_ID,col4);
                    grdDetail.GetGridControl().ColHidden(G2_SPEC04_ID) = false ;
					
					grdTrans.SetGridText(0,G3_SPEC_04,col4);
                    grdTrans.GetGridControl().ColHidden(G3_SPEC_04) = false ;					

					lbSpecGrp04.text = col4;
					chkSpecGrp04.value = 'Y';
					chkSpecGrp04.style.display = "";	                    
                }
				else
				{
					chkSpecGrp04.style.display = "none";
				}
				
                if (dis_col5!=0)
                {
                    grdDetail.SetGridText(0,G2_SPEC05_ID,col5);
                    grdDetail.GetGridControl().ColHidden(G2_SPEC05_ID) = false ;
					
					grdTrans.SetGridText(0,G3_SPEC_05,col5);
                    grdTrans.GetGridControl().ColHidden(G3_SPEC_05) = false ;					

					lbSpecGrp05.text = col5;
					chkSpecGrp05.value = 'Y';
					chkSpecGrp05.style.display = "";	                    
                }
				else
				{
					chkSpecGrp05.style.display = "none";
				}
            }
        break;       
				
        case 'data_fpgm00071' :            
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBgColor( 1, G2_IN_COMP_ID,  grdDetail.rows - 1, G2_IN_COMP_NAME, 0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G2_BAL_QTY,  grdDetail.rows - 1, G2_BAL_QTY, 0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G2_REQ_QTY,  grdDetail.rows - 1, G2_REQ_QTY, 0xCCFFFF );
                
                grdDetail.SetCellBold( 1, G2_IN_COMP_ID,     grdDetail.rows - 1, G2_IN_COMP_ID, true);
                grdDetail.SetCellBold( 1, G2_PLAN_QTY,    grdDetail.rows - 1, G2_BAL_QTY, true);				
				 
               	grdDetail.Subtotal( 0, 2, -1, '13!14!15','###,###,###');
			    
            }                   
        break;             
    }
 } 
 
//===============================================================================================
 function OnSearch(pos)
 {
      switch(pos)
        {
			case 'header':
				data_fpgm00071_header.Call('SELECT');
			break;
            
            case 'Detail':
				if ( chkDetail.GetData() == 'Y' )
				{
                	data_fpgm00071_1.Call('SELECT');
				}
				else
				{
					data_fpgm00071.Call('SELECT');
				}	
            break;
        }        
 }
 
//===================================================================================

 function OnChangeTab(pos)
 {
    switch(pos)
    {
        case 'chkDetail':
            var strRad = chkDetail.GetData();
                     
	        switch (strRad)
	        {
		        case 'N':        		    
		            grdDetail.style.display = "";        		      
		            grdTrans.style.display  = "none";		     
                break;
                
                case 'Y':
		            grdDetail.style.display = "none";        		      
		            grdTrans.style.display  = "";			    	   		    
                break;	
            }                
        break;
    } 
 }
 
  //===============================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_fpgm00071_header" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_fpgm00071_header"> 
                <input bind="grdHeader"  > 
                </input> 
                <output bind="grdHeader" /> 
            </dso>            
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <gw:data id="data_fpgm00071" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso type="grid" user="prod"   function="<%=l_user%>lg_sel_fpgm00071"   >
                <input >
                    <input bind="txtOrdPlanPK" />
                    <input bind="txtProcessPK" />					 
					<input bind="txtComponent" />
					<input bind="lstLang" />
					<input bind="chkMainPart" />
					
					<input bind="chkSpecGrp01" />
					<input bind="chkSpecGrp02" />
					<input bind="chkSpecGrp03" />
					<input bind="chkSpecGrp04" />
					<input bind="chkSpecGrp05" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>	 
 	<!----------------------------------------------------------------------->
    <gw:data id="data_fpgm00071_1" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso type="grid" user="prod"   function="<%=l_user%>lg_sel_fpgm00071_1"   >
                <input >
                    <input bind="txtOrdPlanPK" />
                    <input bind="txtProcessPK" />					 
					<input bind="txtComponent" />
					<input bind="lstLang" />
					<input bind="chkMainPart" />
					
					<input bind="chkSpecGrp01" />
					<input bind="chkSpecGrp02" />
					<input bind="chkSpecGrp03" />
					<input bind="chkSpecGrp04" />
					<input bind="chkSpecGrp05" />
                </input> 
                <output bind="grdTrans" /> 
            </dso> 
        </xml> 
    </gw:data>	 	
    <!---------------------------------------------------------------------->
                <table style="width: 100%; height: 100%">				         					
                    <tr style="height: 1%">                         											 					
						<td align="right" style="width: 5%">
                            Component
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtComponent" styles="width:100%" onenterkey="OnSearch('Detail')" />
                        </td> 						
						<td style="width: 5%; white-space: nowrap" align="right">
                            Lang</td>
                        <td style="width: 30%; white-space: nowrap" align="left">
                            <gw:list id="lstLang" styles='width:100%' onchange="OnSearch('Detail')" />
                        </td>						 
						<td style="width: 20%" align="left">
							Main Part
                			<gw:checkbox id="chkMainPart" styles="color:blue" defaultvalue="Y|N" value="N" onchange="OnSearch('Detail')"></gw:checkbox>	
						</td>
						<td style="width: 9%" align="center">
							<gw:checkbox id="chkDetail" defaultvalue="Y|N" value="N" onchange="OnChangeTab('chkDetail')" /> <b style="color: Purple">Detail</b>
						</td>										            
			            <td style="width: 1%" align="right">	
							<gw:imgbtn id="btnSearch" img="search" onclick="OnSearch('Detail')" />		                 
            			</td>			                        						                         
                    </tr>   
					<tr>
						<td colspan=14 >
							<table style="width: 100%; height: 100%" >
								<tr>	
									<td style="width: 10%; white-space: nowrap" align="right">	
										<gw:label id="lbSpecGrp01" styles='width:100%;color:cc0000;font:9pt'></gw:label>									                 
						            </td>			             
						            <td style="width: 10%; white-space: nowrap" align="left">								 					
						                <gw:checkbox id="chkSpecGrp01" defaultvalue="Y|N" value="N" onclick="OnSearch('Detail')"  />
						            </td>	
									<td style="width: 10%; white-space: nowrap" align="right">	
										<gw:label id="lbSpecGrp02" styles='width:100%;color:cc0000;font:9pt'></gw:label>									                 
						            </td>			            
						            <td style="width: 10%; white-space: nowrap" align="left">													 
						                <gw:checkbox id="chkSpecGrp02" defaultvalue="Y|N" value="N" onclick="OnSearch('Detail')"  />
						            </td>	
									<td style="width: 10%; white-space: nowrap" align="right">	
										<gw:label id="lbSpecGrp03" styles='width:100%;color:cc0000;font:9pt'></gw:label>									                 
						            </td>			            
						            <td style="width: 10%; white-space: nowrap" align="left">							 
						                <gw:checkbox id="chkSpecGrp03" defaultvalue="Y|N" value="N" onclick="OnSearch('Detail')"   />
						            </td>	
									<td style="width: 10%; white-space: nowrap" align="right">	
										<gw:label id="lbSpecGrp04" styles='width:100%;color:cc0000;font:9pt'></gw:label>									                 
						            </td>			            
						            <td style="width: 10%; white-space: nowrap" align="left">							 
						                <gw:checkbox id="chkSpecGrp04" defaultvalue="Y|N" value="N" onclick="OnSearch('Detail')"  />
						            </td>	
									<td style="width: 10%; white-space: nowrap" align="right">	
										<gw:label id="lbSpecGrp05" styles='width:100%;color:cc0000;font:9pt'></gw:label>									                 
						            </td>			          
						            <td style="width: 10%; white-space: nowrap" align="left">							 
						                <gw:checkbox id="chkSpecGrp05" defaultvalue="Y|N" value="N" onclick="OnSearch('Detail')"   />
						            </td>  									    					
								</tr>
							</table>
						</td>        
					</tr>                 
                    <tr style="height: 98%">
                        <td colspan="7">
                            <gw:grid id='grdDetail' 
								header='_Comp_PK|Comp ID|Comp Name|_Spec01_PK|_Spec 01|_Spec02_PK|_Spec 02|_Spec03_PK|_Spec 03|_Spec04_PK|_Spec 04|_Spec05_PK|_Spec 05|Plan Qty|Req Qty|Prod Qty|(%)'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|0|0|1|0|1|0|1|0|1|0|1|3|3|3|3'
								editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								widths='0|2000|3000|0|1200|0|1200|0|1200|0|1200|0|1200|1200|1200|1200|1200'
                                sorting='T' styles='width:100%; height:100%' />
								<gw:grid id='grdTrans' 
								header='Date|Line|Comp|_Spec 01|_Spec 02|_Spec 03|_Spec 04|_Spec 05|Lot ID|Card ID|Prod Qty|Defect'
                                format='4|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='1|0|0|1|1|1|1|1|1|1|3|3'
								editcol='0|0|0|0|0|0|0|0|0|0|0|0' 
								widths='1200|1500|3000|1200|1200|1200|1200|1200|1200|1200|1200|1200'
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>           
    <!------------------------------------------------------------------>
	<gw:textbox id="txtOrdPlanPK" style="display: none" />
	<gw:textbox id="txtProcessPK" style="display: none" />
	 <!------------------------------------------------------------------>
	<gw:grid id='grdHeader' header='_PK|_GRID_TYPE|Col1 Header|Col1 Display|Col2 Header|Col2 Display|Col3 Header|Col3 Display|Col4 Header|Col4 Display|Col5 Header|Col5 Display|Remark'
        format='0|0|0|3|0|3|0|3|0|3|0|3|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0' check='||||||||||||'
        editcol='1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
        sorting='T' autosize='T' styles='width:100%; height:50%;display:none' /> 
</body>
</html>
