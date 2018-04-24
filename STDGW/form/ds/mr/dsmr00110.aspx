<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Genuwin</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>
   var  G_No=0,
	   G_pk=1,
	   G_buyer=2,
	   G_pattern=3,
	   G_item=4,
	   G_gauge=5,
	   G_serial_no=6,
	   G_Requested=7,
	   G_hrc_upper=8,
	   G_hrc_bottom=9,
	   G_mold_type=10,
	   G_Material_upper=11,
	   G_Material_bottom=12,
	   G_build_date=13,
	   G_mold_code=14,
	   G_Released_Date=15,
	   G_Returned_Date=16,
	   G_Produced_Qty=17,
	   G_Judge_upper=18,
	   G_Judge_bottom=19,
	   G_Status_type=20,
	   G_Heating_Started=21,
	   G_Error=22,
	   G_Machine_Plan=23,
	   G_Machine_No=24,
	   G_Shift=25;
function BodyInit()
{	
	MergeHeaderGrid();
	/*data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE b.GROUP_ID='LGIN220' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " )%>|;" ;
    grdMoldExp.SetComboFormat( G_InsR1, data);
	*/
	 data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE b.GROUP_ID = 'LGPC1301' AND a.TLG_LG_CODE_GROUP_PK = b.PK AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.CODE, a.CODE_NM " )%>" ; 
	 //data = data + "|#;";
	grdMoldExp.SetComboFormat(G_Machine_Plan,data); 
	 data2 = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE b.GROUP_ID = 'LGPC1302' AND a.TLG_LG_CODE_GROUP_PK = b.PK AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.CODE, a.CODE_NM " )%>" ; 
		grdMoldExp.SetComboFormat(G_mold_type,data2); 
		
		data3 = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE b.GROUP_ID = 'LGPC0343' AND a.TLG_LG_CODE_GROUP_PK = b.PK AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.CODE, a.CODE_NM " )%>" ; 
		grdMoldExp.SetComboFormat(G_Shift,data3); 
		
		var  lstPlantType2  =  "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code2('LGPC1301') FROM DUAL")%>||";
		lstPlantType.SetDataText(lstPlantType2); 
		lstPlantType.value='';
		var data2 = "||ALL|10|BUILD_DATE|20|RELEASED_DATE|30|RETURNED_DATE";
		lstType.SetDataText(data2);
		lstType.value='10';

		var  lstMold  =  "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code2('LGPC1302') FROM DUAL")%>||";
		lstMoldType.SetDataText(lstMold);
		lstMoldType.value='';

		var  lstShift2  =  "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code2('LGPC0343') FROM DUAL")%>||";
		lstShift.SetDataText(lstShift2);
		lstShift.value='';
		
		

	OnSearch();
}
function OnSearch()
{  
   dso_dsmr00060_1.Call("SELECT");
}
function MergeHeaderGrid()
{
     var fg = grdMoldExp.GetGridControl();
     if(fg.Rows < 2)
		{
		   grdMoldExp.AddRow();     
		}    
		
        fg.FixedRows = 2;
        fg.MergeCells =5;
		fg.MergeRow(0) = true;
		
		fg.MergeCol(0)		= true; 
		fg.Cell(0,0,0,1)    = "No";
		
		fg.MergeCol(1)		= true; 
		fg.Cell(0,0,1,1)    = "PK";
		
		fg.MergeCol(2)		= true; 
		fg.Cell(0,0,2,1)    = "Buyer";
		
		fg.MergeCol(3)		= true; 
		fg.Cell(0,0,3,1)    = "Pattern";
		
		fg.MergeCol(4)		= true; 
		fg.Cell(0,0,4,1)    = "Item";
		
		fg.MergeCol(5)		= true; 
		fg.Cell(0,0,5,1)    = "Gauge";
		
		fg.MergeCol(6)		= true; 
		fg.Cell(0,0,6,1)    = "Serial No";
		
		fg.MergeCol(7)		= true; 
		fg.Cell(0,0,7,1)    = "P.Requested";
		
		fg.MergeCol(10)		= true; 
		fg.Cell(0,0,10,1)    = "Mold Type";
		
		fg.MergeCol(17)		= true; 
		fg.Cell(0,0,17,1)    = "Produced Q'ty";
		
		fg.MergeCol(20)		= true; 
		fg.Cell(0,0,20,1)    = "Status Type(OK/No OK";
		
		fg.MergeCol(21)		= true; 
		fg.Cell(0,0,21,1)    = "Heating Started";
		
		fg.MergeCol(22)		= true; 
		fg.Cell(0,0,22,1)    = "Error";
		
		fg.MergeCol(25)		= true; 
		fg.Cell(0,0,25,1)    = "Shift";
		
		
		fg.Cell(0,0,8,0,9)    = "HRC";
		fg.Cell(0,1,8,1)	= "Upper";
		fg.Cell(0,1,9,1)	= "Bottom"; 
		
		
		fg.Cell(0,0,11,0,12)    = "Material";
		fg.Cell(0,1,11,1)	= "Upper";
		fg.Cell(0,1,12,1)	= "Bottom";
		
		
		fg.Cell(0,0,13,0,16)    = "Mold Status";
		fg.Cell(0,1,13,1)	= "Build Date";
		fg.Cell(0,1,14,1)	= "Mold Code";
		fg.Cell(0,1,15,1)	= "Released Date";
		fg.Cell(0,1,16,1)	= "Returned Date";
		
		fg.Cell(0,0,18,0,19)    = "Judge";
		fg.Cell(0,1,18,1)	= "Judge Upper";
		fg.Cell(0,1,19,1)	= "Judge Bottom";
		
		fg.Cell(0,0,23,0,24)    = "Machine #";
		fg.Cell(0,1,23,1)	= "Machine Plant";
		fg.Cell(0,1,24,1)	= "Machine No";
		
		
		
		
}

function OnAddNew()
{
        grdMoldExp.AddRow();
		
		 grdMoldExp.SetGridText( grdMoldExp.rows-1, G_mold_type,  lstMoldType.value );//Moldtype
		 grdMoldExp.SetGridText( grdMoldExp.rows-1, G_Shift,  lstShift.value );//Shift
		 grdMoldExp.SetGridText( grdMoldExp.rows-1, G_Machine_Plan,  lstPlantType.value );//Shift
		// grdItem_Search.GetGridData( 1, 0) 
		 

}

//------------------------------------------------------------------------------------
function OnSave()
{
	if(grdMoldExp.GetGridData( grdMoldExp.row, G_build_date)=="")
	{
		alert("please select buil date ")
		return;
	}
	else
		dso_dsmr00060_1.Call();
}
function OnDelete()
{
    if(confirm('Are you sure you want to delete!!'))
	{ 
		grdMoldExp.DeleteRow();
		dso_dsmr00060_1.Call();
	}
}
function OnUnDeleteDetail() 
 {
	grdMoldExp.UnDeleteRow()
}
//---------------------------------------------------------------------------
function OnReport()           
{
	var url = '/reports/ds/mr/rpt_dsmr00060.aspx?p_dtfrm='+dtfrm.value+'&p_dtto='+dtto.value+'&p_date_type='+radSampleFns.value+'&p_item='+txtItem.text;  
	System.OpenTargetPage( System.RootURL+url , "newform" );
}
//---------------------------------------------------------------------------

function OnDataReceive(obj)
{
     switch(obj.id)
      {
            case "dso_dsmr00060_1":
                MergeHeaderGrid();  
            break;
			
      }/**/

}

function OnPopUpCode(pos)
{
switch ( pos )
	{
		case 'Mold' :
			var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGPC1302";
			var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');   
		break;
		case 'Plant' :
			var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGPC1301";
			var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');   
		break;
		
		case 'Shift' :
			var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGPC0343";
			var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');   
		break;
	}		
}

function OnPopUp_grd()
   {
		
		txtMasterPK.text=grdMoldExp.GetGridData( grdMoldExp.row, 1);
		 var fpath = System.RootURL + '/form/ds/bs/dsbs00218.aspx?master_pk=' + txtMasterPK.text ;
		 var aValue  = System.OpenModal(  fpath , 700 , 300 , 'resizable:yes;status:yes;scroll:no');                  
       
	}
	
	 function OnPopUp()
   {
		if(grdMoldExp.row <1)
		{
			alert("Please,select item to show file or insert file.");
			return;
		}
		txtMasterPK.text=grdMoldExp.GetGridData( grdMoldExp.row, 1);
		 var fpath = System.RootURL + '/form/ds/bs/dsbs00218.aspx?master_pk=' + txtMasterPK.text ;
		 var aValue  = System.OpenModal(  fpath , 700 , 300 , 'resizable:yes;status:yes;scroll:no');                  
       
	} 


</script>
<body>

 <!------------------------------------------------------------------------------------>
<gw:data id="dso_dsmr00060_1" onreceive="OnDataReceive(this)"> 
<xml> 
	<dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="lg_sel_dsmr00110" procedure="lg_upd_dsmr00110"   > 
		<input bind="grdMoldExp"> 
			 <input bind="lstType"/>
		   <input bind="dtfrm"/>
			<input bind="dtto"/>
			<input bind="txtItem"/>
			<input bind="lstMoldType"/>
			<input bind="lstPlantType"/>			
			<input bind="lstShift"/>			
			<input bind="txtBuy"/>
			<input bind="txtRequest"/>
			<input bind="txtGauge"/>
			<input bind="txtMoldCode"/>
		</input> 
		<output bind="grdMoldExp"></output>
	</dso> 
</xml> 
</gw:data>
<!-------------------------------------------------------------------------------------------------------------------------->

<table style="height: 100%; width: 100%">
	<tr style="width:100%;height:1%" valign="top">
		<td width="100%">
			<table style="width:100%" cellpadding="1" cellspacing="1" border="0">
					<tr>
						<td align="right" width="6%">Date type</td>
						<td width="15%" align="left"><gw:list id="lstType" style="width:100%" onchange="OnSearch()" /></td>

						<td align="left" width="3%">Date</td>
						<td width="15%" align="left" >
							<gw:datebox id="dtfrm"  text=""  style="width:100%" lang="1" onchange="OnSearch()"  />
						</td>
						<td></td>
						<td width="14%" align="left">
							<gw:datebox id="dtto"  text=""  style="width:100%" lang="1" onchange="OnSearch()"  />
						</td>
					
						<td align="left" width="6%">	<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUpCode('Mold')"> Mold Type</b>  </td>
						<td width="10%" align="left"><gw:list id="lstMoldType" style="width:100%" onchange="OnSearch()" /></td>
						
						<td align="left" width="6%">	<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUpCode('Plant')"> Plant</b>  </td>
						<td width="10%" align="left"><gw:list id="lstPlantType" style="width:100%" onchange="OnSearch()" /></td>
						<td></td><td></td>
						  
						<td width="1%" align="left">
							<gw:imgbtn id="btnSearch1" img="search" alt="Search" onclick="OnSearch()" />
						</td>
						<td width="1%" align="left">
							<gw:imgbtn id="btnNew1" img="new" alt="New" onclick="OnAddNew()" />
						</td>
						<td width="1%" align="left">
							<gw:imgbtn id="btnSave1" img="save" alt="Save" onclick="OnSave()" />
						</td>
						<td width="1%" align="left">
							<gw:imgbtn id="btnDlete1" img="delete" alt="Delete" onclick="OnDelete()" />
						</td>
						<td width="1%" align="left">
							<gw:imgbtn id="btnUnDelete1" img="udelete" alt="UnDelete" onclick="OnUnDeleteDetail()" />
						</td>
						<td width="1%" align='left'>                          
							<gw:button img="excel" text="Print" alt="Print Out Report" onclick="OnReport()" />
						</td>
					</tr>
				
					
					<tr>	 
							<td align="left" width="6%">	<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUpCode('Shift')"> Shift</b>  </td>
								<td width="10%" align="left"><gw:list id="lstShift" style="width:100%" onchange="OnSearch()" /></td>			
							<td align="left" width="2%" >Buyer</td>
							<td width="9%" align="left"><gw:textbox id="txtBuy" text="" styles="width:100%" onenterkey="OnSearch()" /></td>
							
							<td align="left" width="2%" >Item</td>
							<td width="9%" align="left"><gw:textbox id="txtItem" text="" styles="width:100%" onenterkey="OnSearch()" /></td>
							
							<td align="left" width="2%" >P.Requested</td>
							<td width="9%" align="left"><gw:textbox id="txtRequest" text="" styles="width:100%" onenterkey="OnSearch()" /></td>
							
							<td align="left" width="2%" >Gauge</td>
							<td width="9%" align="left"><gw:textbox id="txtGauge" text="" styles="width:100%" onenterkey="OnSearch()" /></td>
							<td align="left" width="2%" colspan="2" >Mold Code No</td>
							<td width="10%" align="left"><gw:textbox id="txtMoldCode" text="" styles="width:100%" onenterkey="OnSearch()" /></td>
							<td style="width: 1%" align="right">
							<gw:imgbtn id="btnFileAttachList" img="attach" alt="List File Attach" onclick="OnPopUp()" />     						 
						 </td>

						
						</tr>
			</table>
		</td> 
	</tr>
	<tr  style="width:100%;height:99%"  >
		<td width="100%">  
		   <gw:grid 
				id="grdMoldExp"                           
					header="No|pk|buyer|pattern|item|gauge|serial_no|Requested|hrc_upper|hrc_bottom|mold_type|Material_upper|Material_bottom|build_date|mold_code|Released_Date|Returned Date|Produced Qty|Judge_upper| Judge_bottom| Status_type(ok-not ok)| Heating Started| Error| Machine Plan| Machine No| Shift"   
					format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|4|0|4|4|0|0|0|0|0|0|0|0|0"  
					aligns=  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					editcol ="0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
					widths  ="600|1800|2000|3000|700|1500|2500|2600|2000|2300|1500|2500|2000|1500|2500|2800|1400|2000|1500|2500|2000|1500|2500|2800|1400|2000" 
					styles="width:100%; height:100%"
					sorting="T" oncelldblclick="" acceptnulldate="T"
		  />
		</td>
	</tr>
</table>
<!---------------------------------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="display: none" />
</html>
