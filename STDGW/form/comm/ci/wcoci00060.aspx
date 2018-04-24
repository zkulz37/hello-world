<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
 <%ESysLib.SetUser("comm")%>
  <head>
    <title>genuwin</title>
  </head>

 <script>
//------------------------------------------------------------ 
function BodyInit()
{
    idData_Dsql_ItemTree.Call("SELECT");
} 
//------------------------------------------------------------
 function OnTreeClick()
{ 
   var obj = event.srcElement.GetCurrentNode();    
   txtGroup_PK.text  = ''+obj.oid; 
    txtITEM_CODE.text = ''; 
   grdItem.ClearData();
    idData_item_coci00060.Call("SELECT");
}
   

//-------------------------------------------------------------- 
function OnDataReceive(p_oData)
{
    
}
//--------------------------------------------------------
function SearchOnClick()
{
    txtGroup_PK.text =""; 
    grdItem.ClearData();
    idData_item_coci00060.Call("SELECT");
}
//--------------------------------------------------------
function Upcase()
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
//-------------------------------------------------------
 </script>
<body>
 <!------------------------------------------------------------------------------->
    <gw:data id="idData_Dsql_ItemTree" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="tree" user="comm" function="comm.sp_sel_Item" > 
                <input />
                <output bind="oTree" /> 
            </dso> 
        </xml> 
    </gw:data>

    <!-----------------grdAttribute ---------------------------------------->
     <gw:data id="idData_item_coci00060"  onreceive="OnDataReceive(this)" > 
            <xml> 
               <dso id="1" type="grid" user="comm" parameter="0,1,2,3,4,5,6" function="comm.sp_sel_item_coci00060"  > 
                    <input bind="grdItem" > 
                        <input bind="txtITEM_CODE" /> 
                        <input bind="txtGroup_PK" />
                    </input> 
                    <output bind="grdItem" /> 
                </dso> 
            </xml> 
    </gw:data> 
   <!----------------------------------------------------------------------> 
 <!------------------------------------------------------------------------------->
 <!------------------------------------------------------------------------------->
 <!------------------------------------------------------------------------------->
 <!------------------------------------------------------------------------------->
 <!------------------------------------------------------------------------------->     

<table border="0" width="100%" id="Table1" cellpadding="0" cellspacing="0">
<tr valign="top">
<td width="20%">
        <gw:tree   ID = "oTree" style="width:100%; height:490;overflow:auto;" onclicknode="OnTreeClick()" />
</td>
<td width="80%">
    <table border="0" width="100%" id="Table3">
        <tr>
                <td width="90%">
                        <table width="100%" height="20" cellpadding="4" cellspacing="1" id="RightTopTB" bgcolor="81d7f3">
                                  <tr> 
                                    <td width="25%" bgcolor="bde9ff"><font color="black" ><b>Item Code&nbsp;</b></font></td>
                                    <td width="75%" bgcolor="#FFFFFF"><gw:textbox id="txtITEM_CODE" styles='width:100%'  onenterkey="SearchOnClick()" onkeypress ="Upcase()"  /></td>
                                  </tr>
                                 <!-- 
                                  <tr> 
                                    <td width="25%" bgcolor="bde9ff"><font color="black" ><b>Item Description&nbsp;</b></font></td>
                                    <td width="75%" bgcolor="#FFFFFF"><gw:textbox  id="idITEM_DESC" styles='width:100%'  onenterkey="SearchOnClick()" /></td>
                                  </tr>
                                 --> 
                        </table>
                </td>
               <td width="10%" valign="bottom" align="left">
                        <gw:imgBtn id="ibtnSearch" img="search" alt="Search" text="Search"  onclick="SearchOnClick()" />
               </td>
        </tr> 
       <tr>
        <td colspan="2">
             <gw:grid
                                            id="grdItem"
                                            header="_pk|Item Code|Item Name|Item Local Name|Item Foreign Name|_UOM|_0"
                                            format="0|0|0|0|0|0|0"
                                            aligns="0|0|0|0|0|0|0"
                                            defaults="|||||||"
                                            editcol="0|0|0|0|0|0|0"
                                            widths="0|2500|3000|3000|3000|1500|1500"
                                            styles="width:100%; height:490"
                                            sorting="F"
                                            param="0,1,2,3,4,5,6"  />
        </td>
       </tr> 
    </table>
</td>
</tr>
</table>
<gw:textbox id="txtGroup_PK" styles='width:100%;display:none;'   />

</body>
</html>
