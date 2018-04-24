<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{       
    OnSearch();	
}


function OnSearch()
{
    datGridColumn.Call();
}

function OnDataReceive(obj)
{


}

function OnSelect()
{
    var arr = new Array();
    var ctrl=grdColumn.GetGridControl();
    for(var i=1; i<grdColumn.rows; i++)
    {
        arr[i] = grdColumn.GetGridData(i,1);
    }
    //alert(arr);
    //return;
    window.returnValue = arr; 			
	this.close();
}
function OnDbClik()
{
    var arr = new Array();
    var ctrl=grdColumn.GetGridControl();
    if (ctrl.SelectedRows>=1) 
    {
        for(var i=0;i<ctrl.SelectedRows;i++)
        {
            arr[0]= grdColumn.GetGridData(ctrl.SelectedRow(i),1);
            arr[1]= grdColumn.GetGridData(ctrl.SelectedRow(i),2);
            arr[2]= grdColumn.GetGridData(ctrl.SelectedRow(i),3);
            arr[3]= grdColumn.GetGridData(ctrl.SelectedRow(i),4);
            window.returnValue = arr; 			
	        this.close();
	    }
	}
}
</script>
<body >
<!-------------------data control----------------------->



<!------------------------------------------>
<gw:data id="datGridColumn" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1" function="hr.SP_SEL_BAND_GRID_POPUP" procedure=""> 
                <input bind="grdColumn" >                    
                    
                </input>
                <output  bind="grdColumn" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<!-------------------data control----------------------->
   <table id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=9  style="border:0" align="center" valign="middle">
                          <font size=5>Choose Band & Grade</font>
                        </td>
					    
                        
				         <td colspan=2 style="border:0" align="right">
                        </td>
                        <td  style="border:0;" align="right" >                            
                                                     
                        </td>
                       
                        <td style="border:0" align="right">                           
                           
                        </td>
                    </tr>
                    
                   
                    <tr style="border:1;width:100%;height:90%" valign="top">
                        <td colspan=15 style="width:100%;height:90%;"> 
                             <gw:grid   
                                id="grdColumn"  
                                header="No.|Band|Grade|_Band code|_Grade Code" 
                                format="0|0|0|0|0"  
                                aligns="1|0|0|0|0"  
                                defaults="|||||"  
                                editcol="0|0|0|0|0"  
                                widths="1500|2000|2500|0|0"  
                                styles="width:100%; height:100%" 
								oncelldblclick="OnDbClik()"
                                sorting="T"    oncellclick=""
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
</html>
