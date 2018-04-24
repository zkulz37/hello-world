<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Genuwin</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>
   
function BodyInit()
{
var data = "<%=ESysLib.SetListDataSQL("SELECT   pk, GROUP_ID || ' - ' || group_name  FROM tlg_pb_line_group WHERE del_if = 0 ORDER BY GROUP_ID ") %>||Select ALL" ;    
    lstLingrp.SetDataText(data);
	lstLingrp.value='';
    BindingDataList();
    MergeHeaderGrid();
	System.Translate(document);
	txtProposedByUserPk.text="<%=Session("USER_PK")%>";
   	//dso_getCompany.Call();
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
      switch(obj.id)
      {
             case "DSO_Grid":
                   MergeHeaderGrid();
                 // ChangeColor(); 
             break;
      }

}
 //-----------------------------------------------------
 

//-------------------------------------------------------------------------------
function MergeHeaderGrid()
{
     var fg = Grid_Detail.GetGridControl();
     if(fg.Rows < 2)
		{
		   Grid_Detail.AddRow();     
		}    
        fg.FixedRows = 2
        fg.MergeCells =5	
        
		fg.MergeRow(0) = true
		
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Nation"	
		fg.MergeCol(3) = true
		fg.Cell(0, 0, 3, 1, 3) = "Line Group"	
		fg.MergeCol(4) = true
		fg.Cell(0, 0, 4, 1, 4) = "EX-FAC"	
		fg.MergeCol(5) = true
		fg.Cell(0, 0, 5, 1, 5) = "BUYER"	
		fg.MergeCol(6) = true
		fg.Cell(0, 0, 6, 1, 6) = "PATTERN"	
		fg.MergeCol(7) = true
		fg.Cell(0, 0, 7, 1, 7) = "P.O.NO"	
		fg.MergeCol(8) = true
		fg.Cell(0, 0, 8, 1, 8) = "REF NO"	
		fg.MergeCol(9) = true
		fg.Cell(0, 0, 9, 1, 9) = "AMOUNT(U$)"
		fg.MergeCol(10) = true
		fg.Cell(0, 0, 10, 1, 10) = "DELIVERY"	
		fg.MergeCol(11) = true
		fg.Cell(0, 0, 11, 1, 11) = "AISI"	
		//--------Budget
	    fg.Cell(0, 0, 12,0, 16)  = "Q'TY (Pcs)"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 12, 1, 12) = "Total"
	    fg.Cell(0, 1, 13, 1, 13) = "S/F"
	    fg.Cell(0, 1, 14, 1, 14) = "1 H/H"
	    fg.Cell(0, 1, 15, 1, 15) = "2 H/H"	  
	    fg.Cell(0, 1, 16, 1, 16) = "Knife"
  
	    fg.MergeCol(17) = true
	    fg.Cell(0, 0, 17, 1, 19) = "BALANCE (Pcs)"			
	    fg.Cell(0, 1, 17, 1, 17) = "Total"  
	    fg.Cell(0, 1, 18, 1, 18) = "S/F"
	    fg.Cell(0, 1, 19, 1, 19) = "Knife" 
	  
	  
	  //--------Phát sinh-----------
	  
		fg.MergeCol(20) = true
		fg.Cell(0, 0, 20, 1, 20) = "R E M A R K"
		fg.MergeCol(21) = true
		fg.Cell(0, 0, 21, 1, 21) = "PAYMENT"
		fg.MergeCol(22) = true
		fg.Cell(0, 0, 22, 1, 22) = "Production Req"
		fg.MergeCol(23) = true
		fg.Cell(0, 0, 23, 1, 23) = "Item Code"
	 
	  
	  
	  fg.ColFormat(8) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(9) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(10) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(11) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(12) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(13) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(14) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(15) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(16) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(17) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(18) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(19) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(20) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(21) = "#,###,###,###,###,###,###R"; 
	  fg.ColFormat(22) = "#,###,###,###,###,###,###R"; 
	 
}
function OnPrint()
{
    var url = '/reports/ds/mr/rpt_dsmr00010.aspx?p_date_from='+dtfrdate.value+'&p_date_to='+dttodate.value+'&p_line_group='+lstLingrp.value+'&po_no='+txt_poNo.text;
	System.OpenTargetPage( System.RootURL+url , "newform" );
}
//-----------------------------------------------------------------------

function OnPopup()
{
	fpath = System.RootURL + '/form/fp/pw/fppw00030.aspx';
	var aValue  = System.OpenModal(  fpath , 1000 , 700 , 'resizable:yes;status:yes');
}
</script>
<body>
<gw:data id="DSO_Grid" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="lg_sel_dsmr00010" > 
            <input  >           
			  <input bind="dtfrdate"/>
			  <input bind="dttodate"/> 
			  <input bind="lstLingrp"/>
			  <input bind="txt_poNo"/>			  
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
                                               
												 <td align="left" width="5%">Date</td>
												<td width="5%" align="left"><gw:datebox id="dtfrdate" lang="<%=Session("Lang")%>"  styles="width:100%" /></td>
												
												<td width="5%" align="left"><gw:datebox id="dttodate" lang="<%=Session("Lang")%>"  styles="width:100%" /></td>
												</td> <td align="left" width="12%">Line Group</td>
                                                <td width="25%" align="left"><gw:list id="lstLingrp" style="width:100%" onchange="OnSearch()" >  </gw:list></td>
												 <td align="left" width="10%">Po No</td>
												 <td width="15%" align="left"><gw:textbox id="txt_poNo" style="width:100%" onchange="OnSearch()" >  </gw:textbox></td>
												

											 <td align="left" width="15%"></td>
												<td><gw:imgbtn id="btnSearch1" img="search" alt="Tìm kiếm"  onclick="OnSearch()" /></td>                                                
                                                <td ><gw:button id="btnSave2" img="excel"text="Print" alt="In report"  onclick="OnPrint()" /></td>
                                            </tr>
                                           
									</table>
                             </fieldset>
                            
                        </td>
                   </tr>
                  <tr  style="width:100%;height:95%"  >
                    <td width="100%">  
                           <gw:grid
								id="Grid_Detail"                           
								    header="_PK|_Master_pk|Nation|Budget code|Budget name|Account code|Account name|Total|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|Tổng|Tháng 1|Tháng 2|Item Code"   
									format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
								    aligns="0|0|0|0|0|0|0|0|0|3|0|0|3|3|3|3|3|3|3|3|0|0|0|0"  
									defaults="|||||||||||||||||||||||"  
									editcol ="0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|0|1|1|1"  
									widths  ="0|0|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|2000|2000|2000" 
									styles="width:100%; height:100%"
									sorting="T" oncelldblclick="OnPopup()"
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
