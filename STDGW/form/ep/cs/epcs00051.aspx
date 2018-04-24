<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Many PROD</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">

 var  G1_PK              = 0,
         G1_CUS_CODE           = 1,
         G1_MA_DV              = 2,
         G1_PROD_CODE           = 3
         G1_PROD_NAME           =4,
         G1_PROD_NAME_1         =5,
         G1_PROD_NAME_2         =6,
         G1_UNIT               =7,
         G1_HS_CODE            =8,
         G1_PROD_STATUS             =9,
         G1_TAX_TARIFFS        =10,
         G1_IMEX_TAX           =11,
         G1_ABSOLUTE_TAX_RATE  =12,
         G1_VAT_TARIFFS        =13,
         G1_VAT_TAX            =14,
         G1_VAT_ABSOLUTE       =15,
         G1_EXCIE_TAX          =16,
         G1_TAX_EXCISE_ABSOLUTE=17,
         G1_TAX_ENVIR_TARFFIS  =18,
         G1_TAX_ENVIR          =19,
         G1_TAX_ENVIR_ABSOLUTE =20,
         G1_OTHER_INCOME       =21,
         G1_EXEMPTION_YN       =22,
         G1_EXEMPTION_REFNO    =23,
         G1_EXEMPTION_TAX      =24,
         G1_EXEMPTION_TAX_REDUCED=25,
         G1_IS_SYNC            =26,
         G1_INCENTIVES         =27,
         G1_HS_CODE_EXPANSION  =28;  
    
//-------------------------------------------

function BodyInit()
{
	System.Translate(document);
	//-------------------------
	txt_CusCode.text = "<%=Request.querystring("cus_cd")%>";
	txt_ComCode.text = "<%=Request.querystring("com_cd")%>";
	
	var data="";    
//    data = "DATA|1|SAVED|2|SUBMITED|3|APPROVED|4|CANCEL||Select All";    
//    cboStatus.SetDataText(data);
//    cboStatus.value = "";

    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IECU03' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.code, a.code_nm")%>";   
    idGrid.SetComboFormat(G1_UNIT,data);
    idGrid2.SetComboFormat(G1_UNIT,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select tariffs_code ,tariffs_code || ' - ' || tariffs_name from TLG_IE_TARIFFS where del_if = 0 and tax_type in ('N','KHAC')")%>||";   
    idGrid.SetComboFormat(G1_TAX_TARIFFS,data);
    idGrid2.SetComboFormat(G1_TAX_TARIFFS,data);
    
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select tariffs_code ,tariffs_code || ' - ' || tariffs_name from TLG_IE_TARIFFS where del_if = 0 and tax_type in ('VAT')")%>||";   
    idGrid.SetComboFormat(G1_VAT_TARIFFS,data);
    idGrid2.SetComboFormat(G1_VAT_TARIFFS,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select tariffs_code ,tariffs_code || ' - ' || tariffs_name from TLG_IE_TARIFFS where del_if = 0 and tax_type in ('TTDB')")%>||";   
    idGrid.SetComboFormat(G1_VAT_ABSOLUTE,data);
    idGrid2.SetComboFormat(G1_VAT_ABSOLUTE,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select tariffs_code ,tariffs_code || ' - ' || tariffs_name from TLG_IE_TARIFFS where del_if = 0 and tax_type in ('MT')")%>||";   
    idGrid.SetComboFormat(G1_TAX_ENVIR_TARFFIS,data);
    idGrid2.SetComboFormat(G1_TAX_ENVIR_TARFFIS,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IECU05' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.ord, a.code, a.code_nm")%>";   
    idGrid.SetComboFormat(G1_INCENTIVES,data);
    idGrid2.SetComboFormat(G1_INCENTIVES,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IECU06' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.ord, a.code, a.code_nm")%>";   
    idGrid.SetComboFormat(G1_PROD_STATUS,data);
    idGrid2.SetComboFormat(G1_PROD_STATUS,data);
	
	//----------------------------------
}
//======================================================================

function OnFormatGrid()
{
   
}

//======================================================================
function OnSearch(obj)
{ 
    switch(obj)
    {
        case 1:
	            data_fpab00051.Call("SELECT");
        break;
    }
   
}
//======================================================================
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

//======================================================================

function OnReceiveData(obj)
{
   switch(obj.id)
    {
        case 'data_fpab00051':
        break;
      }
}
//======================================================================

function OnGridCellDoubleClick(oGrid)
{
  if(oGrid.id == "idGrid" && event.row > 0 )
  {
    var col_val_1 = oGrid.GetGridData(event.row, G1_PK );
    var col_val_2 = oGrid.GetGridData(event.row, G1_HS_CODE    );
    
    if ( event.row > 0 && ( !CheckDataExist(idGrid2, col_val_1, col_val_2 )) )
    {
        SetRowBackGroundColor( oGrid, col_val_1, col_val_2, 0x0000FF);
        
		idGrid2.AddRow();
		
		for(var i=0;i<oGrid.cols;i++)
		{
		  idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(event.row,i));
		}
     }
  }
  countItem()
}
//======================================================================

function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
//================================================================================================

function CheckDataExist(p_oGrid,p_value_01,p_value_02)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    //------------------------
    for(var i=1;i<p_oGrid.rows;i++)
    {
          if ( p_oGrid.GetGridData(i, G1_PK) == p_value_01 && p_oGrid.GetGridData(i, G1_HS_CODE) == p_value_02 )
          {
             return true;
          }
    }    
    //------------------------
    return false;
}
//================================================================================================

function SetRowBackGroundColor(p_oGrid, p_col_val_01, p_col_val_02, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if ( p_oGrid.GetGridData( i, G1_PK) == p_col_val_01 && p_oGrid.GetGridData( i, G1_HS_CODE) == p_col_val_02 )
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}

//================================================================================================
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
		
        var col_val_01 = oGrid.GetGridData( row, G1_PK);		
		var col_val_02 = oGrid.GetGridData( row, G1_HS_CODE   );
		
        if ( row > 0 && ( !CheckDataExist( idGrid2, col_val_01, col_val_02 )) )
        {
            SetRowBackGroundColor( oGrid, col_val_01, col_val_02 , 0x0000FF);
            
	        idGrid2.AddRow();
    		
	        for(var j=0; j<oGrid.cols; j++)
	        {
	            idGrid2.SetGridText( idGrid2.rows-1, j, oGrid.GetGridData( row, j) );
	        }
        }
		
	}
    
    countItem();    
}
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
      if ( idGrid2.row > 0 )
      {
            var col_val_01 = idGrid2.GetGridData( idGrid2.row, G1_PK );
            var col_val_02 = idGrid2.GetGridData( idGrid2.row, G1_HS_CODE    );
            
            idGrid2.RemoveRowAt(idGrid2.row);
            
            SetRowBackGroundColor(idGrid,col_val_01,col_val_02,0x000000); 
            
            countItem();
      }
}
//======================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_fpab00051" onreceive="OnReceiveData(this)"> 
        <xml> 
           <dso id="1" type="grid" function="<%=l_user%>lg_sel_epcs00051" > 
                  <input bind="idGrid" > 
                    <input bind="txt_CusCode" />
                    <input bind="txt_ComCode" />
                    <input bind="txt_ProdCode" />
                    <input bind="txt_ProdName" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Code
            </td>
            <td style="width: 20%">
                <gw:textbox id="txt_ProdCode" styles="width:100%" onenterkey="OnSearch(1)" csstype="mandatory" />
            </td>
            <td style="width: 5%" align="right">
               Name
            </td>
            <td style="width: 20%">
                <gw:textbox id="txt_ProdName" styles="width:100%" onenterkey="OnSearch(1)" />
            </td>
            <td style="width: 30%; white-space: nowrap">
                
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)" />
            </td>
        </tr>
        <tr style="height: 49%">
            <td colspan="7">
               
                    <gw:grid id='idGrid'
                            header='_PK|_CUS_CODE|_Company Code|Prod Code|Prod Name|Prod Name(En)|_MAT_NAME_2|Unit|HS Code|Status goods|_TAX_TARIFFS|_IMEX_TAX|_ABSOLUTE_TAX_RATE|_VAT_TARIFFS|_VAT_TAX|_VAT_ABSOLUTE|_EXCIE_TAX|_TAX_EXCISE_ABSOLUTE|_TAX_ENVIR_TARFFIS|_TAX_ENVIR|_TAX_ENVIR_ABSOLUTE|_OTHER_REC|_EXEMPTION_YN|_EXEMPTION_REFNO|_EXEMPTION_TAX|_EXEMPTION_TAX_REDUCED|_IS_SYNC|_INCENTIVES|_HS_CODE_EXPANSION'
                            format='0|0|0|0|0|0|0|2|0|2|2|1|1|2|1|1|2|1|2|1|1|1|3|0|1|0|3|2|0'
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            check='||||||||||||||||||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='1000|1000|1000|1000|3500|3000|1000|1000|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                            sorting='T'
                            styles='width:100%; height:100%'
                            oncelldblclick="OnGridCellDoubleClick(this)"
                            />
                    
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="7">
                <table>
                    <tr>
                        <td align="center" style="width:100%">
                            <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td  align="right" style="white-space: nowrap">
                            <gw:checkbox id="chkDuplicate" defaultvalue="Y|N" value="N" styles='display:none' />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(idGrid)" />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td colspan="7">
                             
                    <gw:grid id='idGrid2'
                                                    header='_PK|_CUS_CODE|_Company Code|Prod Code|Prod Name|Prod Name(En)|_PROD_NAME_2|Unit|HS Code|Status goods|_TAX_TARIFFS|_IMEX_TAX|_ABSOLUTE_TAX_RATE|_VAT_TARIFFS|_VAT_TAX|_VAT_ABSOLUTE|_EXCIE_TAX|_TAX_EXCISE_ABSOLUTE|_TAX_ENVIR_TARFFIS|_TAX_ENVIR|_TAX_ENVIR_ABSOLUTE|_OTHER_REC|_EXEMPTION_YN|_EXEMPTION_REFNO|_EXEMPTION_TAX|_EXEMPTION_TAX_REDUCED|_IS_SYNC|_INCENTIVES|_HS_CODE_EXPANSION'
                                                    format='0|0|0|0|0|0|0|2|0|2|2|1|1|2|1|1|2|1|2|1|1|1|3|0|1|0|3|2|0'
                                                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                    check='||||||||||||||||||||||||||||'
                                                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                    widths='1000|1000|1000|1000|3500|3000|1000|1000|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                                    sorting='T'
                                                    styles='width:100%; height:100%'
                                                    oncelldblclick="OnGridCellDoubleClick(this)"
                                                    />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------------------------------->
     <gw:textbox id="txt_CusCode" styles="width:100%; display:none" />
     <gw:textbox id="txt_ComCode" styles="width:100%; display:none" />
</body>
</html>
