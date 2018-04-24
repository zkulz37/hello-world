<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP UP GET MANY EMPLOYEE & PARTNER</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript"> 
	
var G_Partner_PK	= 0,
	G_Partner_ID	= 1,
	G_Partner_Name	= 2,
	G_Local_Name	= 3;

//=======================================================================
function BodyInit()
{
	System.Translate(document); 
	
	var data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGGS0106') FROM DUAL" )%>||";    
    lstPartnerType.SetDataText(data);
	lstPartnerType.value = "" ;
	     
}
//=======================================================================

 function OnSearch(objAction)
 {
     switch(objAction)
     {
        case 'Employee':
            data_dsmt00021_Employee.Call('SELECT')
        break;
        case 'Partner':
            data_dsmt00021_Partner.Call('SELECT')
        break;
     }
 }
   
////=======================================================================
//function OnSelect(oGrid)
//{
//   var arr_data = new Array();
//   
//   if(oGrid.rows > 1)
//   {   
//      for(var i=1;i<oGrid.rows;i++)
//      {
//         var arrTemp=new Array();
//         
//         for(var j=0;j<oGrid.cols;j++)
//         {
//            arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
//         }
//         
//         arr_data[arr_data.length]= arrTemp;
//      }
//      
//	  if ( arr_data !=null )
//	  {
//		window.returnValue =  arr_data;
//		window.close();
//	  }
//	  else
//	  {
//	    alert("You have not selected data yet.");
//	  }
//   }	  
//	  
//}

//=======================================================================

function OnDataReceive(obj)
{
    switch ( obj.id )
    {        
        case 'data_dsmt00021_Partner' :
            if ( grdPartner.rows > 1 )
            {
                grdPartner.SetCellBgColor( 1, G_Partner_ID, grdPartner.rows - 1, G_Partner_ID, 0xCCFFFF );
            }
        break;
    }    
}
//================================================================================================
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
        var col_val = oGrid.GetGridData( row, G_Partner_PK);		
		
        if ( row > 0 && ( !CheckDataExist( idGrid2, col_val)) )
        {
	        idGrid2.AddRow();
    		
	        for(var j=0; j<oGrid.cols; j++)
	        {
	            idGrid2.SetGridText( idGrid2.rows-1, j, oGrid.GetGridData( row, j) );
	        }
        }		
	}   
}

//=======================================================================

function CheckDataExist(p_oGrid,p_value)
{  
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
	  
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, G_Partner_PK) == p_value)
              {
                 return true;
              }
       }
       return false;
}
//=======================================================================

function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData( idGrid2.row, G_Partner_PK);
    
    idGrid2.RemoveRowAt(idGrid2.row);
  }
}

//=======================================================================
function OnSelect()
{
    if(grdEmployee.selrow < 1)
    {
        alert("You must select Empoyee Info.");
        return;
    }
    if(grdPartner.selrow < 1)
    {
        alert("You must select Partner Info.");
        return;
    }
    
    var arr_data = new Array();
   
     
   for(var i=1;i<grdEmployee.rows;i++)
   {
    var l_Grid1 = grdEmployee.GetGridControl();
    if (l_Grid1.isSelected(i)==true)
    {
         var arrTemp=new Array();
         
         for(var j=0;j<grdEmployee.cols;j++)
         {
            arrTemp[arrTemp.length]= grdEmployee.GetGridData(i,j);
         }
         
         for(var k=1;k<grdPartner.rows;k++)
           {
            var l_Grid2 = grdPartner.GetGridControl();
            if (l_Grid2.isSelected(k)==true)
            {
                 var arrTemp1= new Array();
                 for(var h=0;h<grdPartner.cols;h++)
                 {
                    arrTemp1[arrTemp1.length]= grdPartner.GetGridData(k,h);
                 }
                 
                 arr_data[arr_data.length]= arrTemp.concat(arrTemp1);
             }
             
          }
         
         
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

//==================================================================================
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsmt00021_Partner" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsmt00021" > 
                  <input bind="grdPartner" > 
                    <input bind="lstPartnerType" />
                    <input bind="txtPartner" /> 
                    <input bind="chkAR_YN" /> 
                    <input bind="chkAP_YN" /> 
                  </input> 
                <output bind="grdPartner" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsmt00021_Employee" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsmt00021_1" > 
                  <input bind="grdEmployee" > 
                    <input bind="txtEmployee" /> 
                  </input> 
                <output bind="grdEmployee" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%; vertical-align: top;">
        <tr>
            <td style="width: 40%; height: 100%;">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Employee
                        </td>
                        <td style="width: 60%">
                            <gw:textbox id="txtEmployee" styles="width:100%" csstype="mandatory" onenterkey="OnSearch('Employee')" />
                        </td>
                        <td style="width: 10%" align="right">
                        </td>
                        <td style="width: 5%" align="left">
                        </td>
                        <td style="width: 10%" align="right">
                        </td>
                        <td style="width: 5%" align="left">
                        </td>
                        <td style="width: 3%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="idSearch1" img="search" alt="Search" onclick="OnSearch('Employee')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="9">
                            <gw:grid id="grdEmployee" header="_PK|Emp ID|Emp Name|_Local Name|_F Name" format="0|0|0|0|0"
                                aligns="0|0|0|0|0" defaults="||||" editcol="0|0|0|0|0" widths="0|1000|3000|1000|1000"
                                styles="width:100%; height:100%" sorting="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 60%; height: 100%;">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Partner
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstPartnerType" styles='width:100%' onchange="OnSearch('Partner')" />
                        </td>                         
                        <td style="width: 35%">
                            <gw:textbox id="txtPartner" styles="width:100%" csstype="mandatory" onenterkey="OnSearch('Partner')" />
                        </td>
                        <td style="width: 10%" align="right">
                            Customer
                        </td>
                        <td style="width: 5%" align="left">
                            <gw:checkbox id="chkAR_YN" defaultvalue="Y|N" value="N" />
                        </td>
                        <td style="width: 10%" align="right">
                            Supplier
                        </td>
                        <td style="width: 5%" align="left">
                            <gw:checkbox id="chkAP_YN" defaultvalue="Y|N" value="N" />
                        </td>
                        <td style="width: 3%" align="right">
                            <gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch('Partner')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="11">
                            <gw:grid id="grdPartner" header="_PK|Cust ID|Cust Name|_Local Name|_F Name" format="0|0|0|0|0"
                                aligns="0|0|0|0|0" defaults="||||" editcol="0|0|0|0|0" widths="0|1000|3000|1000|1000"
                                styles="width:100%; height:100%" sorting="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
</html>
