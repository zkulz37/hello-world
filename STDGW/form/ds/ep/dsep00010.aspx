<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Package Cover Popup</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
        
    var G1_PK               = 0,
        G1_Code             = 1,
        G1_Name             = 2,
        G1_Package_Type     = 3,
        G1_Length           = 4,
        G1_Width            = 5,
        G1_Height           = 6,
        G1_Volume           = 7,
        G1_Weight           = 8,
        G1_Thickness        = 9,
        G1_Color            = 10,
        G1_Stuff            = 11,
        G1_Dimension_UNIT   = 12,
        G1_Weight_UNIT      = 13,
        G1_USE              = 14,
        G1_Item             = 15,
	    G1_Parent_YN	    = 16,	
        G1_Description      = 17,
        G_ATT01             = 18,
        G_ATT02             = 19,
        G_ATT03             = 20,
        G_ATT04             = 21,
        G_ATT05             = 22;

 //---------------------------------------------------------
 function BodyInit()
 {
      System.Translate(document);
      grdDetail.GetGridControl().FrozenCols = G1_Length ;
      //--------------  
      FormatGrid();
      //--------------
      OnSearch('grdDetail');
 }
 
 //---------------------------------------------------------
 function FormatGrid()
 {
      var trl ;
      trl = grdDetail.GetGridControl();	
      
      trl.ColFormat(G1_Length)          = "###,###,###,###,###.##";
      trl.ColFormat(G1_Width)           = "###,###,###,###,###.##";
      trl.ColFormat(G1_Height)          = "###,###,###,###,###.##";
      trl.ColFormat(G1_Volume)          = "###,###,###,###,###.###";
      trl.ColFormat(G1_Weight)          = "###,###,###,###,###.##";
      trl.ColFormat(G1_Thickness)       = "###,###,###,###,###.##";
        
        
      var data ="#I;Inner|#C;Outter|#P;Poly"
      grdDetail.SetComboFormat(G1_Package_Type, data);     
 }
 
 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                dsep00010.Call("SELECT");
            break;     
      }  
 }


 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		                
        case 'grdDetail' :       
             
              grdDetail.AddRow();	 	           
        break;
      }  
 }
 
//---------------------------------------------------------

 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                dsep00010.Call();
            break;
      }  

 }

//---------------------------------------------------------

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
 
 //---------------------------------------------------------

 function OnUnDelete()
 {
        grdDetail.UnDeleteRow();
 }
 
//------------------------------------------------------------------
 function CheckInput()
 {   
    var col, row ;
    var dQuantity, dVolume , dLength, dWidth, dHeight ;
    //-------------
    col = event.col ;
    row = event.row ;  
    //-------------  
  
    if ( col == G1_Length || col == G1_Width || col == G1_Height )
    {  
        //------------------------
        dQuantity = grdDetail.GetGridData( row, col) ;               
        Number(dQuantity)?grdDetail.SetGridText( row, col, parseFloat(dQuantity+"").toFixed(2) ):grdDetail.SetGridText( row, col, 0); 
        //------------------------
        dLength   = grdDetail.GetGridData( row, G1_Length) ;
        dWidth    = grdDetail.GetGridData( row, G1_Width) ;
        dHeight   = grdDetail.GetGridData( row, G1_Height) ;
        
        dVolume   = dLength * dWidth * dHeight ;
        
        grdDetail.SetGridText( row, G1_Volume, parseFloat(dVolume+"").toFixed(2) );
        //------------------------
    }   
    else if ( col == G1_Weight || col == G1_Thickness )
    {
        dQuantity =  grdDetail.GetGridData( row, col) ;               
        Number(dQuantity)?grdDetail.SetGridText( row, col, parseFloat(dQuantity+"").toFixed(2) ):grdDetail.SetGridText( row, col, 0); 
    } 
    else if ( col == G1_Volume )
    {
        dQuantity =  grdDetail.GetGridData( row, col) ;               
        Number(dQuantity)?grdDetail.SetGridText( row, col, parseFloat(dQuantity+"").toFixed(3) ):grdDetail.SetGridText( row, col, 0); 
    }     
 }
 //---------------------------------------------------------
 function OnCellDoubleClick(pos)
 {
      switch (pos)         
      {		      
	       case 'grdDetail' :
	             var row  = event.row;
	             var col  = event.col;
	             
                 if ( (col == G1_Dimension_UNIT || col == G1_Weight_UNIT ) &&  row != 0 )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
	                    
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( row, col, obj[1] );
	                   }		               
                 }else
                 {
                 
                     if (grdDetail.GetGridData(row,G1_PK)!= "")
                    {
                     var code_data=new Array()
                     var index =0;
	                    for( j=0 ; j < grdDetail.cols -1 ; j++ )
                        {
                            code_data[index] = grdDetail.GetGridData(row , j );
                            index ++;
                        } 
                        window.returnValue = code_data; 
                        this.close(); 
                    }
                 }
            break;
       }     
 }  
 
 //--------------------------------------------------
 function OnDataReceive(obj)
 {
        switch (obj.id)
        {
            case 'dsep00010':
                if (grdDetail.rows>1)
                {
                    grdDetail.SetCellBold( 1, G1_Volume, grdDetail.rows - 1, G1_Volume, true);
                }
            break;
        }
 }   
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="dsep00010" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="sale" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22" function="<%=l_user%>lg_sel_dsep00010"  procedure="<%=l_user%>lg_upd_dsep00010" > 
                <input> 
                    <input bind="txtName" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 10%" align="right">
                <b>Name</b>
            </td>
            <td style="width: 40%" align="right">
                <gw:textbox id="txtName" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
            </td>
            <td style="width: 45%" align="right">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="New" id="btnSearch" onclick="OnSearch('grdDetail')" />
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
                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('grdDetail')" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="8">
                <gw:grid id="grdDetail" header="_PK|Code|Name|Package Type|Length|Width|Height|Volume|Weight|Thickness|Color|Stuff|Dimension UNIT|Weight UNIT|USE|Item Y/N|Parent Y/N|Description|_ATT01|_ATT02|_ATT03|_ATT04|_ATT05"
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|3|0|0|0|0|0|0' 
                    aligns='0|0|0|1|3|3|3|3|3|3|0|0|1|1|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||1|1|1||||||' 
                    editcol="0|1|1|1|1|1|1|1|1|1|1|1|0|0|1|1|1|1|1|1|1|1|1"
                    widths='1000|1500|2000|1600|1200|1200|1200|1200|1200|1200|1200|1200|1500|1500|800|1000|1000|1000|1000|1000|1000|1000|1000'
                    styles="width:100%; height:100%" sorting="T" onafteredit="CheckInput()" oncelldblclick="OnCellDoubleClick('grdDetail')"
                    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22" />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
</html>
