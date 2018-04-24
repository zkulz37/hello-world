<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser("SALE")
    Dim l_user As String
    l_user = "SALE."
%>
<head id="Head1" runat="server">
    <title>IM/EX DOCUMENT</title>
</head>

<script>
    var G1_CHK			= 0,
		G1_TK_ID		= 1,		 
		G1_DOC_DATE		= 2,
		G1_SLIP_NO		= 3,
		G1_LIQUID_NO	= 4,
		G1_PARTNER		= 5,
		G1_AMOUNT		= 6,
		G1_CCY			= 7,
		G1_LIQUID_PK	= 8;
			
    var G2_CHK			= 0,
		G2_TK_ID		= 1,		 
		G2_DOC_DATE		= 2,
		G2_SLIP_NO		= 3,
		G2_LIQUID_NO	= 4,
		G2_IM_QTY	    = 5,
		G2_LIQUID_QTY   = 6,
		G2_CCY			= 7,
		G2_LIQUID_PK	= 8;		
	
//============================================================================================
function BodyInit()
{   
    OnSearch();
	
    FormatGrid();
} 
//============================================================================================
function OnSearch(pos)
{    
	switch(pos)
	{
		case '1':
			data_ephl00101_1.Call("SELECT");
		break;
		
		case 'MAP-OUT':
			data_ephl00101_3.Call("SELECT");
		break;
		
		case '2':
			data_ephl00101_2.Call("SELECT");
		break;
		
		case 'MAP-IN':
			data_ephl00101_4.Call("SELECT");
		break;
	}     
}
//============================================================================================
function FormatGrid()
{		 	
	txtMasterPK.text = "<%=Request.querystring("master_pk")%>";
}
//============================================================================================
function OnSave(pos)
{
    switch(pos)
	{
		case '1':
			data_ephl00101_3.Call();
		break;	

		case '2':
			data_ephl00101_4.Call();
		break;	
    }
}
//============================================================================================
function OnDelete(pos)
{
	switch(pos)
	{
		case '1':
			grdMapOutgo.DeleteRow();
		break;
		
		case '2':
			grdMapIncome.DeleteRow();
		break;
	}	 
}
//=======================================================================
function OnUnDelete()
{    
    grdWH.UnDeleteRow();
}
//=======================================================================
function OnDataReceive(para)
{
    if(para.id == 'data_ephl00101')
    {
        data_ephl00101_1.Call('SELECT');
    }
}
//=======================================================================
function OnAddNew(para)
{
    if(para == 1)
    {
        var url =System.RootURL + '/form/fp/ab/fpab00240.aspx';	    
	    var values  = window.showModalDialog(  url , this , 'resizable:yes;toolbar=no;dialogWidth:45;dialogHeight:32');
	    
		if(values != null && values[0] != '' )
	    {
	        grdWH.AddRow();
	        grdWH.SetGridText( grdWH.rows-1, G_SEQ, grdWH.rows-1);
	        grdWH.SetGridText( grdWH.rows-1, G_WH_PK, values[0]);
	        grdWH.SetGridText( grdWH.rows-1, G_WH_ID, values[1]);
	        grdWH.SetGridText( grdWH.rows-1, G_WH_NAME, values[2]);
        }	  
    }         
}
//=================================================================================

function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdOutgo" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                AddNewRow('OUT', event_row);
            break;

			case "grdIncome":
			
                var event_col = event.col ;
                var event_row = event.row ;

                AddNewRow('IN', event_row);			
			break;	
      }         
}  
//====================================================================== 
function OnAddNew(pos)
{
	switch(pos)
	{
		case 'MAP-IN':
			for (var i=0; i<grdIncome.rows; i++)
			{
				if ( grdIncome.GetGridControl().isSelected(i) == true )
				{
					AddNewRow('IN',i);
				}
			}
		break;
		
		case 'MAP-OUT':
			for (var i=0; i<grdOutgo.rows; i++)
			{
				if ( grdOutgo.GetGridControl().isSelected(i) == true )
				{
					AddNewRow('OUT',i);
				}
			}
		break;
	}
}
//====================================================================== 
function AddNewRow(pos,row)
{
	switch(pos)
	{
		case 'OUT':
			if ( txtMasterPK.text != '' && row > 0 )
			{
				grdMapOutgo.AddRow();
				grdMapOutgo.SetGridText( grdMapOutgo.rows-1, G1_DOC_DATE,  grdOutgo.GetGridData( row, G1_DOC_DATE ) );
				grdMapOutgo.SetGridText( grdMapOutgo.rows-1, G1_TK_ID,     grdOutgo.GetGridData( row, G1_TK_ID    ) );
				grdMapOutgo.SetGridText( grdMapOutgo.rows-1, G1_SLIP_NO,   grdOutgo.GetGridData( row, G1_SLIP_NO  ) );
				grdMapOutgo.SetGridText( grdMapOutgo.rows-1, G1_AMOUNT,    grdOutgo.GetGridData( row, G1_AMOUNT   ) );
				grdMapOutgo.SetGridText( grdMapOutgo.rows-1, G1_CCY,       grdOutgo.GetGridData( row, G1_CCY      ) );
				grdMapOutgo.SetGridText( grdMapOutgo.rows-1, G1_LIQUID_PK, txtMasterPK.text );
				
				grdOutgo.RemoveRowAt(row);
			}	
		break;
			
		case 'IN':
			if ( txtMasterPK.text != '' && row > 0 )
			{
				grdMapIncome.AddRow();
				grdMapIncome.SetGridText( grdMapIncome.rows-1, G2_DOC_DATE,  grdIncome.GetGridData( row, G2_DOC_DATE   ) );
				grdMapIncome.SetGridText( grdMapIncome.rows-1, G2_TK_ID,     grdIncome.GetGridData( row, G2_TK_ID      ) );
				grdMapIncome.SetGridText( grdMapIncome.rows-1, G2_SLIP_NO,   grdIncome.GetGridData( row, G2_SLIP_NO    ) );
				grdMapIncome.SetGridText( grdMapIncome.rows-1, G2_IM_QTY,    grdIncome.GetGridData( row, G2_IM_QTY     ) );
				grdMapIncome.SetGridText( grdMapIncome.rows-1, G2_LIQUID_QTY,grdIncome.GetGridData( row, G2_LIQUID_QTY ) );
				grdMapIncome.SetGridText( grdMapIncome.rows-1, G2_LIQUID_PK, txtMasterPK.text );
				
				grdIncome.RemoveRowAt(row);
			}	
		break;
	}
}

//====================================================================== 
</script>

<body>
	<!------------------------------------------------------------------>
    <gw:data id="data_ephl00101_1" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="1,8" function="<%=l_user%>lg_sel_ephl00101_1"  >	
				<input	bind="grdOutgo">					 
					<input bind="dtFrom1" />
					<input bind="dtTo1" />	
				</input>
				<output	bind="grdOutgo"/>	
			</dso>	
		</xml>	
	</gw:data>
	<!------------------------------------------------------------------>
    <gw:data id="data_ephl00101_3" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="1,8" function="<%=l_user%>lg_sel_ephl00101_3" procedure="<%=l_user%>lg_upd_ephl00101_3">	
				<input	bind="grdMapOutgo">
					<input bind="txtMasterPK" />					 
				</input>
				<output	bind="grdMapOutgo"/>	
			</dso>	
		</xml>	
	</gw:data>
	<!------------------------------------------------------------------>
    <gw:data id="data_ephl00101_2" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8" function="<%=l_user%>lg_sel_ephl00101_2" procedure="<%=l_user%>lg_upd_ephl00101_2">	
				<input	bind="grdIncome">	
					<input bind="txtMasterPK" />
					<input bind="dtFrom2" />
					<input bind="dtTo2" />				
				</input>
				<output	bind="grdIncome"/>	
			</dso>	
		</xml>	
	</gw:data>
	<!------------------------------------------------------------------>
    <gw:data id="data_ephl00101_4" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="1,5,6,8" function="<%=l_user%>lg_sel_ephl00101_4" procedure="<%=l_user%>lg_upd_ephl00101_4">	
				<input	bind="grdMapIncome">					 
					<input bind="txtMasterPK" />					 		
				</input>
				<output	bind="grdMapIncome"/>	
			</dso>	
		</xml>	
	</gw:data> 	
    <!------------------------------------------------------------------>
    <table style="height: 100%; width: 100%" border="0">
        <tr style="height: 1%"  >
            <td style="width: 50%" >
				<table style="height: 100%; width: 100%" >
					<tr style="height: 1%" >
						<td style="width: 5%; white-space: nowrap" align="center">
							Date
						</td>
						<td style="width: 20%; white-space: nowrap" align="center">
							<gw:datebox id="dtFrom1" lang="1" />
                            ~<gw:datebox id="dtTo1" lang="1" />
						</td>
						<td style="width: 79%; white-space: nowrap" align="center">
						</td>						 						 						
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnSearch1" img="search" onclick="OnSearch('1')" />
						</td>
					</tr>
				</table>
			</td>
			<td style="width: 50%" >
				<table style="height: 100%; width: 100%" >
					<tr style="height: 1%" >
						<td style="width: 5%; white-space: nowrap" align="center">
							Date
						</td>
						<td style="width: 20%; white-space: nowrap" align="center">
							<gw:datebox id="dtFrom2" lang="1" />
                            ~<gw:datebox id="dtTo2" lang="1" />
						</td>
						<td style="width: 79%; white-space: nowrap" align="center">
						</td>						 						 					
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnSearch2" img="search" onclick="OnSearch('2')" />
						</td>
					</tr>
				</table>			
			</td>
        </tr>
        <tr style="height: 49%" >			 
			<td style="width: 50%" >
				<gw:grid id='grdOutgo' 
					header='_Chk|_TK_ID|Doc Date|Slip No|_Liquid No|_Partner|Amount|CCY|_LIQUID_PK'
					format='3|0|4|0|0|0|0|0|0' 
					aligns='0|0|1|1|0|0|3|1|0' 						 
					editcol='0|0|0|0|0|0|0|0|0' 
					widths='800|0|1200|1200|1500|2000|1500|800|1200'
					sorting='T'  styles='width:100%; height:100%' 
					oncelldblclick="OnGridCellDoubleClick(this)" />						
			</td>						
			<td style="width: 50%" > 
				<gw:grid id='grdIncome' 
					header='_Chk|_TK_ID|Doc Date|Slip No|_Liquid No|IM Qty|Liquid Qty|CCY|_LIQUID_PK'
					format='3|0|4|0|0|0|0|0|0' 
					aligns='0|0|1|1|0|3|3|0|0' 						 
					editcol='0|0|0|0|0|0|0|0|0' 
					widths='800|0|1200|1200|1500|1500|1500|800|1200'
					sorting='T'  styles='width:100%; height:100%'
					oncelldblclick="OnGridCellDoubleClick(this)" />						
			</td>					     
        </tr>
		
        <tr style="height: 1%"  >
            <td style="width: 50%" >
				<table style="height: 100%; width: 100%" >
					<tr style="height: 1%" >
						<td style="width: 95%; white-space: nowrap" align="center">							 
						</td>
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnAdd1" img="new" onclick="OnAddNew('MAP-OUT')" />
						</td>
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnSearch1" img="search" onclick="OnSearch('MAP-OUT')" />
						</td>
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnDelete1" img="delete" onclick="OnDelete('1')" />
						</td>						 
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnUnDelete1" img="udelete" onclick="OnUnDelete('1')" />
						</td>						 
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnSave1" img="save" alt="Save" onclick="OnSave('1')" />
						</td>
					</tr>
				</table>
			</td>
			<td style="width: 49%" >
				<table style="height: 100%; width: 100%" >
					<tr style="height: 1%" >
						<td style="width: 5%; white-space: nowrap" align="center">	
							Item
						</td>
						<td style="width: 95%; white-space: nowrap" align="center">							 
						</td>
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnAdd2" img="new" onclick="OnAddNew('MAP-IN')" />
						</td>
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnSearch2" img="search" onclick="OnSearch('MAP-IN')" />
						</td>
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnDelete2" img="delete" onclick="OnDelete('2')" />
						</td>						 
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnUnDelete2" img="udelete" onclick="OnUnDelete('2')" />
						</td>						 
						<td style="width: 1%" align='right'>
							<gw:imgbtn id="btnSave2" img="save" alt="Save" onclick="OnSave('2')" />
						</td>
					</tr>
				</table>			
			</td>
        </tr>
		
        <tr style="height: 99%" >			 
			<td style="width: 50%" >
				<gw:grid id='grdMapOutgo' 
					header='_Chk|_TK_ID|Doc Date|Slip No|_Liquid No|_Partner|Amount|CCY|_LIQUID_PK'
					format='3|0|4|0|0|0|0|0|0' 
					aligns='0|0|1|1|0|3|3|1|0' 						 
					editcol='0|0|0|0|0|0|0|0|0' 
					widths='800|0|1200|1200|1500|2000|1500|800|1200'
					sorting='T'  styles='width:100%; height:100%' />						
			</td>						
			<td style="width: 50%" > 
				<gw:grid id='grdMapIncome' 
					header='_Chk|_TK_ID|Doc Date|Slip No|_Liquid No|IM Qty|Liquid Qty|CCY|_LIQUID_PK'
					format='3|0|4|0|0|0|0|0|0' 
					aligns='0|0|1|1|0|3|3|0|0' 						 
					editcol='0|0|0|0|0|0|0|0|0' 
					widths='800|0|1200|1200|1500|1500|1500|800|1200'
					sorting='T'  styles='width:100%; height:100%' />						
			</td>					     
        </tr> 
    </table>
    <!------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------->
</body>
</html>
