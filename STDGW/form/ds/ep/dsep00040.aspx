<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Packing Result</title>
</head>
<script>

 var G1_WI_DT       = 0,
	 G1_WI_NO       = 1,
	 G1_PO_NO       = 2,
	 G1_Style       = 3,
	 G1_PACK_CODE   = 4,
	 G1_PACK_NAME   = 5,
	 G1_WI_Qty      = 6,
	 G1_Packed_Qty  = 7,
	 G1_Pack_WI_PK  = 8,
	 G1_NULL_01     = 9,
	 G1_PACK_PK     = 10,
	 G1_REMARK      = 11;

var  G2_Barcode     = 2 ,
	 G2_Packed_Qty  = 3 ;

var  G3_Ref_PO_No    = 0,
	 G3_Parent_BC    = 1,
	 G3_Count        = 2,
	 G3_Child_BC     = 3,
	 G3_Pack_Qty     = 4,
	 G3_Spec_01      = 5,
	 G3_Spec_02      = 6,
	 G3_Spec_03      = 7,
	 G3_Spec_04      = 8,
	 G3_Spec_05      = 9,
	 G3_QTY          = 10,
	 G3_Crt_by       = 11,
	 G3_ParentPK     = 12;

var G4_PA_PACKAGES = 0,
    G4_PO_NO	   = 1,
	G4_STYLE	   = 2,
	G4_CARTON_NO   = 3,
	G4_SEQ		   = 4,
	G4_STATUS	   = 5,
	G4_IN_TIME	   = 6,
	G4_IN_BY	   = 7,
	G4_OUT_TIME	   = 8,
	G4_OUT_BY	   = 9,
	G4_PACKING_NO  = 10;
  
var G5_PARTNER_NAME = 0,
    G5_ITEM_CODE	= 1,
	G5_ITEM_NAME	= 2,
	G5_UOM          = 3,
	G5_IN_QTY		= 4,
	G5_OUT_QTY	    = 5;
 //=================================================================
 function BodyInit()
 {
		System.Translate(document);
		dtbWIFrom.SetDataText(System.AddDate(dtbWITo.GetData(),-30));
		//-------------------
		FormatGrid();
		//-------------------
		OnHiddenGrid();
		OnSearch('header');
 }
 //=================================================================
 function FormatGrid()
 {
	  var data = "<%=ESysLib.SetListDataSQL(" SELECT   pk, cover_code || ' * ' || cover_name FROM tlg_pa_packages_type a WHERE del_if = 0 ORDER BY cover_code ")%>";
	  lstPackagesType.SetDataText(data);

	  data = "<%=ESysLib.SetListDataSQL(" SELECT   pk, ref_po_no FROM tlg_pa_packing_wi a WHERE a.del_if = 0 AND close_yn = 'N' ORDER BY ref_po_no ")%>||";
	  lstPONo.SetDataText(data);
	  lstPONoII.SetDataText(data);

	  var ctrl = grdPackingWI.GetGridControl() ;

	  ctrl.ColFormat(G1_WI_Qty)     = "###,###,###,###,###";
	  ctrl.ColFormat(G1_Packed_Qty) = "###,###,###,###,###";

	  ctrl.MergeCells  = 2 ;
	  ctrl.MergeCol(0) = true ;
	  ctrl.MergeCol(1) = true ;
	  ctrl.MergeCol(2) = true ;
	  ctrl.MergeCol(3) = true ;

	  ctrl = grdPackages.GetGridControl() ;

	  ctrl.ColFormat(G3_QTY)      = "###,###,###,###,###";
	  ctrl.ColFormat(G3_Count)    = "###,###,###,###";
	  ctrl.ColFormat(G3_Pack_Qty) = "###,###,###,###";

	  ctrl.MergeCells  = 2 ;
	  ctrl.MergeCol(0) = true ;
	  ctrl.MergeCol(1) = true ;
	  ctrl.MergeCol(2) = true ;
	  ctrl.MergeCol(3) = true ;
	  ctrl.MergeCol(4) = true ;

	  ctrl = grdALLPackages.GetGridControl() ;

	  ctrl.MergeCells  = 2 ;
	  ctrl.MergeCol(0) = true ;
	  ctrl.MergeCol(1) = true ;
	  ctrl.MergeCol(2) = true ;
	  ctrl.MergeCol(3) = true ;
	  ctrl.MergeCol(4) = true ;

	  ctrl = grdInOutDetail.GetGridControl() ;

	  ctrl.ColFormat(G5_IN_QTY)      = "###,###,###,###,###";
	  ctrl.ColFormat(G5_OUT_QTY)     = "###,###,###,###,###";
	 //---------------------------------------
	 grdInOut.GetGridControl().MergeCells  = 2 ;
	 grdInOut.GetGridControl().MergeCol(0) = true ;
	 grdInOut.GetGridControl().MergeCol(1) = true ;
	 grdInOut.GetGridControl().MergeCol(2) = true ;
	 grdInOut.GetGridControl().MergeCol(3) = true ;

	 grdInOut.GetGridControl().Cell( 7, 0, G4_STATUS, 0, G4_STATUS) = 0x3300cc;

	 //---------------------------------------
	 var data = "DATA|I|INCOMING|O|OUTGOING|P|PACKING LIST";
	 idList.SetDataText(data);
	 idList.value = 'O';
 }

 //=================================================================
function OnGridDoubleClick(obj)
{
	switch (obj.id)
	{
		case 'grdPackingWI' :
			var v_col = event.col ;
			var v_row = event.row ;

			if ( v_col == G1_PACK_CODE )
			{
				var pa_packing_wi_pk, pa_label_type_pk, pa_packages_type_pk;

				pa_packing_wi_pk    = grdPackingWI.GetGridData( v_row, G1_Pack_WI_PK);
				pa_packages_type_pk = grdPackingWI.GetGridData( v_row, G1_PACK_PK);

				txtPackagesType.text = grdPackingWI.GetGridData( v_row, G1_PACK_CODE) + ' - ' + grdPackingWI.GetGridData( v_row, G1_PACK_NAME);
				txtPacking.text      = grdPackingWI.GetGridData( v_row, G1_WI_NO);
				txtPONO.text         = grdPackingWI.GetGridData( v_row, G1_PO_NO);

				var path = System.RootURL + "/form/ds/ep/dsep00041.aspx?packages_type_pk=" + pa_packages_type_pk + "&packing_wi_pk=" + pa_packing_wi_pk;
				var object = System.OpenModal( path ,850 , 550 ,  'resizable:yes;status:yes', this);
			}
		break;

		case 'grdPackages' :
			var v_col = event.col ;
			var v_row = event.row ;

			if ( v_col == G3_Parent_BC )
			{
				var path = System.RootURL + "/form/ds/ep/dsep00042.aspx?parent_pk=" + grdPackages.GetGridData( v_row, G3_ParentPK) + "&parent_bc=" + grdPackages.GetGridData( v_row, G3_Parent_BC) ;
				var object = System.OpenModal( path ,850 , 600 ,  'resizable:yes;status:yes', this);
			}
		break;
	}
}

 //=================================================================
function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'data_dsep00040':
			var p_wi_pk ;

			lblRecord01.text = grdPackingWI.rows - 1 + ' (s)';

			if ( grdPackingWI.rows > 1 )
			{
				grdPackingWI.SetCellBold( 1, G1_WI_Qty,    grdPackingWI.rows - 1, G1_Packed_Qty, true );
				grdPackingWI.SetCellBold( 1, G1_PO_NO,     grdPackingWI.rows - 1, G1_PO_NO,      true );
				grdPackingWI.SetCellBold( 1, G1_PACK_CODE, grdPackingWI.rows - 1, G1_PACK_CODE,  true );

				p_wi_pk = grdPackingWI.GetGridData( 1, G1_Pack_WI_PK);
			}
			//-------------------

			for ( var i=1; i<grdPackingWI.rows; i++ )
			{
				if ( p_wi_pk != grdPackingWI.GetGridData( i, G1_Pack_WI_PK) )
				{
					p_wi_pk = grdPackingWI.GetGridData( i, G1_Pack_WI_PK);

					while ( grdPackingWI.rows > i && p_wi_pk == grdPackingWI.GetGridData( i, G1_Pack_WI_PK))
					{
						grdPackingWI.SetCellBgColor( i, 1, i, grdPackingWI.cols - 1, 0xCCFFFF );
						i++;
					}

					if ( grdPackingWI.rows > i )
					{
						p_wi_pk = grdPackingWI.GetGridData( i, G1_Pack_WI_PK);
					}
				}
			}
			//-------------------

		break;

		case 'data_dsep00040_2':
			var parent_bc;
			var child_bc;
			var child_count  = 1;
			var parent_count = 1;

			lblRecord03.text = grdPackages.rows - 1 + ' (s)';

			if ( grdPackages.rows > 1 )
			{
				grdPackages.SetCellBold( 1, G3_Child_BC, grdPackages.rows - 1, G3_Child_BC, true );
				grdPackages.SetCellBold( 1, G3_Pack_Qty, grdPackages.rows - 1, G3_Pack_Qty, true );
				grdPackages.SetCellBold( 1, G3_QTY,      grdPackages.rows - 1, G3_QTY,      true );
				grdPackages.SetCellBold( 1, G3_Count,    grdPackages.rows - 1, G3_Count,    true );

				parent_bc = grdPackages.GetGridData( 1, G3_Parent_BC);

				child_bc = grdPackages.GetGridData( 1, G3_Child_BC);
			}
			//-------------------

			for ( var i=1; i<grdPackages.rows; i++ )
			{
				if ( child_bc != grdPackages.GetGridData( i, G3_Child_BC) && grdPackages.GetGridData( i, G3_Child_BC) != '' )
				{
					child_bc = grdPackages.GetGridData( i, G3_Child_BC);
					child_count = child_count + 1 ;
				}
				//------------------
				if ( parent_bc != grdPackages.GetGridData( i, G3_Parent_BC) )
				{
					parent_bc    = grdPackages.GetGridData( i, G3_Parent_BC);
					parent_count = parent_count + 1 ;

					while ( grdPackages.rows > i && parent_bc == grdPackages.GetGridData( i, G3_Parent_BC))
					{
						grdPackages.SetCellBgColor( i, 1, i, grdPackages.cols - 1, 0xCCFFFF );
						i++;
						//------------------
						if ( grdPackages.rows > i && child_bc != grdPackages.GetGridData( i, G3_Child_BC) && grdPackages.GetGridData( i, G3_Child_BC) != '' )
						{
							child_bc = grdPackages.GetGridData( i, G3_Child_BC);
							child_count = child_count + 1 ;
						}
					}

					if ( grdPackages.rows > i )
					{
						parent_bc = grdPackages.GetGridData( i, G3_Parent_BC);
						parent_count = parent_count + 1 ;
					}
				}
			}

			lblChildCount.text = '( ' + parent_count + ' : ' + child_count + ' )';
		break;

		case 'pro_dsep00040_1' :
			OnSearch('spec02');
		break;

		case 'pro_dsep00040_2' :
			OnSearch('spec03');
		break;

		case 'pro_dsep00040_3' :
			OnSearch('spec04');
		break;

		case 'pro_dsep00040_4' :
			OnSearch('spec05');
		break;

		case 'pro_dsep00040_5' :
			ibtnSearch03.SetEnable(true);
		break;

		case 'data_dsep00040_header':
				if(grdHeader.rows>1)
				{
					var col1    =grdHeader.GetGridData(1,2);
					var dis_col1=grdHeader.GetGridData(1,3);
					var col2    =grdHeader.GetGridData(1,4);
					var dis_col2=grdHeader.GetGridData(1,5);
					var col3    =grdHeader.GetGridData(1,6);
					var dis_col3=grdHeader.GetGridData(1,7);
					var col4    =grdHeader.GetGridData(1,8);
					var dis_col4=grdHeader.GetGridData(1,9);
					var col5    =grdHeader.GetGridData(1,10);
					var dis_col5=grdHeader.GetGridData(1,11);
					if(dis_col1!=0)
					{
						grdPackages.SetGridText(0,G3_Spec_01,col1);
						grdPackages.GetGridControl().ColHidden(G3_Spec_01) = false ;
					}
					if (dis_col2!=0)
					{
						grdPackages.SetGridText(0,G3_Spec_02,col2);
						grdPackages.GetGridControl().ColHidden(G3_Spec_02) = false ;
					}
					if (dis_col3!=0)
					{
						grdPackages.SetGridText(0,G3_Spec_03,col3);
						grdPackages.GetGridControl().ColHidden(G3_Spec_03) = false ;
					}
					if (dis_col4!=0)
					{
						grdPackages.SetGridText(0,G3_Spec_04,col4);
						grdPackages.GetGridControl().ColHidden(G3_Spec_04) = false ;
					}
					if (dis_col5!=0)
					{
						grdPackages.SetGridText(0,G3_Spec_05,col5);
						grdPackages.GetGridControl().ColHidden(G3_Spec_05) = false ;
					}
				}

			OnChangeSpec();
		break;

		case 'data_dsep00040_4':
			if (grdInOut.rows > 1)
			{
				lblRecord04.text = (grdInOut.rows-1) + ' (s)';
			}
		break;

		case 'data_dsep00040_4':
			if (grdInOutDetail.rows > 1)
			{
				lblRecord05.text = (grdInOutDetail.rows-1) + ' (s)';
			}
		break;
	}
}
 //=================================================================
 function OnPopUp(pos)
 {
	switch (pos)
	{
		case 'Parent_Label':
				var path = System.RootURL + "/form/ds/ep/dsep00044.aspx?packages_type_pk=" + lstPackagesType.value + "&wi_pk=" + lstPONo.value;
				var object = System.OpenModal( path ,550 , 650 ,  'resizable:yes;status:yes', this);
		break;
	}
 }
 //=========================================================================
function OnHiddenGrid()
{
	grdPackages.GetGridControl().ColHidden(G3_Spec_01) = true ;
	grdPackages.GetGridControl().ColHidden(G3_Spec_02) = true ;
	grdPackages.GetGridControl().ColHidden(G3_Spec_03) = true ;
	grdPackages.GetGridControl().ColHidden(G3_Spec_04) = true ;
	grdPackages.GetGridControl().ColHidden(G3_Spec_05) = true ;
}
 //=================================================================
function OnSearch(pos)
{
	switch (pos)
	{
		case 'grdPackingWI':
			data_dsep00040.Call("SELECT");
		break;

		case 'grdPackages':
			data_dsep00040_2.Call("SELECT");
		break;

		case 'grdALLPackages':
			data_dsep00040_1.Call("SELECT");
		break;

		case 'spec01':
			pro_dsep00040_1.Call();
		break;

		case 'spec02':
			pro_dsep00040_2.Call();
		break;

		case 'spec03':
			pro_dsep00040_3.Call();
		break;

		case 'spec04':
			pro_dsep00040_4.Call();
		break;

		case 'spec05':
			pro_dsep00040_5.Call();
		break;

		case 'header':
			data_dsep00040_header.Call("SELECT");
		break;

		case 'In-Out' :
			data_dsep00040_4.Call("SELECT");
		break;

		case 'In-Out-Detail' :
			data_dsep00040_5.Call("SELECT");
		break;
	}
}

//=================================================================

function OnChangeSpec()
{
	if ( chkSpec.value == "Y" )
	{
		document.all("tab_Spec").style.display = "" ;

		OnSearch("spec01");
	}
	else
	{
		document.all("tab_Spec").style.display = "none" ;

		lstSpec01.value = "";
		lstSpec02.value = "";
		lstSpec03.value = "";
		lstSpec04.value = "";
		lstSpec05.value = "";
	}
}

//=================================================================

function OnListChange(obj)
{
	switch(obj.id)
	{
		case 'lstPONo':
			if ( chkSpec.value == "Y" )
			{
				ibtnSearch03.SetEnable(false);
				OnSearch("spec01");
			}
		break;
	}
}
//=================================================================
function OnReport(para)
{
    if(para == 1)
    {
     var url =System.RootURL + "/reports/ds/ep/rpt_dsep00040.aspx?p_dt_type="+idList.value+"&p_from_dt="+dtFrom.value+"&p_to_dt="+dtTo.value+"&p_search_no="+txtSearchPOStyle.text;
     System.OpenTargetPage(url);
    }
    else
    {
     var url =System.RootURL + "/reports/ds/ep/rpt_dsep00040_1.aspx?p_pa_packages_pk="+grdInOut.GetGridData( grdInOut.row, G4_PA_PACKAGES);
     System.OpenTargetPage(url);
    }
}
</script>
<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_dsep00040_header" onreceive="OnDataReceive(this)">
		<xml>
			<dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00040_header">
				<input bind="grdHeader"  >
				</input>
				<output bind="grdHeader" />
			</dso>
		</xml>
	</gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00040_1" onreceive="OnDataReceive(this)">
		<xml>
			<dso  type="list" procedure="<%=l_user%>lg_pro_dsep00040_1" >
				<input>
					<input bind="lstPONo" />
				</input>
				<output>
					<output bind="lstSpec01" />
				</output>
			</dso>
		</xml>
	</gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00040_2" onreceive="OnDataReceive(this)">
		<xml>
			<dso  type="list" procedure="<%=l_user%>lg_pro_dsep00040_2" >
				<input>
					<input bind="lstPONo" />
				</input>
				<output>
					<output bind="lstSpec02" />
				</output>
			</dso>
		</xml>
	</gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00040_3" onreceive="OnDataReceive(this)">
		<xml>
			<dso  type="list" procedure="<%=l_user%>lg_pro_dsep00040_3" >
				<input>
					<input bind="lstPONo" />
				</input>
				<output>
					<output bind="lstSpec03" />
				</output>
			</dso>
		</xml>
	</gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00040_4" onreceive="OnDataReceive(this)">
		<xml>
			<dso  type="list" procedure="<%=l_user%>lg_pro_dsep00040_4" >
				<input>
					<input bind="lstPONo" />
				</input>
				<output>
					<output bind="lstSpec04" />
				</output>
			</dso>
		</xml>
	</gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00040_5" onreceive="OnDataReceive(this)">
		<xml>
			<dso  type="list" procedure="<%=l_user%>lg_pro_dsep00040_5" >
				<input>
					<input bind="lstPONo" />
				</input>
				<output>
					<output bind="lstSpec05" />
				</output>
			</dso>
		</xml>
	</gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00040" onreceive="OnDataReceive(this)">
		<xml>
			<dso id="1" type="grid"   function="<%=l_user%>lg_sel_dsep00040" >
				<input>
					<input bind="dtbWIFrom" />
					<input bind="dtbWITo" />
					<input bind="txtPONo01" />
				</input>
				<output bind="grdPackingWI" />
			</dso>
		</xml>
	</gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00040_2" onreceive="OnDataReceive(this)">
		<xml>
			<dso id="1" type="grid"  function="<%=l_user%>lg_sel_dsep00040_2" >
				<input>
					<input bind="lstPackagesType" />
					<input bind="lstPONo" />
					<input bind="txtParentBC" />
					<input bind="txtItemBC" />
					<input bind="txtSpec" />
					<input bind="lstSpec01" />
					<input bind="lstSpec02" />
					<input bind="lstSpec03" />
					<input bind="lstSpec04" />
					<input bind="lstSpec05" />
					<input bind="radSearchType" />
				</input>
				<output bind="grdPackages" />
			</dso>
		</xml>
	</gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00040_1" onreceive="OnDataReceive(this)">
		<xml>
			<dso id="1" type="grid"   function="<%=l_user%>lg_sel_dsep00040_1" >
				<input>
					<input bind="lstPONoII" />
					<input bind="txtCarton" />
					<input bind="txtInner" />
					<input bind="txtPoly" />
					<input bind="txtSpecII" />
				</input>
				<output bind="grdALLPackages" />
			</dso>
		</xml>
	</gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_dsep00040_4" onreceive="OnDataReceive(this)">
		<xml>
			<dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00040_4" >
				<input bind="grdInOut" >
					 <input bind="idList" />
					 <input bind="dtFrom" />
					 <input bind="dtTo" />
					 <input bind="txtSearchPOStyle" />
				 </input>
				<output bind="grdInOut" />
			</dso>
		</xml>
	</gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_dsep00040_5" onreceive="OnDataReceive(this)">
		<xml>
			<dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00040_5" >
				<input bind="grdInOut" >
					 <input bind="dtFrom1" />
					 <input bind="dtTo1" />
					 <input bind="txtSearchPOStyle2" />
				 </input>
				<output bind="grdInOutDetail" />
			</dso>
		</xml>
	</gw:data>
    <!------------------------------------------------------------------>
    <!-- <gw:tab> -->
    <gw:tab>
	<table style="width: 100%; height: 100%" name="By W/I" border="1">
		<tr style="height: 1%">
			<td>
				<table style="width: 100%; height: 100%">
					<tr>
						<td style="width: 5%; white-space: nowrap" align="right">
							W/I Date
						</td>
						<td style="width: 20%; white-space: nowrap" align="left">
							<gw:datebox id="dtbWIFrom" lang="<%=Application("Lang")%>" mode="01" />
							~
							<gw:datebox id="dtbWITo" lang="<%=Application("Lang")%>" mode="01" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							P/O No
						</td>
						<td style="width: 25%; white-space: nowrap">
							<gw:textbox id="txtPONo01" styles="width:100%" onenterkey="OnSearch('grdPackingWI')" />
						</td>
						<td style="width: 30%; white-space: nowrap" align="center">
						</td>
						<td style="width: 14%" align="center">
							<gw:label id="lblRecord01" styles='width:100%;color:blue;font:9pt' text='record(s)' />
						</td>
						<td style="width: 1%">
							<gw:imgbtn id="ibtnSearch01" img="search" alt="Search" text="Search" onclick="OnSearch('grdPackingWI')" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="height: 99%">
			<td>
				<gw:grid id='grdPackingWI' header='W/I Date|W/I No|P/O No|Style|Package|Name|W/I Qty|Packed Qty|_pa_packing_wi_pk|_null_01|_pa_packages_type_pk|Description'
					format='4|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|3|3|0|0|0|0' defaults='|||||||||||'
					editcol='0|0|0|0|0|0|0|0|0|0|0|0' widths='1200|1500|2000|3000|1500|2000|1500|1500|0|0|0|0'
					styles="width:100%; height:100%" sorting='T' oncelldblclick="OnGridDoubleClick(this)" />
			</td>
		</tr>
	</table>
	<table style="width: 100%; height: 100%" name="By P/O" border="1">
		<tr style="height: 1%">
			<td>
				<table style="width: 100%; height: 100%">
					<tr>
						<td style="width: 5%; white-space: nowrap" align="right">
							<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Parent_Label')">Packages Type</b>
						</td>
						<td style="width: 20%; white-space: nowrap" align="left">
							<gw:list id="lstPackagesType" styles='width:100%' />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Parent_Label')">P/O No</b>
						</td>
						<td style="width: 20%; white-space: nowrap" align="left">
							<gw:list id="lstPONo" styles='width:100%' onchange="OnListChange(this)" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Parent B/C
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:textbox id="txtParentBC" styles='width:100%' onenterkey="OnSearch('grdPackages')" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Child B/C
						</td>
						<td style="width: 10%; white-space: nowrap">
							<gw:textbox id="txtItemBC" styles="width:100%" onenterkey="OnSearch('grdPackages')" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="center">
							Spec
							<gw:checkbox id="chkSpec" defaultvalue="Y|N" value="N" onchange="OnChangeSpec()" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="center">
							<gw:radio id="radSearchType" value="1" styles="width:100%" onchange="OnSearch('grdPackages')">
								<span value="1" >Parent</span>
								<span value="2" >Child</span>
							</gw:radio>
						</td>
						<td style="width: 9%" align="center">
							<gw:label id="lblRecord03" styles='width:100%;color:blue;font:9pt' text='record(s)' />
						</td>
						<td style="width: 1%">
							<gw:imgbtn id="ibtnSearch03" img="search" alt="Search" text="Search" onclick="OnSearch('grdPackages')" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="height: 1%">
			<td>
				<table style="width: 100%; height: 100%" id="tab_Spec">
					<tr>
						<td style="width: 10%; white-space: nowrap" align="center">
							<gw:label id="lblChildCount" styles='width:100%;color:red;font:9pt' text='(s)' />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Spec
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:textbox id="txtSpec" styles='width:100%' onenterkey="OnSearch('grdPackages')" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Spec 01
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:list id="lstSpec01" styles='width:100%' />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Spec 02
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:list id="lstSpec02" styles='width:100%' />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Spec 03
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:list id="lstSpec03" styles='width:100%' />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Spec 04
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:list id="lstSpec04" styles='width:100%' />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Spec 05
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:list id="lstSpec05" styles='width:100%' />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="height: 98%">
			<td>
				<gw:grid id='grdPackages' header='P/O No|Parent B/C|*|Child B/C|Pack Qty|Spec 01| Spec 02|Spec 03|Spec 04|Spec 05|QTY|Crt by|_Parent_PK'
					format='0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='1|1|1|1|1|1|1|1|1|1|3|1|0' defaults='||||||||||||'
					editcol='0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1500|2500|1000|2500|1200|1500|1500|1500|1500|1500|1200|800|0'
					sorting='T' styles='width:100%; height:100%' oncelldblclick="OnGridDoubleClick(this)" />
			</td>
		</tr>
	</table>
	<table style="width: 100%; height: 100%" name="Packages Checking II" border="1">
		<tr style="height: 1%">
			<td>
				<table style="width: 100%; height: 100%">
					<tr>
						<td style="width: 5%; white-space: nowrap" align="right">
							 P/O No
						</td>
						<td style="width: 15%; white-space: nowrap" align="left">
							<gw:list id="lstPONoII" styles='width:100%' onchange="" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							 Carton
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:textbox id="txtCarton" styles='width:100%' onenterkey="OnSearch('grdALLPackages')" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Inner
						</td>
						<td style="width: 10%; white-space: nowrap" align="left">
							<gw:textbox id="txtInner" styles='width:100%' onenterkey="OnSearch('grdALLPackages')" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Poly
						</td>
						<td style="width: 10%; white-space: nowrap">
							<gw:textbox id="txtPoly" styles="width:100%" onenterkey="OnSearch('grdALLPackages')" />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							Spec
						</td>
						<td style="width: 10%; white-space: nowrap">
							<gw:textbox id="txtSpecII" styles="width:100%" onenterkey="OnSearch('grdALLPackages')" />
						</td>
						<td style="width: 4%" align="center">
						</td>
						<td style="width: 1%">
							<gw:imgbtn id="ibtnSearch02" img="search" alt="Search" text="Search" onclick="OnSearch('grdALLPackages')" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="height: 98%">
			<td>
				<gw:grid id='grdALLPackages'
					header='Carton|*|Inner|*|Poly|Spec 01| Spec 02|Spec 03|Poly Qty'
					format='0|0|0|0|0|0|0|0|0'
					aligns='1|1|1|1|1|1|1|1|3'
					defaults='||||||||'
					editcol='0|0|0|0|0|0|0|0|0'
					widths='2000|800|2000|800|2000|1500|1500|1500|1200'
					sorting='T' styles='width:100%; height:100%'   />
			</td>
		</tr>
	</table>
	<table style="width: 100%; height: 100%" name="Packages In/Out" border="1" >
		<tr style="height: 1%">
			<td>
				<table style="width: 100%; height: 100%">
					<tr>
						<td style="width: 10%" align="right">
							<gw:list id="idList" styles="color:blue;width:100%" onchange="OnSearch('In-Out')" />
						</td>
						<td style="width: 30%; white-space: nowrap" align="left">
							<gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch('In-Out')" />
							~
							<gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch('In-Out')"  />
						</td>
						<td align='right' style="width: 10%; white-space: nowrap">
							PO/Style/Carton
						</td>
						<td style="width: 30%; white-space: nowrap">
							<gw:textbox id="txtSearchPOStyle" styles='width:100%' onenterkey="OnSearch('In-Out')" />
						</td>
						<td style="width: 19%" align="center">
							<gw:label id="lblRecord04" styles='width:100%;color:cc0000;font:9pt' text='(s)' />
						</td>
						<td style="width: 1%">
                            <gw:imgbtn img="excel" alt="Report" id="btnReport1" onclick="OnReport('1')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="excel" alt="Report" id="btnReport2" onclick="OnReport('2')" />
                        </td>
						<td style="width: 1%">
							<gw:imgbtn id="ibtnSearch04" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('In-Out')" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="height: 99%">
			<td >
				<gw:grid id='grdInOut'
				header='_pa_packages|P/O No|Style|Carton No|Seq|Status|In Time|In By|Out Time|Out By|Packing List'
				format='0|0|0|0|0|0|0|0|0|0|0'
				aligns='0|0|0|1|1|1|1|1|1|1|1'
				defaults='||||||||||'
				editcol='0|0|0|0|0|0|0|0|0|0|0'
				widths='0|1500|2000|1500|800|1500|2000|1200|2000|1200|0' sorting='T' styles='width:100%; height:100%'
				/>
			</td>
		</tr>
	</table>
    <table style="width: 100%; height: 100%" name="Packages In/Out Detail" border="1" >
		<tr style="height: 1%">
			<td>
				<table style="width: 100%; height: 100%">
					<tr>
                    <td>
                        Date
                    </td>
                    <td>
                        <gw:datebox id="dtFrom1" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch('In-Out-Detail')" />
							~
							<gw:datebox id="dtTo1" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch('In-Out-Detail')"  />
                    </td>
						<td style="width: 10%" align="right">
                            Partner/Item
						</td>
						<td style="width: 30%; white-space: nowrap" align="left">
                            <gw:textbox id="txtSearchPOStyle2" styles='width:100%' onenterkey="OnSearch('In-Out-Detail')" />
						</td>
						<td style="width: 19%" align="center">
							<gw:label id="lblRecord05" styles='width:100%;color:cc0000;font:9pt' text='(s)' />
						</td>
						<td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
						<td style="width: 1%">
							<gw:imgbtn id="ibtnSearch05" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('In-Out-Detail')" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="height: 99%">
			<td >
			<gw:grid id='grdInOutDetail'
                header='Partner Name|Item Code|Item Name|UOM|In Qty|Out Qty'
                format='0|0|0|0|1|1'
                aligns='0|0|0|1|0|0'
                check='|||||'
                editcol='1|1|1|1|1|1'
                widths='3000|1800|2500|1000|1200|1000'
                sorting='T'
                styles='width:100%; height:100%'
                />
			</td>
		</tr>
	</table>
	</gw:tab>
    <!-- </gw:tab> -->
    <!------------------------------------------------------------------>
</body>
<!------------------------------------------------------------------>
<gw:textbox id="txtLabelType" styles="width:100%;display:none" />
<gw:textbox id="txtPackagesType" styles="width:100%;display:none" />
<gw:textbox id="txtPacking" styles="width:100%;display:none" />
<gw:textbox id="txtPONO" styles="width:100%;display:none" />
<!------------------------------------------------------------------>
<gw:grid id='grdHeader' header='_PK|_GRID_TYPE|Col1 Header|Col1 Display|Col2 Header|Col2 Display|Col3 Header|Col3 Display|Col4 Header|Col4 Display|Col5 Header|Col5 Display|Remark'
    format='0|0|0|3|0|3|0|3|0|3|0|3|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0' check='||||||||||||'
    editcol='1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
    sorting='T' autosize='T' styles='width:100%; height:50%;display:none' />
<!------------------------------------------------------------------>
</html>
