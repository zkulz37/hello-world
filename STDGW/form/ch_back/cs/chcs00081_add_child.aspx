<!-- #include file="../../../system/lib/form.inc"  -->

  <head>
    <title>genuwin</title>
  </head>
  
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 
 <script>
var flag=0; //chua co modify thong tin
var bAdd=false;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    grdChild.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    txtEmp_PK.text = "<%=Request.querystring("emp_pk")%>";
    txtEmp_NM.text = "<%=Request.querystring("emp_name")%>";
    OnSearch();
    
}

//--------------------------------
function OnSearch()
{
    datChild.Call("SELECT");
}

//--------------------------------

function OnDataReceive(obj)
{
    
    if (obj.id=="datChild")
    {
        lblRecord.text=grdChild.rows -1 + " record(s).";
        //auto_resize_column(grdChild,0,grdChild.cols-1,0);
    }
   
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}


//-------------------------
function ExitOnClick()
{
	window.returnValue = null; 
	window.close();
}
//--------------------------
function OnSelectClick()
{
   var obj=new Array();
    
    if (grdChild.row >= 1)
    {
        obj[0] = grdChild.GetGridData(grdChild.row,2);
        obj[1] = grdChild.GetGridData(grdChild.row,3);
    }
    
    
	window.returnValue = obj; 
	window.close();
}

 </script>

<body>
<!---------------------------------------------------------->
<gw:data id="datChild" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="hr_sel_10030023_child" > 
                <input bind="grdChild" >
                    <input bind="txtEmp_PK" />
                </input>
                <output  bind="grdChild" />
            </dso> 
        </xml> 
</gw:data> 

<!-- MainTable -->
<table    style='margin-left:10px' cellpadding="0" cellspacing="0" border="1" style="width:100%;height:100%">
	<tr style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top">
	    <td>
	        <table border=1 cellpadding="0" cellspacing="0"  style="height:100%" width="100%">
                <tr style="width:100%;height:5%;border:0" valign="middle" cellpadding="0" cellspacing="0">
                    <td style="width:30%;border:0" align="center">
                        <font style="font-size:14; color:red"> Child List </font> 
                    </td>						
		            <td width="20%" valign="middle" style="border:0"></td>
		            <td width="22%" align="right" style="border:0"><gw:label img="new" id="lblRecord"  style="font-weight:bold;color:red;font-size:12 "  text="0 record(s)"/></td>
		            <td width="4%" style="border:0" align="right">  <td>
                    <td width="4%" style="border:0" align="right"></td>					
		            <td width="4%" style="border:0" align="right"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" onclick="OnSearch()" /></td>  
		            <td width="4%" style="border:0" align="right"></td>  
		            <td width="4%" style="border:0" align="right"></td>
		            <td width="4%" style="border:0" align="right"></td>
		            <td width="4%"style="border:0" align="right"><gw:imgBtn img="cancel"    alt="Close"     id="ibtnClose" 	onclick="ExitOnClick()" /></td>
	            </tr>
            	<tr style="width:100%;height:95%;border:1" valign=top cellpadding="0" cellspacing="0">
		            <td width="100%" colspan=11 >
				             <gw:grid   
                                        id="grdChild"  
                                        header="_PK|No|Child Name|Birth Date|Birth Place|Address"   
                                        format="0|0|0|0|0|0"  
                                        aligns="1|1|1|1|1|0"  
                                        defaults="|||||"  
                                        editcol="0|0|0|0|0|0"  
                                        widths="0|500|2500|2000|2000|2000"  
                                        styles="width:100%; height:100%"   
                                        sorting="F" 
                                         oncelldblclick="OnSelectClick()"
                                        /> 

		            </td>
	            </tr>
            </table>
        </td>
	</tr>
</table>
	   
   	

	<gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtEmp_NM" styles="display:none"/>

</body>
</html>
