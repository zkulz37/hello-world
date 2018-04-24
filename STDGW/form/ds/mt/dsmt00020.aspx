<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Buyer Charger</title>
</head>

<script type="text/javascript">

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
    
    var G1_PK                    = 0,
		G1_THR_EMPLOYEE_PK       = 1,        
        G1_EMP_ID                = 2,
        G1_FULL_NAME             = 3,		 
		G1_FULL_FNAME            = 4,
		G1_FULL_KNAME            = 5,
		G1_DIVISION_NAME         = 6
		G1_TCO_BUSPARTNER_PK     = 7,
		G1_PARTNER_ID            = 8,
		G1_PARTNER_NAME          = 9,
		G1_PARTNER_LNAME         = 10,
		G1_PARTNER_FNAME         = 11;
		

 //---------------------------------------------------------
 function BodyInit()
 {
      System.Translate(document);
     
      //--------------  
      FormatGrid();
      //--------------
      OnSearch('grdDetail');
 }
 
//===============================================================================
 function FormatGrid()
 {
    grdDetail.GetGridControl().MergeCells  = 3 ;	
    grdDetail.GetGridControl().MergeCol(0) = true ;	
    grdDetail.GetGridControl().MergeCol(1) = true ;   	
    grdDetail.GetGridControl().MergeCol(2) = true ;
	grdDetail.GetGridControl().MergeCol(3) = true ;
	grdDetail.GetGridControl().MergeCol(4) = true ;
	grdDetail.GetGridControl().MergeCol(5) = true ;
	grdDetail.GetGridControl().MergeCol(6) = true ;
	//grdDetail.GetGridControl().MergeCol(7) = true ;
	//grdDetail.GetGridControl().MergeCol(8) = true ;
	//grdDetail.GetGridControl().MergeCol(9) = true ;
	//grdDetail.GetGridControl().MergeCol(10) = true ;
 }
 
//===============================================================================
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                data_dsmt00020.Call("SELECT");
            break;     
      }  
 }


//===============================================================================
 function OnAddNew(pos)
 {
      switch (pos)         
      {		                
        case 'grdDetail' :       
             var data ;
                var path = System.RootURL + '/form/ds/mt/dsmt00021.aspx';
                var obj = System.OpenModal( path ,900 , 500 ,  'resizable:yes;status:yes');
                if ( obj != null )
                {
                    for (var i = 0 ; i< obj.length; i++)
                    {
                        grdDetail.AddRow();
                        data = obj[i];      
                            
                        grdDetail.SetGridText(grdDetail.rows-1,G1_THR_EMPLOYEE_PK,data[0]);
                        grdDetail.SetGridText(grdDetail.rows-1,G1_EMP_ID,data[1]);
                        grdDetail.SetGridText(grdDetail.rows-1,G1_FULL_NAME,data[2]);
                        grdDetail.SetGridText(grdDetail.rows-1,G1_FULL_FNAME,data[3]);
                        grdDetail.SetGridText(grdDetail.rows-1,G1_FULL_KNAME,data[4]);
                        
                        grdDetail.SetGridText(grdDetail.rows-1,G1_TCO_BUSPARTNER_PK,data[6]);
                        grdDetail.SetGridText(grdDetail.rows-1,G1_PARTNER_ID,data[7]);
                        grdDetail.SetGridText(grdDetail.rows-1,G1_PARTNER_NAME,data[8]);
                        grdDetail.SetGridText(grdDetail.rows-1,G1_PARTNER_LNAME,data[9]);
                        grdDetail.SetGridText(grdDetail.rows-1,G1_PARTNER_FNAME,data[11]);
                     }
                }
                
             // grdDetail.AddRow();	 
			  			              
        break;
      }  
 }
 
//===============================================================================

 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                data_dsmt00020.Call();
            break;
      }  

 }

//===============================================================================

 function OnDelete()
 {
		if ( grdDetail.GetGridData( grdDetail.row, G1_PK ) == "" ) 
	    {						
				grdDetail.RemoveRow();					
		}			
		else 
		{
			if ( confirm( "Do you want to mark this row to delete?" ) ) 
			{
				grdDetail.DeleteRow();
			}
		}
 }
 
//===============================================================================

 function OnUnDelete()
 {
        grdDetail.UnDeleteRow();
 }    
 
//===============================================================================
 function OnDataReceive(obj)
 {
        switch (obj.id)
        {
            case 'data_dsmt00020':
                if (grdDetail.rows > 1)
                {
                    //grdDetail.SetCellBold( 1, G1_BUDGET_ID, grdDetail.rows - 1, G1_BUDGET_ID, true);
					
					//grdDetail.SetCellBgColor( 1, G1_BUDGET_ID, grdDetail.rows - 1, G1_BUDGET_NAME, 0xCCFFFF );
                }
            break;
        }
 }   
//===============================================================================
 function OnReport()
 {
     var url =System.RootURL + "/reports/ds/mt/rpt_dsmt00020.aspx?p_emp="+txtEmployee.text+"&p_partner="+txtPartner.text; 
     System.OpenTargetPage(url);     
 }
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsmt00020" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid"  parameter="0,1,7" function="<%=l_user%>lg_sel_dsmt00020"  procedure="<%=l_user%>lg_upd_dsmt00020" > 
                <input bind="grdDetail"> 
                    <input bind="txtEmployee" /> 
                    <input bind="txtPartner"/> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 10%" align="right">
                Employee
            </td>
            <td style="width: 30%" align="right">
                <gw:textbox id="txtEmployee" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
            </td>
            <td style="width: 10%" align="right">
                Partner
            </td>
            <td style="width: 30%" align="right">
                <gw:textbox id="txtPartner" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
            </td>
            <td style="width: 15%" align="right">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('grdDetail')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('grdDetail')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="udelete" alt="Un Delete" id="btnUnDelete" onclick="OnUnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('grdDetail')" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="11">
                <gw:grid id='grdDetail' header='_PK|_THR_EMPLOYEE_PK|Emp ID|Full Name|L Name|_K Name|Division Name|_TCO_BUSPARTNER_PK|Partner ID|Partner Name|L Name|_PARTNER_FNAME'
                    format='1|1|0|0|0|0|0|1|0|0|0|0' aligns='0|0|1|0|0|0|0|0|1|0|0|0' check='|||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
</html>
