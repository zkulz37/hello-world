<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document); 
	iduser_pk.text = "<%=session("USER_PK")%>";
	//lstCompany.SetDataText("<%=ESysLib.SetListDataSQL("select PK,PARTNER_NAME from TCO_COMPANY where DEL_IF = 0 AND ACTIVE_YN='Y'")%>");
    txtType.text="<%=request.queryString("type")%>";  	
  	txtDeptPk.text="<%=request.queryString("dept_pk")%>";
  	txtCompany.text ="<%=request.queryString("company_pk")%>";
  	datDeptTree.Call("SELECT");
  	
}
//-------------------------------------------
function OnSearch()
{
    
	datDeptTree.Call("SELECT");
}
//-------------------------------------------
function OnSelect()
{
    
    var obj = check_change.text;
    if (obj=="true")
       window.returnValue = obj; 
    if (obj=='')
       window.returnValue = null; 
    else
       window.returnValue = obj; 
	window.close();
    
}
//-------------------------------------------
function EXITOnClick()
{
	OnSelect();
}
/*------------------------------*/
function OnDataReceive(obj)
{   if(obj.id=="datCheck" )
        {    if(check_change.text=='1')                {   
                    if(confirm("Do you want to move department"))
                        {datMove.Call();}
                }
             else
                    alert("Please chose other entry");
        }
        else
        if(obj.id=='datMove')
            OnSelect();
}

//-------------------------------------------
function treeItemOnclick()
{ var obj = treDept.GetCurrentNode();
   if (obj!=null&& txtType.text=='0')
    {   if(obj.oid==txtDeptPk.text)
            alert("Please select other entry"); 
        else
        {txtDeptP_PK.text=obj.oid;
            datCheck.Call();
        }
    
    }
  if(obj!=null&& txtType.text=='1')
    {if(obj.oid==txtDeptPk.text)
            alert("Please select other entry");
      else
        if(confirm("Do you want to move employees into new department"))
                        {txtDeptP_PK.text=obj.oid;
                        datMove.Call();
                        }
        
              
    }
    
}
function OnMove()
{   if(txtType.text=='0')
    {txtDeptP_PK.text='';
    if(confirm ("Do you want to move department to root."))
    datMove.Call();
    }
    else
    {alert("You cann't move enployees to root.");
    }
}
//-------------------------------------------
</script>
<body  bgcolor='#F5F8FF'>
<gw:data id="datCheck" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_agio0060_org2_1" > 
                <input>
                    <input bind="txtDeptPk" /> 
                    <input bind="txtDeptP_PK" /> 
                 </input> 
                <output>
                    
                    <output bind="check_change" />
                    
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datMove" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_agio0060_org2_2" > 
                <input>
                    <input bind="txtDeptPk" /> 
                      <input bind="txtDeptP_PK" /> 
                      <input bind="txtType" /> 
                </input> 
                <output>
                    
                    <output bind="check_change" />
                    
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datDeptTree"   > 
        <xml> 
            <dso id="1" type="tree" function="hr_pro_agio0060_org2_3" > 
                <input>
                    <input bind="txtCompany" /> 
                    <input bind="iduser_pk" /> 
                </input> 
                <output bind="treDept" /> 
            </dso> 
        </xml> 
</gw:data>
<!------------------------------->
<table  width="100%"  cellpadding="0" cellspacing="0" border="1">
    <tr>
        <td>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" >
                <tr>
                    <td align="left" ><a onclick="OnMove()">Please<font color=red ><b> Click </b></font>here to move Organization to root.</a></td>               
                    
                </tr>
                <tr>
                    <td align="left" ><font color=blue><b> Please select Organization move to...</b></font></td>               
                    
                </tr>
            </table>
        </td>
    </tr>
    <tr>
	    <td > 
	        <table cellpadding="0" cellspacing="0" border="0" width="100%" >
                <tr>
                    <td>
	                    <gw:tree  id="treDept" onclicknode="treeItemOnclick()" style="width:100%; height:270;overflow:auto;"  >
		                </gw:tree>  
		           </td>
		       </tr>
		      
		    </table>
	    </td>
    </tr>	
    
</table>
<gw:textbox id="txtDeptPk" maxlen=100 styles='width:100%;display:none'   csstype=""/>
<gw:textbox id="txtDeptP_PK" maxlen=100 styles='width:100%;display:none'   csstype=""/>
<gw:textbox id="txtCompany" maxlen=100 styles='width:100%;display:none'   csstype=""/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="check_change" styles="display:none"/>
<gw:textbox id="txtType" styles="display:none"/>

</body>
</html>
