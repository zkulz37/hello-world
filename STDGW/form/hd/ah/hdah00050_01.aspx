<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>
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

function OnSelectAll()
{
    var arr = new Array();
    var ctrl=grdColumn.GetGridControl();
    for(var i=1; i<grdColumn.rows; i++)
    {
        arr[i] = -1;
    }    
    window.returnValue = arr; 			
	this.close();
}

</script>
<body >
<!-------------------data control----------------------->



<!------------------------------------------>
<gw:data id="datGridColumn" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1" function="HR_SEL_70010005_POP" procedure=""> 
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
                          <font size=5>Choose column to show</font>
                        </td>
					    
                        
				         <td colspan=2 style="border:0" align="right">
                        </td>
                        <td  style="border:0;" align="right" >                            
                           <gw:imgBtn img="selectall" id="ibtnSelectAll"   alt="Select"  onclick="OnSelect()"/>                            
                        </td>
                       
                        <td style="border:0" align="right">                           
                           <gw:imgBtn img="select" id="ibtnSelect"   alt="Select All"  onclick="OnSelectAll()"/>
                        </td>
                    </tr>
                    
                   
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=15 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdColumn"  
                                header="No.|Select Column| Column Name to show" 

                                format="0|3|0"  
                                aligns="1|0|0"  
                                defaults="|||"  
                                editcol="0|0|0"  
                                widths="1500|2000|2500"  
                                styles="width:100%; height:100%" 
								
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
