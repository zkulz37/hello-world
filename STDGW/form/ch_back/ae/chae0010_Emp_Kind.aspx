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
function Check(obj)
{ //  alert(grdList.rows);//GetGridData(1,0));
var count=grdList.rows;
var kq=false;
for (var i=1;i<=count-1;i++)
    {var va=grdList.GetGridData(i,0)+"";   
        if(va==obj)
            return true;
    }
    return false;
    
}
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
    var obj = event.srcElement.GetCurrentNode();
    if( Check(obj.oid)==true)
         OnSelect();
    //txtSalaryGroupNamePK.text= obj.oid;
   // dsoCheckDel.Call();
}
function OnDataReceive(obj)
{   if(obj.id=="datEmpKindTree")  
        dataCheck.Call("SELECT");
}
//-------------------------------------------
</script>
<body  bgcolor='#F5F8FF'>
<gw:data id="datEmpKindTree" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso id="1" type="tree" function="HR.sp_sel_emp_kind_tree_use" > 
                <input>
                    <input bind="iduser_pk" /> 
                </input> 
                <output bind="treeEmpKind" /> 
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dataCheck"  onreceive="OnDataReceive(this)">
    <xml>
        <dso type="grid" parameter="0"  function="hr.sp_list_leaf_empkind" >
            <input> 
				<input bind="iduser_pk" />
            </input>
            <output bind="grdList" />
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

<gw:grid   
					    id="grdList"               
					    header="_pk"
					    format="0"  
					    aligns="0"  
					    defaults="|"  
					    editcol="0"  
					    widths= "0"  
					    styles="width:1%; height:1%"   
					    sorting="T"   
					    param="0"
					    styles="display:none"  /> 
</body>
</html>
