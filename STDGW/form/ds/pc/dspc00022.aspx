<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Department</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
        
    var G1_DETAIL_PK   	= 0,
		G1_MASTER_PK	= 1,
        G1_DATE    		= 2,		       
		G1_REMARK     	= 3;
 //---------------------------------------------------------
 function BodyInit()
 {
      System.Translate(document);

     
	  
	  var p_master_pk = "<%=Request.querystring("p_master_pk")%>";
	  
	  txtMasterPK.text = p_master_pk;
	  
	   //--------------
      OnSearch('grdDetail');
	  
 }
 
//===============================================================================
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                data_dspc00022.Call("SELECT");
            break;     
      }  
 }


//===============================================================================
 function OnAddNew(pos)
 {
      switch (pos)         
      {		                
        case 'grdDetail' :       
             
			grdDetail.AddRow();                                                                                  
            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text );           
			
        break;
      }  
 }
 
//===============================================================================

 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                data_dspc00022.Call();
            break;
      }  

 }

//===============================================================================

 function OnDelete()
 {
		 
				grdDetail.DeleteRow();
		 
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
            case 'data_dspc00022':
                if (grdDetail.rows > 1)
                {
                    
                }
            break;
        }
 }   
 
//===============================================================================
</script>

<body>
	 
    <!------------------------------------------------------------------>
    <gw:data id="data_dspc00022" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid"  parameter="0,1,2,3" function="<%=l_user%>lg_sel_dspc00022"  procedure="<%=l_user%>lg_upd_dspc00022" > 
                <input> 
                    <input bind="txtMasterPK" />					 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            
			<td style="width: 95%" align="right">
                				
            </td>	
            <td style="width: 1%" align="right">
                 
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
            <td colspan="11">
                <gw:grid id="grdDetail" 
					header="_PK|_Master_PK|Date|Remark"
                    format='0|0|4|0' 
					aligns='1|0|1|0' 				
					editcol="1|0|1|1"
					check='|||' 
                    widths='0|1000|1200|1200' 
					styles="width:100%; height:100%"
                    sorting="T"    />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
	
	<gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
		
</body>
</html>
