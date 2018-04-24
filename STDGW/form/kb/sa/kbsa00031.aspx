<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title> POP UP DELI REQ </title>
</head>

<script type="text/javascript" language="javascript">
var  G_PK =0;
//------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);  // Translate to language session
     var p_customer_pk = "<%=Request.querystring("customer_pk")%>";
    txtCustomerPK.text = p_customer_pk;
     //----------------------------   
	var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ; 
    //----------------------------   
    OnSearch();
}

 //==================================================================================
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.rows > 1)
   {   
      for(var i=1;i<oGrid.rows;i++)
      {
         var arrTemp=new Array();
         
         for(var j=0;j<oGrid.cols;j++)
         {
            arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
         }
         
         arr_data[arr_data.length]= arrTemp;
      }
      
	  if ( arr_data !=null )
	  {
		window.returnValue =  arr_data;
		window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }	  
	  
}
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData( idGrid2.row, G_PK);
    
    idGrid2.RemoveRowAt(idGrid2.row);
    
    SetRowBackGroundColor(idGrid,col_val,0x000000); 
    
    countItem()
  }
}
//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, G_PK) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, G_PK) == p_value)
              {
                 return true;
              }
       }
       return false;
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "idGrid" && event.row > 0 )
      {
            var col_val = oGrid.GetGridData(event.row, G_PK );
            
            if(event.row > 0 && ( !CheckDataExist(idGrid2,col_val)) )
            {
                SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		        idGrid2.AddRow();
		        for(var i=0;i<oGrid.cols;i++)
		        {
		          idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(event.row,i));
		        }
            }
      }
      countItem()
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
//================================================================================================
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
        var col_val = oGrid.GetGridData( row, G_PK);		
		
        if ( row > 0 && ( !CheckDataExist( idGrid2, col_val)) )
        {
            SetRowBackGroundColor( oGrid, col_val, 0x0000FF);
            
	        idGrid2.AddRow();
    		
	        for(var j=0; j<oGrid.cols; j++)
	        {
	            idGrid2.SetGridText( idGrid2.rows-1, j, oGrid.GetGridData( row, j) );
	        }
        }		
	}
    
    countItem();    
}
//-------------------------------------------------------------------------------------
function OnCancel()
{
    var code_data=new Array()
    
    for( j=0 ; j < idGrid.cols ; j++ )
    {
        code_data[j] = '' ;
    } 
	    
    window.returnValue = code_data; 
    this.close(); 	
}
//-------------------------------------------------------------------------------------
function OnSearch()
{
    data_kbsa00031.Call("SELECT");
}

//====================================================================================
    
</script>

<body>
    
    <!--============================================= Search =====================================-->
    <gw:data id="data_kbsa00031" onreceive="">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0"	function="<%=l_user%>lg_sel_kbsa00031"	>	
				<input>
					<input	bind="txtCustomerPK"	/>	
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtSlipNoSearch"	/>	
					<input	bind="txtItem"	/>	
				</input>	
				<output	bind="idGrid"	/>	
			</dso>	
		</xml>	
	</gw:data>
	
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 10%">
        <td>
            <table style="width: 100%; height: 100%">
                <tr>             
                     <td style="width: 5%" align="right">
                            Date
                    </td>
                    <td style="white-space: nowrap; width: 30%">
                        <gw:datebox id="dtFromSearch" lang="1" />
                        ~
                        <gw:datebox id="dtToSearch" lang="1" />
                    </td>  
                     <td style="width: 10%" align="right">
                            Slip No / PO No
                        </td>
                        <td style="white-space: nowrap; width: 20%">
                            <gw:textbox id="txtSlipNoSearch"  />
                            <gw:textbox id="txtCustomerPK"  style="display: none" />
                        </td>    
                      <td style="width: 5%" align="right">
                            Item
                        </td>
                        <td style="white-space: nowrap; width: 25%">
                            <gw:textbox id="txtItem"  />
                            
                        </td>     
                     <td style="width: 10%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>         
                      <td style="width: 2%" align="right">
                        <gw:imgbtn id="btnSearch" img="Search" alt="Search" onclick="OnSearch()" />
                    </td>
                    <td style="width: 2%" align="right">
                        <gw:imgbtn id="idSelect" img="select" alt="Select" onclick="OnSelect()" />
                    </td>
                </tr>
            </table>
        </td>
                
        </tr>
        
        <tr style="height: 45%">
        <td colspan="8">
            <gw:grid id='idGrid'
                header='_DELI_REQ_D_PK|Req No|Deli Date|PO No|Item Group|_TLG_IT_ITEM_PK|Item Code|Item Name|Quantiy|Price|Amount|Unit|Lot No'
                format='0|0|4|0|0|0|0|0|1|1|1|0|0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                check='||||||||||||'
                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                sorting='T'
                autosize='T' 
                oncelldblclick="OnGridCellDoubleClick(this)" 
                styles='width:100%; height:100%'
                />
         
        </tr>
           <tr style="height: 1%">
            <td colspan="7">
                <table>
                    <tr>
                        <td style="width: 96%" align="center">
                            <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 1%;white-space: nowrap">
                            <gw:checkbox id="chkDuplicate" defaultvalue="Y|N" value="N" />
                            Duplicate
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(idGrid)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
         <tr style="height: 40%">
        <td colspan="8">
             <gw:grid id='idGrid2'
               header='_DELI_REQ_D_PK|Req No|Deli Date|PO No|Item Group|_TLG_IT_ITEM_PK|Item Code|Item Name|Quantiy|Price|Amount|Unit|Lot No'
                format='0|0|4|0|0|0|0|0|1|1|1|0|0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                check='||||||||||||'
                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                sorting='T'
                autosize='T' 
                styles='width:100%; height:100%'
             />
         </td>
        </tr>
    </table>
</body>

<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<!--------------------------------------------------------->

</html>
