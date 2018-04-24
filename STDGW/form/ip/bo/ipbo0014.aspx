<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Select Color and Size</title>
</head>
<%  ESysLib.SetUser("stm")%>

<script> 
var style_pk = "<%=request.QueryString("style_pk") %>"  ;
var style_no = "<%=request.QueryString("style_no") %>"  ;

var gBlnFlag = true;
  function BodyInit()
 {
    txtStyler_pk.text = style_pk
    txtStyleNo.text   = style_no
    txtStyleNo.SetEnable(false);
    ipbo0012.Call('SELECT')
 }
 
 function OnDataReceive(obj)
 {
    if (obj.id=='ipbo0012')
    {
        ipbo0013.Call('SELECT')
    }
 }
 //----------------------------popup----------version 2---------------------
function OnSelect1()
{
    var arr_data = new Array();
    var ctrl = grdColor.GetGridControl();
    var  rowNo = 0
    if(ctrl.SelectedRows >0)
    {
        for(i=0;i<ctrl.SelectedRows;i++)
	        {	
	            rowNo = ctrl.SelectedRow(i)
	            for( var j =1 ; j <grdSize.rows; j++)
                {
                    var arrTemp=new Array();
                    if(grdSize.GetGridData(j,1)== -1)
                     {
                        arrTemp[0] = grdColor.GetGridData(rowNo,0) //color_pk
                        arrTemp[1] = grdColor.GetGridData(rowNo,3) //color name
                        arrTemp[2] = grdSize.GetGridData(j,0) //size_pk
                        arrTemp[3] = grdSize.GetGridData(j,2) //size_name
                        arrTemp[4] = grdSize.GetGridData(j,3) //size_qty
                        arr_data[arr_data.length]= arrTemp;
                    }
                }
	        }
        
    }else
    {
        alert("Select a Color, please!")
        return;
    }
   if (arr_data.length ==0)
   {
        alert("No data is seleted!")
   }else
   {   
     window.returnValue =  arr_data;
	 window.close();
   }
}  
//----------------------------popup---version 1----------------------------
function OnSelect0()
{
     var arr_data = new Array();
    for(var i =1; i<grdColor.rows ; i++)
    {
        if(grdColor.GetGridData(i,1)== -1)
        {
            for( var j =1 ; j <grdSize.rows; j++)
            {
                var arrTemp=new Array();
                if(grdSize.GetGridData(j,1)== -1)
                 {
                    arrTemp[0] = grdColor.GetGridData(i,0) //color_pk
                    arrTemp[1] = grdColor.GetGridData(i,3) //color name
                    arrTemp[2] = grdSize.GetGridData(j,0) //size_pk
                    arrTemp[3] = grdSize.GetGridData(j,2) //size_name
                    arrTemp[4] = grdSize.GetGridData(j,3) //size_qty
                    arr_data[arr_data.length]= arrTemp;
                }
            }
        }
    }
    window.returnValue =  arr_data;
	window.close();
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="ipbo0012" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid"  function="stm.sp_sel_ipbo0012"  > 
			    <input bind="grdColor" > 
			        <input bind="txtStyler_pk" />	
			    </input> 
			    <output bind="grdColor" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>   
    <gw:data id="ipbo0013" onreceive=""> 
	    <xml> 
		    <dso type="grid"  function="stm.sp_sel_ipbo0013"  > 
			    <input bind="grdSize" > 
			        <input bind="txtStyler_pk" />	
			    </input> 
			    <output bind="grdSize" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    
    <table width="100%" height="100%">
        <tr height="5%">
            
            <td width="15%">
                Style No
            </td>
            <td width="30%">
                <gw:textbox id="txtStyleNo"  styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td width="40%">
            </td>
            <td width="3%">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect1()" />
            </td>
           </tr>
        <tr border="1" height="95%">
            <td colspan="4">
                    <table style="width:100%; height:100%">
                        <tr>
                            <td style="width:48%; height:100%">
                                <gw:grid id='grdColor'
                                header='_PK|_Check|Color Id|Color Name'
                                format='0|3|0|0'
                                aligns='0|0|0|0'
                                defaults='||||'
                                editcol='0|0|0|0'
                                widths='0|1500|1500|1500'
                                sorting='T'
                                styles='width:100%; height:90%'
                                />
                            </td>
                            <td style="width:5%">
                            </td>
                            <td style="width:47%; height:100%">
                                <gw:grid id='grdSize'
                                header='_PK|Check|Size|Quantity'
                                format='0|3|0|1'
                                aligns='0|0|0|0'
                                defaults='||||'
                                editcol='0|0|0|1'
                                widths='0|1500|1500|1500'
                                sorting='T'
                                styles='width:100%; height:90%'
                                 />
                            </td>
                        </tr>
                    </table>   
            </td>
        </tr>
    </table>
</body>
 <gw:textbox id="txtStyler_pk" text="" styles="display:none" />

</html>
