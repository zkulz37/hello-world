<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Genuwin</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>

var  G1_Line_Group =0,
     G1_EX_FA_PLAN         = 1,
     G1_Order_No            = 2, 
     G1_Buyer          = 3, 
     G1_Pattern            = 4, 
     G1_Item           	= 5, 	
     G1_Order_qty             = 6,
	 G1_BALANCE            = 7;
	
function BodyInit()
{
	System.Translate(document);
	txtProposedByUserPk.text="<%=Session("USER_PK")%>";
   	//dso_getCompany.Call();
	var data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0020') FROM DUAL" )%>"; 
    lstGroupCode.SetDataText(data);
    
	OnSearch();
}
//------------------------------------------------------------
function BindingDataList()
{  
}
function OnSearch()
{  
    DSO_Grid.Call("SELECT");
    
}

 function OnDataReceive(obj)
 {
	 if(obj.id=='DSO_Grid')
	 {
		if(Grid_Detail.rows-1 > 0)
		{
			
			Grid_Detail.SetCellBgColor(1, G1_BALANCE, Grid_Detail.rows-1, G1_BALANCE, 0xB3B3D7);
		}
	 }
	 
	  for (i = 1; i < Grid_Detail.rows; i++)
		{		
			if(Grid_Detail.GetGridData(i, 1)=="" && Grid_Detail.GetGridData(i, 2)!="" )
			{
				Grid_Detail.SetGridText(i, 1, 'Sub Total');//column 1 is asset code(set name :grand total)
				Grid_Detail.SetCellBgColor(i, 0, i,27,0X99FFFF) ;
				//grdMaster.SetGridText(i, 0,"");
			}
			if(Grid_Detail.GetGridData(i, 1)=="" &&Grid_Detail.GetGridData(i, 2)==""  )
			{
				Grid_Detail.SetGridText(i, 1, 'Total');//column 1 is asset code(set name :grand total)
				Grid_Detail.SetCellBgColor(i, 0, i,27,0XFF99FF) ;
				//grdMaster.SetGridText(i, 0,"");
			}
		}
 }


 //-----------------------------------------------------
 
function OnPrint()
{
    var url = '/reports/ds/mr/rpt_dsmr00020.aspx?p_line_group='+lstGroupCode.value+'&p_date_from='+dtfrdate.value+'&p_date_to='+dttodate.value+'&P_radType='+radType.value;
	System.OpenTargetPage( System.RootURL+url , "newform" );
}
//-------------------------------------------------------------------------------



</script>
<body>
<gw:data id="DSO_Grid" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="lg_sel_dsmr00020" > 
            <input  >
			  <input bind="lstGroupCode"/> 
			  <input bind="dtfrdate"/>
			  <input bind="dttodate"/> 
			  <input bind="radType"/> 			         
            </input>
            <output bind="Grid_Detail" /> 
        </dso> 
    </xml> 
</gw:data>
 <!------------------------------------------------------------------------------------>

      <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr>
          
            <td style="background: white; width: 100%" id="idRIGHT">
                <table cellpadding="0" cellspacing="0" style="width: 100%;height:100%" border="0">
                   <tr style="width:100%;height:5%" valign="top">
                        <td width="100%">
                             <fieldset>
                                    <table style="width:100%" cellpadding="1" cellspacing="1" border="0">
                                        <tr>
                                                
												 <td align="left" width="10%">Date</td>
												<td width="5%" align="left"><gw:datebox id="dtfrdate" lang="<%=Session("Lang")%>"  styles="width:100%" /></td>
												
												<td width="5%" align="left"><gw:datebox id="dttodate" lang="<%=Session("Lang")%>"  styles="width:100%" /></td>
												</td><td align="right" width="11%">Group Code</td>
                                                <td width="25%" align="left"><gw:list id="lstGroupCode" style="width:100%" onchange="OnSearch()" >  </gw:list>
												<td style="width: 15%; white-space: nowrap">
													<gw:radio id="radType" value="Y" styles="width:100%"> 
														<span value="Y" id="rResult">Result</span> 
														<span value="N" id="rBalance">Balance</span>
													</gw:radio>
												</td>
                                              <td align="left" width="10%"></td>
												<td><gw:imgbtn id="btnSearch1" img="search" alt="Tìm kiếm"  onclick="OnSearch()" /></td>                                                
                                                <td ><gw:button id="btnSave2" img="excel"text="Print" alt="In report"  onclick="OnPrint()" /></td>
                                            </tr>
                                           
									</table>
                             </fieldset>
                            
                        </td>
                   </tr>
                  <tr  style="width:100%;height:95%"  >
                        <td width="100%">
							<gw:grid id="Grid_Detail"
							header="Line Group|EX-FA-PLAN|Order No|Buyer|Pattern|Item|Order's Q'ty|BALANCE (Pcs)|Cắt ton|Cắt phôi| Rora|Hoa Văn|Cắt lõm/ Máy búa|Tạo Lõm|Mài H20|Mài 2/3|QC |Đ/G|Export Amount|_GB|_LB|_CT|_PB|_PB No|REMARK|PAYMENT|Production Request|_Export Actual|_B/L Date|_Invoice"   
							format  ="0|0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0"  
							aligns="2|2|2|2|2|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|2|2|2|2|0|0"  
							editcol ="0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1|1|1|0"  
							widths  ="1500|1200|3000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1000|1000|1000|1000|2000|2000|2000|2000|3000|2000|2000" 
							styles="width:100%; height:100%"
							sorting="T" autosize="T"
							/>
						</td>
                  </tr>
                                    
                </table>
                
                            
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------->
   
<gw:textbox id="txtPK"  text="" style="display:none" />      
  <gw:textbox id="txt_date" style="display: none" />       
  <gw:textbox id="txtDateType" style="display: none" />  
<gw:textbox id="txtProposedByUserPk"  text="" style="display:none" />  
</body>
</html>
