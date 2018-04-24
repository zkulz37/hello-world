<!-- #include file="../../../system/lib/form.inc"  -->

  <head>
    <title>genuwin</title>
  </head>
  
 <%ESysLib.SetUser("hr")%>
 
 <script>
var bAdd=false;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    grdDetailCode.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document); 
    txtInput.text="";
    OnSearch();
    
}

//--------------------------------
function OnSearch()
{txtOption.text=rdoKIND.value;
//alert(txtOption.text);
datDetailCode.Call("SELECT");	
}

//------------------------------------------------------
//---------------------------------------------------------------
//---------------------------------------------------------------
function checkDupItems(obj_grid,obj_col,obj_col_dis)
{/*
    var ctrl 	= obj_grid.GetGridControl();
    var rownum 	= ctrl.Rows;
    if(rownum == 1)
    {
	    return false;
    }
    var i;
    for(i=1; i<rownum; i++)
    {
        
      for(j=i+1; j<rownum; j++)
      {
  	    var i_code 	= obj_grid.GetGridData(i, obj_col);
	    i_code		= i_code.toUpperCase();
	    var j_code 	= obj_grid.GetGridData(j, obj_col);
	    j_code		= j_code.toUpperCase();
    	
	    if(j_code == i_code)
	    {
		    if(j_code !="" )
		    {
			    alert("Code already in use, please re-enter at row " + (i+1) + " and column " + obj_col_dis );
			    return false;
		    }
	    }
      }	
    }
    return true;
*/}
//---------------------------------------------------
//--------------------------------
//--------------------------------------------------------

//--------------------------------

function OnDataReceive(obj)
{     
     if (obj.id=="datDetailCode")
    {
        lblRecord.text=grdDetailCode.rows-1 + " record(s).";
        auto_resize_column(grdDetailCode,0,grdDetailCode.cols-1,0);
    }
   
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------------
function OnCloseClick()
{	window.returnValue = 0; 
	window.close();
}
//-----------------------------------------------------
function CheckButton(obj)
{
    var ctrl 	= grdDetailCode.GetGridControl();
    var rownum 	= ctrl.Row;
    var rownums 	= ctrl.Rows;
    if(rownum > 0 && rownums>1)
    {
    window.returnValue = grdDetailCode.GetGridData(grdDetailCode.row,0); 
	window.close();
    }
}
//-------------------------
function ExitOnClick()
{
	OnCloseClick()
}
//--------------------------
/*function OnSelectClick()
{
   var obj=new Array();
    obj[0]=flag;
    
    if (grdDetailCode.row > 1)
    {
        obj[1]=grdDetailCode.GetGridData(grdDetailCode.row,0);
    }
    else
        obj[1]=0;
    
	window.returnValue = obj; 
	window.close();
}*/
 </script>

<body>
<!---------------------------------------------------------->
<gw:data id="datDetailCode" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso  type="grid"  parameter="0,1,2,3,4" function="hr.sp_sel_project_code" > 
                <input>
                    <input bind="txtOption" />
                    <input bind="txtInput" />
                </input>
                <output  bind="grdDetailCode" />
            </dso> 
        </xml> 
</gw:data> 
<!------------------------------------------->
   
<!-- MainTable -->
<table    style='margin-left:10px' cellpadding="0" cellspacing="0" border="1" style="width:100%;height:100%">
	<tr style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top">
	    <td>
	        <table border=1 cellpadding="0" cellspacing="0"  style="height:100%" width="100%">
                <tr style="width:100%;height:5%;border:0" valign="middle" cellpadding="0" cellspacing="0">
                    <td style="width:30%;border:0" align="center">
                        <gw:radio id="rdoKIND" value="1" > 
                            <span value="1" > <font color="black" ><b>Code </b> </font></span>
                            <span value="2" > <font color="black" ><b>Name</b> </font> </span>
                        </gw:radio >
                    </td>						
		            <td width="30%" valign="middle" style="border:0"><gw:textbox id="txtInput"  csstype="mandatory" styles='width:95%' onenterkey="OnSearch()" /></td>
		            <td width="4%" style="border:0" align="right"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" onclick="OnSearch()" />  <td>	            
		            <td width="36%" align="center" style="border:0"><gw:label img="new" id="lblRecord"  style="font-weight:bold;color:red;font-size:12 "  text="0 record(s)"/></td>
		            <td width="4%"style="border:0" align="right"><gw:imgBtn img="cancel"    alt="Close"     id="ibtnClose" 	onclick="OnCloseClick()" /></td>
	            </tr>
	            <tr style="width:100%;height:5%;border:1" valign=top cellpadding="0" cellspacing="0">
	            <td width="100%" colspan=5  align="center">Double click to select</td>
	            </tr>
            	<tr style="width:100%;height:90%;border:1" valign=top cellpadding="0" cellspacing="0">
		            <td width="100%" colspan=5 >
				             <gw:grid   
                                        id="grdDetailCode"  
                                        header="_PK|CODE|NAME|KNAME|_FNAME"   
                                        format="0|0|0|0|0"  
                                        aligns="0|0|0|0|0"  
                                        defaults="|||||"  
                                        editcol="0|0|0|0|0"  
                                        widths="0|1500|5000|5000|2000"  
                                        styles="width:100%; height:100%"   
                                        sorting="F"  oncelldblclick="CheckButton(this)"
                                        /> 

		            </td>
	            </tr>
            </table>
        </td>
	</tr>
</table>
	   
   <gw:textbox id="txtOption"   styles="display:none" />
	

</body>
</html>
