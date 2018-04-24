<!-- #include file="../../../system/lib/form.inc"  -->

<%ESysLib.SetUser("hr")%>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document); 

	
    	datEmpKindTree.Call("SELECT");
  	
}
//-------------------------------------------

//-------------------------------------------
function OnSelect()
{
    
    var obj = treeEmpKind.GetCurrentNode()
    if (obj!=null)
       window.returnValue = obj.oid; 
    else
       window.returnValue = null; 
	window.close();
    
}
//-------------------------------------------
function EXITOnClick()
{
	OnSelect();
}
/*------------------------------*/

//-------------------------------------------
function treeItemOnclick()
{
   // var obj = event.srcElement.GetCurrentNode();
    //if( Check(obj.oid)==true)
         OnSelect();
    //txtSalaryGroupNamePK.text= obj.oid;
   // dsoCheckDel.Call();
}
function OnDataReceive(obj)
{   //if(obj.id=="datEmpKindTree")  
       // dataCheck.Call("SELECT");
}
//-------------------------------------------
</script>
<body  bgcolor='#F5F8FF'>
<gw:data id="datEmpKindTree" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso id="1" type="tree" function="HR.sp_sel_emp_kind_tree" > 
                <input>
                    <input bind="iduser_pk" /> 
                </input> 
                <output bind="treeEmpKind" /> 
            </dso> 
        </xml> 
</gw:data>
 
<!------------------------------->
<table  width="100%"  cellpadding="0" cellspacing="0" border="1">
    
    <tr>
	    <td > 
	        <table cellpadding="0" cellspacing="0" border="0" width="100%" >
                <tr>
                    <td>
	                    <gw:tree  id="treeEmpKind" onclicknode="treeItemOnclick()" style="width:100%; height:270;overflow:auto;"  >
		                </gw:tree>  
		           </td>
		       </tr>
		      
		    </table>
	    </td>
    </tr>	
    
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>

</body>
</html>
