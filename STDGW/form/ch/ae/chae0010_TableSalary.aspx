<!-- #include file="../../../system/lib/form.inc"  -->

<%ESysLib.SetUser("hr")%>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document); 

	
    	datSalaryGroupTree.Call("SELECT");
  	
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
    
    var obj = treeSalary.GetCurrentNode()
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
    //alert(Check(obj.oid)+"");
    //txtSalaryGroupNamePK.text= obj.oid;
   if( Check(obj.oid)==true)
         OnSelect();
   // dsoCheckDel.Call();
}
function OnDataReceive(obj)
{
if(obj.id=="datSalaryGroupTree")  
    {//alert("sdf");
            dataCheck.Call("SELECT");
    }
}
//-------------------------------------------
</script>
<body  bgcolor='#F5F8FF'>
<gw:data id="dataCheck"  onreceive="OnDataReceive(this)">
    <xml>
        <dso type="grid" parameter="0"  function="hr.sp_list_leaf" >
            <input> 
				<input bind="iduser_pk" />
            </input>
            <output bind="grdList" />
        </dso>
    </xml>
</gw:data>  
<gw:data id="datSalaryGroupTree" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso id="1" type="tree" function="hr.sp_sel_group_salary_tree" > 
                <input>
                    <input bind="iduser_pk" /> 
                </input> 
                <output bind="treeSalary" /> 
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
	                    <gw:tree  id="treeSalary" onclicknode="treeItemOnclick()" style="width:100%; height:270;overflow:auto;"  >
		                </gw:tree>  
		           </td>
		       </tr>
		      
		    </table>
	    </td>
    </tr>	
    
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtSalaryGroupNamePK" styles="display:none"/>
<gw:grid   
					    id="grdList"               
					    header="_pk|_pk1"
					    format="0|0"  
					    aligns="0|0"  
					    defaults="||"  
					    editcol="0|0"  
					    widths= "0|0"  
					    styles="width:1%; height:1%"   
					    sorting="T"   
					    param="0,1"
					    styles="display:none"  />   

</body>
</html>
