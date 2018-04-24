<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Incentive Summary 1</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

var G1_EMP_ID        = 0, 
    G1_EMP_NAME      = 1,     
    G1_PARTNER_ID    = 2, 
    G1_PARTNER_NAME  = 3,    
	G1_SALE_AMOUNT	 = 4,
	G1_INCENT_AMOUNT = 5;
	
//------------------------------------------------------
function BodyInit()
{ 
	System.Translate(document);
    //----------------------------   
    
	OnFormFormat();
}
//=======================================================================

function OnFormFormat()
{
	  var trl ;
      
      trl = grdSearch.GetGridControl();
      	
      trl.ColFormat(G1_SALE_AMOUNT )  = "#,###,###,###.##";
	  trl.ColFormat(G1_INCENT_AMOUNT) = "#,###,###,###.##";          
}
//=======================================================================

function OnSearch()
{
    data_dsmt00100_1.Call("SELECT") ;      
}
//=======================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_dsmt00100_1": 
			if ( grdSearch.rows > 1)
			{
            	grdSearch.SetCellBgColor( 1, G1_SALE_AMOUNT,   grdSearch.rows - 1, G1_SALE_AMOUNT,   0xCCFFFF ); 
				grdSearch.SetCellBgColor( 1, G1_INCENT_AMOUNT, grdSearch.rows - 1, G1_INCENT_AMOUNT, 0xFFFFCC ); 
				
            	grdSearch.SetCellBold( 1, G1_EMP_ID,     grdSearch.rows - 1, G1_EMP_ID,     true); 
				grdSearch.SetCellBold( 1, G1_PARTNER_ID, grdSearch.rows - 1, G1_PARTNER_ID, true); 
				
				grdSearch.Subtotal( 1, 2,-1, '4!5');  				
			}	
        break;
    }
}  
//-----------------------------------------------------------------------------------------------
//function OnPopUp(pos)
//{
//    switch(pos)
//    {
//        case 'Supplier' :
//             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
//	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
//	         
//	         if ( object != null )
//	         {
//	            txtSupplierID.text   = object[1];
//                txtSupplierName.text = object[2];          
//	         }
//        break; 
//        case 'Emp' :
//                 var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
//	             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
//	             if ( obj != null )
//	             {
//	                //txtEmpPK.text   = obj[0];
//	                txtEmpCode.text = obj[1];
//                    txtEmpName.text = obj[2];
//                 }	
//	    break;          
//    }
//}         
//------------------------------------------------------------------------------------------------
function OnSave()
{
  
}
//=======================================================================
      
</script>

<body>
	<!---------------------------------------------------------------->
    <gw:data id="data_dsmt00100_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>LG_SEL_DSMT00100_1"	>	
				<input>
					<input	bind="txtEmp"	/>	
					<input	bind="txtSupplier"	/>	
					<input	bind="dtFrom"	/>	
					<input	bind="dtTo"	/>	
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Date
            </td>
            <td style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtFrom" lang="1" width="10%" />
                ~
                <gw:datebox id="dtTo" lang="1" width="10%" />
            </td>
			 <td style="width: 5%; white-space: nowrap" align="right">
                Emp
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtEmp" styles='width:100%' />
            </td>
            <td align="right" style="width: 5%; white-space: nowrap">
                Partner
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtSupplier" styles="width:100%;" />
            </td>           
            <td style="width: 15%" align="right" >
                <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="7">
                <gw:grid id='grdSearch' header='Emp ID|Full Name|Partner ID|Partner Name|Sale Amount|Incent Amount'
                    format='0|0|0|0|1|1' aligns='0|0|0|0|0|0' check='|||||' editcol='0|0|0|0|0|0'
                    widths='1200|3000|1200|3500|2000|2000' sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------>
</body>
</html>
