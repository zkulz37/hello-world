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
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document); 
  
    OnSearch();
    
}

//--------------------------------
function OnSearch()
{//txtOption.text=rdoKIND.value;
//alert(txtOption.text);
datSubAccount.Call("SELECT");	
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
     if (obj.id=="datSubAccount")
    {
        lblRecord.text=idGrid.rows-1 + " record(s).";
        auto_resize_column(idGrid,0,idGrid.cols-1,0);
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
    var obj=new Array();
    var ctrl 	= idGrid.GetGridControl();
    var rownum 	= ctrl.Row;
    var rownums 	= ctrl.Rows;
    if(rownum > 0 && rownums>1)
    {
        obj[0]=idGrid.GetGridData(ctrl.row,0);
        window.returnValue = obj
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
    
    if (idGrid.row > 1)
    {
        obj[1]=idGrid.GetGridData(idGrid.row,0);
    }
    else
        obj[1]=0;
    
	window.returnValue = obj; 
	window.close();
}*/
 </script>

<body>
<!---------------------------------------------------------->
<gw:data id="datSubAccount" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso  type="grid"  parameter="0,1,2" function="hr.sp_sel_sub_account" > 
                <input>
                    <input bind="txtInput" />
                </input>
                <output  bind="idGrid" />
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
                    <td style="width:10%;border:0" align="center">Sub Account</td>						
		            <td width="40%" valign="middle" style="border:0"><gw:textbox id="txtInput"  csstype="mandatory" styles='width:95%'  onenterkey="OnSearch()"/></td>
		            <td width="4%" style="border:0" align="right"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" onclick="OnSearch()" />  <td>	            
		            <td width="42%" align="center" style="border:0"><gw:label img="new" id="lblRecord"  style="font-weight:bold;color:red;font-size:12 "  text="0 record(s)"/></td>
		            <td width="4%"style="border:0" align="right"><gw:imgBtn img="cancel"    alt="Close"     id="ibtnClose" 	onclick="OnCloseClick()" /></td>
	            </tr>
	            <tr style="width:100%;height:5%;border:1" valign=top cellpadding="0" cellspacing="0">
	            <td width="100%" colspan=5  align="center">Double click to select</td>
	            </tr>
            	<tr style="width:100%;height:90%;border:1" valign=top cellpadding="0" cellspacing="0">
		            <td width="100%" colspan=5 >
				             <gw:grid   
                                        id="idGrid"  
                                        header="Sub Account|Description|Status"   
                                        format="0|0|0"  
                                        aligns="0|0|0"  
                                        defaults="|||"  
                                        editcol="0|0|0"  
                                        widths="2000|4000|1000|"  
                                        styles="width:100%; height:100%"   
                                        sorting="T"  oncelldblclick="CheckButton(this)"
                                        /> 

		            </td>
	            </tr>
            </table>
        </td>
	</tr>
</table>
	   
   <gw:textbox id="txtOption"   styles="display:none" />
	<gw:textbox id="txtcompany"   styles="display:none" />

</body>
</html>
