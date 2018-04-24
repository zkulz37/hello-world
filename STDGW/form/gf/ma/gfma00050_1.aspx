<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ADVANCE LIST</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>

var flag;
var _book_rate = 0;
var book_format='';
var trs_format='';
var data ;
//--------------------------------------------------------------------- 
function BodyInit()
{
    System.Translate(document);  // Translate to language session
    txtEmployeePK.text="<%=request("emp_pk")%>" 
    txtEmployeeID.text="<%=request("empid")%>" 
    
    BindingDataList();
    dat_gfma00050_12.Call();
}
//-------------------------------------------------------------------

 function BindingDataList()
 {      
     var arr;
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.sf_a_get_company('') FROM DUAL")%>";   
     cboCompany.SetDataText(data);
     data = ("<%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where  del_if=0")%>"); 
     cbodept.SetDataText(data+ "|0|Select ALL");
     cbodept.SetDataText('0');
     SetGridFormat();
 }
 //---------------------------------------------------------------------------------------------------
 
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    ctr.ColFormat(5) = "#,###,###,###,###,###.##";
    ctr = grdDetail1.GetGridControl(); 
    ctr.ColFormat(5) = "#,###,###,###,###,###.##";
 }
//-----------------------------------------------------------------------------------
function OnSearch(index)
{
    switch (index)
    {
        case 0:
            
            dat_gfma00050_11.Call("SELECT");
        break;
       
    }
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
  if(oGrid.id == "grdDetail")
  {
    var col_val = oGrid.GetGridData(event.row,0);
    
    if(event.row > 0 && ( !CheckDataExist(grdDetail1,col_val)) )
    {
        SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		grdDetail1.AddRow();
		for(var i=0;i<oGrid.cols;i++)
		{
		  grdDetail1.SetGridText(grdDetail1.rows-1,i,oGrid.GetGridData(event.row,i));
		}
     }
  }
  countItem();
}
//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}    
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
  for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,0) == p_value)
      {
         return true;
      }
   }
   return false;
} 
//--------------------------------------------------------------------
function OnRemove()
{
  if(grdDetail1.row > 0)
  {
    var col_val = grdDetail1.GetGridData(grdDetail1.row,1);
    grdDetail1.RemoveRowAt(grdDetail1.row);
    SetRowBackGroundColor(grdDetail,col_val,0x000000); 
    countItem();
  }
}  
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=grdDetail1.rows-1 + " row(s)."
}
function return_row()
{
     var arr_data = new Array();
   
           if(grdDetail1.rows > 1)
           {   
              for(var i=1;i<grdDetail1.rows;i++)
              {
                 var arrTemp=new Array();
                //  alert(grdDetail.GetGridData(i,2));
                // if (grdDetail1.GetGridData(i,0)== '-1')
               //  {
                    for(var j=0;j<grdDetail1.cols;j++)
                     {
                        arrTemp[arrTemp.length]= grdDetail1.GetGridData(i,j);
                     }             
                     arr_data[arr_data.length]= arrTemp;
                // }    
              }
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
//------------------------------------------------------------------------------------------------

</script>

<body>
    <!-------------1-------------------------------------------------------------->
   
 <gw:data id="dat_gfma00050_11"  onreceive="" > 
    <xml> 
        <dso id="1" type="grid"    function="acnt.sp_sel_gfma00050_11"   > 
            <input bind="grdDetail">                    
                <input bind="cboCompany" /> 
                <input bind="cbodept" /> 
                <input bind="dtFrom_s" /> 
                <input bind="dtto_s" /> 
                <input bind="txtEmployeePK" /> 
                <input bind="txtAdvVC" /> 
            </input> 
            <output bind="grdDetail" /> 
        </dso> 
    </xml> 
</gw:data>
    <!--------------------------------------->
<gw:data id="dat_gfma00050_12" onreceive=""  > 
        <xml> 
            <dso  type="process" procedure="acnt.sp_pro_gfma00050_11" > 
                <input>
                    <input bind="txtEmployeePK" /> 
               </input> 
                <output>
                    <output bind="txtEmployeeNm" />
               </output>
            </dso> 
        </xml> 
</gw:data>
  <!---------------------------------------------------------------------------->
  <table style="width: 100%; height: 100%" border="1">
        <tr>
            
            <td id="right" style="width: 100%" valign=top>
               <fieldset style="padding: 2">
	            <table border="0" width="100%" cellpadding=0 cellspacing=0 id="table1">
		            <tr>
            			
			            <td width="10%">Company</td>
                        <td width="20%" colspan=3><gw:list id="cboCompany" styles="width:100%;" /></td>
                        <td width="10%" align=right>Department</td>
                        <td width="40%" colspan=2><gw:list id="cbodept" onchange="" styles="width:100%;" /></td>
                        <td  width=10%></td>
                        <td  width=10%></td>
			            <td width=2%><gw:imgbtn id="btnsearch" img="search" alt="Search" onclick="OnSearch(0)" styles="width:100%;display:" /></td>
			            <td width=2%><gw:imgbtn id="btnselect" img="select" alt="Select" onclick="return_row()" /></td>
                       
		            </tr>
		            <tr>
		                
                        <td width="10%">From date</td>
                        <td align=left ><gw:datebox id="dtFrom_s" onchange="" lang="1" /> </td>
                        <td  width=1% align=center>~</td>
                        <td align=left colspan=1 ><gw:datebox id="dtto_s" onchange="" lang="1" /> </td>
                        <td width="10%" align=right>Employee</td>
                        <td width="10%"><gw:textbox id="txtEmployeeID" onenterkey="OnSearch(0)" onchange="OnSearch(0)"  styles="width:100%;" /><gw:textbox id="txtEmployeePK" onenterkey="OnSearch(0)" onchange="OnSearch(0)"  styles="width:100%;display:none" /></td>
                       
                        <td width="30%" colspan=1><gw:textbox id="txtEmployeeNm" onenterkey="OnSearch(0)" onchange="OnSearch(0)" styles="width:100%;" /></td>
                        <td align="right" width="10%">Voucher No</td>
                        <td align=left colspan=3 ><gw:textbox id="txtAdvVC"  onenterkey="OnSearch(0)" styles="width:100%;"/> </td>
		            </tr>
		           
	            </table>
	            </fieldset>
	            <table border="0" width="100%" cellpadding=0 cellspacing=0 id="table3">
	                <tr>
	                    <!---0.pk|1.Select|2.Voucher No|3.Date |4.Reeason|5.Amount|6.CCY|7.Ex. rate|8_tac_empadvreq_pk|9_masterpk-->
		                <td width="50%" align="justify" valign="top">
    		                <fieldset style="padding: 2">
			                <legend>A. Advance List </legend>
			                     <table border="0" cellpadding=0 cellspacing=0 width="100%">
	                                
	                                <tr>
	                                    <td colspan=4>
	                                        <gw:grid id='grdDetail' 
                                                header='_pk|_Select|Voucher No|Date |Reason|Amount|CCY|Ex. rate|_tac_empadvreq_pk|_masterpk'
                                                format='0|3|0|4|0|0|0|0|0|0'
                                                aligns='1|0|2|1|2|3|1|3|0|0'
                                                defaults='|||||||||'
                                                editcol='1|1|1|1|1|1|1|1|1|1'
                                                widths='0|800|2000|1200|5500|1200|500|1200|0|0'
                                                sorting='T'
                                                acceptNullDate="f"     
                                                oncellclick=""   
                                                oncelldblclick="OnGridCellDoubleClick(this)"                      
                                                styles='width:100%; height:250'      
                                            />
                                        </td>
	                                </tr>
	                                <tr>
	                                    <td colspan=3><gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' /></td>
                                        <td width="2%"><gw:imgbtn id="btnNewMST" img="delete" alt="Delete" onclick="OnRemove()" />
                                        </td>
	                                </tr>
	                                <tr>
	                                    <td colspan=4>
	                                        <gw:grid id='grdDetail1' 
                                                header='_pk|_Select|Voucher No|Date |Reason|Amount|CCY|Ex. rate|_tac_empadvreq_pk|_masterpk'
                                                format='0|3|0|4|0|0|0|0|0|0'
                                                aligns='1|0|2|1|2|3|1|3|0|0'
                                                defaults='|||||||||'
                                                editcol='1|1|1|1|1|1|1|1|1|1'
                                                widths='0|800|2000|1200|5500|1200|500|1200|0|0'
                                                sorting='T'
                                                acceptNullDate="f"     
                                                oncellclick=""   
                                                oncelldblclick=""                      
                                                styles='width:100%; height:250'      
                                            />
                                        </td>
	                                </tr>
                                </table>
                            
                            </fieldset>
		                </td>
		                
		                    
                                
                            </fieldset>
                        </td>
	                </tr>
                </table>
               
            </td>
         </tr>
    </table>        
     
 
	<gw:textbox id="txtMasterpk"  styles="width:100%;display:none" />

</body>
</html>
